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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.ApplyState;

/**
 * @description 借据实体表
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Entity
@Table
public class Borrow implements Serializable {
	private static final long serialVersionUID = 6424744597701975913L;

	@Expose
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id; 				// ID

	@Expose
	@Column(length = 50, nullable = false)
	private String funCode = "FunCode"; // 功能代码

	@Expose
	@Enumerated(EnumType.ORDINAL)
	private ApplyState applyState; 		// 申领状态

	@Expose
	@Column(nullable = false)
	private Integer receiveNum; 		// 领取数量

	@Expose
	@Column(length = 12, nullable = false)
	private String receiver; 			// 领用人

	@Expose
	@Temporal(TemporalType.DATE)
	private Date receiveDate; 			// 领取日期

	@Expose
	@Temporal(TemporalType.DATE)
	private Date returnDate; 			// 交还日期

	@Expose
	@Column(length = 12, nullable = false)
	private String overStaff; 			// 接管员

	@Expose
	@Column(length = 80, nullable = true)
	private String remark; 				// 备注

	@ManyToOne(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinColumn(name = "asset_borrow_fk")
	private Asset asset;
	
	@Expose
	@Transient
	private Integer assetId;			// 资产ID(只做VO用)
	@Expose
	@Transient
	private String assetName;			//资产Name(只做VO用)
	@Expose
	@Transient
	private String swot = "green";		//SWOT
	
	
	public Borrow() {}

	public Borrow(Integer id, Integer assetId, String assetName, String funCode, ApplyState applyState,
			Integer receiveNum, String receiver, Date receiveDate, Date returnDate, String overStaff, 
			String remark) {
		this.id = id;
		this.assetId = assetId;
		this.assetName = assetName;
		this.funCode = funCode;
		this.applyState = applyState;
		this.receiveNum = receiveNum;
		this.receiver = receiver;
		this.receiveDate = receiveDate;
		this.returnDate = returnDate;
		this.overStaff = overStaff;
		this.remark = remark;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getAssetId() {
		return assetId;
	}

	public void setAssetId(Integer assetId) {
		this.assetId = assetId;
	}

	public String getAssetName() {
		return assetName;
	}

	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}

	public String getFunCode() {
		return funCode;
	}

	public void setFunCode(String funCode) {
		this.funCode = funCode;
	}

	public ApplyState getApplyState() {
		return applyState;
	}

	public void setApplyState(ApplyState applyState) {
		this.applyState = applyState;
	}

	public Integer getReceiveNum() {
		return receiveNum;
	}

	public void setReceiveNum(Integer receiveNum) {
		this.receiveNum = receiveNum;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public Date getReceiveDate() {
		return receiveDate;
	}

	public void setReceiveDate(Date receiveDate) {
		this.receiveDate = receiveDate;
	}

	public Date getReturnDate() {
		return returnDate;
	}

	public void setReturnDate(Date returnDate) {
		this.returnDate = returnDate;
	}

	public String getOverStaff() {
		return overStaff;
	}

	public void setOverStaff(String overStaff) {
		this.overStaff = overStaff;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getSwot() {
		return swot;
	}

	public void setSwot(String swot) {
		this.swot = swot;
	}

	public Asset getAsset() {
		return asset;
	}

	public void setAsset(Asset asset) {
		this.asset = asset;
	}
	
	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getReceiver()).append(getApplyState()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Borrow != true)
			return false;
		Borrow other = (Borrow) obj;
		return new EqualsBuilder().append(getReceiver(), other.getReceiver()).append(getApplyState(), other.getApplyState()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.funCode);
		sb.append(",").append(this.assetName);
		sb.append(",").append(this.applyState);
		sb.append(",").append(this.overStaff);
		sb.append(",").append(this.receiver);
		sb.append(",").append(this.receiveNum);
		sb.append(",").append(this.receiveDate);
		sb.append(",").append(this.returnDate);
		sb.append(",").append(this.remark);
		sb.append("}");
		return sb.toString();
	}
}
