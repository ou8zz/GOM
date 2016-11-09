/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.Date;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.AssignType;
import com.sqe.gom.constant.CensusType;
import com.sqe.gom.constant.DocumentsType;
import com.sqe.gom.constant.GenderType;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.ProcessType;
import com.sqe.gom.constant.TaskType;
import com.sqe.gom.dao.ProcessInfoDAO;
import com.sqe.gom.dao.TaskDAO;
import com.sqe.gom.dao.TraceDAO;
import com.sqe.gom.dao.UserDAO;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.ProcessInfo;
import com.sqe.gom.model.Task;
import com.sqe.gom.model.Trace;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 25, 2012
 * @version 3.0
 */
@Ignore
public class TaskServiceTest extends BaseTest {
	private MockHttpServletRequest request;
	private MockHttpServletResponse response;
	private ProcessService processService;
	private TaskDAO taskDao;
	private TraceDAO traceDao;
	private ProcessInfoDAO processDao;
	private UserDAO userDao;
	private Task task;
	private Trace trace;
	private ProcessInfo process;
	private GomUser james, ole;
	
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

	@Autowired
	public void setUserDao(UserDAO userDao) {
		this.userDao = userDao;
	}

	@Autowired
	public void setProcessService(ProcessService processService) {
		this.processService = processService;
	}
	
	@Before
	public void onSetUpTestDataWithinTransaction() throws Exception {
		james = new GomUser();
		james.setActive(false);
		james.setLock(false);
		james.setCname("分配者");
		james.setEname("james");
		james.setPwd("1234556");
		james.setCell("13689748523");
		james.setEmail("sqe_james@sqeservice.com");
		james.setJobNo("SQE1222");
		james.setBirthday(DateUtil.parseDate("1987-08-16"));
		james.setCensusType(CensusType.COUNTRYSIDE);
		james.setEntryDate(new Date());
		james.setDocuments(DocumentsType.PASSPORT);
		james.setGender(GenderType.F);
		james.setIdcard("350821198703162587");
		james.setNation("汉");
		james.setAccountNo("6221662160161458895");
		james.setBank("上海兴业银行股份有限公司上海普陀支行");
		
		GomGroup dep = createDepGroup();
		GomGroup emp = createEmpGroup();
		james.getGroups().add(dep);
		james.getGroups().add(emp);
		
		ole = new GomUser();
		ole.setActive(false);
		ole.setLock(false);
		ole.setCname("执行者");
		ole.setEname("ole");
		ole.setPwd("1234556");
		ole.setCell("13689748523");
		ole.setEmail("sqe_ole@sqeservice.com");
		ole.setJobNo("SQE1201");
		ole.setBirthday(DateUtil.parseDate("1987-08-16"));
		ole.setCensusType(CensusType.COUNTRYSIDE);
		ole.setEntryDate(new Date());
		ole.setDocuments(DocumentsType.PASSPORT);
		ole.setGender(GenderType.F);
		ole.setIdcard("350821198703162587");
		ole.setNation("汉");
		ole.setAccountNo("6221662160161458895");
		ole.setBank("上海兴业银行股份有限公司上海普陀支行");
		
		ole.getGroups().add(dep);
		ole.getGroups().add(emp);
		
		
		task = new Task();
		task.setTaskTitle("工作标题");
		task.setExecutor("sqe11");
		task.setAssignor("james");
		task.setCompletedRate("60");
		task.setExpectedHours((Float.parseFloat("12")));
		task.setNodeOrder(1);
		task.setTaskType(TaskType.TEMPORARY);
		task.setState(ProcessStatus.InProgress);
		task.setExpectedEnd(new Date());
		task.setDescribe("说明 ");
		task.setCreateDate(new Date());
		task.setExpectedStart(DateUtil.previous(-1));
		
		process = new ProcessInfo();
		process.setAssignType(AssignType.PEOPLE);
		process.setType(ProcessType.TASK);
		process.setNodeOrder(1);
		process.setNodeName("审核人");
		process.setNodeCode("1");
		
		trace = new Trace();
		trace.setActor("james");
		trace.setProcess(process);
		trace.setArrow("start.png");
		trace.setIcon("atti.png");
		trace.setOpinion("没什么意见");
		trace.setDeliverTime(new Date());
		trace.setAttachment("attachment");
		trace.setType(ProcessType.TASK);
		
		request =  new MockHttpServletRequest("GET","/worktask.htm");  
		response = new MockHttpServletResponse();
	}

	@After
	public void cleanData() {
		taskDao.delete(task);
	}
	
	@Test
	public void saveTask() {
		userDao.create(james);
		userDao.create(ole);
		processDao.create(process);
		traceDao.create(trace);
		
		processService.startTask(task, ole.getEname());
		assertNotNull(task.getId());
	}
	
	@Test
	public void getTask() {
		userDao.create(james);
		userDao.create(ole);
		
		task.setNeedHelp(false);
		task.setAssignor(james.getEname());
		taskDao.create(task);
		process.setActor(ole.getEname());
		processDao.create(process);
		trace.setProcessId(task.getId());
		trace.setActor(task.getAssignor());
		traceDao.create(trace);
		
		JGridHelper<Task> grid = new JGridHelper<Task>();
		grid.jgridHandler(request, response, "p.");
		grid.getJq().setSidx("id");
		grid.getJq().setSord("ASC");
		grid.getJq().setPage(1);
		grid.getJq().setRows(10);
		
		JGridBase<Task> jgb = processService.getTasks(grid, james.getEname(), false, null, null, "task");
		assertNotNull(jgb);
		assertTrue(jgb.getList().size() > 0);
		assertEquals(1, jgb.getList().size());
	}
		
	@Test
	public void getTaskTrace() {
		List<Trace> list = processService.getTraces(process.getId(), ProcessType.TASK);
		assertNotNull(list);
		assertTrue(list.size() > 0);
		assertEquals(1, list.size());
	}
}
