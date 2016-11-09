/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.Calendar;
import java.util.Date;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.CensusType;
import com.sqe.gom.constant.GenderType;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.constant.LeaveType;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.model.Leave;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.util.DateUtil;

/**
 * @description write some comment please.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 6, 2011, 11:21:18 AM
 * @version 3.0
 */
public class LeaveDAOTest extends BaseTest {
	@Autowired
	protected UserDAO userDao;
	private Leave leave;
	private GomUser u,u1;

	@Before
	public void onSetUpTestData() throws Exception {
		u = new GomUser();
		u.setCname("张某");
		u.setEname("James");
		u.setCell("13689748523");
		u.setEmail("sqe_james@sqeservice.com");
		u.setEmailPwd("123456");
		u.setJobNo("SQEITNo001");
		u.setPwd("654321");
		u.setBirthday(DateUtil.parseDate("1987-08-16"));
		u.setCensusType(CensusType.COUNTRYSIDE);
		u.setEntryDate(new Date());
		u.setGender(GenderType.F);
		u.setIdcard("350821198703162587");
		u.setNation("汉");
		u.setAccountNo("6221662160161458895");
		u.setBank("上海兴业银行股份有限公司上海普陀支行");
		
		u1 = new GomUser();
		u1.setCname("王某");
		u1.setEname("OLE");
		u1.setCell("13896857412");
		u1.setEmail("sqe_ole@sqeservice.com");
		u1.setEmailPwd("123456");
		u1.setJobNo("SQEITNo002");
		u1.setPwd("654321");
		u1.setBirthday(DateUtil.parseDate("1988-10-28"));
		u1.setCensusType(CensusType.TOWN);
		u1.setEntryDate(new Date());
		u1.setGender(GenderType.M);
		u1.setIdcard("420321198703162587");
		u1.setNation("藏");
		u1.setAccountNo("4362662160161458974");
		u1.setBank("平安股份银行上海分行营业部");
		
		leave = new Leave();
		leave.setId(1);
		leave.setAgent("OLE");
		leave.setDays((short)3);
		Calendar cal = Calendar.getInstance();
		leave.setStartDate(cal.getTime());
		cal.add(Calendar.DAY_OF_MONTH, 3);
		leave.setEndDate(cal.getTime());
		leave.setEvent("因为什么事情");
		leave.setHandOver("所要交接的工作如下");
		leave.setType(LeaveType.CASUAL);
		leave.setContact("假期联系方式 021-56238596");
		leave.setState(ProcessStatus.Reserved);
		//leave.setUserId(u.getId());
	}
	
	@Test
	public void getTraces() {
		Leave l = new Leave();
		l.setId(1);
	}
	
	public void createLeave() {
		GomGroup g = new GomGroup();
		g.setCname("超级管理员");
		g.setEname("Supervisors");
		g.setType(GroupType.ROLE);
		u.getGroups().add(g);
		userDao.create(u);
		
		GomGroup g1 = new GomGroup();
		g1.setCname("职员");
		g1.setEname("Employee");
		g1.setType(GroupType.POSITION);
		u1.getGroups().add(g1);
		userDao.create(u1);
		
		//leave.setUserId(u.getId());
		/**leave.addTrace(new ProcessTrace("arrow_down_green.jpg", "gray.jpg"));
		leave.addTrace(new ProcessTrace("arrow_down_green.jpg", "active.gif", "主管(James):没问题，把工作交接好。"));
		leaveDao.create(leave);
		assertNotNull(leave.getId());
		UserGroup ur = userDao.getUserGroup(u.getEname(), GroupType.ROLE);
		assertEquals(u.getCname(),ur.getCname());
		assertEquals(ur.getPosition(), g.getEname());
		
		Leave l = leaveDao.query(leave.getId());
		assertNotNull(l);
		List<ProcessTrace> ls = l.getTrace();
		if(!ls.isEmpty()) {
			for(ProcessTrace p :ls) {
				System.out.println("状态：" + p.getNode() + " 意见：" + p.getView());
			}
		}*/
	}
}
