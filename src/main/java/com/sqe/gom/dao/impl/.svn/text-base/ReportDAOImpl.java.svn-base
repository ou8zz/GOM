/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.constant.DateRange;
import com.sqe.gom.dao.ReportDAO;
import com.sqe.gom.model.Report;
import com.sqe.gom.model.ReportConfig;

/**
 * @description 
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@SuppressWarnings("unchecked")
@Repository("reportDao")
public class ReportDAOImpl extends GenericHibernateDAO<Report> implements ReportDAO {
	public ReportDAOImpl() {
		super(Report.class);
	}
	
	@Override
	public List<Report> getReports(DateRange type, Integer uid) {
		String sql = "FROM Report AS r WHERE r.type=? AND r.user.id=?";
		return (List<Report>)queryForList(sql, new Object[]{type, uid});
	}
	
	@Override
	public int getReport(DateRange type, Integer uid, Date date) {
		String sql = "SELECT COUNT(*) FROM Report AS r WHERE r.type=? AND r.dated=? AND r.user.id=?";
		
		Long f = (Long) queryForObject(sql, new Object[]{type, date, uid});
		return f.intValue();
	}
	
	public void updateConfig(ReportConfig rc) {
		List<Object> obj = new ArrayList<Object>();
		String sql= "UPDATE ReportConfig SET send=?, sendTime=?, receiver=?, cc=?, ename=?, ccename=?, summary=?, devote=?, weekDevote=?, repos=?, task=?, doing=?, help=?, daily=?, weekly=?, perMonth=?, quarterly=?, how=?, assets=?, login=? WHERE id=?";
		obj.add(rc.getSend());
		obj.add(rc.getSendTime());
		obj.add(rc.getReceiver());
		obj.add(rc.getCc());
		obj.add(rc.getEname());
		obj.add(rc.getCcename());
		obj.add(rc.getSummary());
		obj.add(rc.getDevote());
		obj.add(rc.getWeekDevote());
		obj.add(rc.getRepos());
		obj.add(rc.getTask());
		obj.add(rc.getDoing());
		obj.add(rc.getHelp());
		obj.add(rc.getDaily());
		obj.add(rc.getWeekly());
		obj.add(rc.getPerMonth());
		obj.add(rc.getQuarterly());
		obj.add(rc.getHow());
		obj.add(rc.getAssets());
		obj.add(rc.getLogin());
		obj.add(rc.getId());
		executeUpdate(sql, obj.toArray());
	}
}
