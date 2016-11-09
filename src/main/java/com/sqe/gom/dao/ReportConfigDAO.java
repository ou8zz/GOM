/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.constant.DateRange;
import com.sqe.gom.model.ReportConfig;

/**
 * @description ReportConfig DAO manager interface
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
public interface ReportConfigDAO extends GenericDAO<ReportConfig> {
	
	/**
	 * 查询用户配置列表
	 * @param uid
	 * @return
	 */
	List<ReportConfig> getReportConfigs(Integer uid);
	
	/**
	 * 查询用户报表配置
	 * @param uid
	 * @return
	 */
	ReportConfig getReportConfig(DateRange type, Integer uid);
	
	/**
	 * 保存或修改配置
	 * @param rc
	 */
	void updateConfig(ReportConfig rc);
}
