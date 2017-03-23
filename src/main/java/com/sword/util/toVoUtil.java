package com.sword.util;

import com.sword.model.Concern;
import com.sword.model.Topic;
import com.sword.model.User;
import com.sword.model.VO.ConVo;
import com.sword.model.VO.TopicCatalogVo;

import java.util.Date;

/**
 * Created by Administrator on 2016/11/22.
 */
public class toVoUtil {
    public static final int DEFAULTLEN=100;
    public static int getDEFAULTLEN() {
        return DEFAULTLEN;
    }

    /**
     *
     * @param topic 帖子
     * @param user  帖子主人
     * @param len   文本过滤长度
     * @param dataflag  时间转化标志
     * @return
     */

    public static TopicCatalogVo toTopciVO(Topic topic, User user, int len,int dataflag){
        TopicCatalogVo tcvo1=new TopicCatalogVo();
        tcvo1.setTid(topic.getTid());          //topic的id
        tcvo1.settTopic(topic.getTtopic());  //标题
        tcvo1.setTuid(topic.getTuid());
        tcvo1.setuNickName(user.getUnickname()); //昵称
        tcvo1.setHeadimg(user.getHeadimg()); //头像
        Date createTime=topic.getTtime();
        String time=DateUtil.date(createTime,dataflag); //间隔时间
        tcvo1.setTimes(time);
        tcvo1.setShortContent(HtmlUtil.getTextFromTHML(topic.getTcontent(),len)); //文本描述
        tcvo1.setReplyCount(topic.getTreplaycount());                       //回复数
        tcvo1.setClickCount(topic.getTclickcount());                    //浏览数
        tcvo1.setTzan(topic.getTzan());
        return tcvo1;
    }
    public static TopicCatalogVo toTopciVO(Topic topic, User user){
        return toTopciVO(topic, user,DEFAULTLEN,0);
    }
    public static ConVo toConVo(Concern concern,User user){
        ConVo conVo=new ConVo();
        conVo.setConid(concern.getConid());
        conVo.setUemail(user.getUemail());
        conVo.setHeadimg(user.getHeadimg());
        conVo.setUid(user.getUid());
        conVo.setUnickname(user.getUnickname());
        conVo.setUlevel(user.getUlevel());

        conVo.setUstatement(user.getUstatement());
        return conVo;
    }


}
