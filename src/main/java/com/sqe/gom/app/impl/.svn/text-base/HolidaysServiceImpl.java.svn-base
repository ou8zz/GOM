/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sqe.gom.app.HolidaysService;
import com.sqe.gom.dao.HolidaysDAO;
import com.sqe.gom.dao.LieuDAO;
import com.sqe.gom.exception.GomException;
import com.sqe.gom.model.Holidays;
import com.sqe.gom.model.Lieu;
import com.sqe.gom.util.BinarySearch;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 8, 2012
 * @version 3.0
 */
@Service("holidaysService")
public class HolidaysServiceImpl implements HolidaysService {
	private HolidaysDAO holidaysDao;
	private LieuDAO lieuDao;
	
	@Resource(name = "holidaysDao")
	public void setHolidaysDao(HolidaysDAO holidaysDao) {
		this.holidaysDao = holidaysDao;
	}

	@Resource(name = "lieuDao")
	public void setLieuDao(LieuDAO lieuDao) {
		this.lieuDao = lieuDao;
	}

	@Override
	public JGridBase<Holidays> getHolidays(JGridHelper<Holidays> grid) {
		String ord = " ORDER BY h.";
		if(RegexUtil.notEmpty(grid.getJq().getSidx())) ord += grid.getJq().getSidx() + " " + grid.getJq().getSord();
		else ord += "id";
		List<Holidays> list = holidaysDao.getHolidays("", " AND DATE_FORMAT(h.startDate, '%Y')<>DATE_FORMAT(CURRENT_DATE, '%Y')", null);
		if(!list.isEmpty()) {
			Calendar cal = Calendar.getInstance();
			for(Holidays h : list) {
				cal.setTime(h.getStartDate());
				cal.set(Calendar.YEAR, DateUtil.getField(Calendar.YEAR, null));
				h.setStartDate(cal.getTime());
				
				cal.setTime(h.getEndDate());
				cal.set(Calendar.YEAR, DateUtil.getField(Calendar.YEAR, null));
				h.setEndDate(cal.getTime());
				holidaysDao.update(h);
			}
		}
		grid.getJq().setList(holidaysDao.getHolidays(ord, grid.getQ(), grid.getP()));
		grid.getJq().setRecords(grid.getP().getTotalCount());
		grid.getJq().setTotal(grid.getP().getPageCount());
		return grid.getJq();
	}
	
	@Override
	public List<Holidays> getHolidays(String criteria) {
		return holidaysDao.getHolidays(null, criteria, null);
	}
	
	@Override
	public Boolean isHolidays(String date) throws GomException {
		List<Holidays> list = holidaysDao.getHolidays(" ORDER BY h.startDate", "", null);
		List<String> dated = new ArrayList<String>();
		for(Holidays h : list) {
			if(h.getStartDate().before(h.getEndDate())) {
				Calendar c = Calendar.getInstance();
				c.setTime(h.getStartDate());
				dated.add(DateUtil.formatDate(c.getTime()));
				while(c.getTime().before(h.getEndDate())) {
					c.add(Calendar.DATE, 1);
					dated.add(DateUtil.formatDate(c.getTime()));
				}
			}
		}
		int tag = BinarySearch.binarySearch(dated.toArray(new String[0]), 0, dated.size(), date);
		if(tag>=0) return true;
		return false;
	}

	@Override
	public void saveHolidays(Holidays holidays) {
		if(RegexUtil.isEmpty(holidays.getId())) {
			holidaysDao.create(holidays);
		} else {
			holidaysDao.update(holidays);
		}
	}

	
	@Override
	public JGridBase<Lieu> getLieu(JGridHelper<Lieu> grid, Integer uid) {
		String ord = " ORDER BY l.";
		if(RegexUtil.notEmpty(grid.getJq().getSidx())) ord += grid.getJq().getSidx() + " " + grid.getJq().getSord();
		else ord += "id";
		grid.setQ(grid.getJq().generateSearchCriterion(" WHERE ", "user.id", uid.toString(), "eq", "l."));
		grid.getJq().setList(lieuDao.getLieus(ord, grid.getQ(), grid.getP()));
		grid.getJq().setRecords(grid.getP().getTotalCount());
		grid.getJq().setTotal(grid.getP().getPageCount());
		return grid.getJq();
	}


	@Override
	public void saveLieu(Lieu lieu) {
		if(RegexUtil.notEmpty(lieu.getHolidaysId())) 
			lieu.setHolidays(holidaysDao.query(lieu.getHolidaysId()));
		if(RegexUtil.isEmpty(lieu.getId())) {
			lieuDao.create(lieu);
		} else {
			lieuDao.updateLieu(lieu);
		}
	}
	
}
