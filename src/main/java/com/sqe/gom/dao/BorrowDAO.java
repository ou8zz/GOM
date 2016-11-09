/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.model.Borrow;
import com.sqe.gom.util.Page;

/**
 * @description borrow DAO manager interface
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
public interface BorrowDAO extends GenericDAO<Borrow> {
	
	/**
	 * 查询所有的借据
	 * @param ord
	 * @param criteria
	 * @param page
	 * @return
	 */
	List<Borrow> getBorrows(String ord, String criteria, Page page);
		
	/**
	 * 编辑的借据
	 * @param borrow
	 * @return
	 */
	boolean updateBorrow(Borrow borrow);
}
