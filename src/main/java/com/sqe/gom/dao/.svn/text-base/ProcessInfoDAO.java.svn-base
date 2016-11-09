/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.constant.ProcessType;
import com.sqe.gom.model.ProcessInfo;
import com.sqe.gom.util.Page;

/**
 * @description
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jun 19, 2012  8:38:44 PM
 * @version 3.0
 */
public interface ProcessInfoDAO extends GenericDAO<ProcessInfo> {
	/**
	 * get list of process
	 * 
	 * @param process The entity of process
	 * @param order  asc or desc
	 * @param crit  The query crit
	 * @param page
	 * @return
	 */
	List<ProcessInfo> getProcesses(ProcessInfo process, String order, String crit, Page page);
	
	/**
	 * 根据流程类型和节点或流程序号或流程ID获得流程对象
	 * @param type			LEAVE("请假流程"), TASK("工作流程"), ENTRY("入职流程"), DEPARTURE("离职流程"), ABNORMAL("异常流程");
	 * @param nodeCode		流程节点
	 * @param order			流程序号
	 * @param processId		流程ID号
	 * @return	返回流程对象
	 */
	ProcessInfo getProcessInfo(ProcessType type, String nodeCode, Integer order, Integer processId);
	
	/**
	 * 根据流程类型和节点或节点序号获得流程对象
	 * @param type		LEAVE("请假流程"), TASK("工作流程"), ENTRY("入职流程"), DEPARTURE("离职流程"), ABNORMAL("异常流程");
	 * @param nodeCode	流程节点
	 * @param order		流程序号
	 * @return	返回流程对象
	 */
	ProcessInfo getProcessInfo(ProcessType type, String nodeCode, Integer order);
	
	/**
	 * 查询当前类型条数
	 * @param type	LEAVE("请假流程"), TASK("工作流程"), ENTRY("入职流程"), DEPARTURE("离职流程"), ABNORMAL("异常流程");
	 * @return	返回条查询条数
	 */
	int getProcessOrder(ProcessType type);
}
