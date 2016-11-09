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
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.AssetState;
import com.sqe.gom.constant.AssetType;

/**
 * @description 资产实体表
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Entity
@Table
public class Asset implements Serializable {
	private static final long serialVersionUID = 1400580766537421578L;

	@Expose
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id; 					//ID

	@Expose
	@Column(length = 30, nullable = false)
	private String assetName;				//资产名称

	@Expose
	@Column(length = 10, nullable = false)
	private AssetType assetType;			//资产类型

	@Expose
	@Column(length = 15, nullable = false)
	private String ascription;				//所属部门

	@Expose
	@Column(length = 100, nullable = true)
	private String des;						//说明

	@Expose
	@Column(nullable = false)
	private Integer buyNum;					//购买数量

	@Expose
	@Column(length = 10, nullable = true)
	private String unit;					//单位

	@Expose
	@Column(length = 10, nullable = false)
	private AssetState assetState;			//资产状态 

	@Expose
	@Column(length = 15, nullable = false)
	private String admin;					//管理员

	@Expose
	@Column(length = 15, nullable = false)
	private String buyer;					//采购人员

	@Expose
	@Temporal(TemporalType.DATE)
	private Date buyDate;					//采购日期

	@Expose
	@Temporal(TemporalType.DATE)
	private Date warrantyDate;				//保修到期

	@Expose
	@Temporal(TemporalType.DATE)
	private Date controlDate;				//管制日期

	@Expose
	@Temporal(TemporalType.DATE)
	private Date scrapDate;					//报废日期

	@Expose
	@Column(length = 36)
	private String attachment;				//附件

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "asset")
	private Set<Borrow> borrow = new HashSet<Borrow>();

	public Asset(){}
	
	public Asset(Integer id,String assetName,AssetType assetType,String ascription,String des,
			Integer buyNum,String unit,AssetState assetState,String admin,String buyer,Date buyDate,
			Date warrantyDate,Date controlDate,Date scrapDate,String attachment) {
		this.id = id;
		this.assetName = assetName;
		this.assetType = assetType;
		this.ascription = ascription;
		this.des = des;
		this.buyNum = buyNum;
		this.unit = unit;
		this.assetState = assetState;
		this.admin = admin;
		this.buyer = buyer;
		this.buyDate = buyDate;
		this.warrantyDate = warrantyDate;
		this.controlDate = controlDate;
		this.scrapDate = scrapDate;
		this.attachment = attachment;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAssetName() {
		return assetName;
	}

	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}

	public AssetType getAssetType() {
		return assetType;
	}

	public void setAssetType(AssetType assetType) {
		this.assetType = assetType;
	}

	public String getAscription() {
		return ascription;
	}

	public void setAscription(String ascription) {
		this.ascription = ascription;
	}

	public String getDes() {
		return des;
	}

	public void setDes(String des) {
		this.des = des;
	}

	public Integer getBuyNum() {
		return buyNum;
	}

	public void setBuyNum(Integer buyNum) {
		this.buyNum = buyNum;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public AssetState getAssetState() {
		return assetState;
	}

	public void setAssetState(AssetState assetState) {
		this.assetState = assetState;
	}

	public String getAdmin() {
		return admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}

	public String getBuyer() {
		return buyer;
	}

	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}

	public Date getBuyDate() {
		return buyDate;
	}

	public void setBuyDate(Date buyDate) {
		this.buyDate = buyDate;
	}

	public Date getWarrantyDate() {
		return warrantyDate;
	}

	public void setWarrantyDate(Date warrantyDate) {
		this.warrantyDate = warrantyDate;
	}

	public Date getControlDate() {
		return controlDate;
	}

	public void setControlDate(Date controlDate) {
		this.controlDate = controlDate;
	}

	public Date getScrapDate() {
		return scrapDate;
	}

	public void setScrapDate(Date scrapDate) {
		this.scrapDate = scrapDate;
	}

	public String getAttachment() {
		return attachment;
	}

	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}

	public Set<Borrow> getBorrow() {
		return borrow;
	}

	public void setBorrow(Set<Borrow> borrow) {
		this.borrow = borrow;
	}
	
	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getAssetName()).append(getBuyer()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Asset != true)
			return false;
		Asset other = (Asset) obj;
		return new EqualsBuilder().append(getAssetName(), other.getAssetName()).append(getBuyer(), other.getBuyer()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.assetName);
		sb.append(",").append(this.ascription);
		sb.append(",").append(this.des);
		sb.append(",").append(this.buyNum);
		sb.append(",").append(this.buyer);
		sb.append(",").append(this.unit);
		sb.append(",").append(this.ascription);
		sb.append("}");
		return sb.toString();
	}

}
