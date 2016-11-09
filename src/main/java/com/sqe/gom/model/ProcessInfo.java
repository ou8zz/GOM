/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import java.io.Serializable;
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
import javax.persistence.Transient;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.AssignType;
import com.sqe.gom.constant.ProcessType;

/**
 * @description
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jun 19, 2012 8:25:13 PM
 * @version 3.0
 */
@Entity
@Table(name="process")
@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
public class ProcessInfo implements Serializable {
	private static final long serialVersionUID = -2775261171865979087L;

	@Expose
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Expose
	@Column(nullable=false)
	private Integer nodeOrder;

	@Expose
	@Enumerated(EnumType.ORDINAL)
	@Column(nullable = false)
	private ProcessType type;

	@Expose
	@Column(length = 10, nullable = false)
	private String nodeCode;

	@Expose
	@Column(length = 20)
	private String nodeName;
	
	@Expose
	@Column(length = 36)
	private String icon;

	@Expose
	@Column(length = 15)
	private String actor;

	@Expose
	@Enumerated(EnumType.ORDINAL)
	@Column(nullable = false)
	private AssignType assignType;
	
	@OneToMany(targetEntity=Trace.class, cascade=CascadeType.ALL,fetch=FetchType.LAZY, mappedBy ="process")
	private Set<Trace> traces = new HashSet<Trace>();
	
	@Expose
	@Transient
	private Integer traceId;
	@Expose
	@Transient
	private String opinion;
	@Expose
	@Transient
	private String process;
	@Expose
	@Transient
	private String excPst;
	@Expose
	@Transient
	private String dptOper;
	
	public ProcessInfo() {}
	
	public ProcessInfo(Integer id, Integer nodeOrder, ProcessType type,
			String nodeCode, String nodeName, String icon, String actor,
			AssignType assignType,Integer traceId, String opinion) {
		this.id = id;
		this.nodeOrder = nodeOrder;
		this.type = type;
		this.nodeCode = nodeCode;
		this.nodeName = nodeName;
		this.icon = icon;
		this.actor = actor;
		this.assignType = assignType;
		this.traceId = traceId;
		this.opinion = opinion;
	}
	
	public ProcessInfo(Integer id, Integer nodeOrder, ProcessType type,
			String nodeCode, String nodeName, String icon, String actor,
			AssignType assignType) {
		this.id = id;
		this.nodeOrder = nodeOrder;
		this.type = type;
		this.nodeCode = nodeCode;
		this.nodeName = nodeName;
		this.icon = icon;
		this.actor = actor;
		this.assignType = assignType;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getNodeOrder() {
		return nodeOrder;
	}

	public void setNodeOrder(Integer nodeOrder) {
		this.nodeOrder = nodeOrder;
	}

	public ProcessType getType() {
		return type;
	}

	public void setType(ProcessType type) {
		this.type = type;
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

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getActor() {
		return actor;
	}

	public void setActor(String actor) {
		this.actor = actor;
	}

	public AssignType getAssignType() {
		return assignType;
	}

	public void setAssignType(AssignType assignType) {
		this.assignType = assignType;
	}

	public Set<Trace> getTraces() {
		return traces;
	}

	public void setTraces(Set<Trace> traces) {
		this.traces = traces;
	}

	public String getProcess() {
		return process;
	}

	public void setProcess(String process) {
		this.process = process;
	}

	public String getExcPst() {
		return excPst;
	}

	public void setExcPst(String excPst) {
		this.excPst = excPst;
	}

	public String getOpinion() {
		return opinion;
	}

	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}

	public Integer getTraceId() {
		return traceId;
	}

	public void setTraceId(Integer traceId) {
		this.traceId = traceId;
	}

	public String getDptOper() {
		return dptOper;
	}

	public void setDptOper(String dptOper) {
		this.dptOper = dptOper;
	}

	public void addTrace(Trace trace) {
		trace.setProcess(this);
		this.traces.add(trace);
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).append(getNodeCode()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof ProcessInfo != true)
			return false;
		ProcessInfo other = (ProcessInfo) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getNodeCode(), other.getNodeCode()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.type);
		sb.append(",").append(this.nodeCode);
		sb.append(",").append(this.nodeName);
		sb.append(",").append(this.icon);
		sb.append(",").append(this.actor);
		sb.append(",").append(this.assignType);
		sb.append("}");
		return sb.toString();
	}
}
