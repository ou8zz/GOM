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
import com.sqe.gom.constant.ProcessStatus;

/**
 * @description  departure entity
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date May 4, 2012
 * @version 3.0
 */
@Entity
public class Departure implements Serializable {
	private static final long serialVersionUID = 889913225880181619L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;				//id
	
	@Column(length=200, nullable=false)
	private String reason;	        //离职原因
	
	@Column(length=500)
	private String handover;		//工作交接
	
	@Column(length=15)
	private String recipientDpt;	//接收人部门
	
	@Column(length=15)
	private String recipient;		//接收人
	
	@Column(length=15)
	private String recipientJobNo; //接收人工号
	
	@Column(length=15)
	private String recipientPst; 	//接收人职务
	
	@Temporal(TemporalType.DATE)
	private Date salaryDate;		//工资发放时间
	
	@Column(length=350)
	private String toMailAddr; //process node approval mail address
	
	@Enumerated(EnumType.ORDINAL)
	private ProcessStatus state;   //状态
	
	@ManyToOne(cascade={CascadeType.PERSIST, CascadeType.MERGE})
	@JoinColumn(name="user_departure_fk")
	private GomUser user;
	
	@Transient
	private Date exitDate;			//VO离职日期
	@Transient
	private Date entryDate;			//VO入职日期
	@Transient
	private String accountNo;		//VO银行帐号
	@Transient
	private String userDpt;			//VO部門
	@Transient
	private Integer dptId;    		//英文部门名
	@Transient
	private String userPst;         //VO职务
	@Transient
	private String ename;           //VO英文名
	@Transient
	private String cname;           //VO中文名
	@Transient
	private String jobNo;
	@Transient
	private Integer userId;  //Vo user ID
	@Transient
	private Integer traceId;  // trace identify
	@Transient
	private String opinion;
	@Transient
	private String nodeName;  // name of process node
	@Transient
	private String nodeCode;  //code of process node
	@Transient
	private Integer nodeOrder;
	@Transient
	private ApprovalStatus approval;
	@Transient
	private String attachment;
	@Transient
	private boolean active;

	public Departure() {}
	
	

	public Departure(Integer id, String reason, String handover,
			String recipientDpt, String recipient, String recipientJobNo,
			String recipientPst, Date salaryDate, String toMailAddr,
			Date exitDate, Date entryDate, String accountNo, String userDpt,
			Integer dptId, String userPst, String ename, String cname,
			String jobNo, Integer userId) {
		this.id = id;
		this.reason = reason;
		this.handover = handover;
		this.recipientDpt = recipientDpt;
		this.recipient = recipient;
		this.recipientJobNo = recipientJobNo;
		this.recipientPst = recipientPst;
		this.salaryDate = salaryDate;
		this.toMailAddr = toMailAddr;
		this.exitDate = exitDate;
		this.entryDate = entryDate;
		this.accountNo = accountNo;
		this.userDpt = userDpt;
		this.dptId = dptId;
		this.userPst = userPst;
		this.ename = ename;
		this.cname = cname;
		this.jobNo = jobNo;
		this.userId = userId;
	}
	
	public Departure(Integer id, String reason, String handover, String recipientDpt, String recipient, Date salaryDate,
			Date exitDate, Date entryDate, String accountNo, String ename, String cname,Integer userId, String userDpt, Integer dptId, String userPst) {
		this.id = id;
		this.reason = reason;
		this.handover = handover;
		this.recipientDpt = recipientDpt;
		this.recipient = recipient;
		this.salaryDate = salaryDate;
		this.exitDate = exitDate;
		this.entryDate = entryDate;
		this.accountNo = accountNo;
		this.userDpt = userDpt;
		this.dptId = dptId;
		this.userPst = userPst;
		this.userId = userId;
		this.ename = ename;
		this.cname = cname;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getHandover() {
		return handover;
	}

	public void setHandover(String handover) {
		this.handover = handover;
	}

	public String getRecipientDpt() {
		return recipientDpt;
	}

	public void setRecipientDpt(String recipientDpt) {
		this.recipientDpt = recipientDpt;
	}

	public String getRecipient() {
		return recipient;
	}

	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}

	public String getRecipientJobNo() {
		return recipientJobNo;
	}

	public void setRecipientJobNo(String recipientJobNo) {
		this.recipientJobNo = recipientJobNo;
	}

	public String getRecipientPst() {
		return recipientPst;
	}

	public void setRecipientPst(String recipientPst) {
		this.recipientPst = recipientPst;
	}

	public Date getSalaryDate() {
		return salaryDate;
	}

	public void setSalaryDate(Date salaryDate) {
		this.salaryDate = salaryDate;
	}

	public String getToMailAddr() {
		return toMailAddr;
	}

	public void setToMailAddr(String toMailAddr) {
		this.toMailAddr = toMailAddr;
	}

	public ProcessStatus getState() {
		return state;
	}

	public void setState(ProcessStatus state) {
		this.state = state;
	}

	public GomUser getUser() {
		return user;
	}

	public void setUser(GomUser user) {
		this.user = user;
	}

	public Date getExitDate() {
		return exitDate;
	}

	public void setExitDate(Date exitDate) {
		this.exitDate = exitDate;
	}

	public Date getEntryDate() {
		return entryDate;
	}

	public void setEntryDate(Date entryDate) {
		this.entryDate = entryDate;
	}

	public String getAccountNo() {
		return accountNo;
	}

	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}

	public String getUserDpt() {
		return userDpt;
	}

	public void setUserDpt(String userDpt) {
		this.userDpt = userDpt;
	}

	public Integer getDptId() {
		return dptId;
	}

	public void setDptId(Integer dptId) {
		this.dptId = dptId;
	}

	public String getUserPst() {
		return userPst;
	}

	public void setUserPst(String userPst) {
		this.userPst = userPst;
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

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getTraceId() {
		return traceId;
	}

	public void setTraceId(Integer traceId) {
		this.traceId = traceId;
	}

	public String getOpinion() {
		return opinion;
	}

	public void setOpinion(String opinion) {
		this.opinion = opinion;
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

	public ApprovalStatus getApproval() {
		return approval;
	}

	public void setApproval(ApprovalStatus approval) {
		this.approval = approval;
	}

	public String getAttachment() {
		return attachment;
	}

	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getReason()).append(getId()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if(this == obj) return true;
		if (obj instanceof Departure != true) return false;
		Departure other = (Departure)obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getReason(), other.getReason()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.reason);
		sb.append(",").append(this.handover);
		sb.append(",").append(this.recipientDpt);
		sb.append(",").append(this.recipient);
		sb.append(",").append(this.salaryDate);
		sb.append(",").append(this.state);
		sb.append("}");
		return sb.toString();
	}
}