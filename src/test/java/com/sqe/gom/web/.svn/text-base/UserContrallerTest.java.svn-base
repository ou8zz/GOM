/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;

import com.sqe.gom.BaseTest;
import com.sqe.gom.app.UserService;
import com.sqe.gom.constant.MaritalStatus;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.dao.UserDAO;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.UserController;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 1, 2012
 * @version 3.0
 */
public class UserContrallerTest extends BaseTest {
	private UserService userService;
	private UserController userController;
	private MockHttpServletRequest request;
	private MockHttpServletResponse response;
	private static GomUser u;
	
	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	@Autowired
	private UserDAO userDao;
	
	@Before
	public void setUp() {
		userController = new UserController();
		userController.setUserService(userService);
		request =  new MockHttpServletRequest("GET","/users.htm");  
		response = new MockHttpServletResponse();
	}
	
	@After
	public void tearDown() throws Exception {
		userDao.delete(u);
	}
	
	public void saveUser() throws Exception {
		BindingResult result = new BindException("", "test");
		u = createUser(userDao);
		userController.saveUser(u, result, response);
		
		String str = response.getContentAsString();
		int s = str.indexOf("SUCCESS");
		String success = str.substring(s, s+7);
		assertEquals("SUCCESS", success);
	}
	
	@Test
	public void getUser() throws Exception {
		u = createUser(userDao);
		Model model = new ExtendedModelMap();
		String str = userController.getUser(model);
		assertEquals(str, "admin/users");
	}
	
	@Test
	public void getUsers() throws Exception {
		u = createUser(userDao);
		
		request.addParameter("page","1");   
		request.addParameter("rows","10"); 
		request.addParameter("sidx","id");   
		request.addParameter("sord","ASC"); 
		UserGroup ug = new UserGroup();
		ug.setEname("sqse_ename");
		request.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug);
		userController.getUsers(request, response);
		String str = response.getContentAsString();
		assertNotNull(str);
	}
	
	@Test
	public void userGroup() throws Exception {
		u = createUser(userDao);
		
		userController.checkUserApp(u.getEname(), request, response);
		String str = response.getContentAsString();
		assertNotNull(str);
	}
	
	@Test
	public void deleteUser () throws Exception {
		u = createUser(userDao);
		
		userController.deleteUser(u.getId(), response);
		
		String str = response.getContentAsString();
		int s = str.indexOf("SUCCESS");
		String success = str.substring(s, s+7);
		assertEquals("SUCCESS", success);
	}
	
	@Test
	public void getUsersAdmin() throws Exception {
		u = createUser(userDao);
		u.setActive(true);
		
		request.addParameter("page","1");   
		request.addParameter("rows","10"); 
		request.addParameter("sidx","id");   
		request.addParameter("sord","ASC"); 
		UserGroup ug = new UserGroup();
		ug.setId(u.getId());
		ug.setEname(u.getEname());
		request.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug);
		
		userController.getAdminUsers(request, response);
		
		String str = response.getContentAsString();
		int s = str.indexOf("total");
		String t = str.substring(s+7, s+8);
		assertEquals("1", t);
	}
	
	@Test
	public void updateUser() throws Exception {
		u = createUser(userDao);
		u.setCell("8613521225512");
		u.setMarriage(MaritalStatus.SEPARATED);
		u.setHeight("168");
		u.setPrivateMail("sqe_ole@126.com");
		u.setPhone("12354657");
		
		BindingResult result = new BindException("", "test");
		UserGroup ug = new UserGroup();
		ug.setId(u.getId());
		ug.setEname(u.getEname());
		request.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug);
		userController.saveUser(u, result, response);
		
		String str = response.getContentAsString();
		int s = str.indexOf("SUCCESS");
		String success = str.substring(s, s+7);
		assertEquals("SUCCESS", success);
	}
	
}
