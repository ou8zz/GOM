/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.io.Serializable;

/**
 * @description Define some generate CRUD operations
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jul 27, 2011  6:58:16 PM
 * @version 3.0
 */
public interface GenericDAO<T> {
	/**
	 * Query object by specified id.
	 */
	T query(Serializable id);

	/**
	 * Create an domain object.
	 */
	void create(T t);

	/**
	 * Delete an object.
	 */
	void delete(T t);
	
	/**
	 * remove by entity long id.
	 * 
	 * @param id  the entity identify
	 */
	void delete(Long id);
	
	/**
	 * remove by entity Integer id.
	 * 
	 * @param id  the entity identify
	 */
	void delete(Integer id);

	/**
	 * Update an object.
	 */
	void update(T t);
}
