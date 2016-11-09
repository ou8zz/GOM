/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.constant.DateRange;
import com.sqe.gom.constant.ItemType;
import com.sqe.gom.model.SwotConfig;
import com.sqe.gom.util.Page;

/**
 * @description SwotConfig DAO接口
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 19, 2012
 * @version 3.0
 */
public interface SwotConfigDAO extends GenericDAO<SwotConfig>{

	/**
	 * 根据项目类型查询相应的config配置
	 * @param item
	 * @param dr
	 * @return
	 */
	SwotConfig getSwotConfig(ItemType item, DateRange dr);
	
	/**
	 * 查询所有的SWOTConfig
	 * @param ord
	 * @param criteria
	 * @param page
	 * @return List<SwotConfig>
	 */
	List<SwotConfig> getSwotConfigs(String ord, String criteria, Page page);
	
}

