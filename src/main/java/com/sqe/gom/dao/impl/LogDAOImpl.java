/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.dao.LogDAO;
import com.sqe.gom.model.Logs;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

/**
 * @description	日志记录DAO实现
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Oct 20, 2012
 * @version 3.0
 */
@Repository("logDao")
@SuppressWarnings("unchecked")
public class LogDAOImpl extends GenericHibernateDAO<Logs> implements LogDAO {
	public LogDAOImpl() {
		super(Logs.class);
	}
	
	@Override
	public List<Logs> getLogs(String ord, String criteria, Page page) {
		String count = "SELECT COUNT(*) FROM Logs WHERE 1=1 ";
		String sql = "FROM Logs AS l WHERE 1=1 ";
		if(RegexUtil.notEmpty(criteria)) {count += criteria;sql += criteria;}
		if(RegexUtil.notEmpty(ord)) sql += ord; 
		if(RegexUtil.isEmpty(page)) return (List<Logs>) queryForList(sql, null);
		return (List<Logs>) queryForList(count, sql, null, page);
	}

	@Override
	public void updateLog(Logs log) {
		List<Object> list = new ArrayList<Object>();
		StringBuffer sql= new StringBuffer("UPDATE Logs AS l SET l.id=l.id");
		
		if(RegexUtil.notEmpty(log.getDated())) {
			sql.append(", l.dated=?");
			list.add(log.getDated());
		}
		if(RegexUtil.notEmpty(log.getLevel())){
			sql.append(", l.level=?");
			list.add(log.getLevel());
		}
		if(RegexUtil.notEmpty(log.getMessage())){
			sql.append(", l.message=?");
			list.add(log.getMessage());
		}
		if(RegexUtil.notEmpty(log.getLogger())){
			sql.append(", l.logger=?");
			list.add(log.getLogger());
		}
		if(RegexUtil.notEmpty(log.getType())){
			sql.append(", l.type=?");
			list.add(log.getType());
		}
		
		if(RegexUtil.notEmpty(log.getId())) {
			sql.append(" where l.id=?");
			list.add(log.getId());
			executeUpdate(sql.toString(), list.toArray());
		}
	}

}
