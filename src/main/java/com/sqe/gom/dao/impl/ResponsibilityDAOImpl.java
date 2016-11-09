/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.sqe.gom.dao.ResponsibilityDAO;
import com.sqe.gom.model.Responsibility;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 6, 2012
 * @version 3.0
 */
@SuppressWarnings("unchecked")
@Repository("responsibilityDao")
public class ResponsibilityDAOImpl extends GenericHibernateDAO<Responsibility> implements ResponsibilityDAO {
	
	public ResponsibilityDAOImpl() {
		super(Responsibility.class);
	}

	@Override
	public int updateResponsibility(Responsibility r) {
		StringBuffer sql= new StringBuffer("UPDATE Responsibility AS r SET ");
		List<Object> list = new ArrayList<Object>();
		
		if(RegexUtil.notEmpty(r.getFuncode())) {
			list.add(r.getFuncode());
			sql.append("r.funcode=?");
			
			if(RegexUtil.notEmpty(r.getName())) {
				list.add(r.getName());
				sql.append(",r.name=?");
			}
			if(RegexUtil.notEmpty(r.getExplanation())) {
				list.add(r.getExplanation());
				sql.append(",r.explanation=?");
			}
		}else if(RegexUtil.notEmpty(r.getName())) {
			list.add(r.getName());
			sql.append("r.name=?");
			
			if(RegexUtil.notEmpty(r.getExplanation())) {
				list.add(r.getExplanation());
				sql.append(",r.explanation=?");
			}
		}else if(RegexUtil.notEmpty(r.getExplanation())) {
			list.add(r.getExplanation());
			sql.append(",r.explanation=?");
		}
		
		sql.append(" WHERE r.id=?");
		list.add(r.getId());
		
		return executeUpdate(sql.toString(), list.toArray());
	}

	@Override
	public Long getNodeCount(Integer userId, String userName) {
		String sql ="SELECT COUNT(*) FROM UserResp AS r LEFT JOIN r.user AS u LEFT JOIN r.respon AS p WHERE p.parent.id IS NULL ";
		if(RegexUtil.notEmpty(userId) && userId > 0)  return (Long) queryForObject(sql +"AND u.id=?", new Object[]{userId});
		else  if(RegexUtil.notEmpty(userName)) return (Long) queryForObject(sql + "AND u.ename=?", new Object[]{userName});
		return null;
	}
	
	public List<Responsibility> getResponsibility(String poStr, List<Object> obj) {
		return (List<Responsibility>)queryForList("SELECT new com.sqe.gom.model.Responsibility(r.id,r.funcode,r.name,r.explanation,ur.id,ur.expected,ur.node,u.id,u.ename) FROM UserResp AS ur LEFT JOIN ur.user AS u LEFT JOIN ur.respon AS r WHERE u.id=? AND r.parent.id is null AND r.id NOT IN ("+poStr+")", obj.toArray());
	}
	
	@Override
	public List<Responsibility> getResponsibilities(String criteria) {
		StringBuffer sql = new StringBuffer("SELECT new com.sqe.gom.model.Responsibility(r.id,r.funcode,r.name,r.explanation,p.id) FROM Responsibility AS r LEFT JOIN r.parent as p WHERE 1=1 "); 
		
		if(RegexUtil.notEmpty(criteria)) sql.append(criteria);
		sql.append(" ORDER BY r.funcode");
		
		return (List<Responsibility>) queryForList(sql.toString(),  null);
	}
	
	@Override
	public List<Responsibility> getResponsibility(String ename, Integer userId, String ord, String criteria) {
		StringBuffer sql= new StringBuffer("SELECT new com.sqe.gom.model.Responsibility(r.id,r.funcode,r.name,r.explanation,ur.id,ur.expected,ur.node,u.id,u.ename) FROM UserResp AS ur LEFT JOIN ur.user AS u LEFT JOIN ur.respon AS r WHERE 1=1 ");
		List<Object> obj = new ArrayList<Object>();
		
		if(RegexUtil.notEmpty(ename)){
			sql.append("AND u.ename=? ");
			obj.add(ename);
		}
		else if(RegexUtil.notEmpty(userId) && userId > 0) {
			sql.append("AND u.id=? ");
			obj.add(userId);
		}
		
		if(RegexUtil.notEmpty(criteria)) sql.append(criteria);
		if(RegexUtil.notEmpty(ord)) sql.append(ord);
		
		return (List<Responsibility>) queryForList(sql.toString(), obj.toArray());
	}
	
	@Override
	public List<Responsibility> getNotSelectRespons(String poStr, List<Object> obj) {
		String sql = "SELECT new com.sqe.gom.model.Responsibility(r.id, r.funcode, r.name, r.explanation) FROM Responsibility AS r LEFT JOIN r.parent as p WHERE p.id is null";
		if(RegexUtil.isEmpty(poStr)) return getResponsibilities(" AND p.id IS NULL");
		else return (List<Responsibility>) queryForList(sql + " AND r.id NOT IN ("+ poStr +") ORDER BY r.funcode", obj.toArray());
	}
}
