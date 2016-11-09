/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.model.Product;
import com.sqe.gom.util.Page;

/**
 * @description Product DAO manager interface
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 5, 2012
 * @version 3.0
 */
public interface ProductDAO extends GenericDAO<Product> {
	/**
	 * 根据条件criteria 分页Page 查询所以公司资产  ord 排序
	 * @param ord			排序
	 * @param condition		特殊条件
	 * @param page			前台分页对象
	 * @return	返回产品对象集合
	 */
	List<Product> getProducts(String ord, String criteria, Page page);
	
	/**
	 * 查询所有产品
	 * @return	返回产品对象集合
	 */
	List<Product> getProducts();
	
	/**
	 * 查询产品名称是否存在
	 * @param pro
	 * @return	返回产品对象
	 */
	Product getProduct(String productName);
}
