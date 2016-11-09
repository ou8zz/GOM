/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import java.io.Serializable;

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
import javax.persistence.Transient;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.AbnormalType;
import com.sqe.gom.constant.ProcessStatus;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 8, 2012
 * @version 3.0
 */
@Entity
public class Abnormal implements Serializable {
	private static final long serialVersionUID = 7292068168587925836L;

	@Expose
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Expose
	@Enumerated(EnumType.ORDINAL)
	private AbnormalType type;			//异常类型
	
	@Expose
	@Enumerated(EnumType.ORDINAL)
	private ProcessStatus state;		//流程状态（正在进行-已完成）(InProgress-Completed)
	
	@Expose
	@Column(length=500)
	private String des;					//异常说明
		
	@Expose
	@Column(length=30)
	private String reporter;			//直接汇报人
	
	@Expose
	@Column(length=30)
	private String indirect;			//间接汇报人
	
	@ManyToOne(cascade={CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH})
	@JoinColumn(name="user_abnormal_fk")
	private GomUser user;
	
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
	private String ename;  				// code of user ename
	
	
	
	public Abnormal(){}
	
	public Abnormal(Integer id, AbnormalType type, String reporter, String indirect, String des, String ename) {
		this.id = id;
		this.type = type;
		this.reporter = reporter;
		this.indirect = indirect;
		this.des = des;
		this.ename = ename;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public AbnormalType getType() {
		return type;
	}
	public void setType(AbnormalType type) {
		this.type = type;
	}
	public ProcessStatus getState() {
		return state;
	}
	public void setState(ProcessStatus state) {
		this.state = state;
	}
	public String getDes() {
		return des;
	}
	public void setDes(String des) {
		this.des = des;
	}
	public String getReporter() {
		return reporter;
	}
	public void setReporter(String reporter) {
		this.reporter = reporter;
	}
	public String getIndirect() {
		return indirect;
	}
	public void setIndirect(String indirect) {
		this.indirect = indirect;
	}
	public GomUser getUser() {
		return user;
	}
	public void setUser(GomUser user) {
		this.user = user;
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
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).append(getType()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Abnormal != true)
			return false;
		Abnormal other = (Abnormal) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getType(), other.getType()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.type);
		sb.append(",").append(this.des);
		sb.append(",").append(this.reporter);
		sb.append(",").append(this.indirect);
		sb.append("}");
		return sb.toString();
	}
}
