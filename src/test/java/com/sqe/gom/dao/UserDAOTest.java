package com.sqe.gom.dao;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import static org.junit.Assert.*;
import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.CensusType;
import com.sqe.gom.constant.GenderType;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.vo.UserGroup;

public class UserDAOTest extends BaseTest {
	@Autowired
	private UserDAO userDao;
	
	private GomUser u;
	private GomGroup g;
	private final String ename = "TestUser";
	private final String pwd = "654321";
	private final String email = "sqe_shenmou@sqeservice.com";

	@Before
	public void onSetUpTestDataWithinTransaction() throws Exception {
		u = new GomUser();
		u.setCname("林某");
		u.setEname(ename);
		u.setCell("13689748523");
		u.setEmail(email);
		u.setEmailPwd("junwei");
		u.setJobNo("SQEITNo001");
		u.setPwd(pwd);
		u.setBirthday(DateUtil.parseDate("1987-08-16"));
		u.setCensusType(CensusType.COUNTRYSIDE);
		u.setEntryDate(new Date());
		u.setGender(GenderType.F);
		u.setIdcard("350821198703162587");
		u.setNation("汉");
		u.setAccountNo("6221662160161458895");
		u.setBank("上海兴业银行股份有限公司上海普陀支行");
		
		g = new GomGroup();
		g.setCname("超级用户");
		g.setEname("Supervisors");
		g.setType(GroupType.ROLE);
	}
	
	@Ignore
	public void createRegister() {
		userDao.create(u);
    	assertNotNull(u.getId());
    	userDao.delete(u);
    }
	
	@Test
	public void checkUser() {
		createUser(userDao);
		
		UserGroup ceo = userDao.getUserByDepartAndPosit("Employee", "Develop");
		assertEquals(ceo.getPosition(), "Employee");
		assertNotNull(ceo.getId());
	}
	
	@Ignore
	public void createRole() {
		u.getGroups().add(g);
		userDao.create(u);
		assertNotNull(u.getId());
		assertNotNull(g.getId());
		GomGroup g1 = userDao.getGroup(u.getId(), GroupType.ROLE);
		assertEquals(g1.getEname(),"Supervisors");
		userDao.delete(u);
		System.out.println("createRole");
	}
}
