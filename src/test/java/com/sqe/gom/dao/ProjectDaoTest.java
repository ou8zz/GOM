/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.sqe.gom.BaseTest;
import com.sqe.gom.model.Project;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 27, 2012
 * @version 3.0
 */
public class ProjectDaoTest extends BaseTest {
	private ProjectDAO projectDao;
	private Project project;
	
	@Autowired
	public void setProjectDao(ProjectDAO projectDao) {
		this.projectDao = projectDao;
	}
		
	@Before
	public void initData() {
		project = new Project();
		project.setProjectNo("N001");
		project.setProjectName("Gom");
		project.setVersion("V-3.0");
		project.setDirector("director");
		project.setDes("项目详情");
		project.setExpectedTime("2011-1-1");
		project.setActualTime("2012-2-2");
	}
	
	@After
	public void cleanData() {
		projectDao.delete(project);
	}
	
	@Test
	public void saveProject() {
		projectDao.create(project);
		assertNotNull(project.getId());
	}
	
	@Test
	public void getProject() {
		projectDao.create(project);
		String ord = " ORDER BY p.id ASC";
		List<Project> list = projectDao.getProjects(ord, null);
		
		assertNotNull(list.size());
	}
		
	@Test
	public void updateProject() {
		projectDao.create(project);
		
		project.setProjectNo("N002");
		
		projectDao.update(project);
		assertTrue("N002".equals(project.getProjectNo()));
	}
	
	@Test
	public void checkProject() {
		projectDao.create(project);
		Project pro = projectDao.getProject(project);
		assertNotNull(pro);
	}
}
