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
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.ForeignKey;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.MenuType;

/**
 * @description Ztree 
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 28, 2012 8:59:41 PM
 * @version 3.0
 */
@Entity
@Table
public class Ztree implements Serializable {
	private static final long serialVersionUID = -6200633420923704223L;

	@Expose
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Expose
	@Column(length = 30, nullable = false)
	private String name;
	
	@Expose
	@Column(length = 30)
	private String position;
	
	@Expose
	@Column(length = 30)
	private String role;
	
	@Expose
	@Column(length = 30)
	private String title;
	
	@Expose
	@Column(length = 50)
	private String url;
	
	@Expose
	@Column(length = 30)
	private String ico;
	
	@Expose
	@Column(length = 10, nullable = false)
	private String node;
	
	@Expose
	@Enumerated(EnumType.ORDINAL)
	private MenuType menuType;
	
	@ManyToMany(cascade={CascadeType.ALL},mappedBy="trees",targetEntity=GomUser.class,fetch=FetchType.LAZY)
	private Set<GomUser> users = new HashSet<GomUser>();
	
	@ManyToOne(targetEntity = Ztree.class, cascade=CascadeType.PERSIST)
	@JoinColumn(name = "parentid")
	@ForeignKey(name = "FK_Z_PARENTID")
	private Ztree parent;

	@OneToMany(cascade=CascadeType.ALL, mappedBy = "parent", fetch=FetchType.LAZY)
	@Fetch(FetchMode.SUBSELECT)
	private List<Ztree> children = new ArrayList<Ztree>();

	@Expose
	@Transient
	private int user;		//VO user标识
	
	@Expose
	@Transient
	private Integer pid; 	//父类ID (VO使用)
	
	
	public Ztree() {}
	
	//查询基础树构造方法
	public Ztree(Integer id, String name, String node, String position, String role, String title, String url, String ico, Integer pid) {
		this.id = id;
		this.name = name;
		this.node = node;
		this.position = position;
		this.role = role;
		this.title = title;
		this.url = url;
		this.ico = ico;
		this.pid = pid;
	}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getIco() {
		return ico;
	}

	public void setIco(String ico) {
		this.ico = ico;
	}

	public String getNode() {
		return node;
	}

	public void setNode(String node) {
		this.node = node;
	}

	public MenuType getMenuType() {
		return menuType;
	}

	public void setMenuType(MenuType menuType) {
		this.menuType = menuType;
	}

	public Set<GomUser> getUsers() {
		return users;
	}

	public void setUsers(Set<GomUser> users) {
		this.users = users;
	}

	public Ztree getParent() {
		return parent;
	}

	public void setParent(Ztree parent) {
		this.parent = parent;
	}

	public List<Ztree> getChildren() {
		return children;
	}

	public void setChildren(List<Ztree> children) {
		this.children = children;
	}

	public int getUser() {
		return user;
	}

	public void setUser(int user) {
		this.user = user;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Ztree != true)
			return false;
		Ztree other = (Ztree) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getName(), other.getName()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.name);
		sb.append(",").append(this.position);
		sb.append(",").append(this.role);
		sb.append(",").append(this.title);
		sb.append(",").append(this.url);
		sb.append(",").append(this.ico);
		sb.append(",").append(this.node);
		sb.append("}");
		return sb.toString();
	}
}
