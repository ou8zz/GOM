/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.GroupType;

/**
 * @description group authority of user
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jul 26, 2011  8:59:41 PM
 * @version 3.0
 */
@Entity
@Table(name="ugroup")
@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
public class GomGroup implements Serializable {
	private static final long serialVersionUID = -8804809309718930582L;
	
	@Expose
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY) 
	private Integer id;
	
	@Expose
	@Column(length=15,nullable=false)
	private String ename;
	
	@Expose
	@Column(length=20,nullable=false)
	private String cname;
	
	@Column(length=10)
	@Enumerated(EnumType.ORDINAL)
	private GroupType type;

	@ManyToMany(cascade={CascadeType.ALL},mappedBy="groups",targetEntity=GomUser.class,fetch=FetchType.LAZY)
	private Set<GomUser> users = new HashSet<GomUser>();
	
	public GomGroup() {}

	public GomGroup(Integer id, String cname, String ename, GroupType type) {
		this.id = id;
		this.cname = cname;
		this.ename = ename;
		this.type = type;
	}
	
	public GomGroup(Integer id, String ename, String cname) {
		this.id = id;
		this.ename = ename;
		this.cname = cname;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public GroupType getType() {
		return type;
	}

	public void setType(GroupType type) {
		this.type = type;
	}
	
	public Set<GomUser> getUsers() {
		return users;
	}

	public void setUsers(Set<GomUser> users) {
		this.users = users;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).append(getEname()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof GomGroup != true)
			return false;
		GomGroup other = (GomGroup) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getEname(), other.getEname()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(this.ename);
		sb.append(this.cname);
		sb.append(this.type);
		sb.append("}");

		return sb.toString();
	}
}
