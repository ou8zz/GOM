/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;

import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.model.FixedTask;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description FixedTask manage service
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 5, 2012
 * @version 3.0
 */
@Transactional
public interface FixedTaskService {
	
	/**
	 * 分页查询
	 * @param ord 排序
	 * @param criteria 条件
	 * @param page 分页条件
	 * @return 返回List<FixedTask>
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	JGridBase<FixedTask> getFixedTasks(JGridHelper<FixedTask> grid);
	
	/**
	 * 查询所有固定工作
	 * @param state
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	List<FixedTask> getFixedTasks(ProcessStatus state);
	 
	/**
	 * 保存或修改FixedTask信息
	 * @param FixedTask
	 */
	@PreAuthorize("hasRole('User')")
	void saveFixedTask(FixedTask ft);
	
	/**
	 * 停止一条FixedTask信息
	 * @param 根据id删除
	 */
	@PreAuthorize("hasRole('User')")
	void stopFixedTask(int id);
	
}
