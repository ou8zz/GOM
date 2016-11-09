/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.ForeignKey;

/**
 * @description category authority of category
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 9, 2011 8:59:41 PM
 * @version 3.0
 */
@Entity
@Table
@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
public class Category implements Serializable {
	private static final long serialVersionUID = 8730589466380617089L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(length = 30, nullable = false)
	private String name;

	@Column(length = 10, nullable = false)
	private String node;

	@OneToMany(cascade={CascadeType.PERSIST,  CascadeType.REFRESH},fetch=FetchType.LAZY, mappedBy ="category")
	private Set<Resource> resource = new HashSet<Resource>();
	
	@ManyToOne(cascade=CascadeType.ALL, targetEntity = Category.class)
	@JoinColumn(name = "parentid")
	@ForeignKey(name = "FK_PARENTID")
	private Category parent;

	@OneToMany(cascade={CascadeType.PERSIST,  CascadeType.REFRESH}, mappedBy = "parent", fetch=FetchType.LAZY)
	@Fetch(FetchMode.SUBSELECT)
	private List<Category> children = new ArrayList<Category>();
	
	@Transient
	private Integer pid;
	
	public Category() {}

	public Category(Integer id, String name, String node) {
		this.id = id;
		this.name = name;
		this.node = node;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNode() {
		return node;
	}

	public void setNode(String node) {
		this.node = node;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public Set<Resource> getResource() {
		return resource;
	}

	public void setResource(Set<Resource> resource) {
		this.resource = resource;
	}

	public Category getParent() {
		return parent;
	}

	public void setParent(Category parent) {
		this.parent = parent;
	}

	public List<Category> getChildren() {
		return children;
	}

	public void setChildren(List<Category> children) {
		this.children = children;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Category != true)
			return false;
		Category other = (Category) obj;
		return new EqualsBuilder().append(getId(), other.getId())
				.append(getName(), other.getName()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.name);
		sb.append(",").append(this.node);
		sb.append("}");
		return sb.toString();
	}
}
