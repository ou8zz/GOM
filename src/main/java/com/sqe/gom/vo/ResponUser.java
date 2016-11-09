/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.vo;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.sqe.gom.model.Responsibility;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 17, 2012
 * @version 3.0
 */
public class ResponUser implements Serializable {
	private static final long serialVersionUID = -4607804495647674873L;
	private String user;
	private Responsibility parent;
	private List<Responsibility> children;
	
	
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public Responsibility getParent() {
		return parent;
	}
	public void setParent(Responsibility parent) {
		this.parent = parent;
	}
	public List<Responsibility> getChildren() {
		return children;
	}
	public void setChildren(List<Responsibility> children) {
		this.children = children;
	}
	
	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getUser()).append(getParent()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if(this == obj) return true;
		if(obj instanceof ResponUser != true) return false;
		ResponUser other = (ResponUser) obj;
		return new EqualsBuilder().append(getUser(), other.getUser()).append(getParent(), other.getParent()).isEquals();
	}
	
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.user);
		sb.append(",").append(this.parent);
		sb.append(",").append(this.children);
		sb.append("}");
		return sb.toString();
	}
}
