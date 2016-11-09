/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.model.Task;
import com.sqe.gom.model.Trace;
import com.sqe.gom.util.Page;

/**
 * @description Task DAO manager interface
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 5, 2012
 * @version 3.0
 */
public interface TaskDAO extends GenericDAO<Task> {
	
	/**
	 * 根据条件criteria 分页Page 查询  ord 排序
	 * @param ord
	 * @param condition
	 * @param page
	 * @return
	 */
	List<Task> getTasks(String ord, String criteria, Page page);
	
	/**
	 * 查询固定工作关联
	 * @param criteria
	 * @return
	 */
	List<Task> getTasks(String criteria);
	
	/**
	 * 根据条件criteria 分页Page 查询  ord 排序
	 * @param ord
	 * @param Assignor OR Executor
	 * @param condition
	 * @param page
	 * @return
	 */
	List<Task> getTasks(Trace trace, String order, String criteria, Page page);
	
	/**
	 * 修改工作任务其中一些字段
	 * @param task
	 */
	void updateTask(Task task);
	
}
