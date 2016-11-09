/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.model.Meeting;
import com.sqe.gom.util.Page;

/**
 * @description database operator meeting entity.
 * @author <a href="mailto:sqe_ole@sqeservice.com">James</a>
 * @date Feb 8, 2012  10:32:24 PM
 * @version 3.0
 */
public interface MeetingDAO extends GenericDAO<Meeting> {
	
	/**
	 * 查询会议记录列表
	 * @param ord		排序条件
	 * @param criteria	查询条件
	 * @param page		分页对象
	 * @return			List<Meeting>
	 */
	List<Meeting> getMeetings(String ord, String criteria, Page page);
	
	/**
	 * 保存会议，添加和修改都可以
	 * @param meeting	需要添加或修改的对象
	 */
	void updateMeeting(Meeting meeting);
}
