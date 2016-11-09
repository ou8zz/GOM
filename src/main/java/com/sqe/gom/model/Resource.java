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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.apache.commons.lang.builder.EqualsBuilder;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.ResourceType;

/**
 * @description Resource authority of Resource
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 9, 2011 8:59:41 PM
 * @version 3.0
 */
@Entity
@Table
public class Resource implements Serializable {
	private static final long serialVersionUID = 3352074887945402202L;

	@Expose
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Expose
	@Column(length = 15)
	private String number;			//标准编号
	
	@Expose
	@Column(length = 15)
	private String level;					
	
	@Expose
	@Enumerated(EnumType.ORDINAL)
	private ResourceType resourceType;

	@Expose
	@Column(length = 15, nullable = false)
	private String version;

	@Expose
	@Column(length = 50, nullable = false)
	private String title;
	
	@Expose
	@Column(length = 500, nullable = false)
	private String des;
	
	@Expose
	@Column(length = 36, nullable = false)
	private String attachment;
	
	@Expose
	@Temporal(TemporalType.DATE)
	private Date createDate;
	
	@Expose
	@Temporal(TemporalType.DATE)
	private Date updateDate;
	
	@Expose
	private Boolean isValid;
	
	@Expose
	@Temporal(TemporalType.DATE)
	private Date uploadDate;
	
	@Expose
	@Column(length = 16, nullable = false)
	private String uploadEname;
	
	@Expose
	@Column(length = 20, nullable = false)
	private String maintainDpt;
	
	@Expose
	@Temporal(TemporalType.DATE)
	private Date downloadDate;				//HOW 下载日期
	
	@Expose
	private Integer responsibility;			//管理责任
	
	@Expose
	private int score;						//HOW 责任分数
	
	@Expose
	private String swot;					//HOW swot
	
	@ManyToOne(cascade={CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}, fetch=FetchType.LAZY)
	@JoinColumn(name="category_resource_fk")
	private Category category;
	
	@OneToMany(cascade={CascadeType.PERSIST, CascadeType.REFRESH},fetch=FetchType.LAZY, mappedBy ="resource")
	private Set<Experience> experience = new HashSet<Experience>();
	
	
	
	@Expose
	@Transient
	private Integer path;					//分类路径（仅VO使用）
	@Expose
	@Transient
	private int resourceId;					//如何做ID（仅VO使用）
	@Expose
	@Transient
	private String howGain;					//如何做内容（仅VO使用）
	@Expose
	@Transient
	private String student;					//如何做用户（仅VO使用）
	
	
	
	public Resource() { }

	public Resource(Integer id, Integer path, ResourceType resourceType, String number, String version, String title, 
			String des, String attachment, Date createDate, Date updateDate, Boolean isValid,
			Date uploadDate, String uploadEname, String maintainDpt, Date downloadDate, 
			Integer responsibility, int score, String swot) {
		this.id = id;
		this.path = path;
		this.resourceType = resourceType;
		this.number = number;
		this.version = version;
		this.title = title;
		this.des = des;
		this.attachment = attachment;
		this.createDate = createDate;
		this.updateDate = updateDate;
		this.isValid = isValid;
		this.uploadDate = uploadDate;
		this.uploadEname = uploadEname;
		this.maintainDpt = maintainDpt;
		this.uploadDate = uploadDate;
		this.downloadDate = downloadDate;
		this.responsibility = responsibility;
		this.score = score;
		this.swot = swot;
	}
	
	public Resource(Integer id, ResourceType resourceType, String number, String version, String title, 
			String des, String attachment, Date createDate, Date updateDate, Boolean isValid,
			Date uploadDate, String uploadEname, String maintainDpt, Date downloadDate, 
			Integer responsibility, int score, String swot, String student, String howGain) {
		this.id = id;
		this.resourceType = resourceType;
		this.number = number;
		this.version = version;
		this.title = title;
		this.des = des;
		this.attachment = attachment;
		this.createDate = createDate;
		this.updateDate = updateDate;
		this.isValid = isValid;
		this.uploadDate = uploadDate;
		this.uploadEname = uploadEname;
		this.maintainDpt = maintainDpt;
		this.uploadDate = uploadDate;
		this.downloadDate = downloadDate;
		this.responsibility = responsibility;
		this.score = score;
		this.swot = swot;
		this.student = student;
		this.howGain = howGain;
	}
		
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getPath() {
		return path;
	}

	public void setPath(Integer path) {
		this.path = path;
	}

	public int getResourceId() {
		return resourceId;
	}

	public void setResourceId(int resourceId) {
		this.resourceId = resourceId;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getHowGain() {
		return howGain;
	}

	public void setHowGain(String howGain) {
		this.howGain = howGain;
	}

	public ResourceType getResourceType() {
		return resourceType;
	}

	public void setResourceType(ResourceType resourceType) {
		this.resourceType = resourceType;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDes() {
		return des;
	}

	public void setDes(String des) {
		this.des = des;
	}

	public String getAttachment() {
		return attachment;
	}

	public void setAttachment(String attachment) {
		this.attachment = attachment;
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

	public Boolean getIsValid() {
		return isValid;
	}

	public void setIsValid(Boolean isValid) {
		this.isValid = isValid;
	}

	public Date getUploadDate() {
		return uploadDate;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

	public String getUploadEname() {
		return uploadEname;
	}

	public void setUploadEname(String uploadEname) {
		this.uploadEname = uploadEname;
	}

	public String getMaintainDpt() {
		return maintainDpt;
	}

	public void setMaintainDpt(String maintainDpt) {
		this.maintainDpt = maintainDpt;
	}

	public Date getDownloadDate() {
		return downloadDate;
	}

	public void setDownloadDate(Date downloadDate) {
		this.downloadDate = downloadDate;
	}

	public Integer getResponsibility() {
		return responsibility;
	}

	public void setResponsibility(Integer responsibility) {
		this.responsibility = responsibility;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getSwot() {
		return swot;
	}

	public void setSwot(String swot) {
		this.swot = swot;
	}

	public String getStudent() {
		return student;
	}

	public void setStudent(String student) {
		this.student = student;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Set<Experience> getExperience() {
		return experience;
	}

	public void setExperience(Set<Experience> experience) {
		this.experience = experience;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Resource != true)
			return false;
		Resource other = (Resource) obj;
		return new EqualsBuilder().append(getId(), other.getId())
				.append(getVersion(), other.getVersion()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id).append(",");
		sb.append(this.number).append(",");
		sb.append(this.version).append(",");
		sb.append(this.title).append(",");
		sb.append(this.des).append(",");
		sb.append(this.attachment).append(",");
		sb.append(this.uploadEname).append(",");
		sb.append(this.updateDate).append(",");
		sb.append(this.uploadDate).append(",");
		sb.append(this.resourceId).append(",");
		sb.append(this.howGain).append(",");
		sb.append("}");
		return sb.toString();
	}
}
