/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;
import com.sqe.gom.model.FixedTask;
import com.sqe.gom.util.Page;

/**
 * @description FixedTask DAO manager interface
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 5, 2012
 * @version 3.0
 */
public interface FixedTaskDAO extends GenericDAO<FixedTask> {
	/**
	 * 固定工作列表
	 * @param ord
	 * @param criteria
	 * @param page
	 * @return
	 */
	List<FixedTask> getFixedTasks(String ord, String criteria, Page page);
	
	/**
	 * 查询task列表中没有的固定工作
	 * @param criteria
	 * @return
	 */
	List<FixedTask> getTaskNotFixed(String criteria);
	
	/**
	 * 修改固定工作
	 * @param ft
	 */
	void updateFixedTask(FixedTask ft);
}