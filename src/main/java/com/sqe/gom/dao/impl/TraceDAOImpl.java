/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.sqe.gom.constant.ApprovalStatus;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.ProcessType;
import com.sqe.gom.dao.TraceDAO;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Trace;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Apr 17, 2012  9:13:43 PM
 * @version 3.0
 */
@Repository("traceDao")
public class TraceDAOImpl extends GenericHibernateDAO<Trace> implements
		TraceDAO {
	
	public TraceDAOImpl() {
		super(Trace.class);
	}

	@Override
	public int updateTrace(Trace t) {
		List<Object> list = new ArrayList<Object>();
		
		StringBuffer sql= new StringBuffer("UPDATE Trace SET icon=?, state=?");
		list.add(t.getIcon());
		list.add(t.getState());
		
		if(RegexUtil.notEmpty(t.getArrow())) {
			sql.append(", arrow=?");
			list.add(t.getArrow());
		}
		
		if(RegexUtil.notEmpty(t.getActor())) {
			sql.append(", actor=?");
			list.add(t.getActor());
			//obj = new Object[]{t.getArrow(), t.getIcon(), t.getOpinion(), t.getState(), t.getDeliverTime(),t.getActor(), t.getId()};
		}
		if(RegexUtil.notEmpty(t.getOpinion())) {
			sql.append(", opinion=?");
			list.add(t.getOpinion());
		}
		if(RegexUtil.notEmpty(t.getDeliverTime())) {
			sql.append(", deliverTime=?");
			list.add(t.getDeliverTime());
		}
		if(RegexUtil.notEmpty(t.getAttachment())){
			sql.append(", attachment=?");
			list.add(t.getAttachment());
		}
		if(RegexUtil.notEmpty(t.getId())) {
			sql.append(" where id=?");
			list.add(t.getId());
			return executeUpdate(sql.toString(), list.toArray());
		}else return 0;
	}
	
	@SuppressWarnings("unchecked")
	public List<Trace> getTraces(Integer processId, ProcessType type){
		return (List<Trace>)queryForList("select new com.sqe.gom.model.Trace(t.id,t.processId,t.actor,t.arrow,t.icon,t.opinion,t.attachment,t.deliverTime,t.state,p.nodeName,p.nodeCode,p.nodeOrder) from Trace as t left join t.process as p where t.processId=? and p.type=? ORDER BY p.nodeOrder", new Object[]{processId, type});
	}
	
	@SuppressWarnings("unchecked")
	public List<GomUser> getEntryUser(Trace trace, String order, String crit, Page page) {
		List<GomUser> ls = Collections.emptyList();
		List<Object> tc = new ArrayList<Object>();
		StringBuffer sql= new StringBuffer("FROM Trace as t left join t.process as p WHERE p.type=?");
		tc.add(trace.getType());
		
		if(RegexUtil.notEmpty(trace.getState())) {
			sql.append(" AND t.state=?");
			tc.add(trace.getState());
		}
		
		if(RegexUtil.notEmpty(trace.getActor())) {
			sql.append(" AND t.actor=?");
			tc.add(trace.getActor());
		}
		
		if(RegexUtil.notEmpty(crit)) sql.append(crit);
		
		String csql = "SELECT count(*) " + sql.toString();
		
		List<Trace> traces = (List<Trace>)queryForList(csql, "SELECT new com.sqe.gom.model.Trace(t.id,t.processId,t.actor,t.arrow,t.icon,t.opinion,t.attachment,t.deliverTime,t.state,p.nodeName,p.nodeCode,p.nodeOrder) " + sql.toString(), tc.toArray(), page);
		
		if(!traces.isEmpty()) {
			ls = new ArrayList<GomUser>();
			String usql = "FROM GomUser as u left join u.groups as d left join u.groups as p WHERE u.id=? AND d.type=? AND p.type=?";
			if(RegexUtil.notEmpty(crit)) usql += crit;
			if(RegexUtil.notEmpty(order)) usql += order;
			
			for(Trace t : traces) {
				Object[] obj = new Object[]{t.getProcessId(), GroupType.DEPARTMENT, GroupType.POSITION};
				GomUser user = (GomUser)queryForObject("SELECT new com.sqe.gom.model.GomUser(u.id, u.jobNo,u.ename,u.cname,u.cell,u.gender,u.marriage,u.idcard,u.idScan,u.portrait,u.nation,u.censusType,u.birthday,u.bank,u.accountNo,u.entryDate,u.fullDate,d.id,d.cname,p.id,p.cname) " + usql, obj);
				if(RegexUtil.notEmpty(trace.getApproval()) && user.getEname().equals(trace.getActor()) && trace.getApproval().equals(ApprovalStatus.AGREE)) {
					
				}else {
					user.setTraceId(t.getId());
					user.setNodeCode(t.getNodeCode());
					user.setNodeOrder(t.getNodeOrder());
					user.setOpinion(t.getOpinion());
					ls.add(user);
				}
			}
		}
		
		return ls;
	}
	
	public Trace getTrace(Integer processId, ProcessType type, String node) {
		return (Trace)queryForObject("select t from Trace as t left join t.process as p where t.processId=? and p.type=? and p.nodeCode=?", new Object[] {processId, type, node});
	}
	
	public Trace getUserTrace(Integer processId, ProcessType type, String node, String actor, ProcessStatus state) {
		return (Trace)queryForObject("SELECT new com.sqe.gom.model.Trace(t.id,t.processId,t.actor,t.arrow,t.icon,t.opinion,t.attachment,t.deliverTime,t.state,p.nodeName,p.nodeCode,p.nodeOrder) FROM Trace as t LEFT JOIN t.process AS p WHERE t.processId=? AND t.actor=? AND t.state=? AND p.type=? AND p.nodeCode=?", new Object[] {processId, actor, state, type, node});
	}
	
	@SuppressWarnings("unchecked")
	public List<String> getEntryApprovalMail(Integer processId, ProcessType type) {
		return (List<String>)queryForList("SELECT t.attachment FROM Trace AS t LEFT JOIN t.process AS p WHERE t.processId=? AND t.attachment IS NOT NULL AND p.type=? AND p.nodeCode<>?", new Object[]{processId, type, "newEntrant"});
	}
}