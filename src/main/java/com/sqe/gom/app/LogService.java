/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;

import com.sqe.gom.model.Logs;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description 日志逻辑层
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Transactional
public interface LogService {
	
	/**
	 * 根据条件criteria 分页Page 查询  ord 排序 日志
	 * @param ord
	 * @param condition
	 * @param page
	 * @return
	 */
	JGridBase<Logs> getLogs(JGridHelper<Logs> grid);
		
	/**
	 * 条件查询日志列表
	 * @param criteria
	 * @return
	 */
	List<Logs> getLogs(String criteria);
	
	/**
	 * 添加、更新Logs 
	 * @param Logs
	 * @return 
	 */
	@PreAuthorize("hasRole('Admin')")
	void saveLog(Logs log);
	
}
