/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;

import com.sqe.gom.BaseTest;
import com.sqe.gom.app.ProjectService;
import com.sqe.gom.constant.ProjectType;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.dao.ProjectDAO;
import com.sqe.gom.model.Project;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.ProjectController;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 1, 2012
 * @version 3.0
 */
@Ignore
public class ProjectContrallerTest extends BaseTest {
	private ProjectService projectService;
	private ProjectController projectController;
	private MockHttpServletRequest request;
	private MockHttpServletResponse response;
	private ProjectDAO projectDao;
	private Project project;
	
	@Autowired
	public void setProjectDao(ProjectDAO projectDao) {
		this.projectDao = projectDao;
	}
	
	@Autowired
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
	
	@Before
	public void setUp() {
		projectController = new ProjectController();
		projectController.setProjectService(projectService);
		request =  new MockHttpServletRequest("GET","/project.htm");  
		response = new MockHttpServletResponse();
		
		project = new Project();
		project.setProjectNo("N001");
		project.setProjectName("Gom");
		project.setVersion("V-3.0");
		project.setDirector("director");
		project.setDes("项目详情");
		project.setExpectedTime("2011-1-1");
		project.setActualTime("2012-2-2");
		project.setType(ProjectType.Project);
	}
	
	@After
	public void tearDown() {
		projectDao.delete(project);
	}
	
	@Test
	public void saveProject() throws Exception {
		
		BindingResult result = new BindException("", "test");
		projectController.saveProject(project, result, response);	
		
		String str = response.getContentAsString();
		int s = str.indexOf("SUCCESS");
		String success = str.substring(s, s+7);
		assertEquals("SUCCESS", success);
	}
	
	@Test
	public void getProducts() throws Exception {
		
		projectService.saveProject(project);
		
		request.addParameter("page","1");   
		request.addParameter("rows","10"); 
		request.addParameter("sidx","id");   
		request.addParameter("sord","ASC"); 
		UserGroup ug = new UserGroup();
		ug.setEname("sqse_ename");
		request.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug);
		projectController.getProjects(request, response);
		
		assertNotNull(response.getContentAsString());
	}
	
	@Test
	public void deleteProject() throws Exception {
		projectService.saveProject(project);
		
		projectController.deleteProject(project.getId(), response);
		
		String str = response.getContentAsString();
		int s = str.indexOf("SUCCESS");
		String success = str.substring(s, s+7);
		assertEquals("SUCCESS", success);
	}
}
