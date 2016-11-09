package com.sqe.gom.vo;

import java.util.Collection;
import java.util.Collections;
import com.google.gson.annotations.Expose;
import com.google.gson.reflect.TypeToken;
import com.sqe.gom.util.JsonUtils;

/**
 * @description VO base bean for jGrid.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 7, 2011 11:04:25 PM
 * @version 3.0
 */
public class JGridBase<T> {
	@Expose
	private Integer rows = 0;
	@Expose
	private Integer page = 0;
	@Expose
	private Integer total;
	@Expose
	private Integer records;
	@Expose
	private String sord;
	@Expose
	private String sidx;
	@Expose
	private Collection<T> list = Collections.emptyList();
	
	//about query params
	private boolean search;
	private String searchField;
	private String searchString;
	private String searchOper;
	private String filters;
	private String groupOp;

	public String generateSearchCriterion(String groupOp, String searchField, String searchString, String searchOper,String prePojo) {
		StringBuilder sql = new StringBuilder();
		
		// if searchField,searchString,searchOper all not null, and searchString also not null,create query Criterion
		if(searchField != null && searchString != null && searchString.length() > 0 && searchOper != null) {
			searchField = prePojo + searchField;
			
			if("eq".equals(searchOper))
				sql.append(groupOp + searchField + " = '" + searchString + "'");
			else if("ne".equals(searchOper))
				sql.append(groupOp + searchField + " <> '" + searchString + "'");
			else if("lt".equals(searchOper))
				sql.append(groupOp + searchField + " < '" + searchString + "'");
			else if("le".equals(searchOper))
				sql.append(groupOp + searchField + " <= '" + searchString + "'");
			else if("gt".equals(searchOper))
				sql.append(groupOp + searchField + " > '" + searchString + "'");
			else if("ge".equals(searchOper))
				sql.append(groupOp + searchField + " >= '" + searchString + "'");
			else if("bw".equals(searchOper))
				sql.append(groupOp + searchField + " like '" + searchString + "%'");
			else if("bn".equals(searchOper))
				sql.append(groupOp + searchField + " not like '" + searchString + "%'");
			else if("ew".equals(searchOper))
				sql.append(groupOp + searchField + " like '%" + searchString + "'");
			else if("en".equals(searchOper))
				sql.append(groupOp + searchField + " not like '%" + searchString + "'");
			else if("cn".equals(searchOper))
				sql.append(groupOp + searchField + " like '%" + searchString + "%'");
			else if("nc".equals(searchOper))
				sql.append(groupOp + searchField + " not like '%" + searchString + "%'");
		}
		return sql.toString();
	}
	
	public String generateCriteriaFromFilters(String filters,String prePojo) {
		StringBuilder s = new StringBuilder();
		JQFilters fs = JsonUtils.fromJson(filters, new TypeToken<JQFilters>(){});
		this.groupOp = fs.getGroupOp();
		for(Rules rule : fs.getRules()) {
			String c = this.generateSearchCriterion(" " + getGroupOp() + " ", rule.getField(), rule.getData(), rule.getOp(),prePojo);
			if(c != null) s.append(c);
		}
		return s.toString();
	}
	
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

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public Integer getRecords() {
		return records;
	}

	public void setRecords(Integer records) {
		this.records = records;
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

	public boolean getSearch() {
		return search;
	}

	public void setSearch(boolean search) {
		this.search = search;
	}

	public Collection<T> getList() {
		return list;
	}

	public void setList(Collection<T> list) {
		this.list = list;
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

	public String getFilters() {
		return filters;
	}

	public void setFilters(String filters) {
		this.filters = filters;
	}

	public String getGroupOp() {
		return groupOp;
	}

	public void setGroupOp(String groupOp) {
		this.groupOp = groupOp;
	}
}
