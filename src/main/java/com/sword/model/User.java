package com.sword.model;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.annotations.IdType;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;

/**
 *
 * 
 *
 */
public class User implements Serializable {

	@TableField(exist = false)
	private static final long serialVersionUID = 1L;

	/** 用户编号 */
	@TableId(type = IdType.AUTO)
	private Long uid;

	/** 邮箱登录 */
	private String uemail;

	/** 密码 */
	private String upassword;

	/** 昵称 */
	private String unickname;

	/** 性别 */
	private Integer usex;

	/** 生日 */
	private Date ubirthday;

	/** 等级 */
	private Integer ulevel;

	/** 头像 */
	private String headimg;

	/** 个人说明 */
	private String ustatement;

	/** 注册时间 */
	private Date uregtime;

	/** 是否被封天数-1永久 */
	private Integer ustate;

	/** 积分 */
	private Integer upoint;


	public Long getUid() {
		return this.uid;
	}

	public void setUid(Long uid) {
		this.uid = uid;
	}

	public String getUemail() {
		return this.uemail;
	}

	public void setUemail(String uemail) {
		this.uemail = uemail;
	}

	public String getUpassword() {
		return this.upassword;
	}

	public void setUpassword(String upassword) {
		this.upassword = upassword;
	}

	public String getUnickname() {
		return this.unickname;
	}

	public void setUnickname(String unickname) {
		this.unickname = unickname;
	}

	public Integer getUsex() {
		return this.usex;
	}

	public void setUsex(Integer usex) {
		this.usex = usex;
	}

	public Date getUbirthday() {
		return this.ubirthday;
	}

	public void setUbirthday(Date ubirthday) {
		this.ubirthday = ubirthday;
	}

	public Integer getUlevel() {
		return this.ulevel;
	}

	public void setUlevel(Integer ulevel) {
		this.ulevel = ulevel;
	}

	public String getHeadimg() {
		return this.headimg;
	}

	public void setHeadimg(String headimg) {
		this.headimg = headimg;
	}

	public String getUstatement() {
		return this.ustatement;
	}

	public void setUstatement(String ustatement) {
		this.ustatement = ustatement;
	}

	public Date getUregtime() {
		return this.uregtime;
	}

	public void setUregtime(Date uregtime) {
		this.uregtime = uregtime;
	}

	public Integer getUstate() {
		return this.ustate;
	}

	public void setUstate(Integer ustate) {
		this.ustate = ustate;
	}

	public Integer getUpoint() {
		return this.upoint;
	}

	public void setUpoint(Integer upoint) {
		this.upoint = upoint;
	}

}
