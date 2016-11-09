/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.constant.ResourceType;
import com.sqe.gom.dao.ExperienceDAO;
import com.sqe.gom.model.Experience;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 10, 2012
 * @version 3.0
 */
@SuppressWarnings("unchecked")
@Repository("experienceDao")
public class ExperienceDAOImpl extends GenericHibernateDAO<Experience> implements ExperienceDAO {
	public ExperienceDAOImpl() {
		super(Experience.class);
	}
	
	@Override
	public List<Experience> getExperiences(ResourceType type, String user, String start, String end) {
		StringBuilder sql = new StringBuilder("SELECT new com.sqe.gom.model.Experience(e.id, e.student, e.createDate, e.gain, r.title, r.number) FROM Experience AS e LEFT JOIN e.resource AS r WHERE r.resourceType=? AND e.student=? ");
		
		if(RegexUtil.notEmpty(start)) sql.append(" AND e.createDate>='").append(start).append("'");
		if(RegexUtil.notEmpty(end)) sql.append(" AND e.createDate<='").append(end).append("'");
		sql.append(" ORDER BY e.createDate");
		
		return (List<Experience>) queryForList(sql.toString(), new Object[]{type, user});
	}
	
	@Override
	public List<Experience> getExperiences(String ord, String criteria, Page page) {
		String count = "SELECT COUNT(*) FROM Experience AS e LEFT JOIN e.training AS t WHERE 1=1";
		String sql = "SELECT new com.sqe.gom.model.Experience(e.id, e.student, e.createDate, e.gain) FROM Experience AS e LEFT JOIN e.training AS t WHERE 1=1";
		if(RegexUtil.notEmpty(criteria)) {
			count += criteria;
			sql += criteria;
		}
		if(RegexUtil.notEmpty(ord)) sql += ord; 
		if(RegexUtil.notEmpty(page))
			return (List<Experience>) queryForList(count, sql, null, page);
		else return (List<Experience>) queryForList(sql, null);
	}
	
	@Override
	public int updateExperience(Experience exper) {
		return executeUpdate("UPDATE Experience AS e SET e.gain=? WHERE e.id=?", new Object[]{exper.getGain(), exper.getId()});
	}
}
