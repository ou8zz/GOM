/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Transient;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

/**
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date May 26, 2012
 * @version 3.0
 */
@Entity
@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
public class Config implements Serializable {
	private static final long serialVersionUID = -1343603981579217588L;
	
	@Id @GeneratedValue(generator="configId")
    @GenericGenerator(name ="configId", strategy="assigned")
    @Column(length=45,name="_key",updatable=false)
	private String key;
	
	@Column(length=20, nullable=false)
	private String name;
	
	@Column(length=150)
	private String value;
	
	@Transient
	private String type;
	@Transient
	private String group;
	@Transient
	private String pkey;

	public Config(){}

	public Config(String key, String name) {
		this.key = key;
		this.name = name;
	}

	public Config(String key, String name, String value) {
		this.key = key;
		this.name = name;
		this.value = value;
	}

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
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getGroup() {
		return group;
	}

	public void setGroup(String group) {
		this.group = group;
	}

	public String getPkey() {
		return pkey;
	}

	public void setPkey(String pkey) {
		this.pkey = pkey;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getKey()).append(getName()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if(this == obj) return true;
		if(obj instanceof Config != true) return false;
		Config other = (Config) obj;
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
