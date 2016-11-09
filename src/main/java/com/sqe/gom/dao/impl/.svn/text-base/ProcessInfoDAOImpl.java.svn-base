/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.springframework.stereotype.Repository;

import com.sqe.gom.constant.ProcessType;
import com.sqe.gom.dao.ProcessInfoDAO;
import com.sqe.gom.model.ProcessInfo;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jun 19, 2012  8:39:35 PM
 * @version 3.0
 */
@Repository("processDao")
public class ProcessInfoDAOImpl extends GenericHibernateDAO<ProcessInfo> implements
		ProcessInfoDAO {

	public ProcessInfoDAOImpl() {
		super(ProcessInfo.class);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ProcessInfo> getProcesses(ProcessInfo process, String order, String crit, Page page) {
		List<ProcessInfo> ls = Collections.emptyList();
		List<Object> tc = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer("FROM ProcessInfo as p WHERE p.type=?");
		tc.add(process.getType());
		
		if(RegexUtil.notEmpty(process.getAssignType())) {
			sql.append(" AND p.assignType=?");
			tc.add(process.getAssignType());
		}
		
		ls = (List<ProcessInfo>)queryForList("SELECT count(*) " + sql.toString(), "SELECT new com.sqe.gom.model.ProcessInfo(p.id,p.nodeOrder,p.type,p.nodeCode,p.nodeName,p.icon,p.actor,p.assignType) " + sql.toString(), tc.toArray(), page);
		return ls;
	}

	@Override
	public ProcessInfo getProcessInfo(ProcessType type, String nodeCode, Integer order, Integer processId) {
		if(RegexUtil.notEmpty(order) && order > 0) {
			return (ProcessInfo)queryForObject("SELECT new com.sqe.gom.model.ProcessInfo(p.id,p.nodeOrder,p.type,p.nodeCode,p.nodeName,p.icon,p.actor,p.assignType,t.id,t.opinion) FROM ProcessInfo as p LEFT JOIN p.traces as t WHERE p.type=? AND p.nodeOrder=? AND t.processId=?", new Object[]{type, order, processId});
		}
		else return (ProcessInfo)queryForObject("SELECT new com.sqe.gom.model.ProcessInfo(p.id,p.nodeOrder,p.type,p.nodeCode,p.nodeName,p.icon,p.actor,p.assignType,t.id,t.opinion) FROM ProcessInfo as p LEFT JOIN p.traces as t WHERE p.type=? AND p.nodeCode=? AND t.processId=?", new Object[]{type, nodeCode, processId});
	}
	
	@Override
	public ProcessInfo getProcessInfo(ProcessType type, String nodeCode, Integer order) {
		if(RegexUtil.notEmpty(order) && order > 0) {
			return (ProcessInfo)queryForObject("SELECT p FROM ProcessInfo as p WHERE p.type=? AND p.nodeOrder=?", new Object[]{type, order});
		}
		else return (ProcessInfo)queryForObject("SELECT p FROM ProcessInfo as p WHERE p.type=? AND p.nodeCode=?", new Object[]{type, nodeCode});
	}
	
	public int getProcessOrder(ProcessType type) {
		Long ld = (Long)queryForObject("SELECT count(*) FROM ProcessInfo as p WHERE p.type=?", new Object[]{type});
		return ld.intValue();
	}
}
