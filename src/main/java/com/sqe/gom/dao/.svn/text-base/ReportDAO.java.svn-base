/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.Date;
import java.util.List;

import com.sqe.gom.constant.DateRange;
import com.sqe.gom.model.Report;

/**
 * @description ReportConfig DAO manager interface
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
public interface ReportDAO extends GenericDAO<Report> {
	
	/**
	 * 查询用户的所有列表
	 * @param type 	周期类型
	 * @param uid	用户ID
	 * @return
	 */
	List<Report> getReports(DateRange type, Integer uid);
	
	/**
	 * 查询用户的数据以type类型为列是否存在
	 * @param type	周报或月报
	 * @param uid	用户ID
	 * @return
	 */
	int getReport(DateRange type, Integer uid, Date date);
	
}
