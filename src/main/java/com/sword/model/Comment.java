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
public class Comment implements Serializable {

	@TableField(exist = false)
	private static final long serialVersionUID = 1L;

	/** 评论id自增 */
	@TableId(type = IdType.AUTO)
	private Long cid;

	/** 所评论的帖子id */
	private Long ctid;

	/** 用户id */
	private Long cuid;

	/** 评论时间 */
	private Date ctime;

	/** 用户评论 */
	private String content;

	/** 对应的根评论id */
	private Long rootcid;

	/** 根评论下对谁说用户id */
	private Long parentuid;

	/****评论点赞数******/
	private Long czan;

	/**是否已读 默认0未读，1已读**/
	private int isread;

	/**间接评论上的直接评论id**/
	private Long parentcid;

	public Long getParentcid() {
		return parentcid;
	}

	public void setParentcid(Long parentcid) {
		this.parentcid = parentcid;
	}

	public int getIsread() {
		return isread;
	}

	public void setIsread(int isread) {
		this.isread = isread;
	}

	public Long getCzan() {
		return czan;
	}

	public void setCzan(Long czan) {
		this.czan = czan;
	}

	public Long getCid() {
		return this.cid;
	}

	public void setCid(Long cid) {
		this.cid = cid;
	}

	public Long getCtid() {
		return this.ctid;
	}

	public void setCtid(Long ctid) {
		this.ctid = ctid;
	}

	public Long getCuid() {
		return this.cuid;
	}

	public void setCuid(Long cuid) {
		this.cuid = cuid;
	}

	public Date getCtime() {
		return this.ctime;
	}

	public void setCtime(Date ctime) {
		this.ctime = ctime;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Long getRootcid() {
		return this.rootcid;
	}

	public void setRootcid(Long rootcid) {
		this.rootcid = rootcid;
	}

	public Long getParentuid() {
		return this.parentuid;
	}

	public void setParentuid(Long parentuid) {
		this.parentuid = parentuid;
	}

}
