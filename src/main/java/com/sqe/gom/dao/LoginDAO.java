package com.sqe.gom.dao;

import java.util.Date;
import java.util.List;

import com.sqe.gom.model.Login;
import com.sqe.gom.util.Page;

/**
 * @description login DAO manager interface
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Sep 6, 2011  10:33:16 PM
 * @version 3.0
 */
public interface LoginDAO extends GenericDAO<Login> {
	/**
	 * save login log information of user.
	 *  
	 * @param login  The login log entity
	 */
	void save(Login login);
	
	/**
	 * get user current day log
	 * 
	 * @param uid  The user identify
	 * @param mins  The minutes of lock time.
	 * @return  log of current user
	 */
	Login getLog(int uid, int mins);
	
	/**
	 * 查询当天登录状态
	 * @return 所有Login对象字段
	 */
	Login getLog();
	
	
	/**
	 * 查询用户异常
	 * @param uid
	 * @return
	 */
	List<Integer> logAbnormal(int uid);
	
	/**
	 * get list of current user login log between start date and end date gave by user
	 * 
	 * @param name  Query log parameter
	 * @param startDate  The query log start date
	 * @param endDate  The query log end date
	 * @param endDate  The page helper parameter
	 * @return  Log of current user
	 */
	List<Login> getLogs(int uid, Date startDate, Date endDate, Page page);
}
