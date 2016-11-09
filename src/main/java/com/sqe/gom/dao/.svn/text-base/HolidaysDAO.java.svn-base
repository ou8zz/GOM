/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.model.Holidays;
import com.sqe.gom.util.Page;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 8, 2012
 * @version 3.0
 */
public interface HolidaysDAO extends GenericDAO<Holidays> {
	
	/**
	 * 查询所有节假日期安排列表
	 * @param page
	 * @return
	 */
	List<Holidays> getHolidays(String ord, String criteria, Page page);
	
	
	/**
	 * 查询所有节假日
	 * @return
	 */
	List<Holidays> getHolidays();
}
