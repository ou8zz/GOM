/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.model.Logs;
import com.sqe.gom.util.Page;

/**
 * @description database operator meeting entity.
 * @author <a href="mailto:sqe_ole@sqeservice.com">James</a>
 * @date Feb 8, 2012  10:32:24 PM
 * @version 3.0
 */
public interface LogDAO extends GenericDAO<Logs> {
	
	/**
	 * 查询日志记录列表
	 * @param ord		排序条件
	 * @param criteria	查询条件
	 * @param page		分页对象
	 * @return			List<Meeting>
	 */
	List<Logs> getLogs(String ord, String criteria, Page page);
	
	/**
	 * 添加和修改日志
	 * @param log	需要添加或修改的对象
	 */
	void updateLog(Logs log);
}
