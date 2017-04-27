package com.sword.model;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.annotations.IdType;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;

/**
 *记录登录退出修改密码 发表文章操作
 * 
 *
 */
public class Logtable implements Serializable {

	@TableField(exist = false)
	private static final long serialVersionUID = 1L;

	/** 自增 */
	@TableId(type = IdType.AUTO)
	private Long lid;

	/** 用户Id */
	private Long uid;

	/** 用户ip */
	private String ip;

	/** 操作时间 */
	private Date time;

	/** 1登录2退出3修改密码4发表文章 */
	private Integer type;
	public  Logtable(){

	}
	public Logtable( Long uid, String ip, Date time, Integer type) {
		this.uid = uid;
		this.ip = ip;
		this.time = time;
		this.type = type;
	}

	public Logtable(Long uid, String ip, Integer type) {
		this.uid = uid;
		this.ip = ip;
		this.type = type;
	}

	public Long getLid() {
		return this.lid;
	}

	public void setLid(Long lid) {
		this.lid = lid;
	}

	public Long getUid() {
		return this.uid;
	}

	public void setUid(Long uid) {
		this.uid = uid;
	}

	public String getIp() {
		return this.ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public Date getTime() {
		return this.time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

}
