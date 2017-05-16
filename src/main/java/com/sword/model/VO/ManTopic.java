package com.sword.model.VO;

import java.util.Date;

/**
 * author: lishengzhu
 * eamil:530735771@qq.com
 * date:2017/5/8
 * time:15:46
 * 后台管理中帖子管理 三表联立查询，展示更加详细的帖子信息
 */
public class ManTopic{
        private Long tid;
        private Integer tsid;
        private Long tuid;
        private String ttopic;
        private Date ttime;
        private Long treplaycount;
        private Long tclickcount;
        private Date tlastclicktime;
        private int tstaus;
        private Long tzan;
        private String sname;
        private String uemail;
        private String unickname;
        private String headimg;

    public Long getTid() {
        return tid;
    }

    public void setTid(Long tid) {
        this.tid = tid;
    }

    public Integer getTsid() {
        return tsid;
    }

    public void setTsid(Integer tsid) {
        this.tsid = tsid;
    }

    public Long getTuid() {
        return tuid;
    }

    public void setTuid(Long tuid) {
        this.tuid = tuid;
    }

    public String getTtopic() {
        return ttopic;
    }

    public void setTtopic(String ttopic) {
        this.ttopic = ttopic;
    }

    public Date getTtime() {
        return ttime;
    }

    public void setTtime(Date ttime) {
        this.ttime = ttime;
    }

    public Long getTreplaycount() {
        return treplaycount;
    }

    public void setTreplaycount(Long treplaycount) {
        this.treplaycount = treplaycount;
    }

    public Long getTclickcount() {
        return tclickcount;
    }

    public void setTclickcount(Long tclickcount) {
        this.tclickcount = tclickcount;
    }

    public Date getTlastclicktime() {
        return tlastclicktime;
    }

    public void setTlastclicktime(Date tlastclicktime) {
        this.tlastclicktime = tlastclicktime;
    }

    public int getTstaus() {
        return tstaus;
    }

    public void setTstaus(int tstaus) {
        this.tstaus = tstaus;
    }

    public Long getTzan() {
        return tzan;
    }

    public void setTzan(Long tzan) {
        this.tzan = tzan;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public String getUemail() {
        return uemail;
    }

    public void setUemail(String uemail) {
        this.uemail = uemail;
    }

    public String getUnickname() {
        return unickname;
    }

    public void setUnickname(String unickname) {
        this.unickname = unickname;
    }

    public String getHeadimg() {
        return headimg;
    }

    public void setHeadimg(String headimg) {
        this.headimg = headimg;
    }
}
