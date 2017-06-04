package com.sword.control;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.sword.listen.Online;
import com.sword.listen.OnlineListener;
import com.sword.mapper.*;
import com.sword.model.Section;
import com.sword.model.Topic;
import com.sword.model.User;
import com.sword.model.VO.TopicCatalogVo;
import com.sword.util.DateUtil;
import com.sword.util.HtmlUtil;
import com.sword.util.toVoUtil;
import com.sword.websocket.SystemWebSocketHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created by Administrator on 2016/11/21.
 */
@Controller
@RequestMapping("/show")
public class ShowController {
    public static final int  PAGESIZE=9;
    @Resource
    private SectionMapper sectionMapper;
    @Resource
    private TopicMapper topicMapper;
    @Resource
    private CommentMapper commentMapper;
    @Resource
    private CateLogMapper catelogMapper;
    @Resource
    private UserMapper userMapper;




    @RequestMapping(value = "/catalog" ,method = RequestMethod.POST)
    @ResponseBody
    public Map getCatalog(HttpServletRequest request, HttpServletResponse response){
        Map<String,Object> map=new HashMap<String,Object>();
        List<Section> sectionList=sectionMapper.selectAll();
        List<Integer> replycountList=new ArrayList<Integer>();
        for (int i = 0; i <sectionList.size() ; i++) {
            int sid=sectionList.get(i).getSid();
            int count=catelogMapper.sectionReply(sid);
            replycountList.add(count);
        }

        map.put("b",replycountList);

        return map;
    }
    @RequestMapping("/topicCatalog")
    public String getTopicCatalog(@RequestParam("sid")int sid,@RequestParam(value = "page",required = false)Integer current, Map<String,Object> map){
        ArrayList<TopicCatalogVo> topicCatalogVos=new ArrayList<TopicCatalogVo>(20);
        Map<String,Object> mapwhere1=new HashMap<String,Object>(2);
        mapwhere1.put("tsid",sid);
        mapwhere1.put("tstaus",1);
        List<Topic> topics1=topicMapper.selectByMap(mapwhere1); //查询出在sid版块下的被置顶的帖子
        int size=PAGESIZE;
        //如果是第一页则把置顶的放入集合，然后分页查询未置顶的size-1
        if(current==0||current==1||current==null) {
            current = 1;
            if (topics1.size() != 0) {
                Topic t1 = topics1.get(0);
                User user = userMapper.selectById(t1.getTuid());
                TopicCatalogVo tcvo1 = toVoUtil.toTopciVO(t1, user);
                topicCatalogVos.add(tcvo1);
                size = size - 1;
            }
        }
        List<Topic> topics2=catelogMapper.sectionTopic(new Page<Topic>(current,size),sid);//查询出sid板块下的未被置顶的帖子 时间降序
        Topic countTopic=new Topic();
        countTopic.setTsid(sid);
        int count=topicMapper.selectCount(countTopic);     //总数
            for (Topic t: topics2) {
                User user=userMapper.selectById(t.getTuid());
                TopicCatalogVo tcvo=toVoUtil.toTopciVO(t,user);  //默认为过滤，时间为间隔
                topicCatalogVos.add(tcvo);
            }
            Section section=sectionMapper.selectById(sid);
            String sname=section.getSname();
            String sstatement=section.getSstatement();
            int pages=0;
            if(count<=PAGESIZE){
                pages=1;
            }else {
                if(count%PAGESIZE==0){
                    pages=count/PAGESIZE;
                }else {
                    pages=count/PAGESIZE+1;
                }
            }
            map.put("tcvos",topicCatalogVos);
            map.put("sname",sname);
            map.put("sstatement",sstatement);
            map.put("sid",sid);
            map.put("pages",pages);
            /************最后再点击数+1*************/
            updateSessionClick(sid);
            return "topicCatalog";
    }
    public synchronized void updateSessionClick(int sid){
            Section section=sectionMapper.selectById(sid);
            section.setSclickcount(section.getSclickcount()+1);
            sectionMapper.updateById(section);
    }
    @RequestMapping("/search")
    public String search(@RequestParam("searchkey")String key,Map map){
        System.out.println(key);
        EntityWrapper<User> userEw=new EntityWrapper<>();
        userEw.where("unickname like '%"+key+"%'").or("uemail like '%"+key+"%'");
        List<User> userList=userMapper.selectList(userEw);
        EntityWrapper<Topic> topicEw=new EntityWrapper<>();
        topicEw.where("ttopic like '%"+key+"%'");
        List<Topic> topicList=topicMapper.selectList(topicEw);
        List<TopicCatalogVo> topicCatalogVos=null;
        if(topicList.size()!=0){
            topicCatalogVos=new ArrayList<>(topicList.size());
        }
        for (Topic t:topicList) {
            User user=userMapper.selectById(t.getTuid());
            TopicCatalogVo topicCatalogVo=toVoUtil.toTopciVO(t,user);
            topicCatalogVos.add(topicCatalogVo);
        }
        map.put("userlist",userList);
        map.put("topiclist",topicCatalogVos);
        return "search";
    }

}
