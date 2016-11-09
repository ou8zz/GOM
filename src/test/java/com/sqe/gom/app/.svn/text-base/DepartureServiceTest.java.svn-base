/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.Date;

import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.ApprovalStatus;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.ProcessType;
import com.sqe.gom.dao.DepartureDAO;
import com.sqe.gom.dao.TraceDAO;
import com.sqe.gom.dao.UserDAO;
import com.sqe.gom.model.Departure;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Trace;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 25, 2012
 * @version 3.0
 */
@Ignore
public class DepartureServiceTest extends BaseTest {
	private MockHttpServletRequest request;
	private MockHttpServletResponse response;
	private ProcessService processService;
	private DepartureDAO departureDao;
	private TraceDAO traceDao;
	private UserDAO userDao;
	private Departure departure;
	private Trace trace;
	private GomUser gu;
	
	@Autowired
	public void setProcessService(ProcessService processService) {
		this.processService = processService;
	}
	
	@Autowired
	public void setDepartureDao(DepartureDAO departureDao) {
		this.departureDao = departureDao;
	}

	@Autowired
	public void setTraceDao(TraceDAO traceDao) {
		this.traceDao = traceDao;
	}
	
	@Autowired
	public void setUserDao(UserDAO userDao) {
		this.userDao = userDao;
	}

	@Before
	public void onSetUpTestDataWithinTransaction() throws Exception {
		request =  new MockHttpServletRequest("GET","/departure.htm");  
		response = new MockHttpServletResponse();
		
		departure = new Departure();
		
		gu = createUser(userDao);
		
		departure.setReason("我不想干了");
		departure.setEname(gu.getEname());
		departure.setUser(gu);
		departure.setState(ProcessStatus.InProgress);
		departure.setApproval(ApprovalStatus.APPROVAL);
		
		trace = new Trace();
		trace.setArrow("start.png");
		trace.setOpinion("没什么意见");
		trace.setDeliverTime(new Date());
		trace.setAttachment("attachment");
		trace.setType(ProcessType.DEPARTURE);
		
	}
	
	@After
	public void cleanData() {
		departureDao.delete(departure);
	}
	
	@Test
	public void startDeparture() {
		UserGroup ug = new UserGroup();
		ug.setId(gu.getId());
		ug.setEname(gu.getEname());
		processService.startDeparture(departure, ug);
		
		assertNotNull(departure.getId());
		assertEquals(1, (int)departure.getId());
	}
	
	@Test
	public void getDepartures() {
		UserGroup ug = new UserGroup();
		ug.setId(gu.getId());
		ug.setEname(gu.getEname());
		processService.startDeparture(departure, ug);
		
		JGridHelper<Departure> grid = new JGridHelper<Departure>();
		grid.jgridHandler(request, response, "d.");
		grid.getJq().setSidx("id");
		grid.getJq().setSord("ASC");
		grid.getJq().setPage(1);
		grid.getJq().setRows(10);
		
		JGridBase<Departure> jgb = processService.getDepartures(gu.getEname(), grid);
		assertTrue(jgb.getList().size() > 0);
		assertEquals(jgb.getList().size(), 1);
		assertEquals(gu.getEname(), departure.getEname());
		
	}
		
	@Test
	public void getDeparture() {
		UserGroup ug = new UserGroup();
		ug.setId(gu.getId());
		ug.setEname(gu.getEname());
		processService.startDeparture(departure, ug);
		
		Departure d = processService.getDeparture(gu.getId(), ProcessStatus.InProgress);
		assertNotNull(d);
		assertEquals(1, (int)d.getId());
		assertEquals(gu.getEname(), d.getEname());
	}
	
	@Test
	public void updateDeparture() {
		UserGroup ug = new UserGroup();
		ug.setId(gu.getId());
		ug.setEname(gu.getEname());
		processService.startDeparture(departure, ug);
		
		departure.setRecipient("sqe22");
		departure.setRecipientDpt("人事部");
		processService.updateDeparture(departure, ug);
		
		assertEquals(1, (int)departure.getId());
		assertEquals("sqe22" , departure.getRecipient());
	}
}
