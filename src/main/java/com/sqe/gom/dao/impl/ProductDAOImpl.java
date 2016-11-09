/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.dao.ProductDAO;
import com.sqe.gom.model.Product;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 5, 2012
 * @version 3.0
 */
@SuppressWarnings("unchecked")
@Repository("productDao")
public class ProductDAOImpl extends GenericHibernateDAO<Product> implements ProductDAO {
	public ProductDAOImpl() {
		super(Product.class);
	}
	
	@Override
	public List<Product> getProducts(String ord, String criteria, Page page) {
		String count = "SELECT COUNT(*) FROM Product WHERE 1=1";
		String sql = "SELECT new com.sqe.gom.model.Product(p.id,p.productName,p.productType,p.version,p.explains,p.num,p.unit,p.outputDate) FROM Product AS p WHERE 1=1";
		if(RegexUtil.notEmpty(criteria)) {
			count += criteria;
			sql += criteria;
		}
		if(RegexUtil.notEmpty(ord)) sql += ord; 
		List<Product> list = (List<Product>) queryForList(count, sql, null, page);
		return list;
	}
	
	@Override
	public List<Product> getProducts() {
		String sql = "SELECT new com.sqe.gom.model.Product(p.id,p.productName) FROM Product AS p";
		List<Product> list = (List<Product>) queryForList(sql, null);
		return list;
	}

	@Override
	public Product getProduct(String productName) {
		String sql = "FROM Product AS p WHERE p.productName=?";
		Product p = (Product) queryForObject(sql, new Object[]{productName});
		return p;
	}

}
