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
import com.sqe.gom.dao.LeaveDAO;
import com.sqe.gom.model.Leave;
import com.sqe.gom.model.Trace;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

/**
 * @description leave operate that DAO
 * @see com.sqe.gom.dao.LeaveDAO
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jul 31, 2011  4:25:44 PM
 * @version 3.0
 */
@Repository("leaveDao")
public class LeaveDAOImpl extends GenericHibernateDAO<Leave> implements LeaveDAO {
	public LeaveDAOImpl() {
		super(Leave.class);
	}
	
	public int updateLeave(Leave leave) {
		StringBuffer sql= new StringBuffer("UPDATE Leave SET");
		List<Object> list = new ArrayList<Object>();
		
		if(RegexUtil.notEmpty(leave.getState())) {
			list.add(leave.getState());
			sql.append(" state=?");
			
			if(RegexUtil.notEmpty(leave.getRelationAddr())){list.add(leave.getRelationAddr()); sql.append(", relationAddr=?");}
		}else if(RegexUtil.notEmpty(leave.getRelationAddr())){
			list.add(leave.getRelationAddr());
			sql.append(" relationAddr=?");
			if(RegexUtil.notEmpty(leave.getState())) {
				list.add(leave.getState());
				sql.append(", state=?");
			}
		}
		
		if(!list.isEmpty()) {
			if(RegexUtil.notEmpty(leave.getId())){list.add(leave.getId());sql.append(" WHERE id=?");}
			return executeUpdate(sql.toString(), list.toArray());
		}else return 0;
	}
	
	public Leave getLeave(Integer uid, ProcessStatus state){
		return (Leave)queryForObject("SELECT new com.sqe.gom.model.Leave(l.id,l.type,l.event,l.agentDpt,l.agentJobNo,l.agentPst,l.agentCname,l.agent,l.recipient,l.handOver,l.startDate,l.endDate,l.days,l.contact,l.relationAddr,l.applyDate, u.ename,u.cname,u.jobNo,d.id,d.cname,p.id,p.cname) FROM Leave AS l LEFT JOIN l.user AS u LEFT JOIN u.groups AS d LEFT JOIN u.groups AS p WHERE u.id=? AND l.state=? AND d.type=? AND p.type=?", new Object[]{uid, state,GroupType.DEPARTMENT, GroupType.POSITION});
	}
	
	@SuppressWarnings("unchecked")
	public List<Leave> getLeaves(Integer userId, String criteria, String order, Page page) {
		String sql = "FROM Leave AS l WHERE l.user.id=? ";
		if(RegexUtil.notEmpty(criteria)) sql += criteria;
		String dsql = "SELECT l " + sql;
		if(RegexUtil.notEmpty(order)) dsql += order;
		if(null == page) return (List<Leave>)queryForList(dsql, new Object[]{userId});
		return (List<Leave>)queryForList("SELECT count(*) " + sql, dsql, new Object[]{userId}, page);
	}
	
	public Leave getLeave(Integer id) {
		return (Leave)queryForObject("SELECT new com.sqe.gom.model.Leave(l.id,l.type,l.event,l.agentDpt,l.agent,l.handOver,l.startDate,l.endDate,l.days,l.contact,l.relationAddr,l.applyDate,u.ename,u.cname,u.jobNo,d.id,d.cname,p.id,p.cname) FROM Leave AS l LEFT JOIN l.user AS u left join u.groups as d left join u.groups as p WHERE l.id=? AND d.type=? AND p.type=?", new Object[]{id, GroupType.DEPARTMENT, GroupType.POSITION});
	}
	
	public List<Leave> getLeaves(Trace trace, String criteria, String order, Page page) {
		List<Leave> list = new ArrayList<Leave>();
		List<Object> tc = new ArrayList<Object>();
		
		StringBuffer sql= new StringBuffer("FROM Trace as t left join t.process as p WHERE p.type=?");
		tc.add(trace.getType());
		
		if(RegexUtil.notEmpty(trace.getActor())) {
			sql.append(" AND t.actor=?");
			tc.add(trace.getActor());
		}
		
		if(RegexUtil.notEmpty(trace.getState())) {
			sql.append(" AND t.state=?");
			tc.add(trace.getState());
		}
		
		if(RegexUtil.notEmpty(criteria)) sql.append(criteria);
		String csql = "SELECT count(*) " + sql.toString();
		
		@SuppressWarnings("unchecked")
		List<Trace> traces = (List<Trace>)queryForList(csql, "SELECT new com.sqe.gom.model.Trace(t.id,t.processId,t.actor,t.arrow,t.icon,t.opinion,t.attachment,t.deliverTime,t.state,p.nodeName,p.nodeCode,p.nodeOrder) " + sql.toString(), tc.toArray(), page);
		
		if(traces.isEmpty()) list = Collections.emptyList();
		else {
			String dsql = "FROM Leave as l left join l.user as u left join u.groups as d left join u.groups as p WHERE l.id=? AND l.state=? AND d.type=? AND p.type=?";
			if(RegexUtil.notEmpty(criteria)) dsql += criteria;
			if(RegexUtil.notEmpty(order)) dsql += order;
			
			for(Trace t : traces) {
				Leave leave = (Leave)queryForObject("SELECT new com.sqe.gom.model.Leave(l.id,l.type,l.event,l.agentDpt,l.agentJobNo,l.agentPst,l.agentCname,l.agent,l.recipient,l.handOver,l.startDate,l.endDate,l.days,l.contact,l.relationAddr,l.applyDate, u.ename,u.cname,u.jobNo,d.id,d.cname,p.id,p.cname) " + dsql, 
						new Object[]{t.getProcessId(), ProcessStatus.InProgress, GroupType.DEPARTMENT, GroupType.POSITION});
				if(RegexUtil.notEmpty(leave)) {
					if(RegexUtil.notEmpty(trace.getApproval()) && leave.getEname().equals(trace.getActor()) && trace.getApproval().equals(ApprovalStatus.AGREE)) {
						list = new ArrayList<Leave>();
					}else {
						leave.setTraceId(t.getId());
						leave.setNodeName(t.getNodeName());
						leave.setNodeCode(t.getNodeCode());
						leave.setNodeOrder(t.getNodeOrder());
						leave.setOpinion(t.getOpinion());
						list.add(leave);
					}
				}
			}
		}
		
		return list;
	}
}
