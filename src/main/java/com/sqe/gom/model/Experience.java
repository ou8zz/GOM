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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

/**
 * @description 培训心得实体映射表
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 9, 2012
 * @version 3.0
 */
@Table
@Entity
public class Experience implements Serializable {
	private static final long serialVersionUID = -5481780019930500944L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;					//id号
	
	@Column(length=15,nullable=false)
	private String student;				//学员		// 添加人
	
	@Temporal(TemporalType.DATE)
	private Date createDate;			//创建日期   	//添加日期
	
	//@Type(type="text")
	@Column(name="gain",columnDefinition="TEXT")
	private String gain;				//心得收获 	 //如何做的内容
	
	@ManyToOne(cascade={CascadeType.PERSIST, CascadeType.MERGE})
	@JoinColumn(name="training_experience_fk")
	private Training training;
	
	@ManyToOne(cascade={CascadeType.PERSIST, CascadeType.MERGE})
	@JoinColumn(name="resource_how_fk")
	private Resource resource;
	
	@Transient
	private Integer trainingId;			//培训ID
	@Transient
	private Integer resourceId;			//如何做ID
	@Transient
	private String title;				//文件主旨
	@Transient
	private String number;				//文件编号
	@Transient
	private String swot = "green";		//SWOT
	
	
	
	public Experience(){}
	
	public Experience(Integer id, String student, Date createDate, String gain){
		this.id = id;
		this.student = student;
		this.createDate = createDate;
		this.gain = gain;
	}
	
	public Experience(Integer id, String student, Date createDate, String gain, String title, String number){
		this.id = id;
		this.student = student;
		this.createDate = createDate;
		this.gain = gain;
		this.title = title;
		this.number = number;
	}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getTrainingId() {
		return trainingId;
	}

	public void setTrainingId(Integer trainingId) {
		this.trainingId = trainingId;
	}

	public Integer getResourceId() {
		return resourceId;
	}

	public void setResourceId(Integer resourceId) {
		this.resourceId = resourceId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getStudent() {
		return student;
	}

	public void setStudent(String student) {
		this.student = student;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getGain() {
		return gain;
	}

	public void setGain(String gain) {
		this.gain = gain;
	}

	public String getSwot() {
		return swot;
	}

	public void setSwot(String swot) {
		this.swot = swot;
	}

	public Training getTraining() {
		return training;
	}

	public void setTraining(Training training) {
		this.training = training;
	}

	public Resource getResource() {
		return resource;
	}

	public void setResource(Resource resource) {
		this.resource = resource;
	}


	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).append(getStudent()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Experience != true)
			return false;
		Experience other = (Experience) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getStudent(), other.getStudent()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.student);
		sb.append(",").append(this.createDate);
		sb.append(",").append(this.gain);
		sb.append("}");
		return sb.toString();
	}
}
