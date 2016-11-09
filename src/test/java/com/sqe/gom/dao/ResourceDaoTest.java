/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import static org.junit.Assert.assertNotNull;

import java.util.Date;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.ResourceType;
import com.sqe.gom.model.Category;
import com.sqe.gom.model.Experience;
import com.sqe.gom.model.Resource;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 27, 2012
 * @version 3.0
 */
public class ResourceDaoTest extends BaseTest {
	private ResourceDAO resourceDao;
	private CategoryDAO categoryDao;
	private Resource resource;
	private Category c;
	
	@javax.annotation.Resource(name="resourceDao")
	public void setResourceDao(ResourceDAO resourceDao) {
		this.resourceDao = resourceDao;
	}
	
	@Autowired
	public void setCategoryDao(CategoryDAO categoryDao) {
		this.categoryDao = categoryDao;
	}
	
	@Before
	public void initData() {
		resource = new Resource();
		resource.setTitle("教育");
		resource.setVersion("V-1.0");
		resource.setCreateDate(new Date());
		resource.setUpdateDate(new Date());
		resource.setDes("教育详细信息");
		resource.setResourceType(ResourceType.EXPERIENCE);
		resource.setAttachment("");
		resource.setIsValid(true);
		resource.setUploadEname("sqe11");
		resource.setMaintainDpt("人事部");
		resource.setUploadDate(new Date());
		resource.setResponsibility(1);
		resource.setScore(12);
		resource.setSwot("12");
		
		c = new Category();
		c.setName("开发部");
		c.setPid(null);
		String str = categoryDao.getMaxNode(null);
		if(RegexUtil.notEmpty(str)) {
			Integer node = Integer.parseInt(str);
			node = node + 1;
			c.setNode(String.valueOf(node));
		} else c.setNode(String.valueOf(1));
	}
	
	@After
	public void tearDown() {
		resourceDao.delete(resource);
	}
	
	@Test
	public void saveResource() {
		categoryDao.create(c);
		resource.setCategory(c);	//添加分组
		resourceDao.create(resource);
	}
	
	@Test
	public void getResource() {
		categoryDao.create(c);
		resource.setCategory(c);	//添加分组
		resourceDao.create(resource);
		String gain = "";
		Resource resources = resourceDao.query(resource.getId());
		for(Experience e : resources.getExperience()) {
			Date down = resources.getDownloadDate();
			Date crea = e.getCreateDate();
			if(RegexUtil.notEmpty(down) && (down.after(crea) || down.equals(crea))) {
				gain += e.getGain();
			}
		}
	}
	
	@Test
	public void getResources() {
		categoryDao.create(c);
		resource.setCategory(c);	//添加分组
		resourceDao.create(resource);
		
		String q = " AND r.isValid=true";		//前台用户只加载管理员认证过的数据
		q += " AND r.resourceType="+ResourceType.EXPERIENCE.ordinal();
		q += " AND r.title like '%"+resource.getTitle()+"%'";
		String ord = " ORDER BY r.id ASC";
		List<Resource> list = resourceDao.getResources(ord, q, new Page(1,5));
		assertNotNull(list);
	}
	
}
