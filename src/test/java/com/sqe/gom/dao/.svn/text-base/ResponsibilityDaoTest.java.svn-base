/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.sqe.gom.BaseTest;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Responsibility;
import com.sqe.gom.model.UserResp;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 25, 2012
 * @version 3.0
 */
public class ResponsibilityDaoTest extends BaseTest {
	
	@Autowired
	private ResponsibilityDAO responsibilityDao;
	@Autowired
	private UserDAO userDao;
	@Autowired
	private UserRespDAO urDao;
	
	private Responsibility responsibility;
			
	@Before
	public void setUp() {
		responsibility = new Responsibility();
		responsibility.setFuncode("F-01");
		responsibility.setName("责任名称");
		responsibility.setExplanation("分配说明");
		responsibility.setNode("1");
		Responsibility parent = null;
		if(RegexUtil.notEmpty(responsibility.getParentId()))
			parent = responsibilityDao.query(responsibility.getParentId());
		responsibility.setParent(parent);
	}
	
	@After
	public void tearDown() {
		responsibilityDao.delete(responsibility);
	}
	
	@Test
	public void saveResponsibility() throws Exception {
		responsibilityDao.create(responsibility);
	}
	
			
	@Test
	public void updateResponsibility() {
		responsibilityDao.create(responsibility);
		responsibility.setName("责任名称");
		int b = responsibilityDao.updateResponsibility(responsibility);
		assertEquals(1 , b);
	}
	
	@Test
	public void getResponsibilitys() {
		responsibilityDao.create(responsibility);
		List<Responsibility> list = responsibilityDao.getResponsibilities(" AND r.parent=null");
		assertTrue(list.size() > 0);
		assertEquals(1, list.size());
	}
	
	@Test
	public void getResponsibility() {
		GomUser user = createUser(userDao);
		responsibilityDao.create(responsibility);
		
		UserResp ur = new UserResp();
		ur.setUser(user);
		ur.setRespon(responsibility);
		ur.setExpected(50);
		ur.setNode("0");
		urDao.create(ur);
		
		List<Responsibility> list = responsibilityDao.getResponsibilities(null);
		assertTrue(list.size() > 0);
		assertEquals("F-01", list.get(0).getFuncode());
	}
}
