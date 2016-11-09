/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.ProcessType;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Trace;
import com.sqe.gom.util.Page;

/**
 * @description trace database operation
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Apr 15, 2012  9:07:23 PM
 * @version 3.0
 */
public interface TraceDAO extends GenericDAO<Trace> {
	/**
	 * get list of process trace
	 * 
	 * @param processId  The identify process ID
	 * @param type  The process type
	 * @return  list of process trace
	 */
	List<Trace> getTraces(Integer processId, ProcessType type);
	
	/**
	 * 查询入职需要审核的列表
	 * @param trace		流程对象
	 * @param order		排序方式
	 * @param crit		特殊条件
	 * @param page		前台分页
	 * @return	
	 */
	List<GomUser> getEntryUser(Trace trace, String order, String crit, Page page);
	
	/**
	 * query trace by processId, processType, processStatus and node
	 * 
	 * @param processId  The identify of process
	 * @param type  The type of process
	 * @param state  The state of process
	 * @param node The name of node
	 * @return The result of query trace
	 */
	Trace getTrace(Integer processId, ProcessType type, String node);
	
	/**
	 * 查询根据流程ID和流程类型查询当前详细Trace
	 * @param processId	流程ID
	 * @param type		流程类型
	 * @param node		流程节点
	 * @param actor		流程执行者
	 * @param state		流程状态
	 * @return	返回Trace对象
	 */
	Trace getUserTrace(Integer processId, ProcessType type, String node, String actor, ProcessStatus state);
	
	/**
	 * 编辑当前trace状态，图标，箭头
	 * @param t	Trace对象
	 * @return	返回成功失败0:1
	 */
	int updateTrace(Trace t);
	
	/**
	 * Query mail address for entrant process node
	 * 
	 * @param processId  The identify of process
	 * @param type   The type of process
	 * @return  list of mail address
	 */
	List<String> getEntryApprovalMail(Integer processId, ProcessType type);
}