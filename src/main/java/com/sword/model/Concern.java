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
public class Concern implements Serializable {

	@TableField(exist = false)
	private static final long serialVersionUID = 1L;

	/** 自增 */
	@TableId(type = IdType.AUTO)
	private Long conid;

	/** 关注人 */
	private Long confromuid;

	/** 被关注人 */
	private Long contouid;


	public Long getConid() {
		return this.conid;
	}

	public void setConid(Long conid) {
		this.conid = conid;
	}

	public Long getConfromuid() {
		return this.confromuid;
	}

	public void setConfromuid(Long confromuid) {
		this.confromuid = confromuid;
	}

	public Long getContouid() {
		return this.contouid;
	}

	public void setContouid(Long contouid) {
		this.contouid = contouid;
	}

}
