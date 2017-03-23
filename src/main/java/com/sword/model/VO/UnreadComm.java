package com.sword.model.VO;

import java.util.Date;

/**
 * Created by asus on 2017/3/22.
 */
public class UnreadComm {
    private long cuid;
    private String unickname;
    private String headimg;
    private long ctid;
    private String ttopic;
    private long cid; //唯一标志
    private String content;
    private Date ctime;

    public long getCuid() {
        return cuid;
    }

    public void setCuid(long cuid) {
        this.cuid = cuid;
    }

    public String getUnickname() {
        return unickname;
    }

    public void setUnickname(String unickname) {
        this.unickname = unickname;
    }

    public long getCtid() {
        return ctid;
    }

    public void setCtid(long ctid) {
        this.ctid = ctid;
    }

    public String getHeadimg() {
        return headimg;
    }

    public void setHeadimg(String headimg) {
        this.headimg = headimg;
    }

    public String getTtopic() {
        return ttopic;
    }

    public void setTtopic(String ttopic) {
        this.ttopic = ttopic;
    }

    public long getCid() {
        return cid;
    }

    public void setCid(long cid) {
        this.cid = cid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCtime() {
        return ctime;
    }

    public void setCtime(Date ctime) {
        this.ctime = ctime;
    }
}
