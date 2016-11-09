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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.OverTimeType;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 8, 2012
 * @version 3.0
 */
@Entity
public class Lieu implements Serializable {
	private static final long serialVersionUID = 6924045733985010888L;

	@Expose
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Expose
	@Enumerated(EnumType.ORDINAL)
	private OverTimeType type;
	
	@Expose
	@Temporal(TemporalType.DATE)
	private Date dayoff;
	
	@Expose
	@Temporal(TemporalType.DATE)
	private Date workedon;
	
	@Expose
	@Column(length=30)
	private String explanation;
	
	@ManyToOne(cascade={CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}, fetch=FetchType.LAZY)
	@JoinColumn(name="user_lieu_fk")
	private GomUser user;	
	
	@ManyToOne(cascade={CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}, fetch=FetchType.LAZY)
	@JoinColumn(name="holidays_lieu_fk")
	private Holidays holidays;
	
	@Expose
	@Transient
	private Integer holidaysId;
	
	public Lieu(){}
	
	public Lieu(Integer id, OverTimeType type, Date dayoff, Date workedon, String explanation, Integer holidaysId) {
		this.id = id;
		this.type = type;
		this.dayoff = dayoff;
		this.workedon = workedon;
		this.explanation = explanation;
		this.holidaysId = holidaysId;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public OverTimeType getType() {
		return type;
	}
	public void setType(OverTimeType type) {
		this.type = type;
	}
	public Date getDayoff() {
		return dayoff;
	}
	public void setDayoff(Date dayoff) {
		this.dayoff = dayoff;
	}
	public Date getWorkedon() {
		return workedon;
	}
	public void setWorkedon(Date workedon) {
		this.workedon = workedon;
	}
	public String getExplanation() {
		return explanation;
	}
	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}
	public GomUser getUser() {
		return user;
	}
	public void setUser(GomUser user) {
		this.user = user;
	}
	public Holidays getHolidays() {
		return holidays;
	}
	public void setHolidays(Holidays holidays) {
		this.holidays = holidays;
	}
	public Integer getHolidaysId() {
		return holidaysId;
	}
	public void setHolidaysId(Integer holidaysId) {
		this.holidaysId = holidaysId;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).append(getType()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Lieu != true)
			return false;
		Lieu other = (Lieu) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getType(), other.getType()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.type);
		sb.append(",").append(this.dayoff);
		sb.append(",").append(this.workedon);
		sb.append(",").append(this.explanation);
		sb.append("}");
		return sb.toString();
	}
}
