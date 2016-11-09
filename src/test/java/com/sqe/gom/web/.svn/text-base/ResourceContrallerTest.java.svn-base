/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web;

import static org.junit.Assert.assertEquals;

import java.util.Date;

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
import com.sqe.gom.app.ResourceService;
import com.sqe.gom.app.TrainingService;
import com.sqe.gom.constant.ResourceType;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.dao.CategoryDAO;
import com.sqe.gom.dao.ResourceDAO;
import com.sqe.gom.model.Category;
import com.sqe.gom.model.Experience;
import com.sqe.gom.model.Resource;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.ResourceController;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 1, 2012
 * @version 3.0
 */
public class ResourceContrallerTest extends BaseTest {
	private ResourceService resourceService;
	private TrainingService trainingService;
	private ResourceController resourceController;
	private MockHttpServletRequest request;
	private MockHttpServletResponse response;
	private ResourceDAO resourceDao;
	private CategoryDAO categoryDao;
	private Resource resource;
	
	@Autowired
	public void setResourceDao(ResourceDAO resourceDao) {
		this.resourceDao = resourceDao;
	}
	
	@Autowired
	public void setCategoryDao(CategoryDAO categoryDao) {
		this.categoryDao = categoryDao;
	}
	
	@Autowired
	public void setResourceService(ResourceService resourceService) {
		this.resourceService = resourceService;
	}
	
	@Autowired
	public void setTrainingService(TrainingService trainingService) {
		this.trainingService = trainingService;
	}
	
	@Before
	public void setUp() {
		resourceController = new ResourceController();
		resourceController.setResourceService(resourceService);
		resourceController.setTrainingService(trainingService);
		request =  new MockHttpServletRequest("GET","/resource.htm");  
		response = new MockHttpServletResponse();
		
		resource = new Resource();
		resource.setTitle("教育");
		resource.setVersion("V-1.0");
		resource.setCreateDate(new Date());
		resource.setUpdateDate(new Date());
		resource.setDes("教育详细信息");
		resource.setResourceType(ResourceType.EXPERIENCE);
		resource.setAttachment("file.doc");
		resource.setIsValid(true);
		resource.setUploadEname("sqe11");
		resource.setMaintainDpt("人事部");
		resource.setUploadDate(new Date());
		resource.setResponsibility(1);
		resource.setScore(12);
		resource.setSwot("12");
	}
	
	@After
	public void tearDown() {
		resourceDao.delete(resource);
	}
	
	@Test
	public void saveResource() throws Exception {
		Category category = new Category();
		category = new Category();
		category.setName("开发部");
		category.setPid(null);
		
		String str = categoryDao.getMaxNode(null);
		if(RegexUtil.notEmpty(str)) {
			Integer node = Integer.parseInt(str);
			node = node + 1;
			category.setNode(String.valueOf(node));
		} else category.setNode(String.valueOf(1));
		
		categoryDao.create(category);
		resource.setCategory(category);	//添加分组
		resource.setPath(category.getId());
		
		BindingResult result = new BindException("", "test");
		request.addParameter("oldfile", "file.doc");
		UserGroup ug = new UserGroup();
		ug.setEname("sqe_ename");
		ug.setCdepartment("人事部");
		request.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug);
		resourceController.editResource(resource, result, request, response);
		String reslut = response.getContentAsString();
		int s = reslut.indexOf("SUCCESS");
		String success = reslut.substring(s, s+7);
		assertEquals("SUCCESS", success);
	}
	
	@Test
	public void getResource() throws Exception {
		 request.addParameter("pageId","1");   
		 request.addParameter("type","HOW"); 
		 request.addParameter("name",""); 
		 Model model = new ExtendedModelMap();
		 String str = resourceController.getResourceApp(model, request, request.getSession());
		 assertEquals(str, "app/resource");
	}
	
	@Test
	public void getResources() throws Exception {
		request.addParameter("page","1");   
		request.addParameter("rows","10"); 
		request.addParameter("sidx","id");   
		request.addParameter("sord","ASC"); 
		UserGroup ug = new UserGroup();
		ug.setEname("sqse_ename");
		request.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug);
		resourceController.getHowtodos(request, response);
		assertEquals(200, response.getStatus());
	}
	
	@Test
	public void updateDownloadDate() throws Exception {
		resourceDao.create(resource);
		
		request.addParameter("resourceId",resource.getId().toString());   
		resourceController.updateDownloadDate(request, response);
		
		String str = response.getContentAsString();
		int s = str.indexOf("SUCCESS");
		String success = str.substring(s, s+7);
		assertEquals("SUCCESS", success);
	}
	
	@Test
	public void getHowtodos () throws Exception {
		Category cate = new Category();
		cate.setId(1);
		cate.setName("开发文件");
		cate.setParent(null);
		resource.setCategory(cate);	//添加分组
		resource.setPath(1);
		BindingResult result = new BindException("", "test");
		resourceController.editResource(resource, result, request, response);
		
		request.addParameter("page","1");   
		request.addParameter("rows","10"); 
		request.addParameter("sidx","id");   
		request.addParameter("sord","ASC"); 
		UserGroup ug = new UserGroup();
		ug.setEname("sqse_ename");
		request.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug);
		resourceController.getHowtodos(request, response);
		resourceController.getResource(request, response);
		
		assertEquals(200, response.getStatus());
	}
	
	@Test
	public void getResourcesAdmin() throws Exception {
		Category cate = new Category();
		cate.setId(1);
		cate.setName("开发文件");
		cate.setParent(null);
		resource.setCategory(cate);	//添加分组
		resource.setPath(1);
		BindingResult result = new BindException("", "test");
		
		resourceController.editResource(resource, result, request, response);
		
		request.addParameter("page","1");   
		request.addParameter("rows","10"); 
		request.addParameter("sidx","id");   
		request.addParameter("sord","ASC"); 
		UserGroup ug = new UserGroup();
		ug.setEname("sqse_ename");
		request.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug);
		resourceController.getResources(request, response) ;
		
		assertEquals(200, response.getStatus());
	}

	@Test
	public void saveHow() throws Exception {
		resourceDao.create(resource);
		BindingResult result = new BindException("", "test");
		
		UserGroup ug = new UserGroup();
		ug.setId(1);
		ug.setEname("sqse_ename");
		ug.setCdepartment("人事部");
		request.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug);
		
		Experience experience = new Experience();
		experience.setResourceId(resource.getId());
		experience.setStudent(ug.getEname());
		experience.setGain("添加新的心得内容如此");
		experience.setResource(resource);
		experience.setCreateDate(new Date());
		
		resourceController.saveHow(experience, result, request, response);
		
		String str = response.getContentAsString();
		int s = str.indexOf("SUCCESS");
		String success = str.substring(s, s+7);
		assertEquals("SUCCESS", success);
	}
	
}
