/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.constant.DateRange;
import com.sqe.gom.dao.ReportConfigDAO;
import com.sqe.gom.model.ReportConfig;

/**
 * @description 
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@SuppressWarnings("unchecked")
@Repository("reportConfigDao")
public class ReportConfigDAOImpl extends GenericHibernateDAO<ReportConfig> implements ReportConfigDAO {
	public ReportConfigDAOImpl() {
		super(ReportConfig.class);
	}
	
	@Override
	public List<ReportConfig> getReportConfigs(Integer uid) {
		String sql = "SELECT r FROM ReportConfig AS r WHERE r.user.id=?";
		return (List<ReportConfig>)queryForList(sql, new Object[]{uid});
	}
	
	@Override
	public ReportConfig getReportConfig(DateRange type, Integer uid) {
		String sql = "FROM ReportConfig AS r WHERE r.type=? AND r.user.id=?";
		return (ReportConfig)queryForObject(sql, new Object[]{type, uid});
	}
	
	@Override
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
