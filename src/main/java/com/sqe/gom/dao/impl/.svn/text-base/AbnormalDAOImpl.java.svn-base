/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.ProcessType;
import com.sqe.gom.dao.AbnormalDAO;
import com.sqe.gom.model.Abnormal;
import com.sqe.gom.model.Trace;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 25, 2012
 * @version 3.0
 */
@SuppressWarnings("unchecked")
@Repository("abnormalDao")
public class AbnormalDAOImpl extends GenericHibernateDAO<Abnormal> implements AbnormalDAO {
	public AbnormalDAOImpl() {
		super(Abnormal.class);
	}
	
	@Override
	public Long getAbnormal(Integer uid, ProcessStatus state) {
		String sql = "SELECT COUNT(*) FROM Abnormal AS a WHERE a.user.id=? AND a.state=?";
		return (Long)queryForObject(sql, new Object[]{uid, state});
	}
	
	@Override
	public List<Abnormal> getAbnormals(String order, String criteria, Page page) {
		String sql = "SELECT new com.sqe.gom.model.Abnormal(a.id, a.type, a.reporter, a.indirect, a.des, u.ename) FROM Abnormal as a LEFT JOIN a.user AS u WHERE 1=1";
		if(RegexUtil.notEmpty(criteria)) sql += criteria;
		if(RegexUtil.notEmpty(order)) sql += order;
		return (List<Abnormal>) queryForList(sql, null, page);
	}
	
	@Override
	public List<Abnormal> getAbnormals(Trace trace, String order, String criteria, Page page) {
		List<Abnormal> ls = new ArrayList<Abnormal>();
		List<Object> tc = new ArrayList<Object>();
		StringBuffer sql= new StringBuffer("FROM Trace as t LEFT JOIN t.process as p WHERE p.type=?");
		tc.add(ProcessType.ABNORMAL);
		
		if(RegexUtil.notEmpty(trace.getActor())) {
			sql.append(" AND t.actor=?");
			tc.add(trace.getActor());
		}
		if(RegexUtil.notEmpty(trace.getState())) {
			sql.append(" AND t.state=?");
			tc.add(trace.getState());
		}
		
		String csql = "SELECT count(*) " + sql.toString();
		
		List<Trace> traces = (List<Trace>)queryForList(csql, "SELECT new com.sqe.gom.model.Trace(t.id,t.processId,t.actor,t.arrow,t.icon,t.opinion,t.attachment,t.deliverTime,t.state,p.nodeName,p.nodeCode,p.nodeOrder) " + sql.toString(), tc.toArray(), page);
	
		if(!traces.isEmpty()) {
			String dsql = "FROM Abnormal as a LEFT JOIN a.user AS u WHERE a.id=?";
			if(RegexUtil.notEmpty(criteria)) dsql += criteria;
			if(RegexUtil.notEmpty(order)) dsql += order;
			
			for(Trace t : traces) {
				Abnormal abnormals = (Abnormal)queryForObject("SELECT new com.sqe.gom.model.Abnormal(a.id, a.type, a.reporter, a.indirect, a.des, u.ename) " + dsql, new Object[]{t.getProcessId()});
				if(RegexUtil.notEmpty(abnormals)) {
					abnormals.setTraceId(t.getId());
					abnormals.setNodeName(t.getNodeName());
					abnormals.setNodeCode(t.getNodeCode());
					ls.add(abnormals);
				}
			}
		} 
		else ls = Collections.emptyList();
	
		return ls;
	}
	
	@Override
	public boolean updateAblState(ProcessStatus state, Integer uid) {
		String sql = "UPDATE Abnormal AS a SET a.state=? WHERE a.user.id=?";
		int i = executeUpdate(sql, new Object[]{state, uid});
		if(i > 0) return true;
		return false;
	}
}
