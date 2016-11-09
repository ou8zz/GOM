/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.Date;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.AssignType;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.ProcessType;
import com.sqe.gom.constant.TaskType;
import com.sqe.gom.model.ProcessInfo;
import com.sqe.gom.model.Task;
import com.sqe.gom.model.Trace;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 27, 2012
 * @version 3.0
 */
public class TaskDaoTest extends BaseTest {
	private TaskDAO taskDao;
	private TraceDAO traceDao;
	private ProcessInfoDAO processDao;
	private Task task;
	private Trace trace;
	private ProcessInfo process;
	
	@Autowired
	public void setTaskDao(TaskDAO taskDao) {
		this.taskDao = taskDao;
	}
	
	@Autowired
	public void setTraceDao(TraceDAO traceDao) {
		this.traceDao = traceDao;
	}
	
	@Autowired
	public void setProcessDao(ProcessInfoDAO processDao) {
		this.processDao = processDao;
	}

	@Before
	public void initData() {
		task = new Task();
		task.setTaskTitle("工作标题");
		task.setAssignor("admin");
		task.setExecutor("sqe11,sqe22");
		task.setCompletedRate("60");
		task.setExpectedHours((Float.parseFloat("12")));
		task.setNodeOrder(1);
		task.setTaskType(TaskType.TEMPORARY);
		task.setState(ProcessStatus.InProgress);
		task.setExpectedEnd(new Date());
		task.setDescribe("说明 ");
		task.setCreateDate(new Date());
		
		process = new ProcessInfo();
		process.setActor("admin");
		process.setAssignType(AssignType.PEOPLE);
		process.setType(ProcessType.TASK);
		process.setNodeOrder(1);
		process.setNodeName("审核人");
		process.setNodeCode("1");
		
		trace = new Trace();
		trace.setProcess(process);
		trace.setArrow("start.png");
		trace.setIcon("atti.png");
		trace.setOpinion("没什么意见");
		trace.setDeliverTime(new Date());
		trace.setAttachment("attachment");
		trace.setType(ProcessType.TASK);
		
	}
	
	@After
	public void cleanData() {
		taskDao.delete(task);
	}
	
	@Test
	public void getTaskTrace() {
		processDao.create(process);
		taskDao.create(task);
		
		trace.setProcessId(task.getId());
		traceDao.create(trace);
		
		List<Trace> list = traceDao.getTraces(task.getId(), ProcessType.TASK);
		assertTrue(list.size() > 0);
	}
	
	@Test
	public void saveTask() {
		processDao.create(process);
		taskDao.create(task);
		
		assertNotNull(task.getId());
	}
	
	@Test
	public void getTask() {
		processDao.create(process);
		taskDao.create(task);
		
		List<Task> list = taskDao.getTasks(null);
		assertTrue(list.size() > 0);
		assertEquals(1, list.size());
	}
		
	@Test
	public void updateTask() {
		processDao.create(process);
		taskDao.create(task);
		
		task.setDescribe("修改说明");
		taskDao.update(task);
		assertEquals("修改说明", task.getDescribe());
	}
	

}
