/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.constant.DateRange;
import com.sqe.gom.constant.ItemType;
import com.sqe.gom.dao.SwotConfigDAO;
import com.sqe.gom.model.SwotConfig;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 19, 2012
 * @version 3.0
 */
@SuppressWarnings("unchecked")
@Repository("swotConfigDao")
public class SwotConfigDAOImpl extends GenericHibernateDAO<SwotConfig> implements SwotConfigDAO {
	public SwotConfigDAOImpl() {
		super(SwotConfig.class);
	}
	
	@Override
	public List<SwotConfig> getSwotConfigs(String ord, String criteria, Page page) {
		String count = "SELECT COUNT(*) FROM SwotConfig AS p WHERE 1=1";
		String sql = "FROM SwotConfig AS p WHERE 1=1";
		if(RegexUtil.notEmpty(criteria)) {
			count += criteria;
			sql += criteria;
		}
		if(RegexUtil.notEmpty(ord)) sql += ord;
		return (List<SwotConfig>) queryForList(count, sql, null, page);
	}
	
	@Override
	public SwotConfig getSwotConfig(ItemType item, DateRange dr) {
		return (SwotConfig) queryForObject("FROM SwotConfig AS c WHERE c.item=? AND c.range=?", new Object[]{item, dr});
	}

}
