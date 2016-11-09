/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
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

/**
 * @description The user educated in the past.
 *               职员的受教育或培训经历
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Sep 4, 2011 10:10:07 PM
 * @version 3.0
 */
@Entity
public class Education implements Serializable {
	private static final long serialVersionUID = -1971530704328896396L;
	
	@Expose
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
	
	@Expose
	@Temporal(TemporalType.DATE)
	private Date startDate;
	
	@Expose
	@Temporal(TemporalType.DATE)
	private Date endDate;
	
	@Expose
	@Column(length=16,nullable=false)
	private String ed; // educational background 学历简称 e.g. 高中，大专，本科等,或者也可以是职称
	
	@Expose
	@Column(length=30,nullable=false)
	private String school; // 学校/机构
	
	@Expose
	@Column(length=20,nullable=false)
	private String major; // 专业
	
	@Expose
	@Column(length=30)
	private String idno; // 证书编号
	
	@Expose
	@Column(length=36)
	private String idScan; // 证书JPG扫描件
	
	@ManyToOne(cascade={CascadeType.PERSIST})
	@JoinColumn(name="user_education_fk")
	private GomUser user;
	
	@Expose
	@Transient
	private Integer uid;

	public Integer getId() {
		return id;
	}

	public Date getStartDate() {
		return startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public String getEd() {
		return ed;
	}

	public String getSchool() {
		return school;
	}

	public String getMajor() {
		return major;
	}

	public String getIdno() {
		return idno;
	}

	public String getIdScan() {
		return idScan;
	}

	public GomUser getUser() {
		return user;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public void setEd(String ed) {
		this.ed = ed;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public void setIdno(String idno) {
		this.idno = idno;
	}

	public void setIdScan(String idScan) {
		this.idScan = idScan;
	}

	public void setUser(GomUser user) {
		this.user = user;
	}

	public Integer getUid() {
		return uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getEd()).append(getSchool()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof GomUser != true)
			return false;
		Education other = (Education) obj;
		return new EqualsBuilder().append(getSchool(), other.getSchool()).append(getEd(), other.getEd()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.startDate);
		sb.append(",").append(this.endDate);
		sb.append(",").append(this.ed);
		sb.append(",").append(this.school);
		sb.append(",").append(this.major);
		sb.append(",").append(this.idno);
		sb.append(",").append(this.idScan);
		sb.append("}");
		return sb.toString();
	}
}
