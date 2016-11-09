/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
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
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.ForeignKey;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.ProjectType;

/**
 * @description Project
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 5, 2012
 * @version 3.0
 */
@Entity
@Table
public class Project implements Serializable {
	private static final long serialVersionUID = 4980408194208305297L;
	
	@Expose
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
	
	@Expose
	@Column(length=30)
	private String projectNo;			//项目编号
	
	@Expose
	@Column(length=30,nullable=false)
	private String projectName;			//项目名称
	
	@Expose
	@Column(length=10)
	private String version;				//版本
	
	@Enumerated(EnumType.ORDINAL)
	private ProjectType type;			//项目类型（项目,模块）
	
	@Expose
	@Column(length=15,nullable=false)
	private String director;			//项目主管
		
	@Expose
	@Temporal(TemporalType.DATE)
	private Date startDate;				//开始时间
	
	@Expose
	@Temporal(TemporalType.DATE)
	private Date endDate;				//预计结束日期

	@Expose
	@Temporal(TemporalType.DATE)
	private Date actualEnd;				//实际结束日期
	
	@Expose
	@Column(length=10)
	private String expectedTime;		//预计工时
	
	@Expose
	@Column(length=10)
	private String actualTime;			//实际工时
	
	@Expose
	@Column(length=200)
	private String des;					//项目说明
	
	@Temporal(TemporalType.DATE)
	private Date updateDate;			//变更时间
	
	@Enumerated(EnumType.ORDINAL)
	private ProcessStatus state;
	
	@ManyToOne(cascade={CascadeType.PERSIST, CascadeType.MERGE}, fetch=FetchType.LAZY)
	@JoinColumn(name="project_product_fk")
	private Product product;
	
	@ManyToOne(targetEntity = Project.class, fetch=FetchType.LAZY)
	@JoinColumn(name = "parentid")
	@ForeignKey(name = "FK_PROJECT_PARENTID")
	private Project parent;

	@OneToMany(cascade={CascadeType.ALL}, mappedBy="parent", fetch=FetchType.LAZY)
	@Fetch(FetchMode.SUBSELECT)  
	private List<Project> children = new ArrayList<Project>();
	
	@OneToMany(cascade=CascadeType.ALL,fetch=FetchType.LAZY, mappedBy="project")
	private Set<Task> tasks = new HashSet<Task>();
	
	@Expose
	@Transient
	private Integer parentId;
	
	@Expose
	@Transient
	private String parentName;
	
	@Expose
	@Transient
	private Integer productId;
	
	@Expose
	@Transient
	private String productName;
	
	@Expose
	@Transient
	private Integer dtrDptId;
	
	public Project(){}
	
	public Project(Integer id){this.id = id;}

	public Project(Integer id, String projectNo, String projectName,
			String version, ProjectType type, String director, Date startDate,
			Date endDate, Date actualEnd, String expectedTime,
			String actualTime, String des, Integer parentId, String parentName, Integer productId, String productName) {
		this.id = id;
		this.projectNo = projectNo;
		this.projectName = projectName;
		this.version = version;
		this.type = type;
		this.director = director;
		this.startDate = startDate;
		this.endDate = endDate;
		this.actualEnd = actualEnd;
		this.expectedTime = expectedTime;
		this.actualTime = actualTime;
		this.des = des;
		this.parentId = parentId;
		this.parentName = parentName;
		this.productId = productId;
		this.productName = productName;
	}
	
	public Project(Integer id,String projectNo,String projectName,String version,Date startDate){
		this.id = id;
		this.projectNo = projectNo;
		this.projectName = projectName;
		this.version = version;
		this.startDate = startDate;
	}
	
	public Project(Integer id,String projectNo,String projectName,String version,String director,
			Date startDate,Date endDate,Date updateDate,Date actualEnd,String expectedTime,
			String actualTime,String des){
		this.id = id;
		this.projectNo = projectNo;
		this.projectName = projectName;
		this.version = version;
		this.director = director;
		this.startDate = startDate;
		this.endDate = endDate;
		this.updateDate = updateDate;
		this.actualEnd = actualEnd;
		this.expectedTime = expectedTime;
		this.actualTime = actualTime;
		this.des = des;
	}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getProjectNo() {
		return projectNo;
	}

	public void setProjectNo(String projectNo) {
		this.projectNo = projectNo;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public ProjectType getType() {
		return type;
	}

	public void setType(ProjectType type) {
		this.type = type;
	}

	public String getDirector() {
		return director;
	}

	public void setDirector(String director) {
		this.director = director;
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

	public Date getActualEnd() {
		return actualEnd;
	}

	public void setActualEnd(Date actualEnd) {
		this.actualEnd = actualEnd;
	}

	public String getExpectedTime() {
		return expectedTime;
	}

	public void setExpectedTime(String expectedTime) {
		this.expectedTime = expectedTime;
	}

	public String getActualTime() {
		return actualTime;
	}

	public void setActualTime(String actualTime) {
		this.actualTime = actualTime;
	}

	public String getDes() {
		return des;
	}

	public void setDes(String des) {
		this.des = des;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public ProcessStatus getState() {
		return state;
	}

	public void setState(ProcessStatus state) {
		this.state = state;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Project getParent() {
		return parent;
	}

	public void setParent(Project parent) {
		this.parent = parent;
	}

	public List<Project> getChildren() {
		return children;
	}

	public void setChildren(List<Project> children) {
		this.children = children;
	}

	public Set<Task> getTasks() {
		return tasks;
	}

	public void setTasks(Set<Task> tasks) {
		this.tasks = tasks;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public Integer getDtrDptId() {
		return dtrDptId;
	}

	public void setDtrDptId(Integer dtrDptId) {
		this.dtrDptId = dtrDptId;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).append(getProjectName()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Project != true)
			return false;
		Project other = (Project) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getProjectName(), other.getProjectName()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.projectNo);
		sb.append(",").append(this.projectName);
		sb.append(",").append(this.version);
		sb.append(",").append(this.director);
		sb.append(",").append(this.startDate);
		sb.append(",").append(this.endDate);
		sb.append(",").append(this.updateDate);
		sb.append(",").append(this.actualEnd);
		sb.append(",").append(this.expectedTime);
		sb.append(",").append(this.actualTime);
		sb.append(",").append(this.des);
		sb.append("}");
		return sb.toString();
	}
}
