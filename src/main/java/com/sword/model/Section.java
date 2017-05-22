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
public class Section implements Serializable {

	@TableField(exist = false)
	private static final long serialVersionUID = 1L;

	/** 版块ID */
	@TableId(type = IdType.AUTO)
	private Integer sid;

	/** 名字 */
	private String sname;

	/** 版主ID对应于use表的用户ID */
	private Long smasterid;

	/** 版块的说明 */
	private String sstatement;

	/** 浏览数 */
	private Long sclickcount;

	/** 主贴数 */
	private Long stopiccount;
	/*******简要说明*/
	private String sshortsm;

	/**父级菜单 没有则为'0' **/
	private String sparentname;

	public String getSparentname() {
		return sparentname;
	}

	public void setSparentname(String sparentname) {
		this.sparentname = sparentname;
	}

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public String getSshortsm() {
		return sshortsm;
	}

	public void setSshortsm(String sshortsm) {
		this.sshortsm = sshortsm;
	}

	public Integer getSid() {
		return this.sid;
	}

	public void setSid(Integer sid) {
		this.sid = sid;
	}

	public String getSname() {
		return this.sname;
	}

	public void setSname(String sname) {
		this.sname = sname;
	}

	public Long getSmasterid() {
		return this.smasterid;
	}

	public void setSmasterid(Long  smasterid) {
		this.smasterid = smasterid;
	}

	public String getSstatement() {
		return this.sstatement;
	}

	public void setSstatement(String sstatement) {
		this.sstatement = sstatement;
	}

	public Long getSclickcount() {
		return this.sclickcount;
	}

	public void setSclickcount(Long sclickcount) {
		this.sclickcount = sclickcount;
	}

	public Long getStopiccount() {
		return this.stopiccount;
	}

	public void setStopiccount(Long stopiccount) {
		this.stopiccount = stopiccount;
	}

}
