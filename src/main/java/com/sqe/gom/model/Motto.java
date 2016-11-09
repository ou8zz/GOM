/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.google.gson.annotations.Expose;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Nov 24, 2012
 * @version 3.0
 */
@Entity
public class Motto implements Serializable {
	private static final long serialVersionUID = 6275524208781002258L;

	@Expose
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;				//ID号	
	
	@Expose
	@Column(length=2000)
	private String mottoText;		//格言

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getMottoText() {
		return mottoText;
	}
	public void setMottoText(String mottoText) {
		this.mottoText = mottoText;
	}
	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).append(getMottoText()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Motto != true)
			return false;
		Motto other = (Motto) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getMottoText(), other.getMottoText()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.mottoText);
		sb.append("}");
		return sb.toString();
	}
}
