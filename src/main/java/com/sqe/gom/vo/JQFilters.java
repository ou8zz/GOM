package com.sqe.gom.vo;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

/**
 * @description jQFilters parameter of jGrid POJO
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 7, 2011 11:04:25 PM
 * @version 3.0
 */
public class JQFilters implements Serializable {
	private static final long serialVersionUID = 4758987206598160847L;
	private String groupOp;
	private List<Rules> rules;
	
	public String getGroupOp() {
		return groupOp;
	}

	public void setGroupOp(String groupOp) {
		this.groupOp = groupOp;
	}

	public List<Rules> getRules() {
		return rules;
	}

	public void setRules(List<Rules> rules) {
		this.rules = rules;
	}

	public int hashCode() {
		return new HashCodeBuilder().append(getGroupOp()).append(getGroupOp()).toHashCode();
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof JQFilters))
			return false;
		JQFilters o = (JQFilters) obj;
		return new EqualsBuilder().append(getGroupOp(), o.getGroupOp()).append(getRules(), o.getRules()).isEquals();
	}

	public String toString() {
		StringBuilder buf = new StringBuilder();
		buf.append("{");
		buf.append(this.groupOp);
		buf.append(", ").append(this.rules);
		buf.append("}");
		return buf.toString();
	}
}
