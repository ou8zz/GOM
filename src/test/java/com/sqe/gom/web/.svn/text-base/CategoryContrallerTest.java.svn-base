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
import com.sqe.gom.app.ResourceService;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.model.Category;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.CategoryController;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 1, 2012
 * @version 3.0
 */
public class CategoryContrallerTest extends BaseTest {
	private ResourceService resourceService;
	private CategoryController categoryController;
	private MockHttpServletRequest request;
	private MockHttpServletResponse response;
	
	@Autowired
	public void setResourceService(ResourceService resourceService) {
		this.resourceService = resourceService;
	}
	
	@Before
	public void setUp() {
		categoryController = new CategoryController();
		categoryController.setResourceService(resourceService);
		request =  new MockHttpServletRequest("GET","/category.htm");  
		response = new MockHttpServletResponse();
	}
	
	@Test
	public void saveCategory() throws Exception {
		Category c = new Category();
		c.setName("开发部");
		c.setPid(null);
		
		BindingResult result = new BindException("", "test");
		categoryController.saveCategory(c, result, response);
		String str = response.getContentAsString();
		int s = str.indexOf("SUCCESS");
		String success = str.substring(s, s+7);
		assertEquals("SUCCESS", success);
	}
		
	@Test
	public void getCategory() throws Exception {
		Category c = new Category();
		c.setName("开发部");
		c.setPid(null);
		
		BindingResult result = new BindException("", "test");
		categoryController.saveCategory(c, result, response);
		
		request.addParameter("page","1");   
		request.addParameter("rows","10"); 
		request.addParameter("sidx","id");   
		request.addParameter("sord","ASC"); 
		UserGroup ug = new UserGroup();
		ug.setEname("sqse_ename");
		request.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug);
		categoryController.getCategory(request, response);
		String str = response.getContentAsString();
		assertNotNull(str);
	}
	
	@Test
	public void getPaths() throws Exception {
		Category c = new Category();
		c.setName("开发部");
		c.setPid(null);
		
		BindingResult result = new BindException("", "test");
		categoryController.saveCategory(c, result, response);
		
		categoryController.getPaths(response);
		String str = response.getContentAsString();
		assertNotNull(str);
	}
	
	@Test
	public void deleteCategory() throws Exception {
		Category c = new Category();
		c.setName("开发部");
		c.setPid(null);
		
		BindingResult result = new BindException("", "test");
		categoryController.saveCategory(c, result, response);
		
		categoryController.deleteCategory(c.getId(), response);
		
		String str = response.getContentAsString();
		int s = str.indexOf("SUCCESS");
		String success = str.substring(s, s+7);
		assertEquals("SUCCESS", success);
	}
}
