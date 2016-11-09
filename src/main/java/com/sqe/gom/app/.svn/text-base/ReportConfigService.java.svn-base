/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;

import com.sqe.gom.model.ReportConfig;

/**
 * @description 
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Transactional
public interface ReportConfigService {
	
	/**
	 * 查询用户的报表配置
	 * @param ug
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	ReportConfig getReportConfig(String type, Integer uid);

	/**
	 * 编辑报表配置
	 * @param rc
	 */
	@PreAuthorize("hasRole('User')")
	void saveReportConfig(ReportConfig rc);
}
