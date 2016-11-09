/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.Collections;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.dao.GroupDAO;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

/**
 * @description  Group DAO implement.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Sep 6, 2011  10:33:55 PM
 * @version 3.0
 */
@Repository("groupDao")
@SuppressWarnings("unchecked")
public class GroupDAOImpl extends GenericHibernateDAO<GomGroup> implements GroupDAO{
	public GroupDAOImpl(){
		super(GomGroup.class);
	}
	
	public List<GomGroup> getGroups(GroupType type, Page page) {
		List<GomGroup> ls;
		String sql = "select new com.sqe.gom.model.GomGroup(g.id,g.ename,g.cname) from GomGroup as g where g.type=?";
		if(page == null || page.equals("")) {
			ls = (List<GomGroup>)queryForList(sql ,new Object[]{type});
		}
		else ls = (List<GomGroup>)queryForList("select count(*) from GomGroup where type=?",sql, new Object[]{type}, page);
		return ls;
	}
	
	public GomGroup getGroup(GomGroup g) {
		String name, sql = "select new GomGroup(g.id,g.cname,g.ename,g.type) from GomGroup as g where g.type=? and ";
		if(RegexUtil.notEmpty(g.getCname())) { name = g.getCname(); sql += "g.cname=?";}
		else {name = g.getEname(); sql += "g.ename=?";}
		return (GomGroup)queryForObject(sql, new Object[]{g.getType(),name});
	}

	@Override
	public List<GomGroup> getGroups(String order, String criteria, Page page, GroupType type) {
		List<GomGroup> ls = Collections.emptyList();
		String csql = "SELECT count(*) FROM GomGroup g WHERE g.type=?";
		String q = "SELECT new GomGroup(g.id, g.cname, g.ename, g.type) FROM GomGroup g WHERE g.type=?";
		if(RegexUtil.notEmpty(criteria)) {
			q += " AND" + criteria;
			csql += " AND " + criteria;
		}
		ls = (List<GomGroup>)queryForList(csql, q, new Object[]{type}, page);
		
		return ls;
	}
	
	@Override
	public List<GomGroup> getGroups(int uid) {
		return (List<GomGroup>)queryForList("SELECT g FROM GomGroup AS g LEFT JOIN g.users AS u WHERE u.id=?", new Object[]{uid});
	}
}
