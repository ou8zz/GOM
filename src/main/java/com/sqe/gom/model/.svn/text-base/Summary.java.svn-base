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

/**
 * @description Summary实体映射表
 * @author OLE 
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 9, 2012
 * @version 3.0
 */
@Table
@Entity
public class Summary implements Serializable {
	private static final long serialVersionUID = -7573512164501426720L;

	@Expose
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;				//ID号	
	
	@Expose
	@Column(length=6)
	private Float data;				//实际数值
	
	@Expose
	@Temporal(TemporalType.DATE)
	private Date dated;				//创建日期
		
	@Expose
	@Enumerated(EnumType.ORDINAL)
	private DateMarkType dateMark;	//班期状态
	
	@ManyToOne(cascade={CascadeType.PERSIST, CascadeType.MERGE}, fetch=FetchType.LAZY)
	@JoinColumn(name = "config_summarys_fk")
	private SwotConfig swotConfig;
	
	@ManyToOne(cascade=CascadeType.MERGE, fetch=FetchType.LAZY)
	@JoinColumn(name="user_summarys_fk")
	private GomUser user;	
	
	@Expose
	@Transient
	private String swot;  //VO 统计项目 {贡献，计划，实际，请假，调休，迟到，早退，延误}
	
	@Expose
	@Transient
	private String item;
	
	public Summary(){}
	
	//统计数据返回结果集
	public Summary(Float data, String item){
		this.data = data;
		this.item = item;
	}
	
	public Summary(Integer id, Float data, Date dated, DateMarkType dateMark){
		this.id = id;
		this.data = data;
		this.dated = dated;
		this.dateMark = dateMark;
	}
	
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

	public Date getDated() {
		return dated;
	}

	public void setDated(Date dated) {
		this.dated = dated;
	}

	public DateMarkType getDateMark() {
		return dateMark;
	}

	public void setDateMark(DateMarkType dateMark) {
		this.dateMark = dateMark;
	}

	public SwotConfig getSwotConfig() {
		return swotConfig;
	}

	public void setSwotConfig(SwotConfig swotConfig) {
		this.swotConfig = swotConfig;
	}

	public String getSwot() {
		return swot;
	}

	public void setSwot(String swot) {
		this.swot = swot;
	}

	public String getItem() {
		return item;
	}

	public void setItem(String item) {
		this.item = item;
	}

	public GomUser getUser() {
		return user;
	}

	public void setUser(GomUser user) {
		this.user = user;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).append(getDated()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Summary != true)
			return false;
		Summary other = (Summary) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getDated(), other.getDated()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.data);
		sb.append(",").append(this.swot);
		sb.append(",").append(this.dated);
		sb.append(",").append(this.dateMark);
		sb.append("}");
		return sb.toString();
	}
}
