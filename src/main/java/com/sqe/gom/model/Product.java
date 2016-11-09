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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.ProductType;

/**
 * @description Project
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 5, 2012
 * @version 3.0
 */
@Entity
@Table
public class Product implements Serializable {
	private static final long serialVersionUID = 8996661602985799902L;
	
	@Expose
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;		
	
	@Expose
	@Column(length=12,nullable=false)
	private String productName;			//产品名称 
	
	@Expose
	@Enumerated(EnumType.ORDINAL)
	private ProductType productType;	//产品类型
	
	@Expose
	@Column(length=10,nullable=false)
	private String version;				//版本
	
	@Expose
	@Column(length=200,nullable=false)
	private String explains;			//说明
	
	@Expose
	@Column(length=10,nullable=false)
	private Integer num;				//数量 
	
	@Expose
	@Column(length=10,nullable=false)
	private String unit;				//单位
	
	@Expose
	@Temporal(TemporalType.DATE)
	private Date outputDate;			//生产日期
	
	@OneToMany(cascade=CascadeType.ALL,fetch=FetchType.LAZY, mappedBy="product")
	private Set<Project> projects = new HashSet<Project>();
	
	public Product(){}
	
	public Product(Integer id){
		this.id = id;
	}
	
	public Product(Integer id, String productName){
		this.id = id;
		this.productName = productName;
	}
	
	public Product(Integer id,String productName,ProductType productType,String version,String explains,Integer num,String unit,Date outputDate){
		this.id = id;
		this.productName = productName;
		this.productType = productType;
		this.version = version;
		this.explains = explains;
		this.num = num;
		this.unit = unit;
		this.outputDate = outputDate;
	}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public ProductType getProductType() {
		return productType;
	}

	public void setProductType(ProductType productType) {
		this.productType = productType;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getExplains() {
		return explains;
	}

	public void setExplains(String explains) {
		this.explains = explains;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public Date getOutputDate() {
		return outputDate;
	}

	public void setOutputDate(Date outputDate) {
		this.outputDate = outputDate;
	}

	public Set<Project> getProjects() {
		return projects;
	}

	public void setProjects(Set<Project> projects) {
		this.projects = projects;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getProductName()).append(getId()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Product != true)
			return false;
		Product other = (Product) obj;
		return new EqualsBuilder().append(getProductName(), other.getProductName()).append(getId(), other.getId()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.productName);
		sb.append(",").append(this.productType);
		sb.append(",").append(this.version);
		sb.append(",").append(this.explains);
		sb.append(",").append(this.num);
		sb.append(",").append(this.unit);
		sb.append(",").append(this.outputDate);
		sb.append("}");
		return sb.toString();
	}
}
