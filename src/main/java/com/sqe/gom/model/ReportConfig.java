/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.DateRange;

/**
 * @description 
 * @author OLE 
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 9, 2012
 * @version 3.0
 */
@Table
@Entity
@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
public class ReportConfig implements Serializable {
	private static final long serialVersionUID = 1660293704691710842L;

	@Expose
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;				//ID号	
	
	//summary, devote, weekDevote, repos, task, doing,help,daily, weekly, perMonth, quarterly,how, assets，login
	//概述、对公司贡献，一周贡献，管理责任，工作命令，需要做，需要帮忙，每日做，每周做，每月做，每季做，如何做，资产管理，登录或登出日志
	
	@Expose
	@Column(length=4)
	private DateRange type;					//报表类型（日，周，月，季，年，早报）
	
	@Expose
	@Column(length=30)
	private String sendTime;				//报表发送时间 
	
	@Expose
	@Column(length=500)
	private String receiver;				//收件人邮箱
	
	@Expose
	@Column(length=150)
	private String ename;					//收件人
	
	@Expose
	@Column(length=500)
	private String cc;						//抄送邮箱
	
	@Expose
	@Column(length=150)
	private String ccename;					//抄送人
	
	@Expose
	private Boolean send;					//是否发送
	
	@Expose
	private Boolean summary;				//概述
	
	@Expose
	private Boolean devote;					//贡献
	
	@Expose
	private Boolean weekDevote;				//一周贡献
	
	@Expose
	private Boolean repos;					//管理责任
	
	@Expose
	private Boolean task;					//工作命令
	
	@Expose
	private Boolean doing;					//需要做
	
	@Expose
	private Boolean help;					//需要帮忙
	
	@Expose
	private Boolean daily;					//每日做
	
	@Expose
	private Boolean weekly;					//每周做
	
	@Expose
	private Boolean perMonth;				//每月做
	
	@Expose
	private Boolean quarterly;				//每季做
	
	@Expose
	private Boolean how;					//如何做
	
	@Expose
	private Boolean assets;					//资产管理
	
	@Expose
	private Boolean login;					//登录日志
	
	@ManyToOne(cascade=CascadeType.ALL, fetch=FetchType.LAZY)
	@JoinColumn(name="user_report_fk")
	private GomUser user;	
	
	@Expose
	@Transient
	private Integer userId;
	
	@Expose
	@Transient
	private String stext;
	
	
	public ReportConfig(){}
	

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public DateRange getType() {
		return type;
	}

	public void setType(DateRange type) {
		this.type = type;
	}

	public String getSendTime() {
		return sendTime;
	}

	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getCc() {
		return cc;
	}

	public void setCc(String cc) {
		this.cc = cc;
	}

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public String getCcename() {
		return ccename;
	}

	public void setCcename(String ccename) {
		this.ccename = ccename;
	}

	public Boolean getSend() {
		return send;
	}

	public void setSend(Boolean send) {
		this.send = send;
	}

	public Boolean getSummary() {
		return summary;
	}

	public void setSummary(Boolean summary) {
		this.summary = summary;
	}

	public Boolean getDevote() {
		return devote;
	}

	public void setDevote(Boolean devote) {
		this.devote = devote;
	}

	public Boolean getWeekDevote() {
		return weekDevote;
	}

	public void setWeekDevote(Boolean weekDevote) {
		this.weekDevote = weekDevote;
	}

	public Boolean getRepos() {
		return repos;
	}

	public void setRepos(Boolean repos) {
		this.repos = repos;
	}

	public Boolean getTask() {
		return task;
	}

	public void setTask(Boolean task) {
		this.task = task;
	}


	public Boolean getDoing() {
		return doing;
	}


	public void setDoing(Boolean doing) {
		this.doing = doing;
	}


	public Boolean getHelp() {
		return help;
	}


	public void setHelp(Boolean help) {
		this.help = help;
	}


	public Boolean getDaily() {
		return daily;
	}


	public void setDaily(Boolean daily) {
		this.daily = daily;
	}


	public Boolean getWeekly() {
		return weekly;
	}


	public void setWeekly(Boolean weekly) {
		this.weekly = weekly;
	}


	public Boolean getPerMonth() {
		return perMonth;
	}


	public void setPerMonth(Boolean perMonth) {
		this.perMonth = perMonth;
	}


	public Boolean getQuarterly() {
		return quarterly;
	}


	public void setQuarterly(Boolean quarterly) {
		this.quarterly = quarterly;
	}


	public Boolean getHow() {
		return how;
	}


	public void setHow(Boolean how) {
		this.how = how;
	}


	public Boolean getAssets() {
		return assets;
	}


	public void setAssets(Boolean assets) {
		this.assets = assets;
	}


	public Boolean getLogin() {
		return login;
	}


	public void setLogin(Boolean login) {
		this.login = login;
	}

	public GomUser getUser() {
		return user;
	}

	public void setUser(GomUser user) {
		this.user = user;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getStext() {
		return stext;
	}

	public void setStext(String stext) {
		this.stext = stext;
	}


	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).append(getUser()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof ReportConfig != true)
			return false;
		ReportConfig other = (ReportConfig) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getUser(), other.getUser()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.summary);
		sb.append(",").append(this.devote);
		sb.append(",").append(this.weekDevote);
		sb.append(",").append(this.repos);
		sb.append(",").append(this.task);
		sb.append(",").append(this.doing);
		sb.append(",").append(this.help);
		sb.append(",").append(this.daily);
		sb.append(",").append(this.weekly);
		sb.append(",").append(this.weekly);
		sb.append(",").append(this.perMonth);
		sb.append(",").append(this.quarterly);
		sb.append(",").append(this.how);
		sb.append(",").append(this.assets);
		sb.append(",").append(this.login);
		sb.append("}");
		return sb.toString();
	}
}
