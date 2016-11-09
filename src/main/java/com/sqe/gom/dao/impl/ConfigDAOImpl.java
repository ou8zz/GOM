package com.sqe.gom.dao.impl;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Repository;
import com.sqe.gom.dao.ConfigDAO;
import com.sqe.gom.model.Config;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

@Repository("configDao")
public class ConfigDAOImpl extends GenericHibernateDAO<Config> implements ConfigDAO {
	private Map<String ,String> map = new HashMap<String,String>();
	
	public ConfigDAOImpl(){
		super(Config.class);
	}
	
	@PostConstruct
	public void initConfigMap() {
		@SuppressWarnings("unchecked")
		List<Config> list = (List<Config>)queryForList("SELECT c FROM Config AS c", new Object[]{});
		if(!list.isEmpty()) {
			map.clear();
			for(Config c : list) {
				map.put(c.getKey(), c.getValue());
			}
		}
	}
	
	public String getConfigValue(String key) {
		if(!map.isEmpty()) return map.get(key);
		else return null;
	}

	@SuppressWarnings("unchecked")
	public List<Config> getConfigs(String ord, String criteria, Page page) {
		List<Config> list = Collections.emptyList();
		String sql = "FROM Config as c ";
		if(RegexUtil.notEmpty(criteria)) sql += " WHERE " + criteria;
		String csql = "SELECT COUNT(*) " + sql;
		if(RegexUtil.notEmpty(ord)) sql += ord;
		
		if(RegexUtil.notEmpty(page)) {
			list = (List<Config>)queryForList(csql, "SELECT c " + sql, new Object[]{}, page);
		}
		
		return list;
	}

	@SuppressWarnings("unchecked")
	public List<Config> getConfigs() {
		List<Config> list = Collections.emptyList();
		String sql = "SELECT c FROM Config AS c WHERE c.value IS NULL";
		
		list = (List<Config>)queryForList(sql, new Object[]{});
		return list;
	}

	@Override
	public int updateConfig(Config def) {
		return executeUpdate("update Config set name=?, value=? WHERE key=?", new Object[]{def.getName(), def.getValue(), def.getKey()});
	}

	@Override
	public Config getConfig(String key) {
		return query(key);
	}
}
