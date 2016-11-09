/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.constant.ProcessType;
import com.sqe.gom.dao.TaskDAO;
import com.sqe.gom.model.Task;
import com.sqe.gom.model.Trace;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 5, 2012
 * @version 3.0
 */
@SuppressWarnings("unchecked")
@Repository("taskDao")
public class TaskDAOImpl extends GenericHibernateDAO<Task> implements TaskDAO {
	public TaskDAOImpl() {
		super(Task.class);
	}

	@Override
	public List<Task> getTasks(String ord, String criteria, Page page) {
		String count = "SELECT COUNT(*) FROM Task AS t WHERE 1=1";
		String sql = "SELECT new com.sqe.gom.model.Task(t.id,t.taskTitle,t.state,t.taskType,t.expectedHours,t.actualHours,t.completedRate,t.occupyRate,t.executor,t.assignor,t.expectedStart,t.expectedEnd,t.actualStart,t.actualEnd,t.createDate,t.describe,t.delay) FROM Task AS t WHERE 1=1 ";
		if(RegexUtil.notEmpty(criteria)) { 
			count += criteria;
			sql += criteria;
		}
		if(RegexUtil.notEmpty(ord)) sql += ord; 
		if(RegexUtil.isEmpty(page)) return (List<Task>) queryForList(sql, null);
		return (List<Task>) queryForList(count, sql, null, page);
	}
	
	@Override
	public List<Task> getTasks(String criteria) {
		String sql = "SELECT t FROM Task AS t LEFT JOIN t.fixed AS f WHERE 1=1 ";
		if(RegexUtil.notEmpty(criteria)) sql += criteria;
		return (List<Task>) queryForList(sql, null);
	}
	
	@Override
	public List<Task> getTasks(Trace trace, String order, String criteria, Page page) {
		List<Task> ls = new ArrayList<Task>();
		List<Object> tc = new ArrayList<Object>();
		StringBuffer sql= new StringBuffer("FROM Trace as t LEFT JOIN t.process as p WHERE p.type=?");
		tc.add(ProcessType.TASK);
		
		if(RegexUtil.notEmpty(trace.getActor())) {
			sql.append(" AND t.actor=?");
			tc.add(trace.getActor());
		}
		
		if(RegexUtil.notEmpty(trace.getState())) {
			sql.append(" AND t.state=?");
			tc.add(trace.getState());
		}
		
//		if(RegexUtil.notEmpty(criteria)) sql.append(criteria);
		String csql = "SELECT count(*) " + sql.toString();
		
		List<Trace> traces = (List<Trace>)queryForList(csql, "SELECT new com.sqe.gom.model.Trace(t.id,t.processId,t.actor,t.arrow,t.icon,t.opinion,t.attachment,t.deliverTime,t.state,p.nodeName,p.nodeCode,p.nodeOrder) " + sql.toString(), tc.toArray(), page);
	
		if(!traces.isEmpty()) {
			String dsql = "FROM Task as t WHERE t.id=?";
			if(RegexUtil.notEmpty(criteria)) dsql += criteria;
			if(RegexUtil.notEmpty(order)) dsql += order;
			
			for(Trace t : traces) {
				Task task = (Task)queryForObject("SELECT new com.sqe.gom.model.Task(t.id,t.taskTitle,t.state,t.taskType,t.expectedHours,t.actualHours,t.completedRate,t.occupyRate,t.executor,t.assignor,t.expectedStart,t.expectedEnd,t.actualStart,t.actualEnd,t.createDate,t.describe,t.delay) " + dsql, new Object[]{t.getProcessId()});
				if(RegexUtil.notEmpty(task)) {
					task.setTraceId(t.getId());
					task.setNodeName(t.getNodeName());
					task.setNodeCode(t.getNodeCode());
					ls.add(task);
				}
			}
		} 
		else ls = Collections.emptyList();
	
		return ls;
	}

	@Override
	public void updateTask(Task t) {
		List<Object> list = new ArrayList<Object>();
		StringBuffer sql= new StringBuffer("UPDATE Task AS t SET t.state=?");
		list.add(t.getState());
		
		if(RegexUtil.notEmpty(t.getTaskTitle())) {
			sql.append(", t.taskTitle=?");
			list.add(t.getTaskTitle());
		}
		if(RegexUtil.notEmpty(t.getExecutor())) {
			sql.append(", t.executor=?");
			list.add(t.getExecutor());
		}
		if(RegexUtil.notEmpty(t.getAssignor())){
			sql.append(", t.assignor=?");
			list.add(t.getAssignor());
		}
		if(RegexUtil.notEmpty(t.getExpectedHours())){
			sql.append(", t.expectedHours=?");
			list.add(t.getExpectedHours());
		}
		if(RegexUtil.notEmpty(t.getActualHours())){
			sql.append(", t.actualHours=?");
			list.add(t.getActualHours());
		}
		if(RegexUtil.notEmpty(t.getCompletedRate())){
			sql.append(", t.completedRate=?");
			list.add(t.getCompletedRate());
		}
		if(RegexUtil.notEmpty(t.getExpectedStart())){
			sql.append(", t.expectedStart=?");
			list.add(t.getExpectedStart());
		}
		if(RegexUtil.notEmpty(t.getExpectedEnd())){
			sql.append(", t.expectedEnd=?");
			list.add(t.getExpectedEnd());
		}
		if(RegexUtil.notEmpty(t.getActualStart())){
			sql.append(", t.actualStart=?");
			list.add(t.getActualStart());
		}
		if(RegexUtil.notEmpty(t.getActualEnd())){
			sql.append(", t.actualEnd=?");
			list.add(t.getActualEnd());
		}
		if(RegexUtil.notEmpty(t.getNeedHelp())){
			sql.append(", t.needHelp=?");
			list.add(t.getNeedHelp());
		}
		if(RegexUtil.notEmpty(t.getNeedState())){
			sql.append(", t.needState=?");
			list.add(t.getNeedState());
		}
		if(RegexUtil.notEmpty(t.getDescribe())){
			sql.append(", t.describe=?");
			list.add(t.getDescribe());
		}
		if(RegexUtil.notEmpty(t.getDelay())){
			sql.append(", t.delay=?");
			list.add(t.getDelay());
		}
		if(RegexUtil.notEmpty(t.getResponsibility())) {
			sql.append(", t.responsibility=?");
			list.add(t.getResponsibility());
		}
		if(RegexUtil.notEmpty(t.getId())) {
			sql.append(" where t.id=?");
			list.add(t.getId());
			executeUpdate(sql.toString(), list.toArray());
		}
	}
}
