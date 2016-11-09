/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.vo;

import com.sqe.gom.constant.AddrType;

/**
 * @description 地址类封装
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Sep 27, 2011 9:46:49 PM
 * @version 3.0
 */
public class Addrs {
	private Integer id;
	private String contact;
	private String relation;
	private String address;
	private String zipcode;
	private String cell;
	private String phone;
	private AddrType addrType = AddrType.PRESENT;
	private String fcontact;
	private String frelation;
	private String faddress;
	private String fzipcode;
	private String fcell;
	private String fphone;
	private AddrType faddrType = AddrType.FAMILY;

	public Integer getId() {
		return id;
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

	public String getFcontact() {
		return fcontact;
	}

	public String getFrelation() {
		return frelation;
	}

	public String getFaddress() {
		return faddress;
	}

	public String getFzipcode() {
		return fzipcode;
	}

	public String getFcell() {
		return fcell;
	}

	public String getFphone() {
		return fphone;
	}

	public AddrType getFaddrType() {
		return faddrType;
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

	public void setFcontact(String fcontact) {
		this.fcontact = fcontact;
	}

	public void setFrelation(String frelation) {
		this.frelation = frelation;
	}

	public void setFaddress(String faddress) {
		this.faddress = faddress;
	}

	public void setFzipcode(String fzipcode) {
		this.fzipcode = fzipcode;
	}

	public void setFcell(String fcell) {
		this.fcell = fcell;
	}

	public void setFphone(String fphone) {
		this.fphone = fphone;
	}

	public void setFaddrType(AddrType faddrType) {
		this.faddrType = faddrType;
	}
}
