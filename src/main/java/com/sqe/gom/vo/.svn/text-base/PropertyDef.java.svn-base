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
public class PropertyDef implements Serializable {
	private static final long serialVersionUID = -1343603981579217588L;
	private String key;
	private String name;
	private String value;

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
	
	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getKey()).append(getName()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if(this == obj) return true;
		if(obj instanceof PropertyDef != true) return false;
		PropertyDef other = (PropertyDef) obj;
		return new EqualsBuilder().append(getKey(), other.getKey()).append(getName(), other.getName()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.key);
		sb.append(",").append(this.name);
		sb.append(",").append(this.value);
		sb.append("}");
		return sb.toString();
	}
}
