/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;

import com.sqe.gom.BaseTest;
import com.sqe.gom.app.ResponsibilityService;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.dao.ResponsibilityDAO;
import com.sqe.gom.model.Responsibility;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.ResponsibilityController;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 1, 2012
 * @version 3.0
 */
public class ResponsibilityControllerTest extends BaseTest {
	private ResponsibilityController responsibilityController;
	private ResponsibilityService responsibilityService;
	private ResponsibilityDAO responsibilityDao;
	private Responsibility responsibility;
	private MockHttpServletRequest request;
	private MockHttpServletResponse response;
	
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
		responsibilityController = new ResponsibilityController();
		responsibilityController.setResponsibilityService(responsibilityService);
		request =  new MockHttpServletRequest("GET","/responsibility.htm");  
		response = new MockHttpServletResponse();
		
		responsibility = new Responsibility();
		responsibility.setFuncode("F-01");
		responsibility.setName("责任名称");
		responsibility.setExplanation("分配说明");
		Responsibility parent = null;
		if(RegexUtil.notEmpty(responsibility.getParentId()))
			parent = responsibilityDao.query(responsibility.getParentId());
		responsibility.setParent(parent);
	}
	
	
	@Test
	public void saveResponsibility() throws Exception {
		BindingResult result = new BindException("", "test");
		responsibilityController.saveResponsibilityApp(responsibility, result, response);
		String str = response.getContentAsString();
		int s = str.indexOf("SUCCESS");
		String success = str.substring(s, s+7);
		assertEquals("SUCCESS", success);
		responsibilityDao.delete(responsibility);
	}
		
	@Test
	public void getResponsibility() throws Exception {
		responsibilityDao.create(responsibility);
		
		request.addParameter("page","1");   
		request.addParameter("rows","10"); 
		request.addParameter("sidx","id");   
		request.addParameter("sord","ASC"); 
		UserGroup ug = new UserGroup();
		ug.setEname("sqse_ename");
		request.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug);
		responsibilityController.getResponsibility(request, response);
		String str = response.getContentAsString();
		System.out.println(str);
		assertNotNull(str);
		responsibilityDao.delete(responsibility);
	}
		
}
