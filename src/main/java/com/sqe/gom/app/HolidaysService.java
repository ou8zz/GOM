/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;

import com.sqe.gom.exception.GomException;
import com.sqe.gom.model.Holidays;
import com.sqe.gom.model.Lieu;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 8, 2012
 * @version 3.0
 */
@Transactional
public interface HolidaysService {
	
	/**
	 * 获得节假日列表
	 * @param page
	 * @return
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	JGridBase<Holidays> getHolidays(JGridHelper<Holidays> grid);
	
	/**
	 * 按条件查询节假日
	 * @param criteria
	 * @return
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	List<Holidays> getHolidays(String criteria);
	
	/**
	 * 如果date 是节假日
	 * @param date
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	Boolean isHolidays(String date) throws GomException;
	
	/**
	 * 保存或修改节假日
	 * @param holidays
	 */
	@PreAuthorize("hasRole('Admin')")
	void saveHolidays(Holidays holidays);
	
	/**
	 * 获得调休列表
	 * @param grid
	 * @return
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	JGridBase<Lieu> getLieu(JGridHelper<Lieu> grid, Integer uid);
	
	/**
	 * 保存或修改调休
	 * @param lieu
	 */
	@PreAuthorize("hasRole('User')")
	void saveLieu(Lieu lieu);
}
