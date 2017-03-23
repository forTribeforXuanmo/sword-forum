package com.sword.model;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotations.IdType;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;

/**
 *
 * 
 *
 */
public class Manage implements Serializable {

	@TableField(exist = false)
	private static final long serialVersionUID = 1L;

	/** 管理员ID */
	@TableId(type = IdType.AUTO)
	private Integer mid;

	/** 名字 */
	private String mname;

	/** 密码 */
	private String mpassword;

	/** 性别 */
	private Integer msex;

	/** 角色（0超级管理员1普通管理员） */
	private Integer mrole;

	/** 邮箱地址  */
	private String memail;


	public Integer getMid() {
		return this.mid;
	}

	public void setMid(Integer mid) {
		this.mid = mid;
	}

	public String getMname() {
		return this.mname;
	}

	public void setMname(String mname) {
		this.mname = mname;
	}

	public String getMpassword() {
		return this.mpassword;
	}

	public void setMpassword(String mpassword) {
		this.mpassword = mpassword;
	}

	public Integer getMsex() {
		return this.msex;
	}

	public void setMsex(Integer msex) {
		this.msex = msex;
	}

	public Integer getMrole() {
		return this.mrole;
	}

	public void setMrole(Integer mrole) {
		this.mrole = mrole;
	}

	public String getMemail() {
		return this.memail;
	}

	public void setMemail(String memail) {
		this.memail = memail;
	}

}
