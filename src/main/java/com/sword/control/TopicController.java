package com.sword.control;

import com.sword.mapper.LogtableMapper;
import com.sword.mapper.SectionMapper;
import com.sword.mapper.TopicMapper;
import com.sword.mapper.UserMapper;
import com.sword.model.Logtable;
import com.sword.model.Topic;
import com.sword.model.User;
import com.sword.util.IpUtil;
import com.sword.util.LevelUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

/**
 *
 * Topic 控制层
 *
 */
@Controller
public class TopicController {
    @Resource
    private TopicMapper topicMapper;
    @Resource
    private SectionMapper sectionMapper;
    @Resource
    private LogtableMapper logtableMapper;
    @Resource
    private UserMapper userMapper;
    /*帖子点赞*/
@RequestMapping("/addtopicclick")
    public  synchronized void addclick(@RequestParam("tid") long tid){
    Topic topic=topicMapper.selectById(tid);
    topic.setTzan(topic.getTzan()+1);
    topicMapper.updateById(topic);
}
@RequestMapping("/addtopic")
    public void addTopic(@RequestParam("sid")int sid, @RequestParam("topic")String topic, @RequestParam("content")String content, HttpServletRequest request, HttpServletResponse response) throws Exception {
    Topic newTopic=new Topic();
    User u= (User) request.getSession().getAttribute("user");
    long uid= u.getUid();
    newTopic.setTuid(uid);
    newTopic.setTsid(sid);
    newTopic.setTtopic(topic);
    newTopic.setTcontent(content);
    int i=topicMapper.insertSelective(newTopic);
    PrintWriter pw=null;
    System.out.println(content);
    try {
         pw=response.getWriter();
    } catch (IOException e) {
        e.printStackTrace();
    }
    if(i==1){
        /**插入发表帖子记录**/
        Logtable logtable=new Logtable(u.getUid(),new IpUtil().getIp(request),5);
        logtableMapper.insert(logtable);
        /** 发表一个加8分最多一天加80分 就是发布帖子超过10个就不会在加了**/
        int count=logtableMapper.todayTopicCount(u.getUid(),new Date());
        if(count<=10){
            int newpoint=u.getUpoint()+8;
            int level= LevelUtil.point2Level(newpoint);
            u.setUpoint(newpoint);
            u.setUlevel(level);
            userMapper.updateById(u);
            request.getSession().setAttribute("user",u);
        }
        pw.write("success");
    }else {
        pw.write("failed");
    }
    if(pw!=null){
        pw.close();
    }
}


}