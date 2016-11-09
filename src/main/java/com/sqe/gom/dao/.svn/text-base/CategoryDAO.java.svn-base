/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.model.Category;

/**
 * @description category DAO Manager
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 9, 2011
 * @version 3.0
 */
public interface CategoryDAO extends GenericDAO<Category> {

	/** Category表操作, 注意更新时的path的关联更新
	 * 比如：name=手册 path=/IT部，
	 * 假如 IT 部被更新，那么他的子类手册的path也要更新！
	 * 首先添加或更新Category
	 * 根据ID判断是更新还是保存
	 * @param Category 
	 * @return  
	 */	
	void updateCategory(Category c);

	/**
	 * 查询所有分类，按node排序
	 * @param criteria
	 * @return
	 */
	List<Category> getCategories(String criteria);
	
	/**
	 * 查询到分类的所有数据
	 * @param  
	 * @return List  
	 */
	List<Category> getCategories(String criteria, String order);
	
	/**
	 * 查询最大的节点
	 * @param id
	 * @return
	 */
	String getMaxNode(Integer id);
}
