/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import static org.junit.Assert.assertNotNull;

import javax.annotation.Resource;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.w3c.dom.Document;

import com.sqe.gom.BaseTest;
import com.sqe.gom.dao.CategoryDAO;
import com.sqe.gom.model.Category;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 25, 2012
 * @version 3.0
 */
public class CategoryServiceTest extends BaseTest {
	private CategoryDAO categoryDao;
	private ResourceService resourceService;
	private Category category;
	
	@Resource(name="categoryDao")
	public void setCategoryDao(CategoryDAO categoryDao) {
		this.categoryDao = categoryDao;
	}
		
	@Resource(name="resourceService")
	public void setResourceService(ResourceService resourceService) {
		this.resourceService = resourceService;
	}
	
	@Before
	public void setUp() {
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
	}
	
	@After
	public void tearDown() {
		categoryDao.delete(category);
	}
	
	@Test
	public void saveCategory() throws Exception {
		categoryDao.create(category);
		assertNotNull(category.getId());
		
		Category cate = new Category();
		cate.setName("人事部资料");
		cate.setPid(null);
		resourceService.saveCategory(cate);
		assertNotNull(cate.getId());
		
	}
	
	@Test
	public void getCategorys() {
		categoryDao.create(category);
		Document doc = resourceService.getCategories(null, 1);
		assertNotNull(doc.getNodeName());
    }
	
	@Test
	public void deleteCategory() {
		categoryDao.create(category);
		resourceService.removeCategory(category.getId());
	}
}
