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

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.DateRange;
import com.sqe.gom.constant.ItemType;

/**
 * @description	Report entity
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 6, 2013
 * @version 3.0
 */
@Entity
@Table(name="reports")
public class Report implements Serializable {
	private static final long serialVersionUID = -2465209891178216897L;
	
	@Expose
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
	
	@Expose
	@Column(length=6)
	private Float data;				//实际数值
	
	@Expose
	@Enumerated(EnumType.ORDINAL)
	private DateRange type;			//报表类型（目前报表类型为：周报WEEK，月报MONTH）
	
	@Expose
	@Enumerated(EnumType.ORDINAL)
	private ItemType item;			//项目类型（贡献，计划，实际，请假，调休，迟到，早退，延误）
	
	@Expose
	@Temporal(TemporalType.DATE)
	private Date dated;				//日期
	
	@ManyToOne(cascade=CascadeType.MERGE, fetch=FetchType.LAZY)
	@JoinColumn(name="user_reports_fk")
	private GomUser user;	
	
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Float getData() {
		return data;
	}

	public void setData(Float data) {
		this.data = data;
	}

	public DateRange getType() {
		return type;
	}

	public void setType(DateRange type) {
		this.type = type;
	}

	public ItemType getItem() {
		return item;
	}

	public void setItem(ItemType item) {
		this.item = item;
	}

	public Date getDated() {
		return dated;
	}

	public void setDated(Date dated) {
		this.dated = dated;
	}

	public GomUser getUser() {
		return user;
	}

	public void setUser(GomUser user) {
		this.user = user;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).append(getType()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Report != true)
			return false;
		Report other = (Report) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getType(), other.getType()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.data);
		sb.append(",").append(this.type);
		sb.append(",").append(this.item);
		sb.append(",").append(this.dated);
		sb.append("}");
		return sb.toString();
	}
}
