/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Transient;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.google.gson.annotations.Expose;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jul 21, 2012
 * @version 3.0
 */
@Entity
public class UserResp implements Serializable {
	private static final long serialVersionUID = 1508150651207744715L;
	
	@Expose
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
		
	@Expose
	@Column(nullable = false)
	private Integer expected;					//预设比重
	
	@Expose
	@Column(length=10,nullable=false)
	private String node;
	
	@ManyToOne(cascade={CascadeType.PERSIST, CascadeType.REFRESH})
	@JoinColumn(name="user_resp_fk")
	private GomUser user;
	
	@ManyToOne(cascade={CascadeType.PERSIST, CascadeType.REFRESH})
	@JoinColumn(name="resp_user_fk")
	private Responsibility respon;
	
	@Expose
	@Transient
	private Integer responId;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getExpected() {
		return expected;
	}

	public void setExpected(Integer expected) {
		this.expected = expected;
	}

	public String getNode() {
		return node;
	}

	public void setNode(String node) {
		this.node = node;
	}

	public GomUser getUser() {
		return user;
	}

	public void setUser(GomUser user) {
		this.user = user;
	}

	public Responsibility getRespon() {
		return respon;
	}

	public void setRespon(Responsibility respon) {
		this.respon = respon;
	}
	
	public Integer getResponId() {
		return responId;
	}

	public void setResponId(Integer responId) {
		this.responId = responId;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getExpected()).append(getExpected()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof UserResp != true)
			return false;
		UserResp other = (UserResp) obj;
		return new EqualsBuilder().append(getExpected(), other.getExpected()).append(getId(), other.getId()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.expected);
		sb.append(",").append(this.node);
		sb.append("}");
		return sb.toString();
	}
}
