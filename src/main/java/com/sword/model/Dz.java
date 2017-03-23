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
public class Dz implements Serializable {

	@TableField(exist = false)
	private static final long serialVersionUID = 1L;

	/** 自增 */
	@TableId(type = IdType.AUTO)
	private Long dzid;

	/** 点赞人uid */
	private Long dzformuid;

	/** 被点赞帖子 */
	private Long dztotid;

	/** 点赞时间 */
	private Date dztime;


	public Long getDzid() {
		return this.dzid;
	}

	public void setDzid(Long dzid) {
		this.dzid = dzid;
	}

	public Long getDzformuid() {
		return this.dzformuid;
	}

	public void setDzformuid(Long dzformuid) {
		this.dzformuid = dzformuid;
	}

	public Long getDztotid() {
		return this.dztotid;
	}

	public void setDztotid(Long dztotid) {
		this.dztotid = dztotid;
	}

	public Date getDztime() {
		return this.dztime;
	}

	public void setDztime(Date dztime) {
		this.dztime = dztime;
	}

}
