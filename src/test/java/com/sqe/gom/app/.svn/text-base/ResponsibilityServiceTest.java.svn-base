/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.sqe.gom.BaseTest;
import com.sqe.gom.dao.ResponsibilityDAO;
import com.sqe.gom.dao.UserDAO;
import com.sqe.gom.dao.UserRespDAO;
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
public class ResponsibilityServiceTest extends BaseTest {
	private ResponsibilityService responsibilityService;
	private ResponsibilityDAO responsibilityDao;
	private Responsibility responsibility;
	private UserResp ur;
	
	@Autowired
	private UserDAO userDao;
	@Autowired
	private UserRespDAO urDao;
	
	@Autowired
	public void setResponsibilityDao(ResponsibilityDAO responsibilityDao) {
		this.responsibilityDao = responsibilityDao;
	}
		
	@Autowired
	public void setResponsibilityService(ResponsibilityService responsibilityService) {
		this.responsibilityService = responsibilityService;
	}
	
	@Before
	public void setUp() {
		responsibility = new Responsibility();
		responsibility.setFuncode("F-01");
		responsibility.setName("责任名称");
		responsibility.setExplanation("分配说明");
		responsibility.setNode("0");
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
		responsibilityService.saveResponsibility(responsibility);
		assertNotNull(responsibility.getId());
	}
		
	@Test
	public void updateResponsibility() throws Exception {
		responsibilityDao.create(responsibility);
		assertNotNull(responsibility.getId());
		
		responsibility.setFuncode("F-112");
		responsibilityService.saveResponsibility(responsibility);
		assertEquals("F-112", responsibility.getFuncode());
	}
	
	@Test
	public void getResponsibility() {
		responsibilityDao.create(responsibility);
		GomUser gu = createUser(userDao);
		
		ur = new UserResp();
		ur.setUser(gu);
		ur.setRespon(responsibility);
		ur.setExpected(50);
		ur.setNode("0");
		urDao.create(ur);
		
		Responsibility res = responsibilityService.getResponsibility(responsibility.getId());
		assertNotNull(res);
		assertEquals("F-01", responsibility.getFuncode());
		
	}
	
	@Test
	public void getResponsibilitys() {
		responsibilityDao.create(responsibility);
		GomUser gu = createUser(userDao);
		
		ur = new UserResp();
		ur.setUser(gu);
		ur.setRespon(responsibility);
		ur.setExpected(50);
		ur.setNode("0");
		urDao.create(ur);
		
		responsibilityService.saveResponsibility(responsibility);
		
		List<Responsibility> list = responsibilityService.getResponsibility(null, gu.getId(), 0, false, null);
		assertNotNull(list);
		assertEquals(1, list.size());
		
	}
}
