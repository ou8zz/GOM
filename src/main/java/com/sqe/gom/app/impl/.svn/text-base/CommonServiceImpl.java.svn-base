/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sqe.gom.app.CommonService;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.dao.FixedTaskDAO;
import com.sqe.gom.model.FixedTask;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description GOM 通用方法或功能公共接口
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Feb 12, 2012  3:12:04 PM
 * @version 3.0
 */
@Service("commonService")
public class CommonServiceImpl implements CommonService {
	private FixedTaskDAO fixedTaskDao;
	
	@Resource(name="fixedTaskDao")
	public void setFixedTaskDao(FixedTaskDAO fixedTaskDao) {
		this.fixedTaskDao = fixedTaskDao;
	}
	
	@Override
	public JGridBase<FixedTask> getFixedTasks(JGridHelper<FixedTask> grid, String state) {
		StringBuffer ord = new StringBuffer(" ORDER BY f.");
		if(RegexUtil.notEmpty(grid.getJq().getSidx())) ord.append(grid.getJq().getSidx()).append(" ").append(grid.getJq().getSord());
		else ord.append("taskTitle");
		
		StringBuffer sql;
		if(RegexUtil.isEmpty(grid.getQ())) sql = new StringBuffer();
		else sql = new StringBuffer(grid.getQ());
		if(RegexUtil.notEmpty(state)) sql.append(" AND state=").append(ProcessStatus.valueOf(state).ordinal());
		
		List<FixedTask> list = fixedTaskDao.getFixedTasks(ord.toString(), sql.toString(), grid.getP());
		
		grid.getJq().setList(list);
		grid.getJq().setRecords(grid.getP().getTotalCount());
		grid.getJq().setTotal(grid.getP().getPageCount());
		
		return grid.getJq();
	}
		
	@Override
	public List<FixedTask> getFixedTasks(ProcessStatus state) {
		String ord = " ORDER BY f.id ASC";
		String cr = "";
		if(RegexUtil.notEmpty(state)) cr = " AND f.state="+state.ordinal(); 
		return fixedTaskDao.getFixedTasks(ord, cr, null);
	}
	
	@Override
	public void saveFixedTask(FixedTask ft) {
		if(RegexUtil.isEmpty(ft.getId())) {
			ft.setCreateDate(new Date());
			ft.setState(ProcessStatus.InProgress);
			fixedTaskDao.create(ft);
		}
		else fixedTaskDao.updateFixedTask(ft);
	}

	@Override
	public void stopFixedTask(int id) {
		FixedTask ft = new FixedTask();
		ft.setState(ProcessStatus.Suspended);
		ft.setId(id);
		fixedTaskDao.updateFixedTask(ft);
	}
}
