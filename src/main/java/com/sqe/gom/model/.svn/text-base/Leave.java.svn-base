/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import static javax.persistence.TemporalType.TIMESTAMP;
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
import javax.persistence.Transient;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.sqe.gom.constant.ApprovalStatus;
import com.sqe.gom.constant.LeaveType;
import com.sqe.gom.constant.ProcessStatus;

/**
 * @description property of leave entity.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jul 26, 2011 9:24:27 PM
 * @version 3.0
 */
@Entity
@Table(name = "leaves")
public class Leave implements Serializable {
	private static final long serialVersionUID = -8286819822349772539L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Enumerated(EnumType.ORDINAL)
	@Column(nullable = false)
	private LeaveType type;

	@Column(length=150, nullable=false)
	private String event; // explain about this leave

	@Column(length=15, nullable=false)
	private String agentDpt;
	
	@Column(length=15, nullable=false)
	private String agentJobNo;
	
	@Column(length=15, nullable=false)
	private String agentPst;
	
	@Column(length=12, nullable=false)
	private String agentCname;

	@Column(length=12, nullable = false)
	private String agent; // agent ename
	
	@Column(length=15, nullable = false)
	private String recipient;

	@Column(length=500, nullable=false)
	private String handOver; // The applicant transfer to agent things.

	@Temporal(TIMESTAMP)
	@Column(nullable = false)
	private Date startDate;

	@Temporal(TIMESTAMP)
	@Column(nullable = false)
	private Date endDate;

	@Column(nullable = false)
	private Short days;

	@Column(length=30,nullable=false)
	private String contact;

	@Column(length = 300)
	private String relationAddr;

	@Enumerated(EnumType.ORDINAL)
	@Column(nullable = false)
	private ProcessStatus state;

	@Temporal(TIMESTAMP)
	@Column(nullable = false)
	private Date applyDate;

	@ManyToOne(cascade={CascadeType.PERSIST, CascadeType.MERGE}, fetch = FetchType.LAZY)
	@JoinColumn(name = "user_leave_id")
	private GomUser user;

	@Transient
	private String ename;
	@Transient
	private String cname;
	@Transient
	private String jobNo;
	@Transient
	private Integer recipientDpt;
	@Transient
	private Integer dptId;
	@Transient
	private String cdepartment;
	@Transient
	private Integer pstId;
	@Transient
	private String cposition;
	@Transient
	private Integer traceId;
	@Transient
	private Integer nodeOrder;
	@Transient
	private String nodeCode;
	@Transient
	private String nodeName;
	@Transient
	private String opinion;
	@Transient
	private String orOpinion;
	@Transient
	private ApprovalStatus approval;
	@Transient
	private Boolean reported;
	@Transient
	private String superior;
	@Transient
	private String tmp_user;
	@Transient
	private String attachment;

	public Leave() {}
	
	public Leave(Integer id, LeaveType type, String event, String agentDpt,
			String agent, String handOver, Date startDate, Date endDate,
			Short days, String contact, String relationAddr, Date applyDate,
			String ename, String cname, String jobNo, Integer dptId,
			String cdepartment, Integer pstId, String cposition,
			Integer traceId, Integer nodeOrder, String nodeCode,
			String nodeName, String opinion) {
		this.id = id;
		this.type = type;
		this.event = event;
		this.agentDpt = agentDpt;
		this.agent = agent;
		this.handOver = handOver;
		this.startDate = startDate;
		this.endDate = endDate;
		this.days = days;
		this.contact = contact;
		this.relationAddr = relationAddr;
		this.applyDate = applyDate;
		this.ename = ename;
		this.cname = cname;
		this.jobNo = jobNo;
		this.dptId = dptId;
		this.cdepartment = cdepartment;
		this.pstId = pstId;
		this.cposition = cposition;
		this.traceId = traceId;
		this.nodeOrder = nodeOrder;
		this.nodeCode = nodeCode;
		this.nodeName = nodeName;
		this.opinion = opinion;
	}

	public Leave(Integer id, LeaveType type, String event, String agentDpt, String agentJobNo, String agentPst, String agentCname,
			String agent, String recipient, String handOver, Date startDate, Date endDate,
			Short days, String contact, String relationAddr, Date applyDate,
			String ename, String cname, String jobNo, Integer dptId,
			String cdepartment, Integer pstId, String cposition) {
		this.id = id;
		this.type = type;
		this.event = event;
		this.agentDpt = agentDpt;
		this.agentJobNo = agentJobNo;
		this.agentPst = agentPst;
		this.agentCname = agentCname;
		this.agent = agent;
		this.recipient = recipient;
		this.handOver = handOver;
		this.startDate = startDate;
		this.endDate = endDate;
		this.days = days;
		this.contact = contact;
		this.relationAddr = relationAddr;
		this.applyDate = applyDate;
		this.ename = ename;
		this.cname = cname;
		this.jobNo = jobNo;
		this.dptId = dptId;
		this.cdepartment = cdepartment;
		this.pstId = pstId;
		this.cposition = cposition;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public LeaveType getType() {
		return type;
	}

	public void setType(LeaveType type) {
		this.type = type;
	}

	public String getEvent() {
		return event;
	}

	public void setEvent(String event) {
		this.event = event;
	}

	public String getAgentDpt() {
		return agentDpt;
	}

	public void setAgentDpt(String agentDpt) {
		this.agentDpt = agentDpt;
	}

	public String getAgentJobNo() {
		return agentJobNo;
	}

	public void setAgentJobNo(String agentJobNo) {
		this.agentJobNo = agentJobNo;
	}

	public String getAgentPst() {
		return agentPst;
	}

	public void setAgentPst(String agentPst) {
		this.agentPst = agentPst;
	}

	public String getAgentCname() {
		return agentCname;
	}

	public void setAgentCname(String agentCname) {
		this.agentCname = agentCname;
	}

	public String getAgent() {
		return agent;
	}

	public void setAgent(String agent) {
		this.agent = agent;
	}
	

	public String getHandOver() {
		return handOver;
	}

	public void setHandOver(String handOver) {
		this.handOver = handOver;
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

	public Short getDays() {
		return days;
	}

	public void setDays(Short days) {
		this.days = days;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getRelationAddr() {
		return relationAddr;
	}

	public void setRelationAddr(String relationAddr) {
		this.relationAddr = relationAddr;
	}

	public ProcessStatus getState() {
		return state;
	}

	public void setState(ProcessStatus state) {
		this.state = state;
	}

	public Date getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}

	public GomUser getUser() {
		return user;
	}

	public void setUser(GomUser user) {
		this.user = user;
	}

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getJobNo() {
		return jobNo;
	}

	public void setJobNo(String jobNo) {
		this.jobNo = jobNo;
	}

	public Integer getRecipientDpt() {
		return recipientDpt;
	}

	public void setRecipientDpt(Integer recipientDpt) {
		this.recipientDpt = recipientDpt;
	}

	public String getRecipient() {
		return recipient;
	}

	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}

	public Integer getDptId() {
		return dptId;
	}

	public void setDptId(Integer dptId) {
		this.dptId = dptId;
	}

	public String getCdepartment() {
		return cdepartment;
	}

	public void setCdepartment(String cdepartment) {
		this.cdepartment = cdepartment;
	}

	public Integer getPstId() {
		return pstId;
	}

	public void setPstId(Integer pstId) {
		this.pstId = pstId;
	}

	public String getCposition() {
		return cposition;
	}

	public void setCposition(String cposition) {
		this.cposition = cposition;
	}

	public Integer getTraceId() {
		return traceId;
	}

	public void setTraceId(Integer traceId) {
		this.traceId = traceId;
	}

	public Integer getNodeOrder() {
		return nodeOrder;
	}

	public void setNodeOrder(Integer nodeOrder) {
		this.nodeOrder = nodeOrder;
	}

	public String getNodeCode() {
		return nodeCode;
	}

	public void setNodeCode(String nodeCode) {
		this.nodeCode = nodeCode;
	}

	public String getNodeName() {
		return nodeName;
	}

	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}

	public String getOpinion() {
		return opinion;
	}

	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}

	public String getOrOpinion() {
		return orOpinion;
	}

	public void setOrOpinion(String orOpinion) {
		this.orOpinion = orOpinion;
	}

	public ApprovalStatus getApproval() {
		return approval;
	}

	public void setApproval(ApprovalStatus approval) {
		this.approval = approval;
	}

	public Boolean getReported() {
		return reported;
	}

	public void setReported(Boolean reported) {
		this.reported = reported;
	}

	public String getSuperior() {
		return superior;
	}

	public void setSuperior(String superior) {
		this.superior = superior;
	}

	public String getTmp_user() {
		return tmp_user;
	}

	public void setTmp_user(String tmp_user) {
		this.tmp_user = tmp_user;
	}

	public String getAttachment() {
		return attachment;
	}

	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).append(getApplyDate()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Leave != true)
			return false;
		Leave other = (Leave) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getApplyDate(), other.getApplyDate()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.type);
		sb.append(",").append(this.event);
		sb.append(",").append(this.agentDpt);
		sb.append(",").append(this.agent);
		sb.append(",").append(this.handOver);
		sb.append(",").append(this.startDate);
		sb.append(",").append(this.endDate);
		sb.append(",").append(this.days);
		sb.append(",").append(this.contact);
		sb.append(",").append(this.state);
		sb.append(",").append(this.applyDate);
		sb.append("}");
		return sb.toString();
	}
}
