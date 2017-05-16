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
public class Sixin implements Serializable {

	@TableField(exist = false)
	private static final long serialVersionUID = 1L;

	/**  */
	@TableId(type = IdType.AUTO)
	private Long siid;

	/** 为了让系统发消息，-1代表系统，不用外键 */
	private Long sifromuid;

	/**  */
	private Long sitouid;

	/** 为了丰富以后内容是由text */
	private String content;

	/**  */
	private Date time;

	/** 0默认未读，1已读 */
	private Integer isread;


	public Long getSiid() {
		return this.siid;
	}

	public void setSiid(Long siid) {
		this.siid = siid;
	}

	public Long getSifromuid() {
		return this.sifromuid;
	}

	public void setSifromuid(Long sifromuid) {
		this.sifromuid = sifromuid;
	}

	public Long getSitouid() {
		return this.sitouid;
	}

	public void setSitouid(Long sitouid) {
		this.sitouid = sitouid;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getTime() {
		return this.time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public Integer getIsread() {
		return this.isread;
	}

	public void setIsread(Integer isread) {
		this.isread = isread;
	}

}
