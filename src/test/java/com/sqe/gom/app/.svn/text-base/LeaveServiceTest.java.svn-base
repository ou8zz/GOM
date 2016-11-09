package com.sqe.gom.app;

import static org.junit.Assert.*;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.ApprovalStatus;
import com.sqe.gom.constant.LeaveType;
import com.sqe.gom.model.Leave;
import com.sqe.gom.vo.UserGroup;

/**
 * @description  Test case of leave task service that contains Employee User,
 *               Manager/Assistant User cases success and failure.
 *               
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 20, 2011, 10:29:08 AM
 * @version 3.0
 */
@Ignore
public class LeaveServiceTest extends BaseTest {
	private static final int DEFAULT_WAIT_TIME = 3000;
	private Leave leave;
	private UserGroup u,agent,ceo,director,manager,assistant;
	private Map<String, Object> m;
	private ProcessService leaveService;
	
	@Resource(name="leaveService")
	public void setLeaveService(ProcessService leaveService) {
		this.leaveService = leaveService;
	}
	
	//initial test data
	@Before
	public void onSetUpTestData() throws Exception {
		u = new UserGroup();
		u.setId(1);
		u.setCname("陈斌");
		u.setEname("Chen");
		u.setCell("13689748523");
		u.setEmail("test@sqeservice.com");
		u.setJobNo("SQEITNo001");
		u.setPosition("Employee");
		u.setDepartment("开发部");
		
		agent = new UserGroup();
		agent.setId(2);
		agent.setCname("王某");
		agent.setEname("Wang");
		agent.setCell("13896857412");
		agent.setEmail("test1@sqeservice.com");
		agent.setJobNo("SQEITNo002");
		agent.setPosition("Employee");
		
		leave = new Leave();
		leave.setId(1);
		leave.setAgent(agent.getEname());
		leave.setDays((short)4);
		Calendar cal = Calendar.getInstance();
		leave.setStartDate(cal.getTime());
		cal.add(Calendar.DAY_OF_MONTH, 3);
		leave.setEndDate(cal.getTime());
		leave.setEvent("一个多年好友结婚");
		leave.setHandOver("所要交接的工作如下");
		leave.setType(LeaveType.MARRIAGE);
		leave.setContact("打老家座机0573-56895263");
		
		ceo = new UserGroup();
		ceo.setId(3);
		ceo.setCname("李某");
		ceo.setEname("Lee");
		ceo.setCell("13896858974");
		ceo.setEmail("test2@sqeservice.com");
		ceo.setJobNo("SQEITNo003");
		ceo.setPosition("CEO");
		
		director = new UserGroup();
		director.setId(4);
		director.setCname("刘某");
		director.setEname("Liu");
		director.setCell("13352638974");
		director.setEmail("test3@sqeservice.com");
		director.setJobNo("SQEITNo004");
		director.setPosition("Director");
		
		manager = new UserGroup();
		manager.setId(5);
		manager.setCname("黄某");
		manager.setEname("Huang");
		manager.setCell("15001768596");
		manager.setEmail("test4@sqeservice.com");
		manager.setJobNo("SQEITNo005");
		manager.setPosition("Manager");
		
		assistant = new UserGroup();
		assistant.setId(6);
		assistant.setCname("谢某");
		assistant.setEname("Xie");
		assistant.setCell("18785748562");
		assistant.setEmail("test5@sqeservice.com");
		assistant.setJobNo("SQEITNo006");
		assistant.setPosition("Assistant");
	}
}