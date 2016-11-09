/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.sqe.gom.constant.ItemType;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 13, 2012
 * @version 3.0
 */

public class Statistics implements Serializable{
	private static final long serialVersionUID = 3468468022958673519L;
	
	private Float data;
	private ItemType item;
	private Date dated;

	public Float getData() {
		return data;
	}
	public void setData(Float data) {
		this.data = data;
	}
	public ItemType getItem() {
		return item;
	}
	public void setItem(ItemType item) {
		this.item = item;
	}
	public Date getDated() {
		return dated;
	}
	public void setDated(Date dated) {
		this.dated = dated;
	}
	
	
	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getData()).append(getItem()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Statistics != true)
			return false;
		Statistics other = (Statistics) obj;
		return new EqualsBuilder().append(getData(), other.getData()).append(getItem(), other.getItem()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.data).append(", ");
		sb.append(this.item).append(", ");
		sb.append(this.dated);
		sb.append("}");
		return sb.toString();
	}
}
