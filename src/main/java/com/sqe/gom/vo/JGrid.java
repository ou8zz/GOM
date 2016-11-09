package com.sqe.gom.vo;

import java.util.List;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

/**
 * @description jGrid parameter POJO
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 7, 2011 11:04:25 PM
 * @version 3.0
 */
public class JGrid {
	private Integer rows = 0;
	private Integer page = 0;
	private String sord;
	private String sidx;
	private boolean search;
	private String searchField;
	private String searchString;
	private String searchOper;
	private List<JQFilters> filters;

	public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public String getSord() {
		return sord;
	}

	public void setSord(String sord) {
		this.sord = sord;
	}

	public String getSidx() {
		return sidx;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

	public boolean isSearch() {
		return search;
	}

	public void setSearch(boolean search) {
		this.search = search;
	}

	public String getSearchField() {
		return searchField;
	}

	public void setSearchField(String searchField) {
		this.searchField = searchField;
	}

	public String getSearchString() {
		return searchString;
	}

	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}

	public String getSearchOper() {
		return searchOper;
	}

	public void setSearchOper(String searchOper) {
		this.searchOper = searchOper;
	}

	public List<JQFilters> getFilters() {
		return filters;
	}

	public void setFilters(List<JQFilters> filters) {
		this.filters = filters;
	}
	
	public int hashCode() {
		return new HashCodeBuilder().append(getRows()).append(getSearchField()).toHashCode();
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof JGrid))
			return false;
		JGrid o = (JGrid) obj;
		return new EqualsBuilder().append(getRows(), o.getRows()).append(getSearchField(), o.getSearchField()).isEquals();
	}

	public String toString() {
		StringBuilder buf = new StringBuilder();
		buf.append("{");
		buf.append(this.rows);
		buf.append(", ").append(this.page);
		buf.append(", ").append(this.sord);
		buf.append(", ").append(this.sidx);
		buf.append(", ").append(this.search);
		buf.append(", ").append(this.searchField);
		buf.append(", ").append(this.searchString);
		buf.append(", ").append(this.searchOper);
		buf.append(", ").append(this.filters);
		buf.append("}");
		return buf.toString();
	}
}
