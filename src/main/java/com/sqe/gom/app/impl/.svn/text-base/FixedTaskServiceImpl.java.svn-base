/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sqe.gom.app.FixedTaskService;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.dao.FixedTaskDAO;
import com.sqe.gom.model.FixedTask;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description	FixedTask 
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Aug 2, 2012
 * @version 3.0
 */
@Service("fixedTaskService")
public class FixedTaskServiceImpl implements FixedTaskService {
	private FixedTaskDAO fixedTaskDao;
	
	@Resource(name="fixedTaskDao")
	public void setFixedTaskDao(FixedTaskDAO fixedTaskDao) {
		this.fixedTaskDao = fixedTaskDao;
	}
		
	@Override
	public JGridBase<FixedTask> getFixedTasks(JGridHelper<FixedTask> grid) {
		String ord = " ORDER BY f.";
		if(RegexUtil.notEmpty(grid.getJq().getSidx())) ord += grid.getJq().getSidx() + " " + grid.getJq().getSord();
		else ord += "id asc";
		
		List<FixedTask> list = fixedTaskDao.getFixedTasks(ord, grid.getQ(), grid.getP());
		
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
