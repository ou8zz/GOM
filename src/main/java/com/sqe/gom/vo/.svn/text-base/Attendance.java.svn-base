/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.vo;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.DateRange;

/**
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date May 26, 2012
 * @version 3.0
 */
public class Attendance implements Serializable {
	private static final long serialVersionUID = 8154176413911646940L;

	@Expose
	private String jobNo;
	@Expose
	private String ename;
	@Expose
	private DateRange range;
	@Expose
	private Float day = 0f;
	@Expose
	private Float hours = 0f;
	@Expose
	private Integer leave = 0;
	@Expose
	private Integer late = 0;
	@Expose
	private Integer compensatory = 0;
	@Expose
	private Date des;
	
	
	public String getJobNo() {
		return jobNo;
	}

	public void setJobNo(String jobNo) {
		this.jobNo = jobNo;
	}

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public DateRange getRange() {
		return range;
	}

	public void setRange(DateRange range) {
		this.range = range;
	}

	public Float getDay() {
		return day;
	}

	public void setDay(Float day) {
		this.day = day;
	}

	public Float getHours() {
		return hours;
	}

	public void setHours(Float hours) {
		this.hours = hours;
	}

	public Integer getLeave() {
		return leave;
	}

	public void setLeave(Integer leave) {
		this.leave = leave;
	}

	public Integer getLate() {
		return late;
	}

	public void setLate(Integer late) {
		this.late = late;
	}

	public Integer getCompensatory() {
		return compensatory;
	}

	public void setCompensatory(Integer compensatory) {
		this.compensatory = compensatory;
	}

	public Date getDes() {
		return des;
	}

	public void setDes(Date des) {
		this.des = des;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getJobNo()).append(getEname()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if(this == obj) return true;
		if(obj instanceof Attendance != true) return false;
		Attendance other = (Attendance) obj;
		return new EqualsBuilder().append(getJobNo(), other.getJobNo()).append(getEname(), other.getEname()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.jobNo);
		sb.append(",").append(this.ename);
		sb.append(",").append(this.range);
		sb.append(",").append(this.day);
		sb.append(",").append(this.hours);
		sb.append(",").append(this.leave);
		sb.append(",").append(this.late);
		sb.append(",").append(this.compensatory);
		sb.append(",").append(this.des);
		sb.append("}");
		return sb.toString();
	}
}
