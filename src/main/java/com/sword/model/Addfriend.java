package com.sword.model;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.annotations.IdType;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;

/**
 *
 * 申请添加好友持久化记录
 *
 */
public class Addfriend implements Serializable {

	@TableField(exist = false)
	private static final long serialVersionUID = 1L;

	/**  */
	@TableId(type = IdType.AUTO)
	private Long aid;

	/**  */
	private Long fromuid;

	/**  */
	private Long touid;

	/**  */
	private Date time;

	/** ‘接受’，‘拒绝’，等待 */
	private String staus;

	/** 0未改变1改变状态 */
	private Integer flag;


	public Long getAid() {
		return this.aid;
	}

	public void setAid(Long aid) {
		this.aid = aid;
	}

	public Long getFromuid() {
		return this.fromuid;
	}

	public void setFromuid(Long fromuid) {
		this.fromuid = fromuid;
	}

	public Long getTouid() {
		return this.touid;
	}

	public void setTouid(Long touid) {
		this.touid = touid;
	}

	public Date getTime() {
		return this.time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getStaus() {
		return this.staus;
	}

	public void setStaus(String staus) {
		this.staus = staus;
	}

	public Integer getFlag() {
		return this.flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
	}

}
