package com.sword.model.VO;

/**
 * Created by asus on 2017/3/15.
 */
public class ConVo {
    private long conid;
    private long uid;     //通过点击进入他人的空间--这里需要用到主键，查看他人的信息和帖子
    private String headimg;
    private String uemail;
    private String unickname;
    private int usex;   //0 1转换成男女
    private String ustatement;
    private int ulevel;

    public int getUsex() {
        return usex;
    }

    public void setUsex(int usex) {
        this.usex = usex;
    }

    public String getHeadimg() {
        return headimg;
    }

    public void setHeadimg(String headimg) {
        this.headimg = headimg;
    }

    public long getConid() {
        return conid;
    }

    public void setConid(long conid) {
        this.conid = conid;
    }

    public long getUid() {
        return uid;
    }

    public void setUid(long uid) {
        this.uid = uid;
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


    public String getUstatement() {
        return ustatement;
    }

    public void setUstatement(String ustatement) {
        this.ustatement = ustatement;
    }

    public int getUlevel() {
        return ulevel;
    }

    public void setUlevel(int ulevel) {
        this.ulevel = ulevel;
    }
}
