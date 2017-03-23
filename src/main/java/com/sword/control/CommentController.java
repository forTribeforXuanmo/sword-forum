package com.sword.control;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.sword.mapper.CommentMapper;
import com.sword.mapper.TopicMapper;
import com.sword.mapper.UserMapper;
import com.sword.model.Comment;
import com.sword.model.Topic;
import com.sword.model.User;
import com.sword.model.VO.CommentVo;
import com.sword.model.VO.CommentVoS;
import com.sword.model.VO.TopicCatalogVo;
import com.sword.model.VO.UnreadComm;
import com.sword.util.DateUtil;
import com.sword.util.HtmlUtil;
import com.sword.util.toVoUtil;
import com.sword.websocket.SystemWebSocketHandler;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.socket.TextMessage;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * Comment 控制层
 *
 */
@Controller
public class CommentController {
    @Resource
    CommentMapper commentMapper;
    @Resource
    UserMapper userMapper;
    @Resource
    TopicMapper topicMapper;
    /*展示对应的帖子内容，帖子和评论*/
    @RequestMapping(value="/showTopicDetail/{tid}")
     public String showComment(@PathVariable("tid") long tid, Map<String,Object>map,HttpServletRequest request){
        //获取楼主的信息 直接使用TopicCataLogVo,只需把html过滤去掉,时间采用中国日期格式
        Topic maintopic=topicMapper.selectById(tid);
        User  topicuser=userMapper.selectById(maintopic.getTuid());
        User me=null;
        me= (User) request.getSession().getAttribute("user");
        if(me!=null&&me.getUid()==topicuser.getUid()){
            commentMapper.updateRead(tid);
        }
        TopicCatalogVo topicCatalogVo= toVoUtil.toTopciVO(maintopic,topicuser, HtmlUtil.NOTFILTER,1);
        List<CommentVoS> commentvoslist=new ArrayList<CommentVoS>();   //所有的评论集合
        Map<String,Object> rootmap=new HashMap<String,Object>();
        rootmap.put("ctid",tid);
        rootmap.put("rootcid",0L);
        List<Comment> rootComments=commentMapper.selectByMap(rootmap);  //查出所以得根评论
        for (Comment c:rootComments) {
            //直接根评论
            CommentVo rootcomment=comment2Vo(c,userMapper);
            //根据根评论的cid来查出里面的子评论
            Long cid=c.getCid();
            Map<String,Object> rootdirectmap=new HashMap<String,Object>();
            rootdirectmap.put("rootcid",cid);
            rootdirectmap.put("parentuid",0L);
            List<Comment> rootdirects =commentMapper.selectByMap(rootdirectmap);//根评论下的直接评论
            List<CommentVo> root_directcomment=new ArrayList<CommentVo>();
            for (Comment c2: rootdirects) {
                CommentVo onedirect=comment2Vo(c2,userMapper);
                root_directcomment.add(onedirect);
            }
            //非直接评论
            Map<String,Object> root_Ndirectmap=new HashMap<String,Object>();
            root_Ndirectmap.put("ctid",tid);
            root_Ndirectmap.put("rootcid",cid);
            List<Comment> root_Ndirect=commentMapper.selectNdirect(root_Ndirectmap);
            List<CommentVo> root_Ndirectcomment=new ArrayList<CommentVo>();
            for (Comment c3:root_Ndirect) {
                CommentVo oneNdirect=comment2Vo(c3,userMapper);
                root_Ndirectcomment.add(oneNdirect);
            }
            //完整的一个CommentVoS
            CommentVoS oneCommentvs=new CommentVoS();
            oneCommentvs.setRootcomment(rootcomment);
            oneCommentvs.setRoot_directcomment(root_directcomment);
            oneCommentvs.setRoot_Ndirectcomment(root_Ndirectcomment);
            commentvoslist.add(oneCommentvs);
        }
        map.put("comment",commentvoslist);
        map.put("topic",topicCatalogVo);
        /*增加帖子的点击数*/
        maintopic.setTclickcount(maintopic.getTclickcount()+1);
        topicMapper.updateById(maintopic);
        return "topicdetail";
    }
    public static CommentVo comment2Vo(Comment comment,UserMapper userMapper){
        CommentVo cvo=new CommentVo();
        cvo.setCid(comment.getCid());
        cvo.setContent(comment.getContent());
        cvo.setTimeinterval(DateUtil.date(comment.getCtime(),0));
        cvo.setRootid(comment.getRootcid());
        cvo.setParentuid(comment.getParentuid());
        cvo.setCzan(comment.getCzan());
        cvo.setUid(comment.getCuid());   //自己的uid
        //自己的昵称,头像
        User me=userMapper.selectById(comment.getCuid());
        cvo.setHeadimg(me.getHeadimg());
        cvo.setNickname(me.getUnickname());
        //parent的昵称
        Long parentuid=comment.getParentuid();
        if(parentuid!=0){
            User parent=userMapper.selectById(parentuid);
            cvo.setParentunickname(parent.getUnickname());
            System.out.println(parent.getUnickname());
        }
        return cvo;

    }
    @Bean
    public SystemWebSocketHandler systemWebSocketHandler() {
        return new SystemWebSocketHandler();
    }

    /*发表评论*/
    @RequestMapping("/addComment")
    public void addComment(@RequestParam("content")String content, @RequestParam("tid")long tid,
                           @RequestParam(value = "rootcid",required = false,defaultValue ="0")long rootcid,
                           @RequestParam(value = "parentuid",required = false,defaultValue = "0")long parentuid,
                           HttpServletRequest request, HttpServletResponse response){
        User user= (User) request.getSession().getAttribute("user");
        Long uid=user.getUid();
        Comment comment=new Comment();
        comment.setContent(HtmlUtil.filter(content));
        comment.setCtid(tid);
        comment.setCuid(uid);
        comment.setRootcid(rootcid);
        comment.setParentuid(parentuid);
        int i=commentMapper.insertSelective(comment);
        PrintWriter pw=null;
        if(i==1){
            System.out.println("增加评论成功");
            Topic topic=topicMapper.selectById(tid);
            int unreadCount=commentMapper.unreadCount(topic.getTuid());
            systemWebSocketHandler().sendMessageToUser(topic.getTuid(),new TextMessage(unreadCount+""));
            try {
                 pw=response.getWriter();
                 pw.write("success");
                 pw.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else {
            try {
                pw=response.getWriter();
                pw.write("err");
                pw.close();
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
    }
    /**查看我的未读评论**/
    @RequestMapping("/unReadComment")
    public String unReadComment(HttpServletRequest request,@RequestParam("page")int current,Map<String,Object>map){
        User me= (User) request.getSession().getAttribute("user");
        Page page=new Page(current,8);
        List<UnreadComm> unreadComms=commentMapper.unreadComment(page,me.getUid());
        map.put("unreadcomms",unreadComms);
        map.put("pages",page.getPages());
        return "unreadcomment";
    }


}