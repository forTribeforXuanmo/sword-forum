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
public class Topic implements Serializable {

	@TableField(exist = false)
	private static final long serialVersionUID = 1L;

	/** 主贴ID */
	@TableId(type = IdType.AUTO)
	private Long tid;

	/** 所属的版块ID */
	private Integer tsid;

	/** 发表帖子的用户ID */
	private Long tuid;

	/** 主题 */
	private String ttopic;

	/** 内容 */
	private String tcontent;

	/** 发帖时间 */
	private Date ttime;

	@Override
	public String toString() {
		return "Topic{" +
				"tid=" + tid +
				", tsid=" + tsid +
				", tuid=" + tuid +
				", ttopic='" + ttopic + '\'' +
				", tcontent='" + tcontent + '\'' +
				", ttime=" + ttime +
				", tclickcount=" + tclickcount +
				", treplaycount=" + treplaycount +
				", tlastclicktime=" + tlastclicktime +
				", tstaus=" + tstaus +
				", tzan=" + tzan +
				'}';
	}

	/** 帖子浏览数 */
	private Long tclickcount;

	/** 帖子回帖数 */
	private Long treplaycount;

	/** 最后一次浏览时间 */
	private Date tlastclicktime;

	/*******0不置顶1置顶******/
	private Integer tstaus;

	/*********点赞数*****/
	private Long tzan;

	public Long getTzan() {
		return tzan;
	}

	public void setTzan(Long tzan) {
		this.tzan = tzan;
	}

	public Integer getTstaus() {
		return tstaus;
	}

	public void setTstaus(Integer tstaus) {
		this.tstaus = tstaus;
	}

	public Long getTid() {
		return this.tid;
	}

	public void setTid(Long tid) {
		this.tid = tid;
	}

	public Integer getTsid() {
		return this.tsid;
	}

	public void setTsid(Integer tsid) {
		this.tsid = tsid;
	}

	public Long getTuid() {
		return this.tuid;
	}

	public void setTuid(Long tuid) {
		this.tuid = tuid;
	}

	public String getTtopic() {
		return this.ttopic;
	}

	public void setTtopic(String ttopic) {
		this.ttopic = ttopic;
	}

	public String getTcontent() {
		return this.tcontent;
	}

	public void setTcontent(String tcontent) {
		this.tcontent = tcontent;
	}

	public Date getTtime() {
		return this.ttime;
	}

	public void setTtime(Date ttime) {
		this.ttime = ttime;
	}

	public Long getTclickcount() {
		return this.tclickcount;
	}

	public void setTclickcount(Long tclickcount) {
		this.tclickcount = tclickcount;
	}

	public Long getTreplaycount() {
		return this.treplaycount;
	}

	public void setTreplaycount(Long treplaycount) {
		this.treplaycount = treplaycount;
	}

	public Date getTlastclicktime() {
		return this.tlastclicktime;
	}

	public void setTlastclicktime(Date tlastclicktime) {
		this.tlastclicktime = tlastclicktime;
	}

}
