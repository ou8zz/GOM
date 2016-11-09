/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.model.Abnormal;
import com.sqe.gom.model.Trace;
import com.sqe.gom.util.Page;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 25, 2012
 * @version 3.0
 */

public interface AbnormalDAO extends GenericDAO<Abnormal>{

	/**
	 * 查询用户状态异常 
	 * @param uid
	 * @param state
	 * @return	返回条数
	 */
	Long getAbnormal(Integer uid, ProcessStatus state);
	
	/**
	 * 按条件查询异常
	 * @param order
	 * @param criteria
	 * @param page
	 * @return
	 */
	List<Abnormal> getAbnormals(String order, String criteria, Page page);
	
	/**
	 * 异常流程列表
	 * @param trace
	 * @param order
	 * @param criteria
	 * @param page
	 * @return
	 */
	List<Abnormal> getAbnormals(Trace trace, String order, String criteria, Page page);
	
	/**
	 * 修改用户异常状态
	 * @param state
	 * @param uid
	 * @return
	 */
	boolean updateAblState(ProcessStatus state, Integer uid);
}
