package com.sword.model.VO;

import com.sword.model.Topic;

/**
 * Created by Administrator on 2016/11/21.
 */
public class TopicCatalogVo {
    private Long   tid;              //帖子id
    private String tTopic;          //帖子标题
    private Long tuid;              //发帖人id
    private String uNickName;       //发帖人昵称
    private String headimg;         //发帖人头像



    private String times;           //相隔时间，几天前或者几小时前或者某种日期格式
    private String shortContent;    //帖子前150个文本内容
    private String[] label;         //帖子标签，可供查询使用
    private Long replyCount;        //评论数

    private Long tzan;              //帖子点赞数
    private Long clickCount;        //点击数，浏览数

    public Long getTuid() {
        return tuid;
    }

    public void setTuid(Long tuid) {
        this.tuid = tuid;
    }

    public Long getTzan() {
        return tzan;
    }

    public void setTzan(Long tzan) {
        this.tzan = tzan;
    }

    public Long getTid() {
        return tid;
    }

    public void setTid(Long tid) {
        this.tid = tid;
    }

    public String gettTopic() {
        return tTopic;
    }

    public void settTopic(String tTopic) {
        this.tTopic = tTopic;
    }

    public String getuNickName() {
        return uNickName;
    }

    public void setuNickName(String uNickName) {
        this.uNickName = uNickName;
    }
    public String getTimes() {
        return times;
    }

    public void setTimes(String times) {
        this.times = times;
    }
    public String getHeadimg() {
        return headimg;
    }

    public void setHeadimg(String headimg) {
        this.headimg = headimg;
    }

    public String getShortContent() {
        return shortContent;
    }

    public void setShortContent(String shortContent) {
        this.shortContent = shortContent;
    }

    public String[] getLabel() {
        return label;
    }

    public void setLabel(String[] label) {
        this.label = label;
    }

    public Long getReplyCount() {
        return replyCount;
    }

    public void setReplyCount(Long replyCount) {
        this.replyCount = replyCount;
    }

    public Long getClickCount() {
        return clickCount;
    }

    public void setClickCount(Long clickCount) {
        this.clickCount = clickCount;
    }
}
