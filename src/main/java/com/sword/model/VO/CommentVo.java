package com.sword.model.VO;

import com.sword.model.Comment;

/**
 * Created by Administrator on 2016/11/22.
 */
public class CommentVo {
    private Long   uid;                 //用户id
    private String headimg;              //头像
    private String nickname;             //昵称
    private String fromuemail;             //发言人账号



    private String content;                //评论内容
    private Long cid;                   //评论id
    private String timeinterval;         //评论间隔时间
    private Long tid;                 //评论所在帖子
    private String ttopic;             //评论帖子标题



    private Long rootid;                //所属的根评论id
    private Long parentuid;             //根评论下的间接评论：对根评论下直接评论的人评论用户id
    private Long parentcid;             //间接评论上直接评论的id
    private String parentunickname;     //根评论下的间接评论：对根评论下直接评论的人评论用户id对应的昵称
    private Long czan;                  //点赞数

    public Long getParentcid() {
        return parentcid;
    }

    public void setParentcid(Long parentcid) {
        this.parentcid = parentcid;
    }

    public Long getUid() {
        return uid;
    }
    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getHeadimg() {
        return headimg;
    }

    public void setHeadimg(String headimg) {
        this.headimg = headimg;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getCid() {
        return cid;
    }

    public void setCid(Long cid) {
        this.cid = cid;
    }

    public String getTimeinterval() {
        return timeinterval;
    }

    public void setTimeinterval(String timeinterval) {
        this.timeinterval = timeinterval;
    }

    public Long getRootid() {
        return rootid;
    }

    public void setRootid(Long rootid) {
        this.rootid = rootid;
    }

    public String getFromuemail() {
        return fromuemail;
    }

    public void setFromuemail(String fromuemail) {
        this.fromuemail = fromuemail;
    }
    public Long getParentuid() {
        return parentuid;
    }

    public void setParentuid(Long parentuid) {
        this.parentuid = parentuid;
    }
    public Long getTid() {
        return tid;
    }

    public void setTid(Long tid) {
        this.tid = tid;
    }

    public String getTtopic() {
        return ttopic;
    }

    public void setTtopic(String ttopic) {
        this.ttopic = ttopic;
    }

    public Long getCzan() {
        return czan;
    }

    public void setCzan(Long czan) {
        this.czan = czan;
    }

    public String getParentunickname() {
        return parentunickname;
    }

    public void setParentunickname(String parentunickname) {
        this.parentunickname = parentunickname;
    }
}
