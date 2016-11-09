/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.ItemType;
import com.sqe.gom.constant.SwotModel;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 24, 2012
 * @version 3.0
 */
public class SwotResult implements Serializable  {
	private static final long serialVersionUID = -1701828467803819506L;

	private Integer id;			//ID号	
		
	@Expose
	private SwotModel swotType;	//SWOT类型 
	
	@Expose
	private Float data; 		//运算数据
	
	@Expose
	private String swot;  		//运算结果
	
	@Expose
	private Date dated;			//日期
	
	@Expose
	private String day;			//日期（天）
	
	@Expose
	private String title;		//项目类型
	
	private ItemType item;		//项目类型enum
	
	public SwotResult() {}
	
	public SwotResult(SwotModel swotType, Float data) {
		this.swotType = swotType;
		this.data = data;
	}
	
	public SwotResult(Float data, String swot) {
		this.data = data;
		this.swot = swot;
	}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public SwotModel getSwotType() {
		return swotType;
	}

	public void setSwotType(SwotModel swotType) {
		this.swotType = swotType;
	}

	public Float getData() {
		return data;
	}

	public void setData(Float data) {
		this.data = data;
	}

	public String getSwot() {
		return swot;
	}

	public void setSwot(String swot) {
		this.swot = swot;
	}

	public Date getDated() {
		return dated;
	}

	public void setDated(Date dated) {
		this.dated = dated;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public ItemType getItem() {
		return item;
	}

	public void setItem(ItemType item) {
		this.item = item;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).append(getData()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof SwotResult != true)
			return false;
		SwotResult other = (SwotResult) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getData(), other.getData()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.swotType);
		sb.append(",").append(this.data);
		sb.append(",").append(this.swot);
		sb.append(",").append(this.dated);
		sb.append(",").append(this.title);
		sb.append(",").append(this.item);
		sb.append("}");
		return sb.toString();
	}
}
