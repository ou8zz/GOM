/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.ProductType;
import com.sqe.gom.constant.ProjectType;
import com.sqe.gom.dao.ProductDAO;
import com.sqe.gom.dao.ProjectDAO;
import com.sqe.gom.model.Product;
import com.sqe.gom.model.Project;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 25, 2012
 * @version 3.0
 */
@Ignore
public class ProjectServiceTest extends BaseTest {
	private ProjectService projectService;
	private ProjectDAO projectDao;
	private ProductDAO productDao;
	private Project project;
	private Product product;
	
	@Autowired
	public void setProjectDao(ProjectDAO projectDao) {
		this.projectDao = projectDao;
	}
	
	@Autowired
	public void setProductDao(ProductDAO productDao) {
		this.productDao = productDao;
	}
	
	@Autowired
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
	
	@Before
	public void setUp() {
		project = new Project();
		project.setType(ProjectType.Project);
		project.setProjectNo("N001");
		project.setProjectName("Gom");
		project.setVersion("V-3.0");
		project.setDirector("director");
		project.setDes("项目详情");
		project.setExpectedTime("2011-1-1");
		project.setActualTime("2012-2-2");
		
		product = new Product();
		product.setProductName("产品名");
		product.setProductType(ProductType.CONSULTING);
		product.setVersion("V-1.0");
		product.setUnit("个");
		product.setExplains("项目关系 ");
		product.setNum(1);
	}
	
	@After
	public void tearDown() {
		if(RegexUtil.notEmpty(project.getId())) 
			projectDao.delete(project);
		if(RegexUtil.notEmpty(product.getId())) 
			productDao.delete(product);
	}
	
	@Test
	public void saveProject() {
		projectService.saveProject(project);
		assertNotNull(project.getId());
	}
	
	@Test
	public void saveProduct() {
		projectService.saveProduct(product);
		assertNotNull(product.getId());
	}
	
	@Test
	public void checkProject() {
		projectService.saveProject(project);
		boolean b = projectService.checkProject(project);
		assertTrue(b);
	}
	
	@Test
	public void checkProduct() {
		projectService.saveProduct(product);
		boolean b = projectService.checkProduct(product.getProductName());
		assertTrue(b);
	}
}
