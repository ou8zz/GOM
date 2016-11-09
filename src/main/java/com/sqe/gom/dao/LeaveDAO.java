/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.model.Leave;
import com.sqe.gom.model.Trace;
import com.sqe.gom.util.Page;

/**
 * @description
 * @see 在此描述依赖的其他接口或类
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jul 31, 2011  4:24:30 PM
 * @version 3.0
 */
public interface LeaveDAO extends GenericDAO<Leave>{
	/**
	 * 更新请假状态
	 * 
	 * @param leave  请假单
	 * @return  成功的更新条数
	 */
	int updateLeave(Leave leave);
	
	/**
	 * query leave by userId and processStatus
	 * 
	 * @param uid  The identify of user
	 * @param state  The state of leave process
	 * @return  entity of leave
	 */
	Leave getLeave(Integer uid, ProcessStatus state);
	
	/**
	 * get list of leaves
	 * 
	 * @param userId  The identify of user
	 * @param state  The leave process state
	 * @return list of leaves.
	 */
	List<Leave> getLeaves(Integer userId, String criteria, String order, Page page);
	
	/**
	 * query leave by leaveId
	 * 
	 * @param id  The identify of leave
	 * @return  entity of leave
	 */
	Leave getLeave(Integer id);
	
	/**
	 * 查询当前用户对请假流程是否有操作的项目。如审核，回执等
	 * @param trace		操作对象内容，包括当前用户名，流程状态等
	 * @param criteria	特殊条件
	 * @param order		排序方式
	 * @param page		前台分页对象
	 * @return	list集合
	 */
	List<Leave> getLeaves(Trace trace, String criteria, String order, Page page);
}
