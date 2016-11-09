/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.constant.DateRange;
import com.sqe.gom.model.Statistics;
import com.sqe.gom.model.Summary;
import com.sqe.gom.vo.Attendance;

/**
 * @description Summary DAO manager interface
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
public interface SummaryDAO extends GenericDAO<Summary> {
	
	/**
	 * 统计项目查询
	 * @param uid		用户ID
	 * @param count		所需条数
	 * @param range		日期类型
	 * @return
	 */
	List<Statistics> getSummary(Integer uid, Integer count, DateRange range);
	
	
	/**
	 * 用户出勤查询存储过程
	 * @param uid
	 * @return
	 */
	List<Attendance> getAttendance(Integer uid);
}
