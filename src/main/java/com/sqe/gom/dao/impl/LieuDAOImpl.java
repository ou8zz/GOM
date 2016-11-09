/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.dao.LieuDAO;
import com.sqe.gom.model.Lieu;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 8, 2012
 * @version 3.0
 */
@SuppressWarnings("unchecked")
@Repository("lieuDao")
public class LieuDAOImpl extends GenericHibernateDAO<Lieu> implements LieuDAO {
	public LieuDAOImpl() {
		super(Lieu.class);
	}

	@Override
	public List<Lieu> getLieus(String ord, String criteria, Page page) {
		String count = "SELECT COUNT(*) FROM Lieu AS l LEFT JOIN l.holidays AS h ";
		String sql = "SELECT new com.sqe.gom.model.Lieu(l.id, l.type, l.dayoff, l.workedon, l.explanation, h.id) FROM Lieu AS l LEFT JOIN l.holidays AS h ";
		if(RegexUtil.notEmpty(criteria)) sql += criteria;
		if(RegexUtil.notEmpty(ord)) sql += ord;
		if(RegexUtil.notEmpty(page))
			return (List<Lieu>) queryForList(count, sql, null, page);
		else 
			return (List<Lieu>) queryForList(sql, null);
	}

	@Override
	public void updateLieu(Lieu l) {
		List<Object> list = new ArrayList<Object>();
		StringBuffer sql= new StringBuffer("UPDATE Lieu AS l SET l.id=?");
		list.add(l.getId());
		
		if(RegexUtil.notEmpty(l.getType())) {
			sql.append(", l.type=?");
			list.add(l.getType());
		}
		if(RegexUtil.notEmpty(l.getExplanation())){
			sql.append(", l.explanation=?");
			list.add(l.getExplanation());
		}
		if(RegexUtil.notEmpty(l.getDayoff())){
			sql.append(", l.dayoff=?");
			list.add(l.getDayoff());
		}
		if(RegexUtil.notEmpty(l.getWorkedon())){
			sql.append(", l.workedon=?");
			list.add(l.getWorkedon());
		}
		if(RegexUtil.notEmpty(l.getHolidays())){
			sql.append(", l.holidays=?");
			list.add(l.getHolidays());
		}
		
		if(RegexUtil.notEmpty(l.getId())) {
			sql.append(" WHERE l.id=?");
			list.add(l.getId());
			executeUpdate(sql.toString(), list.toArray());
		}
	}
	
}
