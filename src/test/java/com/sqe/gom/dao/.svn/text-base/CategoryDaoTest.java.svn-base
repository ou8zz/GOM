/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.ResourceType;
import com.sqe.gom.model.Category;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 25, 2012
 * @version 3.0
 */
public class CategoryDaoTest extends BaseTest {
	private CategoryDAO categoryDao;
	private ResourceDAO resourceDao;
	private Category c;
	
	@Resource(name="categoryDao")
	public void setCategoryDao(CategoryDAO categoryDao) {
		this.categoryDao = categoryDao;
	}
	
	@Resource(name="resourceDao")
	public void setResourceDao(ResourceDAO resourceDao) {
		this.resourceDao = resourceDao;
	}
		
	@Before
	public void initData() {
		c = new Category();
		c.setName("开发部");
		c.setPid(null);

		if(RegexUtil.notEmpty(c.getPid())) {
			Category parent = categoryDao.query(c.getPid());
			c.setParent(parent);
			String str = categoryDao.getMaxNode(c.getPid());
			if(RegexUtil.notEmpty(str)) {
				int i = str.lastIndexOf(".");
				String nodePre = str.substring(0, i+1);
				int node = Integer.parseInt(str.substring(i+1));
				node = node + 1;
				c.setNode(String.valueOf(nodePre+node));
			} else c.setNode(parent.getNode() + ".1");
		} else {
			String str = categoryDao.getMaxNode(null);
			if(RegexUtil.notEmpty(str)) {
				Integer node = Integer.parseInt(str);
				node = node + 1;
				c.setNode(String.valueOf(node));
			} else c.setNode(String.valueOf(1));
		}
		categoryDao.create(c);
	}
	
	@After
	public void cleanData() {
		categoryDao.delete(c);
	}
	
	@Test
	public void saveResource() throws Exception {
		com.sqe.gom.model.Resource resource = new com.sqe.gom.model.Resource();
		resource.setId(null);
		resource.setTitle("这是标题");
		resource.setVersion("V-2.3");
		resource.setCreateDate(new Date());
		resource.setUpdateDate(new Date());
		resource.setUploadDate(new Date());
		resource.setDes("这是说明");
		resource.setResourceType(ResourceType.HOW);
		resource.setAttachment("");
		resource.setIsValid(true);
		resource.setUploadEname("sqe11");
		resource.setMaintainDpt("开发部");
		resource.setCategory(categoryDao.query(c.getId()));	
		
		if(RegexUtil.notEmpty(resource.getId())) {
			//执行更新
			float ver = Float.parseFloat(RegexUtil.formatDecimal(Float.parseFloat(resource.getVersion().substring(2)), "#.##"));
			resource.setVersion("V-"+ (ver + 0.1));				
			resource.setUpdateDate(new Date());
			resourceDao.update(resource);
			assertNotNull(resource);
		} else {
			//执行添加
			resource.setIsValid(true);
			resource.setVersion("V-1.0");
			resource.setUploadDate(new Date());
			resource.setCreateDate(new Date());
			resourceDao.create(resource);
			assertNotNull(resource.getId());
		}
	}
	
	@Test
	public void saveCategory() throws Exception {
		assertNotNull(c);
	}
		
	@Test
	public void updateCategory() {
		Category ca = new Category();
		ca.setId(c.getId());
		ca.setName("人事部");
		ca.setPid(null);
		categoryDao.updateCategory(ca);
		
		assertEquals("人事部", ca.getName());
	}
	
	@Test
	public void getCategory() {
		List<Category> list = categoryDao.getCategories(null);
		assertNotNull(list);
	}
}
