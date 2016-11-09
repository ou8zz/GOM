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
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.TaskType;
import com.sqe.gom.constant.NeedState;

/**
 * @description	工作任务实体
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 28, 2012
 * @version 3.0
 */
@Entity
public class Task implements Serializable {
	private static final long serialVersionUID = 3784093844996737754L;

	@Expose
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
	
	@Expose
	@Column(length=35,nullable=false)
	private String taskTitle;			//任务标题  
	
	@Expose
	@Enumerated(EnumType.ORDINAL)
	private ProcessStatus state;		//任务状态（未分配-正在进行-已完成-已废除）(Ready-InProgress-Completed-Obsolete)
	
	@Expose
	@Enumerated(EnumType.ORDINAL)
	private TaskType taskType;			//工作类型  
	
	@Expose
	@Column(name="des",length=500)
	private String describe;			//任务描述 
	
	@Expose
	private Float expectedHours = 0f;		//预计工时
	
	@Expose
	private Float actualHours = 0f;			//实际工时（可以为空）
	
	@Expose
	@Column(length=10)
	private String completedRate = "0";		//完成比例
	
	@Expose
	@Column(length=10)
	private String occupyRate;			//模块占用比例（只对项目任务）
	
	@Expose
	@Column(length=15)
	private String executor;			//执行人
	
	@Expose
	@Column(length=15)
	private String assignor;			//指派人 
	
	@Expose
	@Temporal(TemporalType.TIMESTAMP)
	private Date expectedStart;			//预计开始时间 
	
	@Expose
	@Temporal(TemporalType.TIMESTAMP)
	private Date expectedEnd;			//预计结束时间 
	
	@Expose
	@Temporal(TemporalType.TIMESTAMP)
	private Date actualStart;			//实际开始时间 
	
	@Expose
	@Temporal(TemporalType.TIMESTAMP)
	private Date actualEnd;				//实际结束时间
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date createDate;  			//创建时间
	
	@Expose
	private Boolean needHelp;			//是否需要帮忙(true为是，false为否)
	
	@Expose
	@Enumerated(EnumType.ORDINAL)
	private NeedState needState;		//需要帮忙状况{EXIGENCY("紧急"),GENERAL("一般"),SECONDARY("次要");}
	
	@Expose
	@Column(length=50)
	private String delay;				//工作延误原因
	
	@ManyToOne(cascade={CascadeType.PERSIST, CascadeType.MERGE})
	@JoinColumn(name="task_respon_fk")
	private Responsibility responsibility;
	
	@ManyToOne(cascade={CascadeType.PERSIST, CascadeType.MERGE})
	@JoinColumn(name="task_project_fk")
	private Project project;
	
	@ManyToOne(cascade={CascadeType.PERSIST, CascadeType.MERGE})
	@JoinColumn(name="task_fixed_fk")
	private FixedTask fixed;
	
	@Expose
	@Transient
	private Integer proId;				//项目号（仅VO使用）
	@Expose
	@Transient
	private Integer fixedId;			//固定工作号（仅VO使用）
	@Expose
	@Transient
	private String responId;			//责任管理ID（仅VO使用）
	@Expose
	@Transient
	private Integer traceId;  			// trace identify
	@Expose
	@Transient
	private String nodeName;  			// name of process node
	@Expose
	@Transient
	private String nodeCode;  			// code of process node
	@Expose
	@Transient
	private Integer nodeOrder;
	@Expose
	@Transient
	private String attachment;
	@Expose
	@Transient
	private String swot = "green";
	
	
	public Task(){}
	
	public Task(Integer id, String taskTitle, ProcessStatus state, TaskType taskType, Float expectedHours, Float actualHours,String completedRate,String occupyRate,
			String executor, String assignor, Date expectedStart, Date expectedEnd, Date actualStart, Date actualEnd, Date createDate, String describe, String delay) {
		this.id = id;
		this.taskTitle = taskTitle;
		this.state = state;
		this.taskType = taskType;
		this.expectedHours = expectedHours;
		this.actualHours = actualHours;
		this.completedRate = completedRate;
		this.occupyRate = occupyRate;
		this.executor = executor;
		this.assignor = assignor;
		this.expectedStart = expectedStart;
		this.expectedEnd = expectedEnd;
		this.actualStart = actualStart;
		this.actualEnd = actualEnd;
		this.createDate = createDate;
		this.describe = describe;
		this.delay = delay;
	}
		
	public Task(Integer fixedId, String taskTitle, ProcessStatus state, TaskType taskType, Float expectedHours, Date expectedStart, String describe) {
		this.fixedId = fixedId;
		this.taskTitle = taskTitle;
		this.state = state;
		this.taskType = taskType;
		this.expectedHours = expectedHours;
		this.expectedStart = expectedStart;
		this.describe = describe;
	}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getProId() {
		return proId;
	}

	public void setProId(Integer proId) {
		this.proId = proId;
	}

	public Integer getFixedId() {
		return fixedId;
	}

	public void setFixedId(Integer fixedId) {
		this.fixedId = fixedId;
	}

	public String getResponId() {
		return responId;
	}

	public void setResponId(String responId) {
		this.responId = responId;
	}

	public String getTaskTitle() {
		return taskTitle;
	}

	public void setTaskTitle(String taskTitle) {
		this.taskTitle = taskTitle;
	}

	public ProcessStatus getState() {
		return state;
	}

	public void setState(ProcessStatus state) {
		this.state = state;
	}

	public TaskType getTaskType() {
		return taskType;
	}

	public void setTaskType(TaskType taskType) {
		this.taskType = taskType;
	}

	public String getDescribe() {
		return describe;
	}

	public void setDescribe(String describe) {
		this.describe = describe;
	}

	public Float getActualHours() {
		return actualHours;
	}

	public void setActualHours(Float actualHours) {
		this.actualHours = actualHours;
	}

	public String getOccupyRate() {
		return occupyRate;
	}

	public void setOccupyRate(String occupyRate) {
		this.occupyRate = occupyRate;
	}

	public String getCompletedRate() {
		return completedRate;
	}

	public void setCompletedRate(String completedRate) {
		this.completedRate = completedRate;
	}

	public String getExecutor() {
		return executor;
	}

	public void setExecutor(String executor) {
		this.executor = executor;
	}

	public String getAssignor() {
		return assignor;
	}

	public void setAssignor(String assignor) {
		this.assignor = assignor;
	}

	public Float getExpectedHours() {
		return expectedHours;
	}

	public void setExpectedHours(Float expectedHours) {
		this.expectedHours = expectedHours;
	}

	public Date getExpectedStart() {
		return expectedStart;
	}

	public void setExpectedStart(Date expectedStart) {
		this.expectedStart = expectedStart;
	}

	public Date getExpectedEnd() {
		return expectedEnd;
	}

	public void setExpectedEnd(Date expectedEnd) {
		this.expectedEnd = expectedEnd;
	}

	public Date getActualStart() {
		return actualStart;
	}

	public void setActualStart(Date actualStart) {
		this.actualStart = actualStart;
	}

	public Date getActualEnd() {
		return actualEnd;
	}

	public void setActualEnd(Date actualEnd) {
		this.actualEnd = actualEnd;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Responsibility getResponsibility() {
		return responsibility;
	}

	public void setResponsibility(Responsibility responsibility) {
		this.responsibility = responsibility;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public FixedTask getFixed() {
		return fixed;
	}

	public void setFixed(FixedTask fixed) {
		this.fixed = fixed;
	}

	public Integer getTraceId() {
		return traceId;
	}

	public void setTraceId(Integer traceId) {
		this.traceId = traceId;
	}

	public String getNodeName() {
		return nodeName;
	}

	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}

	public String getNodeCode() {
		return nodeCode;
	}

	public void setNodeCode(String nodeCode) {
		this.nodeCode = nodeCode;
	}

	public Integer getNodeOrder() {
		return nodeOrder;
	}

	public void setNodeOrder(Integer nodeOrder) {
		this.nodeOrder = nodeOrder;
	}

	public String getAttachment() {
		return attachment;
	}

	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}

	public Boolean getNeedHelp() {
		return needHelp;
	}

	public void setNeedHelp(Boolean needHelp) {
		this.needHelp = needHelp;
	}

	public NeedState getNeedState() {
		return needState;
	}

	public void setNeedState(NeedState needState) {
		this.needState = needState;
	}

	public String getDelay() {
		return delay;
	}

	public void setDelay(String delay) {
		this.delay = delay;
	}

	public String getSwot() {
		return swot;
	}

	public void setSwot(String swot) {
		this.swot = swot;
	}

	
	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getTaskTitle()).append(getTaskTitle()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Task != true)
			return false;
		Task other = (Task) obj;
		return new EqualsBuilder().append(getTaskTitle(), other.getTaskTitle()).append(getTaskType(), other.getTaskType()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.taskTitle);
		sb.append(",").append(this.state);
		sb.append(",").append(this.taskType);
		sb.append(",").append(this.responsibility);
		sb.append(",").append(this.describe);
		sb.append(",").append(this.expectedHours);
		sb.append(",").append(this.actualHours);
		sb.append(",").append(this.completedRate);
		sb.append(",").append(this.executor);
		sb.append(",").append(this.assignor);
		sb.append(",").append(this.expectedStart);
		sb.append(",").append(this.expectedEnd);
		sb.append(",").append(this.actualStart);
		sb.append(",").append(this.actualEnd);
		sb.append(",").append(this.createDate);
		sb.append("}");
		return sb.toString();
	}
}
