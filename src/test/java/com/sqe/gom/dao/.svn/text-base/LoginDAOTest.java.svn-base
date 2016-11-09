/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import static org.junit.Assert.*;
import java.util.Date;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.CensusType;
import com.sqe.gom.constant.DocumentsType;
import com.sqe.gom.constant.GenderType;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Login;
import com.sqe.gom.util.DateUtil;

/**
 * @description test login DAO
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Oct 9, 2011  10:41:22 PM
 * @version 3.0
 */
@Ignore
public class LoginDAOTest extends BaseTest{
	@Autowired
	private LoginDAO loginDao;
	
	@Autowired
	private UserDAO userDao;
	private Login l;
	private GomUser u;
	
	@Before
	public void setUpInitData() {
		u = new GomUser();
		u.setCname("林某");
		u.setEname("test_login");
		u.setCell("13689748523");
		u.setEmail("login_test@abc.com");
		u.setEmailPwd("junwei");
		u.setJobNo("SQEITNo001");
		u.setPwd("123456");
		u.setBirthday(DateUtil.parseDate("1987-08-16"));
		u.setCensusType(CensusType.COUNTRYSIDE);
		u.setEntryDate(new Date());
		u.setDocuments(DocumentsType.PASSPORT);
		u.setGender(GenderType.F);
		u.setIdcard("350821198703162587");
		u.setNation("汉");
		u.setLock(false);
		u.setAccountNo("6221662160161458895");
		u.setBank("上海兴业银行股份有限公司上海普陀支行");
		userDao.create(u);
		
		l = new Login();
		l.setLoginIP("22.33.123.45");
		l.setLoginTake(DateUtil.formatCurDateToTime());
		l.setLoginTime(new Date());
		l.setUser(u);
	}
	
	@Ignore
	public void getLog() {
		l.setUnlockTime(DateUtil.forwardMin(5));
		l.setLoginTime(new Date());
		loginDao.save(l);
		System.out.println(l.getLoginTake());
		Login login = loginDao.getLog(u.getId(), 30);
		assertNull(login);
	}
	
	@Test
	public void updateLock() {
		l.setLoginTime(new Date());
		loginDao.save(l);
		assertNotNull(l.getId());
		
		l.setUnlockTime(DateUtil.forwardMin(30));
		u.setLock(true);
		l.setUser(u);
		loginDao.update(l);
		System.out.println(l.getLoginTake());
		Login login = loginDao.query(l.getId());
		assertNotNull(login);
		System.out.println("Unlock Time" + l.getUnlockTime() + "/n Lock=" + login.getUser().isLock());
	}
}
