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
import javax.persistence.Transient;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.TrainingType;

/**
 * @description 培训实体映射表
 * @author OLE 
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 9, 2012
 * @version 3.0
 */
@Table
@Entity
public class Training implements Serializable {
	private static final long serialVersionUID = 8746108676961165383L;

	@Expose
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;					//ID号	
	
	@Expose
	@Column(length=30,nullable=false)
	private String tprogram;			//训练项目    
	
	@Expose
	@Column(length=12,nullable=false)
	private String lecturer;			//讲师   
	
	@Expose
	@Enumerated(EnumType.ORDINAL)
	private TrainingType trainingType; 	//培训类型   
	
	@Expose
	@Column(nullable=false)
	private float trainingTime;			//训练时数
	
	@Expose
	private double fee;					//上课费用
	
	@Expose
	private double otherFee;			//其它费用
	
	@Expose
	@Temporal(TemporalType.DATE)
	@Column(nullable=false)
	private Date startDate;				//开始日期  
	
	@Expose
	@Temporal(TemporalType.DATE)
	@Column(nullable=false)
	private Date endDate;				//结束日期  
	
	@Expose
	@Column(length=100,nullable=false)
	private String qualification;		//讲师资质
	
	@Expose
	@Column(length=500,nullable=false)
	private String tcontent;			//内容   
	
	@Expose
	@Transient
	private Integer experienceId;		//心得ID  <仅VO使用>
	
	@Expose
	@Transient
	private String gain;				//心得	<仅VO使用>
	
	@OneToMany(cascade=CascadeType.ALL,fetch=FetchType.EAGER, mappedBy ="training")
	private Set<Experience> experience = new HashSet<Experience>();
	
	
	public Training(){}
	
	public Training(Integer id, String tprogram, String lecturer, TrainingType trainingType, float trainingTime, 
			double fee, double otherFee, Date startDate, Date endDate, String qualification, String tcontent){
		this.id = id;
		this.tprogram = tprogram;
		this.lecturer = lecturer;
		this.trainingType = trainingType;
		this.trainingTime = trainingTime;
		this.fee = fee;
		this.otherFee = otherFee;
		this.startDate = startDate;
		this.endDate = endDate;
		this.qualification = qualification;
		this.tcontent = tcontent;
	}
	
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getExperienceId() {
		return experienceId;
	}

	public void setExperienceId(Integer experienceId) {
		this.experienceId = experienceId;
	}

	public String getGain() {
		return gain;
	}

	public void setGain(String gain) {
		this.gain = gain;
	}

	public String getTprogram() {
		return tprogram;
	}

	public void setTprogram(String tprogram) {
		this.tprogram = tprogram;
	}

	public String getLecturer() {
		return lecturer;
	}

	public void setLecturer(String lecturer) {
		this.lecturer = lecturer;
	}

	public TrainingType getTrainingType() {
		return trainingType;
	}

	public void setTrainingType(TrainingType trainingType) {
		this.trainingType = trainingType;
	}

	public float getTrainingTime() {
		return trainingTime;
	}

	public void setTrainingTime(float trainingTime) {
		this.trainingTime = trainingTime;
	}

	public double getFee() {
		return fee;
	}

	public void setFee(double fee) {
		this.fee = fee;
	}

	public double getOtherFee() {
		return otherFee;
	}

	public void setOtherFee(double otherFee) {
		this.otherFee = otherFee;
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

	public String getQualification() {
		return qualification;
	}

	public void setQualification(String qualification) {
		this.qualification = qualification;
	}

	public String getTcontent() {
		return tcontent;
	}

	public void setTcontent(String tcontent) {
		this.tcontent = tcontent;
	}

	public Set<Experience> getExperience() {
		return experience;
	}


	public void setExperience(Set<Experience> experience) {
		this.experience = experience;
	}


	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).append(getTprogram()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Leave != true)
			return false;
		Training other = (Training) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getTprogram(), other.getTprogram()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.tprogram);
		sb.append(",").append(this.lecturer);
		sb.append(",").append(this.trainingTime);
		sb.append(",").append(this.fee);
		sb.append(",").append(this.otherFee);
		sb.append(",").append(this.startDate);
		sb.append(",").append(this.endDate);
		sb.append(",").append(this.qualification);
		sb.append(",").append(this.tcontent);
		sb.append("}");
		return sb.toString();
	}
}
