/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.DateRange;
import com.sqe.gom.constant.ProcessStatus;

/**
 * @description 固定工作实体
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 28, 2012
 * @version 3.0
 */
@Entity
public class FixedTask implements Serializable {
	private static final long serialVersionUID = 3998398866714495370L;

	@Expose
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Expose
	@Column(length = 35, nullable = false)
	private String taskTitle; // 任务标题

	@Expose
	@Enumerated(EnumType.ORDINAL)
	private ProcessStatus state; // 任务状态（正在进行-停止）(InProgress-Suspended)

	@Expose
	@Enumerated(EnumType.ORDINAL)
	private DateRange frequency; // 频率周期

	@Expose
	private Short period; // 周期

	@Expose
	private Float hours; // 工时

	@Expose
	@Column(name = "des", length = 500)
	private String describe; // 任务描述

	@Expose
	@Temporal(TemporalType.TIME)
	private Date expectedStart; // 预计开始

	@Expose
	@Temporal(TemporalType.TIME)
	private Date expectedEnd; // 预计结束时间

	@Temporal(TemporalType.TIMESTAMP)
	private Date createDate;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updateDate;

	@OneToMany(cascade = {CascadeType.MERGE, CascadeType.PERSIST}, fetch = FetchType.LAZY, mappedBy = "fixed")
	private Set<Task> tasks = new HashSet<Task>();

	public FixedTask() {}
	
	public FixedTask(Integer id) {this.id=id;}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTaskTitle() {
		return taskTitle;
	}

	public void setTaskTitle(String taskTitle) {
		this.taskTitle = taskTitle;
	}

	public ProcessStatus getState() {
		return state;
	}

	public void setState(ProcessStatus state) {
		this.state = state;
	}

	public DateRange getFrequency() {
		return frequency;
	}

	public void setFrequency(DateRange frequency) {
		this.frequency = frequency;
	}

	public Short getPeriod() {
		return period;
	}

	public void setPeriod(Short period) {
		this.period = period;
	}

	public Float getHours() {
		return hours;
	}

	public void setHours(Float hours) {
		this.hours = hours;
	}

	public String getDescribe() {
		return describe;
	}

	public void setDescribe(String describe) {
		this.describe = describe;
	}

	public Date getExpectedStart() {
		return expectedStart;
	}

	public void setExpectedStart(Date expectedStart) {
		this.expectedStart = expectedStart;
	}

	public Date getExpectedEnd() {
		return expectedEnd;
	}

	public void setExpectedEnd(Date expectedEnd) {
		this.expectedEnd = expectedEnd;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public Set<Task> getTasks() {
		return tasks;
	}

	public void setTasks(Set<Task> tasks) {
		this.tasks = tasks;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getTaskTitle()).append(getCreateDate()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof FixedTask != true)
			return false;
		FixedTask other = (FixedTask) obj;
		return new EqualsBuilder().append(getTaskTitle(), other.getTaskTitle()).append(getCreateDate(), other.getCreateDate()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.taskTitle);
		sb.append(",").append(this.state);
		sb.append(",").append(this.hours);
		sb.append(",").append(this.frequency);
		sb.append(",").append(this.describe);
		sb.append(",").append(this.expectedStart);
		sb.append(",").append(this.expectedEnd);
		sb.append(",").append(this.createDate);
		sb.append(",").append(this.updateDate);
		sb.append("}");
		return sb.toString();
	}
}
