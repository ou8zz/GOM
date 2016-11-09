/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.dao.HolidaysDAO;
import com.sqe.gom.model.Holidays;
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
@Repository("holidaysDao")
public class HolidaysDAOImpl extends GenericHibernateDAO<Holidays> implements HolidaysDAO {
	public HolidaysDAOImpl() {
		super(Holidays.class);
	}
	
	@Override
	public List<Holidays> getHolidays(String ord, String criteria, Page page) {
		String count = "SELECT COUNT(*) FROM Holidays AS h WHERE 1=1";
		String sql = "FROM Holidays AS h WHERE 1=1";
		if(RegexUtil.notEmpty(criteria)) sql += criteria;
		if(RegexUtil.notEmpty(ord)) sql += ord;
		if(RegexUtil.notEmpty(page))
			return (List<Holidays>) queryForList(count, sql, null, page);
		else 
			return (List<Holidays>) queryForList(sql, null);
	}

	@Override
	public List<Holidays> getHolidays() {
		String sql = "FROM Holidays AS h";
		return (List<Holidays>) queryForList(sql, null);
	}
	
}
