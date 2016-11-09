/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;

import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.model.Meeting;
import com.sqe.gom.util.Page;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description 会议逻辑层
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Transactional
public interface MeetingService {
	
	/**
	 * 条件查询会议记录
	 * @param time
	 * @param page
	 * @return
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	List<Meeting> getMettings(String time, Page page);
	
	/**
	 * 根据条件criteria 分页Page 查询  ord 排序Meeting
	 * @param ord
	 * @param condition
	 * @param page
	 * @return
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	JGridBase<Meeting> getMettings(JGridHelper<Meeting> grid);
		
	/**
	 * 保存、更新Meeting 完成后发送邮件
	 * @param Meeting
	 * @return HandlerState
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(rollbackFor = Exception.class)	//如果邮件没有发成功回滚事务
	HandlerState saveMeeting(Meeting m);
	
}
