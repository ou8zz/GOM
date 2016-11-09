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
import com.sqe.gom.constant.ApprovalStatus;
import com.sqe.gom.constant.NeedState;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.ProcessType;

/**
 * @description The trace of process
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jan 25, 2012 1:37:57 PM
 * @version 3.0
 */
@Entity
public class Trace implements Serializable {
	private static final long serialVersionUID = -1870734915476152115L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(nullable = false)
	private Integer processId;

	@Column(length=15)
	private String actor;

	@Column(length=25)
	private String arrow;
	
	@Column(length=20,nullable=false)
	private String icon;

	@Column(length=500)
	private String opinion;

	@Column(length=37)
	private String attachment;

	@Temporal(TemporalType.TIMESTAMP)
	private Date deliverTime;

	@Enumerated(EnumType.ORDINAL)
	private ProcessStatus state;
	
	@ManyToOne(cascade={CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH})
	@JoinColumn(name="process_trace_fk")
	private ProcessInfo process;
	
	@Transient
	private String nodeName;
	@Transient
	private String nodeCode;
	@Transient
	private Integer nodeOrder;
	@Transient
	private String operator;
	@Transient
	private String department;
	@Transient
	private ApprovalStatus approval;
	@Transient
	private String orOpinion;
	@Transient
	private ProcessType type;
	@Transient
	private Boolean needHelp;
	@Transient
	private NeedState needState;
	@Transient
	private String backer;
	@Transient
	private String delay;
	
	

	public Trace() {}

	public Trace(Integer id, Integer processId, String actor,
			String arrow, String icon, String opinion,
			String attachment, Date deliverTime, ProcessStatus state,
			String nodeName, String nodeCode, Integer nodeOrder) {
		this.id = id;
		this.processId = processId;
		this.actor = actor;
		this.arrow = arrow;
		this.icon = icon;
		this.opinion = opinion;
		this.attachment = attachment;
		this.deliverTime = deliverTime;
		this.state = state;
		this.nodeName = nodeName;
		this.nodeCode = nodeCode;
		this.nodeOrder = nodeOrder;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public ProcessType getType() {
		return type;
	}

	public void setType(ProcessType type) {
		this.type = type;
	}

	public Integer getProcessId() {
		return processId;
	}

	public void setProcessId(Integer processId) {
		this.processId = processId;
	}

	public String getActor() {
		return actor;
	}

	public void setActor(String actor) {
		this.actor = actor;
	}

	public String getArrow() {
		return arrow;
	}

	public void setArrow(String arrow) {
		this.arrow = arrow;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getOpinion() {
		return opinion;
	}

	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}

	public String getAttachment() {
		return attachment;
	}

	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}

	public Date getDeliverTime() {
		return deliverTime;
	}

	public void setDeliverTime(Date deliverTime) {
		this.deliverTime = deliverTime;
	}

	public ProcessStatus getState() {
		return state;
	}

	public void setState(ProcessStatus state) {
		this.state = state;
	}

	public ProcessInfo getProcess() {
		return process;
	}

	public void setProcess(ProcessInfo process) {
		this.process = process;
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

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public ApprovalStatus getApproval() {
		return approval;
	}

	public void setApproval(ApprovalStatus approval) {
		this.approval = approval;
	}

	public String getOrOpinion() {
		return orOpinion;
	}

	public void setOrOpinion(String orOpinion) {
		this.orOpinion = orOpinion;
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

	public String getBacker() {
		return backer;
	}

	public void setBacker(String backer) {
		this.backer = backer;
	}

	public String getDelay() {
		return delay;
	}

	public void setDelay(String delay) {
		this.delay = delay;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).append(getOpinion()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Trace != true)
			return false;
		Trace other = (Trace) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getOpinion(), other.getOpinion()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.processId);
		sb.append(",").append(this.arrow);
		sb.append(",").append(this.icon);
		sb.append(",").append(this.opinion);
		sb.append(",").append(this.attachment);
		sb.append(",").append(this.deliverTime);
		sb.append(",").append(this.state);
		sb.append("}");
		return sb.toString();
	}
}
