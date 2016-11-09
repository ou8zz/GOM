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
import com.sqe.gom.constant.AddrType;

/**
 * @description user address contains family, contactor, current and so on.
 *              用户入职时，需提供现居地址、紧急联系人地址，籍贯地址（即户口登记的住址，如同现居地址可略）
 *              每个地址应包含联系人，与之关系，地址，手机，座机
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Sep 4, 2011 9:11:43 PM
 * @version 3.0
 */
@Entity
public class Address implements Serializable {
	private static final long serialVersionUID = -1058832141497170700L;

	@Expose
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
	
	@Expose
	@Column(length=10,nullable=false)
	private String contact; // 沈某人
	
	@Expose
	@Column(length=10,nullable=false)
	private String relation;  //e.g. 父子/母女/朋友
	
	@Expose
	@Column(length=50,nullable=false)
	private String address; //e.g. 上海市长宁区长宁路1018号4#1805
	
	@Expose
	@Column(length=6)
	private String zipcode; // 邮编e.g. 2000065
	
	@Expose
	@Column(length=17,nullable=false)
	private String cell; // e.g. 13689529632 
	
	@Expose
	@Column(length=16,nullable=true)
	private String phone; // e.g. 0591-96858596
	
	@Expose
	@Enumerated(EnumType.ORDINAL)
	private AddrType addrType;
	
	@ManyToOne(cascade={CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH})
	@JoinColumn(name="user_address_fk")
	private GomUser user;
	
	@Expose
	@Transient
	private Integer uid;

	public Integer getId() {
		return id;
	}

	public Address() {}

	public Address(Integer id, String contact, String relation, String address,
			String zipcode, String cell, String phone, AddrType addrType,
			Integer uid) {
		this.id = id;
		this.contact = contact;
		this.relation = relation;
		this.address = address;
		this.zipcode = zipcode;
		this.cell = cell;
		this.phone = phone;
		this.addrType = addrType;
		this.uid = uid;
	}

	public String getContact() {
		return contact;
	}

	public String getRelation() {
		return relation;
	}

	public String getAddress() {
		return address;
	}

	public String getZipcode() {
		return zipcode;
	}

	public String getCell() {
		return cell;
	}

	public String getPhone() {
		return phone;
	}

	public AddrType getAddrType() {
		return addrType;
	}

	public GomUser getUser() {
		return user;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public void setRelation(String relation) {
		this.relation = relation;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public void setCell(String cell) {
		this.cell = cell;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public void setAddrType(AddrType addrType) {
		this.addrType = addrType;
	}

	public void setUser(GomUser user) {
		this.user = user;
	}

	public Integer getUid() {
		return uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getContact()).append(getCell()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof GomUser != true)
			return false;
		Address other = (Address) obj;
		return new EqualsBuilder().append(getContact(), other.getContact()).append(getCell(), other.getCell()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.contact);
		sb.append(",").append(this.relation);
		sb.append(",").append(this.address);
		sb.append(",").append(this.zipcode);
		sb.append(",").append(this.cell);
		sb.append(",").append(this.phone);
		sb.append(",").append(this.addrType);
		sb.append("}");
		return sb.toString();
	}
}
