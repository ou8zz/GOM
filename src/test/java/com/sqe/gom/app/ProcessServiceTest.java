package com.sqe.gom.app;

import java.util.Calendar;
import java.util.Date;
import javax.annotation.Resource;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import static org.junit.Assert.*;
import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.CensusType;
import com.sqe.gom.constant.GenderType;
import com.sqe.gom.constant.LeaveType;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.dao.UserDAO;
import com.sqe.gom.model.Departure;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Leave;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;

public class ProcessServiceTest extends BaseTest {
	private UserService userService;
	private ProcessService processService;
	private Departure dep;
	@Autowired
	private UserDAO userDao;
	
	@Resource(name="userService")
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	@Resource(name="processService")
	public void setProcessService(ProcessService processService) {
		this.processService = processService;
	}
	
	@Before
	public void onSetUpTestData() throws Exception {
		dep = new Departure();
		dep.setUserId(2);
	}
	
	@Test
	public void testUpdateDeparture() {
		UserGroup user = userDao.getLoginUser("elly", "c845e5f29ec258226dd9b651e89f6ecb", false);
	}
}
