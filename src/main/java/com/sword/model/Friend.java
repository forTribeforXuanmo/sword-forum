package com.sword.model;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.annotations.IdType;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;

/**
 *
 * 好友列表
 *
 */
public class Friend implements Serializable {

	@TableField(exist = false)
	private static final long serialVersionUID = 1L;

	/**  */
	@TableId(type = IdType.AUTO)
	private Long fid;

	/**  */
	private Long fromuid;

	/**  */
	private Long touid;

	/**  */
	private Date time;


	public Long getFid() {
		return this.fid;
	}

	public void setFid(Long fid) {
		this.fid = fid;
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

}
