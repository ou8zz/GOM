/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.w3c.dom.Document;

import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.ResourceType;
import com.sqe.gom.dao.CategoryDAO;
import com.sqe.gom.dao.ExperienceDAO;
import com.sqe.gom.dao.ResourceDAO;
import com.sqe.gom.model.Category;
import com.sqe.gom.model.Experience;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Resource;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 25, 2012
 * @version 3.0
 */
public class ResouceServiceTest extends BaseTest {
	private MockHttpServletRequest request;
	private MockHttpServletResponse response;
	private ResourceService resourceService;
	private CategoryDAO categoryDao;
	private ExperienceDAO experienceDao;
	private ResourceDAO resourceDao;
	private Resource resource;
	private UserGroup ug;
	private GomUser gu;
	private Category category;
	
	@Autowired
	public void setCategoryDao(CategoryDAO categoryDao) {
		this.categoryDao = categoryDao;
	}
		
	@Autowired
	public void setExperienceDao(ExperienceDAO experienceDao) {
		this.experienceDao = experienceDao;
	}
	
	@Autowired
	public void setResourceDao(ResourceDAO resourceDao) {
		this.resourceDao = resourceDao;
	}
	
	@Autowired
	public void setResourceService(ResourceService resourceService) {
		this.resourceService = resourceService;
	}
	
	@Before
	public void initData() {
		ug = new UserGroup();
		ug.setEname("sqe11");
		ug.setCdepartment("人事部");
		ug.setComment("附件");
		
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
		
		resource = new Resource();
		resource.setTitle("教育");
		resource.setVersion("V-1.0");
		resource.setCreateDate(new Date());
		resource.setUpdateDate(new Date());
		resource.setDes("教育详细信息");
		resource.setResourceType(ResourceType.HOW);
		resource.setAttachment("");
		resource.setIsValid(true);
		resource.setUploadEname("sqe11");
		resource.setMaintainDpt("人事部");
		resource.setUploadDate(new Date());
		resource.setDownloadDate(DateUtil.parseDate("2011-01-01"));
		resource.setResponsibility(1);
		resource.setScore(12);
		resource.setSwot("12");
		resource.setCategory(category);	//添加分组
		resource.setPath(category.getId());
		
		request =  new MockHttpServletRequest("GET","/resource.htm");  
		response = new MockHttpServletResponse();
	}
	
	@After
	public void cleanData() {
		if(RegexUtil.notEmpty(resource.getId()))
			resourceDao.delete(resource);
	}
	
	@Test
	public void saveResource() {
		resourceService.saveResource(resource, ug);
		assertNotNull(resource.getId());
	}
	
	@Test
	public void saveCategory() {
		resourceService.saveCategory(category);
		assertNotNull(category.getId());
	}
	
	@Test
	public void getCategories() {
		resourceService.saveCategory(category);
		
		Document doc = resourceService.getCategories(null, 1);
		//assertNotNull(doc.getTextContent());
	}
		
	@Test
	public void getResources() {
		resourceService.saveResource(resource, ug);
		List<Resource> list1 = resourceService.getResources("HOW", null, new Page(1,5));
		List<Resource> list2 = resourceService.getResources("", "教育", new Page(1,5));
		assertNotNull(list1);
		assertNotNull(list2);
		assertEquals(1, list1.size());
		assertEquals(1, list2.size());
	}
	
	@Test
	public void getHows() {
		resourceService.saveResource(resource, ug);
		
		JGridHelper<Resource> grid = new JGridHelper<Resource>();
		grid.jgridHandler(request, response, "r.");
		grid.getJq().setSidx("id");
		grid.getJq().setSord("ASC");
		grid.getJq().setPage(1);
		grid.getJq().setRows(10);
		
		Experience experience = new Experience();
		experience.setStudent("sqe11");
		experience.setCreateDate(new Date());
		experience.setGain("sqe11我的心得内容添加");
		experience.setResource(resource);
		experienceDao.create(experience);
		Set<Experience> se = new HashSet<Experience>();
		se.add(experience);
		resource.setExperience(se);
		
		assertNotNull(experience.getId());
		
		JGridBase<Resource> jgb = resourceService.getHowtodos(grid, resource.getUploadEname());
		
		assertNotNull(jgb.getList());
		assertEquals(1, jgb.getList().size());
	}
	
	@Test
	public void getResourceSelect() {
		resourceService.saveResource(resource, ug);
		
		Experience experience = new Experience();
		experience.setStudent("sqe11");
		experience.setCreateDate(new Date());
		experience.setGain("sqe11我的心得内容添加");
		experience.setResource(resource);
		experienceDao.create(experience);
		Set<Experience> se = new HashSet<Experience>();
		se.add(experience);
		resource.setExperience(se);
		
		JGridHelper<Resource> grid = new JGridHelper<Resource>();
		grid.jgridHandler(request, response, "r.");
		grid.getJq().setSidx("id");
		grid.getJq().setSord("ASC");
		grid.getJq().setPage(1);
		grid.getJq().setRows(10);
		
		JGridBase<Resource> jgb = resourceService.getHowtodos(grid, resource.getUploadEname());
		
		assertNotNull(jgb.getList());
		assertEquals(1, jgb.getList().size());
		
		List<Resource> list = resourceService.getResourceSelect();
		assertTrue(list.size() > 0);
	}
}
