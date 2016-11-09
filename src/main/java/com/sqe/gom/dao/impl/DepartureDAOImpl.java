package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.springframework.stereotype.Repository;

import com.sqe.gom.constant.ApprovalStatus;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.ProcessType;
import com.sqe.gom.dao.DepartureDAO;
import com.sqe.gom.model.Departure;
import com.sqe.gom.model.Trace;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

/**
 * @description  departureDAO implements entity class.
 * @see com.sqe.gom.dao.GenericDAO
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jul 28, 2011  11:22:04 PM
 * @version 3.0
 */
@Repository("departureDao")
public class DepartureDAOImpl extends GenericHibernateDAO<Departure> implements
		DepartureDAO {
	public DepartureDAOImpl() {
		super(Departure.class);
	}

	@Override
	public Departure getDeparture(Integer processId, Integer userId, ProcessStatus state, boolean onlyCrit) {
		if(userId > 0) {
			if(onlyCrit) return (Departure)queryForObject("select d from Departure as d left join d.user as u where d.state=? AND u.id=?", new Object[] {state, userId});
			else return (Departure)queryForObject("select new com.sqe.gom.model.Departure(d.id,d.reason,d.handover,d.recipientDpt,d.recipient,d.salaryDate,u.exitDate,u.entryDate,u.accountNo,u.ename,u.cname,u.id,g.cname,g.id,p.cname) from Departure as d left join d.user as u left join u.groups as g left join u.groups as p where d.state=? AND u.id=? AND g.type=? AND p.type=?", new Object[] {state, userId, GroupType.DEPARTMENT, GroupType.POSITION});
		}else if(processId > 0) {
			return (Departure)queryForObject("select new com.sqe.gom.model.Departure(d.id,d.reason,d.handover,d.recipientDpt,d.recipient,d.salaryDate,u.exitDate,u.entryDate,u.accountNo,u.ename,u.cname,u.id,g.cname,g.id,p.cname) from Departure as d left join d.user as u left join u.groups as g left join u.groups as p WHERE d.id=? AND d.state=? AND g.type=? AND p.type=?", new Object[] {processId, state, GroupType.DEPARTMENT, GroupType.POSITION});
		}else return null;
	}
	
	public Trace getTraceByProcess(Integer departureId, String nodeCode, Integer nodeOrder) {
		return (Trace)queryForObject("select t from Trace as t left join t.process as p WHERE t.processId=? AND p.nodeCode=? AND p.type=? AND p.nodeOrder=?", new Object[] {departureId, nodeCode, ProcessType.DEPARTURE, nodeOrder});
	}
	
	@SuppressWarnings("unchecked")
	public List<Departure> getDepartures(Trace trace, String order, String criteria, Page page) {
		List<Departure> ls = new ArrayList<Departure>();
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
		
		//if(RegexUtil.notEmpty(criteria)) sql.append(criteria);
		String csql = "SELECT count(*) " + sql.toString();
		
		List<Trace> traces = (List<Trace>)queryForList(csql, "SELECT new com.sqe.gom.model.Trace(t.id,t.processId,t.actor,t.arrow,t.icon,t.opinion,t.attachment,t.deliverTime,t.state,p.nodeName,p.nodeCode,p.nodeOrder) " + sql.toString(), tc.toArray(), page);
		
		if(traces.isEmpty()) ls = Collections.emptyList();
		else {
			String dsql = "FROM Departure as d left join d.user as u left join u.groups as g left join u.groups as p WHERE d.id=? AND d.state=? AND g.type=? AND p.type=?";
			if(RegexUtil.notEmpty(criteria)) dsql += criteria;
			if(RegexUtil.notEmpty(order)) dsql += order;
			
			for(Trace t : traces) {
				Departure departure = (Departure)queryForObject("SELECT new com.sqe.gom.model.Departure(d.id,d.reason,d.handover,d.recipientDpt,d.recipient,d.recipientJobNo,d.recipientPst,d.salaryDate,d.toMailAddr,u.exitDate,u.entryDate," +
						"u.accountNo,g.cname,g.id,p.cname,u.ename,u.cname,u.jobNo,u.id) " + dsql, new Object[]{t.getProcessId(), ProcessStatus.InProgress, GroupType.DEPARTMENT, GroupType.POSITION});
				if(RegexUtil.notEmpty(departure)) {
					if(RegexUtil.notEmpty(trace.getApproval()) && departure.getEname().equals(trace.getActor()) && trace.getApproval().equals(ApprovalStatus.AGREE)) {
						
					}else {
						departure.setTraceId(t.getId());
						departure.setNodeName(t.getNodeName());
						departure.setNodeCode(t.getNodeCode());
						departure.setNodeOrder(t.getNodeOrder());
						departure.setOpinion(t.getOpinion());
						ls.add(departure);
					}
				}
			}
		}
		
		return ls;
	}
	
	public int updateDeparture(Departure dep) {
		List<Object> list = new ArrayList<Object>();
		StringBuffer sql= new StringBuffer("update Departure set toMailAddr=?");
		if(RegexUtil.notEmpty(dep.getToMailAddr())) list.add(dep.getToMailAddr());
	
		if(RegexUtil.notEmpty(dep.getSalaryDate())) {
			sql.append(",salaryDate=?");
			list.add(dep.getSalaryDate());
		}
		
		if(RegexUtil.notEmpty(dep.getState())) {
			sql.append(",state=?");
			list.add(dep.getState());
		}
		
		if(dep.getNodeCode().equals("Apply")) {
			if(RegexUtil.notEmpty(dep.getReason())) {
				sql.append(",reason=?");
				list.add(dep.getReason());
			}
		}
		
		//更新主管选择的工作接收人
		if(dep.getNodeCode().equals("Director") && RegexUtil.notEmpty(dep.getRecipient()) && RegexUtil.notEmpty(dep.getRecipientDpt())) {
			sql.append(",recipient=?");
			list.add(dep.getRecipient());
			sql.append(",recipientDpt=?");
			if(dep.getRecipientDpt().startsWith(",")) dep.setRecipientDpt(dep.getRecipientDpt().substring(1));
			list.add(dep.getRecipientDpt());
		}
		
		if(dep.getNodeCode().equals("Receiver")) {
			if(RegexUtil.notEmpty(dep.getRecipientJobNo())) {
				sql.append(",recipientJobNo=?");
				list.add(dep.getRecipientJobNo());
			}
			
			if(RegexUtil.notEmpty(dep.getRecipientPst())) {
				sql.append(",recipientPst=?");
				list.add(dep.getRecipientPst());
			}
			
			if(RegexUtil.notEmpty(dep.getHandover())) {
				sql.append(",handover=?");
				list.add(dep.getHandover());
			}
		}
		
		if(list.isEmpty()) {
			return 0;
		}else {
			sql.append(" WHERE id=?");
			list.add(dep.getId());
			return executeUpdate(sql.toString(), list.toArray());
		}
	}

	@Override
	public void removeDeparture(Integer lid, Integer position) {
		// TODO Auto-generated method stub

	}

	@Override
	public int updateLastTracePosition(int traceId, int position) {
		// TODO Auto-generated method stub
		return 0;
	}
}
