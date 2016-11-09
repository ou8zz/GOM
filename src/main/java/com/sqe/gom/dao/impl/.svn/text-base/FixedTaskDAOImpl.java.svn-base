package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.stereotype.Service;
import com.sqe.gom.constant.TaskType;
import com.sqe.gom.dao.FixedTaskDAO;
import com.sqe.gom.model.FixedTask;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

@SuppressWarnings("unchecked")
@Service("fixedTaskDao")
public class FixedTaskDAOImpl extends GenericHibernateDAO<FixedTask> implements FixedTaskDAO {
	public FixedTaskDAOImpl() {
		super(FixedTask.class);
	}
	
	@Override
	public List<FixedTask> getTaskNotFixed(String criteria) {
		List<Object> obj = new ArrayList<Object>();
		String count = "SELECT f.id FROM Task AS t LEFT JOIN t.fixed AS f WHERE t.taskType=" + TaskType.REGULAR.ordinal();
		
		StringBuilder sql = new StringBuilder("SELECT f FROM FixedTask AS f WHERE 1=1 ");
		if(RegexUtil.notEmpty(criteria)) sql.append(criteria);
		
		List<Integer> li = (List<Integer>) queryForList(count, null);
		if(!li.isEmpty()) {
			for(int i : li) {
				sql.append(" AND f.id<>?");
				obj.add(i);
			}
		}
		
		return (List<FixedTask>) queryForList(sql.toString(), obj.toArray());
	}
	
	@Override
	public List<FixedTask> getFixedTasks(String ord, String criteria, Page page) {
		String count = "SELECT COUNT(*) FROM FixedTask AS f WHERE 1=1";
		String sql = "SELECT f FROM FixedTask AS f WHERE 1=1";
		if(RegexUtil.notEmpty(criteria)) {
			count += criteria;
			sql += criteria;
		}
		if(RegexUtil.notEmpty(ord)) sql += ord;
		if(RegexUtil.isEmpty(page)) return (List<FixedTask>)queryForList(sql, null);
		return (List<FixedTask>)queryForList(count, sql, null, page);
	}
	
	public void updateFixedTask(FixedTask f){
		List<Object> list = new ArrayList<Object>();
		StringBuffer sql= new StringBuffer("UPDATE FixedTask AS f SET f.updateDate=?");
		list.add(new Date());
		
		if(RegexUtil.notEmpty(f.getTaskTitle())) {
			sql.append(", f.taskTitle=?");
			list.add(f.getTaskTitle());
		}
		
		if(RegexUtil.notEmpty(f.getFrequency())) {
			sql.append(", f.frequency=?");
			list.add(f.getFrequency());
		}
		
		if(RegexUtil.notEmpty(f.getPeriod())) {
			sql.append(", f.period=?");
			list.add(f.getPeriod());
		}
		
		if(RegexUtil.notEmpty(f.getHours())) {
			sql.append(", f.hours=?");
			list.add(f.getHours());
		}
		
		if(RegexUtil.notEmpty(f.getExpectedStart())) {
			sql.append(", f.expectedStart=?");
			list.add(f.getExpectedStart());
		}
		
		if(RegexUtil.notEmpty(f.getExpectedEnd())) {
			sql.append(", f.expectedEnd=?");
			list.add(f.getExpectedEnd());
		}
		
		if(RegexUtil.notEmpty(f.getDescribe())) {
			sql.append(", f.describe=?");
			list.add(f.getDescribe());
		}
		
		if(RegexUtil.notEmpty(f.getState())) {
			sql.append(", f.state=?");
			list.add(f.getState());
		}
		
		if(RegexUtil.notEmpty(f.getId())) {
			if(!list.isEmpty()) {
				sql.append(" WHERE f.id=?");
				list.add(f.getId());
				executeUpdate(sql.toString(), list.toArray());
			}
		}
	}
}
