/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.vo;

import java.io.Serializable;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

/**
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date May 26, 2012
 * @version 3.0
 */
public class Rules implements Serializable {
	private static final long serialVersionUID = -7041110939130627229L;
	private String field;
	private String data;
	private String op;
	
	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getOp() {
		return op;
	}

	public void setOp(String op) {
		this.op = op;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getField()).append(getData()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if(this == obj) return true;
		if(obj instanceof Rules != true) return false;
		Rules other = (Rules) obj;
		return new EqualsBuilder().append(getField(), other.getField()).append(getData(), other.getData()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.field);
		sb.append(",").append(this.op);
		sb.append(",").append(this.data);
		sb.append("}");
		return sb.toString();
	}
}
