package com.sqe.gom.app;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import com.sqe.gom.model.Config;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description  所有与GOM的通信接口
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Feb 10, 2012  8:06:17 PM
 * @version 3.0
 */
@Transactional
public interface GomService {
	
	/**
	 * 获得当前系统版本
	 * @return	版本
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	String getVersion();
	
	/**
	 * query all configGroup
	 * 
	 * @return list of configGroup
	 */
	@PreAuthorize("hasRole('Admin')")
	List<Config> getConfigs();
	
	/**
	 * get configDef by ConfigGroup key
	 * 
	 * @param groupKey  The identify key of ConfigGroup
	 * @param pre  The prefix of query entity.
	 * @param grid  The grid entity
	 * @return  The property of entity leave.
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	@Transactional(readOnly=true)
	JGridBase<Config> getConfigByGroup(String groupKey, String pre, JGridHelper<Config> grid);
	
	/**
	 * save or update ConfigDef
	 * 
	 * @param def The entity of ConfigDef
	 */
	@PreAuthorize("hasRole('Admin')")
	void saveConfig(Config def);
}