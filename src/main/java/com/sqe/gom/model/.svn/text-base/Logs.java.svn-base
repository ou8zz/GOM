/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.sqe.gom.constant.LogsType;

/**
 * @description 日志记录
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Sep 4, 2011 9:11:43 PM
 * @version 3.0
 */
@Table
@Entity
@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
public class Logs implements Serializable {
	private static final long serialVersionUID = -9206194212373685415L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Enumerated(EnumType.ORDINAL)
	private LogsType type;
	
	@Column(nullable = false)
	private Date dated;

	@Column(length = 50, nullable = false)
	private String logger;

	@Column(length = 10, nullable = false)
	private String level;

	@Column(length = 2000, nullable = false)
	private String message;

	@Transient
	private Integer userId;
	
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public LogsType getType() {
		return type;
	}

	public void setType(LogsType type) {
		this.type = type;
	}

	public Date getDated() {
		return dated;
	}

	public void setDated(Date dated) {
		this.dated = dated;
	}

	public String getLogger() {
		return logger;
	}

	public void setLogger(String logger) {
		this.logger = logger;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public int hashCode() {
		return new HashCodeBuilder().append(getDated()).append(getId())
				.toHashCode();
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof Logs != true)
			return false;
		Logs other = (Logs) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getDated(), other.getDated()).isEquals();
	}

	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.type);
		sb.append(",").append(this.dated);
		sb.append(",").append(this.logger);
		sb.append(",").append(this.level);
		sb.append(",").append(this.message);
		sb.append("}");
		return sb.toString();
	}
}
