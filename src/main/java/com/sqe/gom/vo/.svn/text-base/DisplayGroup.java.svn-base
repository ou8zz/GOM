/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.vo;

import java.io.Serializable;
import java.util.List;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date May 26, 2012
 * @version 3.0
 */
public class DisplayGroup implements Serializable {
	private static final long serialVersionUID = -8644239813833577374L;
	private String name;
	private String key;
	private List<Rules> defs;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public List<Rules> getDefs() {
		return defs;
	}

	public void setDefs(List<Rules> defs) {
		this.defs = defs;
	}
	
	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getKey()).append(getName()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if(this == obj) return true;
		if(obj instanceof DisplayGroup != true) return false;
		DisplayGroup other = (DisplayGroup) obj;
		return new EqualsBuilder().append(getKey(), other.getKey()).append(getName(), other.getName()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.name);
		sb.append(",").append(this.key);
		sb.append("}");
		return sb.toString();
	}
}
