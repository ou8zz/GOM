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
 * @description
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Feb 10, 2012  8:06:17 PM
 * @version 3.0
 */
@Transactional
public interface CommonService {
	/**
	 * 分页查询
	 * 
	 * @return list of FixedTasks JGridBase
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	JGridBase<FixedTask> getFixedTasks(JGridHelper<FixedTask> grid, String state);
	
	/**
	 * 查询所有固定工作
	 * @param state
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	List<FixedTask> getFixedTasks(ProcessStatus state);
	 
	/**
	 * 保存FixedTask信息
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
