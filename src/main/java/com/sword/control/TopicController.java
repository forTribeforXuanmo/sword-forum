package com.sword.control;

import com.sword.mapper.SectionMapper;
import com.sword.mapper.TopicMapper;
import com.sword.model.Topic;
import com.sword.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

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
    /*帖子点赞*/
@RequestMapping("/addtopicclick")
    public  synchronized void addclick(@RequestParam("tid") long tid){
    Topic topic=topicMapper.selectById(tid);
    topic.setTzan(topic.getTzan()+1);
    topicMapper.updateById(topic);

}
@RequestMapping("/addtopic")
    public void addTopic(@RequestParam("sid")int sid, @RequestParam("topic")String topic, @RequestParam("content")String content, HttpServletRequest request, HttpServletResponse response){
    Topic newTopic=new Topic();
    User u= (User) request.getSession().getAttribute("user");
    long uid= u.getUid();
    newTopic.setTuid(uid);
    newTopic.setTsid(sid);
    newTopic.setTtopic(topic);
    newTopic.setTcontent(content);
    int i=topicMapper.insertSelective(newTopic);
    PrintWriter pw=null;
    try {
         pw=response.getWriter();

    } catch (IOException e) {
        e.printStackTrace();
    }
    if(i==1){
        pw.write("success");
    }else {
        pw.write("failed");
    }
    if(pw!=null){
        pw.close();
    }
}


}