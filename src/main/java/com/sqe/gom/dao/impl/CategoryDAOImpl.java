/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.dao.CategoryDAO;
import com.sqe.gom.model.Category;
import com.sqe.gom.util.RegexUtil;

/**
 * @description  ResourceDAO implements entity class.
 * @see com.sqe.gom.dao.GenericDAO
 * @description category
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 9, 2011
 * @version 3.0
 */
@SuppressWarnings("unchecked")
@Repository("categoryDao")
public class CategoryDAOImpl extends GenericHibernateDAO<Category> implements CategoryDAO {
	public CategoryDAOImpl() {
		super(Category.class);
	}

	@Override
	public void updateCategory(Category c) {
		executeUpdate("UPDATE Category AS c SET c.name=? WHERE c.id=?", new Object[]{c.getName(),c.getId()});
	}

	@Override
	public List<Category> getCategories(String criteria) {		
		String sql = "SELECT new com.sqe.gom.model.Category(c.id, c.name, c.node) FROM Category AS c ORDER BY c.node";
		if(RegexUtil.notEmpty(criteria)) sql += criteria;
		return (List<Category>) queryForList(sql, null);
	}
	
	@Override
	public List<Category> getCategories(String criteria, String ord) {		
		String sql = "SELECT c FROM Category AS c LEFT JOIN c.parent AS p WHERE 1=1";
		if(RegexUtil.notEmpty(criteria)) sql += criteria;
		if(RegexUtil.notEmpty(ord)) sql += ord;
		return (List<Category>) queryForList(sql, null);
	}
	
	@Override
	public String getMaxNode(Integer id) {
		StringBuilder sql = new StringBuilder("SELECT MAX(p.node) FROM Category AS p WHERE ");
		if(RegexUtil.notEmpty(id)) sql.append("p.parent.id=").append(id);
		else sql.append("p.parent is null");
		return (String) queryForObject(sql.toString(), null);
	}
}