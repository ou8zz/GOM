/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.Date;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.ProductType;
import com.sqe.gom.model.Product;
import com.sqe.gom.util.Page;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 27, 2012
 * @version 3.0
 */
public class ProductDaoTest extends BaseTest {
	private ProductDAO productDao;
	private Product product;
		
	@Autowired
	public void setProductDao(ProductDAO productDao) {
		this.productDao = productDao;
	}
	
	@Before
	public void initData() {
		product = new Product();
		product.setProductName("产品名");
		product.setProductType(ProductType.CONSULTING);
		product.setVersion("V-1.0");
		product.setUnit("个");
		product.setExplains("项目关系 ");
		product.setNum(1);
		product.setOutputDate(new Date());
	}
	
	@After
	public void cleanData() {
		productDao.delete(product);
	}
	
	@Test
	public void saveProduct() {
		productDao.create(product);
		assertNotNull(product.getId());
	}
	
	@Test
	public void getProduct() {
		productDao.create(product);
		String ord = " ORDER BY p.id ASC";
		List<Product> list = productDao.getProducts(ord, null, new Page(1,5));
		
		assertNotNull(list.size());
	}
		
	@Test
	public void updateProduct() {
		productDao.create(product);
		product.setProductName("修改名");
		product.setProductType(ProductType.CONSULTING);
		product.setVersion("V-1.1");
		product.setUnit("个");
		product.setExplains("项目关系");
		productDao.update(product);
		assertTrue("V-1.1".equals(product.getVersion()));
	}
	
	@Test
	public void checkProduct() {
		productDao.create(product);
		Product pro = productDao.getProduct(product.getProductName());
		assertNotNull(pro);
	}
}
