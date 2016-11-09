package com.sqe.gom.dao;

import java.util.List;
import com.sqe.gom.model.Config;
import com.sqe.gom.util.Page;

public interface ConfigDAO extends GenericDAO<Config> {
	/**
	 * get defs list
	 * @param ord  The order paramter.
	 * @param criteria The criteria of query
	 * @param page The page of number
	 * @return list of defs
	 */
	List<Config> getConfigs(String ord, String criteria, Page page);
	
	/**
	 *  get all exist in database config
	 *  
	 * @return list of config
	 */
	List<Config> getConfigs();
	
	/**
	 * update ConfigDef by parameter to designated.
	 * @param def The entity information
	 * @return number of updated
	 */
	int updateConfig(Config def);
	
	/**
	 * get config value by key.
	 * 
	 * @param key
	 * @return
	 */
	String getConfigValue(String key);
	
	/**
	 * query config by key identify
	 * 
	 * @param key  The config identify key.
	 * @return  Entity of query result.
	 */
	Config getConfig(String key);
}
