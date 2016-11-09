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
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Transient;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.ForeignKey;
import com.google.gson.annotations.Expose;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 5, 2012
 * @version 3.0
 */
@Entity
@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
public class Responsibility implements Serializable {
	private static final long serialVersionUID = -7003072122429839649L;

	@Expose
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Expose
	@Column(length = 10, nullable = false)
	private String funcode;						//功能代码
	
	@Expose
	@Column(length = 50, nullable = false)
	private String name;						//责任名称
	
	@Expose
	@Column(length = 100, nullable = false)
	private String explanation;					//分配说明
	
	@ManyToOne(targetEntity=Responsibility.class,cascade={CascadeType.PERSIST, CascadeType.REFRESH},fetch=FetchType.LAZY)
	@JoinColumn(name="parentid")
	@ForeignKey(name="FK_R_PARENTID")
	private Responsibility parent;

	@OneToMany(cascade={CascadeType.PERSIST,  CascadeType.REFRESH},mappedBy="parent",fetch=FetchType.LAZY)
	private Set<Responsibility> children = new HashSet<Responsibility>();
	
	@OneToMany(cascade={CascadeType.PERSIST, CascadeType.REFRESH},mappedBy="respon",fetch=FetchType.LAZY)
	private Set<UserResp> respons = new HashSet<UserResp>();
	
	@Expose
	@Transient
	private Integer responId;						//责任ID
	
	@Expose
	@Transient
	private Integer actual;						//实际比重
	
	@Expose
	@Transient
	private Integer expected;					//预设比重
	
	@Expose
	@Transient
	private String node;						//NODE
	
	@Expose
	@Transient
	private Integer userId;						//UserId <仅VO>
	
	@Expose
	@Transient
	private Integer parentId;					//父类id <仅VO>
	
	@Expose
	@Transient
	private Integer groupId;					//组id <仅VO>
	
	@Expose
	@Transient
	private String cdepartment;					//部门 <仅VO>
	
	@Expose
	@Transient
	private String ename;						//英文名 <仅VO>
	
	@Expose
	@Transient
	private String swot = "green";				//SWOT
	
	public Responsibility(){}
	
	public Responsibility(Integer id)  {
		this.id=id;
	}
	
	public Responsibility(Integer id, String funcode, String name, String explanation) {
		this.id = id;
		this.funcode = funcode;
		this.name = name;
		this.explanation = explanation;
	}

	public Responsibility(Integer id, String funcode, String name,
			String explanation, Integer parentId) {
		this.id = id;
		this.funcode = funcode;
		this.name = name;
		this.explanation = explanation;
		this.parentId = parentId;
	}

	public Responsibility(Integer id, String funcode, String name,
			String explanation, Integer responId, Integer expected, String node, Integer userId,
			String ename) {
		this.id = id;
		this.funcode = funcode;
		this.name = name;
		this.explanation = explanation;
		this.responId = responId;
		this.expected = expected;
		this.node = node;
		this.userId = userId;
		this.ename = ename;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFuncode() {
		return funcode;
	}

	public void setFuncode(String funcode) {
		this.funcode = funcode;
	}

	public String getNode() {
		return node;
	}

	public void setNode(String node) {
		this.node = node;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getExplanation() {
		return explanation;
	}

	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}

	public Responsibility getParent() {
		return parent;
	}

	public void setParent(Responsibility parent) {
		this.parent = parent;
	}

	public Set<Responsibility> getChildren() {
		return children;
	}

	public void setChildren(Set<Responsibility> children) {
		this.children = children;
	}

	public Integer getActual() {
		return actual;
	}

	public void setActual(Integer actual) {
		this.actual = actual;
	}

	public Integer getExpected() {
		return expected;
	}

	public void setExpected(Integer expected) {
		this.expected = expected;
	}

	public Integer getResponId() {
		return responId;
	}

	public void setResponId(Integer responId) {
		this.responId = responId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public Integer getGroupId() {
		return groupId;
	}

	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}

	public String getCdepartment() {
		return cdepartment;
	}

	public void setCdepartment(String cdepartment) {
		this.cdepartment = cdepartment;
	}

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public String getSwot() {
		return swot;
	}

	public void setSwot(String swot) {
		this.swot = swot;
	}

	public Set<UserResp> getRespons() {
		return respons;
	}

	public void setRespons(Set<UserResp> respons) {
		this.respons = respons;
	}

	public void addChild(Responsibility resp) {
		resp.setParent(this);
		this.children.add(resp);
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getFuncode()).append(getName()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if(this == obj) return true;
		if(obj instanceof Responsibility != true) return false;
		Responsibility other = (Responsibility) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getFuncode(), other.getFuncode()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.funcode);
		sb.append(",").append(this.name);
		sb.append(",").append(this.explanation);
		sb.append("}");
		return sb.toString();
	}
}
