package com.sqe.gom.app.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sqe.gom.app.GomService;
import com.sqe.gom.dao.ConfigDAO;
import com.sqe.gom.model.Config;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

@Service("gomService")
public class GomServiceImpl implements GomService {
	private ConfigDAO configDao;

	@Resource(name="configDao")
	public void setConfigDao(ConfigDAO configDao) {
		this.configDao = configDao;
	}

	@Override
	public String getVersion() {
		return configDao.getConfig("version").getValue();
	}
	
	@Override
	public List<Config> getConfigs() {
		return configDao.getConfigs();
	}
	
	@Override
	public JGridBase<Config> getConfigByGroup(String groupKey, String pre, JGridHelper<Config> grid) {
		String od =" ORDER BY " + pre;
		if(RegexUtil.notEmpty(grid.getJq().getSidx())) od += grid.getJq().getSidx() + " " + grid.getJq().getSord();
		else od += "name DESC";
		
		StringBuffer sql = new StringBuffer();
		if(RegexUtil.notEmpty(groupKey)) sql.append("c.key like '").append(groupKey).append(".%'");
		if(RegexUtil.notEmpty(grid.getQ())) sql.append(grid.getQ());
		
		List<Config> defs = configDao.getConfigs(od, sql.toString(), grid.getP());
		if(!defs.isEmpty()) {
			grid.getJq().setList(defs);
			grid.getJq().setRecords(grid.getP().getTotalCount());
			grid.getJq().setTotal(grid.getP().getPageCount());
		}
		
		return grid.getJq();
	}

	@Override
	public void saveConfig(Config def) {
		if(RegexUtil.isEmpty(configDao.query(def.getKey()))) configDao.create(def);
		else configDao.updateConfig(def);
	}

}
