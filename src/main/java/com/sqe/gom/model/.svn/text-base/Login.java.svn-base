/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.DateMarkType;
import com.sqe.gom.vo.UserGroup;

/**
 * @description property of login entity.
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jul 26, 2011 9:24:27 PM
 * @version 3.0
 */
@Table
@Entity
public class Login implements Serializable {
	private static final long serialVersionUID = 4784841256982110241L;

	@Expose
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Expose
	@Column(length=15, nullable=false)
	private String loginIP;

	@Expose
	@Temporal(TemporalType.TIMESTAMP)
	private Date loginTime;
	
	@Expose
	@Column(length=500, nullable=false)
	private String loginTake;
	
	@Expose
	@Temporal(TemporalType.TIMESTAMP)
	private Date loginOut;				//登出时间
	
	@Expose
	private Boolean reportMark;			//日报发送成功标记
	
	@Expose
	@Enumerated(EnumType.ORDINAL)
	private DateMarkType dateMark;		//班期
	
	@Temporal(TemporalType.TIME)
	@Column(updatable=false)
	private Date unlockTime;
	
	@ManyToOne(cascade=CascadeType.MERGE,fetch=FetchType.LAZY)
	@JoinColumn(name="user_id")
	private GomUser user;

	@Transient
	private UserGroup ug;				//vo user
	
	@Transient
	private String swot = "green";		//vo SWOT
	
	
	public Login(){}
	
	public Login(Integer id, String loginIP, Date loginTime, String loginTake, Date loginOut, Boolean reportMark, Date unlockTime) {
		this.id = id;
		this.loginIP = loginIP;
		this.loginTime = loginTime;
		this.loginTake = loginTake;
		this.loginOut = loginOut;
		this.reportMark = reportMark;
		this.unlockTime = unlockTime;
	}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getLoginIP() {
		return loginIP;
	}

	public void setLoginIP(String loginIP) {
		this.loginIP = loginIP;
	}

	public Date getLoginTime() {
		return loginTime;
	}

	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}

	public String getLoginTake() {
		return loginTake;
	}

	public void setLoginTake(String loginTake) {
		this.loginTake = loginTake;
	}

	public Date getUnlockTime() {
		return unlockTime;
	}

	public void setUnlockTime(Date unlockTime) {
		this.unlockTime = unlockTime;
	}

	public Date getLoginOut() {
		return loginOut;
	}

	public void setLoginOut(Date loginOut) {
		this.loginOut = loginOut;
	}

	public Boolean getReportMark() {
		return reportMark;
	}

	public void setReportMark(Boolean reportMark) {
		this.reportMark = reportMark;
	}

	public DateMarkType getDateMark() {
		return dateMark;
	}

	public void setDateMark(DateMarkType dateMark) {
		this.dateMark = dateMark;
	}

	public GomUser getUser() {
		return user;
	}

	public void setUser(GomUser user) {
		this.user = user;
	}

	public UserGroup getUg() {
		return ug;
	}

	public void setUg(UserGroup ug) {
		this.ug = ug;
	}

	public String getSwot() {
		return swot;
	}

	public void setSwot(String swot) {
		this.swot = swot;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).append(getLoginTime()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) return true;
		if (obj instanceof Login != true) return false;
		Login other = (Login) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getLoginTime(), other.getLoginTime()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.loginIP);
		sb.append(",").append(this.loginTime);
		sb.append(",").append(this.loginTake);
		sb.append(",").append(this.loginOut);
		sb.append(",").append(this.unlockTime);
		sb.append(",").append(this.reportMark);
		sb.append("}");
		return sb.toString();
	}
}