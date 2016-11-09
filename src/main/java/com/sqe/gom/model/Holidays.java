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
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.google.gson.annotations.Expose;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 8, 2012
 * @version 3.0
 */
@Entity
@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
public class Holidays implements Serializable{
	private static final long serialVersionUID = 3455145900206552162L;
	
	@Expose
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Expose
	@Column(length=15,nullable=false)
	private String name;
	
	@Expose
	@Temporal(TemporalType.DATE)
	private Date startDate;
	
	@Expose
	@Temporal(TemporalType.DATE)
	private Date endDate;
	
	@Expose
	private Integer days;
	
	@OneToMany(cascade=CascadeType.ALL,fetch=FetchType.LAZY, mappedBy ="holidays")
	private Set<Lieu> lieu = new HashSet<Lieu>();
	
	
	public Holidays(){}
	
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public Integer getDays() {
		return days;
	}

	public void setDays(Integer days) {
		this.days = days;
	}

	public Set<Lieu> getLieu() {
		return lieu;
	}

	public void setLieu(Set<Lieu> lieu) {
		this.lieu = lieu;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).append(getName()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Holidays != true)
			return false;
		Holidays other = (Holidays) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getName(), other.getName()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.name);
		sb.append(",").append(this.startDate);
		sb.append(",").append(this.endDate);
		sb.append(",").append(this.days);
		sb.append("}");
		return sb.toString();
	}
}
