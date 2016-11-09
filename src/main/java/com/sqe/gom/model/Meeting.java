/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.google.gson.annotations.Expose;

/**
 * @description	会议实体
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Oct 20, 2012
 * @version 3.0
 */
@Entity
@Table(name="meeting")
public class Meeting implements Serializable {
	private static final long serialVersionUID = -8002475606152048283L;
	
	@Expose
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;						//id
	
	@Expose
	@Column(length=20, nullable=false)
	private String number;					//编号
	
	@Expose
	@Column(length=20, nullable=false)
	private String title;					//会议主题 
	
	@Expose
	@Column(length=20, nullable=false)
	private String locale;					//会议地点
	
	@Expose
	@Temporal(TemporalType.TIMESTAMP)
	private Date time;						//会议时间 
	
	@Expose
	@Column(length=20, nullable=false)
	private String host;					//主持人
	
	@Expose
	@Column(length=20, nullable=false)
	private String notes;					//记录人
	
	@Expose
	@Column(length=50)
	private String participants;			//参会人员
	
	private Boolean isTrace;				//是否追踪
	
	@Expose
	@Temporal(TemporalType.DATE)
	private Date traceDate;					//追踪日期
	
	@Expose
	@Temporal(TemporalType.DATE)
	private Date endDate;					//结束日期
	
	@Expose
	@Column(length=2000)
	private String content;					//内容
	
	@Expose
	@Column(length=200, name="explains")
	private String explain;					//说明
	
	
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLocale() {
		return locale;
	}

	public void setLocale(String locale) {
		this.locale = locale;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public String getParticipants() {
		return participants;
	}

	public void setParticipants(String participants) {
		this.participants = participants;
	}

	public Boolean getIsTrace() {
		return isTrace;
	}

	public void setIsTrace(Boolean isTrace) {
		this.isTrace = isTrace;
	}

	public Date getTraceDate() {
		return traceDate;
	}

	public void setTraceDate(Date traceDate) {
		this.traceDate = traceDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getExplain() {
		return explain;
	}

	public void setExplain(String explain) {
		this.explain = explain;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getNumber()).append(getTitle()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Meeting != true)
			return false;
		Meeting other = (Meeting) obj;
		return new EqualsBuilder().append(getNumber(), other.getNumber()).append(getTitle(), other.getTitle()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.number);
		sb.append(",").append(this.title);
		sb.append(",").append(this.locale);
		sb.append(",").append(this.time);
		sb.append(",").append(this.host);
		sb.append(",").append(this.notes);
		sb.append(",").append(this.traceDate);
		sb.append(",").append(this.endDate);
		sb.append(",").append(this.content);
		sb.append(",").append(this.explain);
		sb.append("}");
		return sb.toString();
	}
}
