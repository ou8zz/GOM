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
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 17, 2012
 * @version 3.0
 */
public class ResponGroup implements Serializable {
	private static final long serialVersionUID = 9170991786226005251L;
	private String group;
	private List<ResponUser> respon;
	
	
	
	public String getGroup() {
		return group;
	}
	public void setGroup(String group) {
		this.group = group;
	}
	public List<ResponUser> getRespon() {
		return respon;
	}
	public void setRespon(List<ResponUser> respon) {
		this.respon = respon;
	}
	
	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getGroup()).append(getRespon()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if(this == obj) return true;
		if(obj instanceof ResponGroup != true) return false;
		ResponGroup other = (ResponGroup) obj;
		return new EqualsBuilder().append(getGroup(), other.getGroup()).append(getRespon(), other.getRespon()).isEquals();
	}
	
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.group);
		sb.append(",").append(this.respon);
		sb.append("}");
		return sb.toString();
	}
}
