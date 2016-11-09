package com.sqe.gom.vo;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

/**
 * @description jQFilters parameter of jGrid POJO
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 7, 2011 11:04:25 PM
 * @version 3.0
 */
public class Filter {
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
	
	public int hashCode() {
		return new HashCodeBuilder().append(getField()).append(getData()).toHashCode();
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof Filter))
			return false;
		Filter o = (Filter) obj;
		return new EqualsBuilder().append(getField(), o.getField()).append(getData(), o.getData()).isEquals();
	}

	public String toString() {
		StringBuilder buf = new StringBuilder();
		buf.append("{");
		buf.append(this.field);
		buf.append(", ").append(this.op);
		buf.append(", ").append(this.data);
		buf.append("}");
		return buf.toString();
	}
}
