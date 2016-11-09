package com.sqe.gom.web.core.expand;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;

/**
 * @description  Group DAO implement.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Sep 6, 2011  10:33:55 PM
 * @version 3.0
 */
public class JGridHelper<T>{
	private Page p;
	private String q;
	private JGridBase<T> jq;
	
	public void jgridHandler(HttpServletRequest req, HttpServletResponse res, String pre){
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		String page = req.getParameter("page");
		String rows = req.getParameter("rows");
		String sidx = req.getParameter("sidx");
		String sord = req.getParameter("sord");
		// for search parameter
		String search = req.getParameter("search");
		String searchField = req.getParameter("searchField");
		String searchString = req.getParameter("searchString");
		String searchOper = req.getParameter("searchOper");
		String filters = req.getParameter("filters");
		
		jq = null;
		jq = new JGridBase<T>();
		if (RegexUtil.notEmpty(page))
			jq.setPage(Integer.valueOf(page));
		if (RegexUtil.notEmpty(rows))
			jq.setRows(Integer.valueOf(rows));
		if (RegexUtil.notEmpty(sidx))
			jq.setSidx(sidx);
		if (RegexUtil.notEmpty(sord))
			jq.setSord(sord);
		if (RegexUtil.notEmpty(search))
			jq.setSearch(Boolean.valueOf(search));
		if (RegexUtil.notEmpty(searchField))
			jq.setSearchField(searchField);
		if (RegexUtil.notEmpty(searchString))
			jq.setSearchString(searchString);
		if (RegexUtil.notEmpty(searchOper))
			jq.setSearchOper(searchOper);
		if (RegexUtil.notEmpty(filters))
			jq.setFilters(filters);

		if (jq.getRows() < 1) p = new Page(jq.getPage());
		else p = new Page(jq.getPage(), jq.getRows());
		
		if(jq.getSearch()) {
			if(jq.getFilters() != null && jq.getFilters().length() > 0) q = jq.generateCriteriaFromFilters(jq.getFilters(), pre);
			else if(jq.getSearchField() != null && !jq.getSearchField().equals("")) q = jq.generateSearchCriterion(jq.getGroupOp(), jq.getSearchField(), jq.getSearchString(), jq.getSearchOper(), pre);
		}
	}

	public Page getP() {
		return p;
	}

	public void setP(Page p) {
		this.p = p;
	}

	public String getQ() {
		return q;
	}

	public void setQ(String q) {
		this.q = q;
	}

	public JGridBase<T> getJq() {
		return jq;
	}

	public void setJq(JGridBase<T> jq) {
		this.jq = jq;
	}
}
