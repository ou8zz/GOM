/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;
import com.sqe.gom.model.Responsibility;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 6, 2012
 * @version 3.0
 */
public interface ResponsibilityDAO extends GenericDAO<Responsibility> {
	
	/**
	 * 根据ID更新
	 * @param Responsibili
	 * @return boolean 
	 */	
	int updateResponsibility(Responsibility r);
	
	/**
	 * 根据条件查询职责
	 * @param criteria
	 * @return
	 */
	List<Responsibility> getResponsibilities(String criteria);
	
	/**
	 * 查询需要复制的Responsibility
	 * 
	 * @param poStr
	 * @param obj
	 * @param receiver
	 * @return
	 */
	List<Responsibility> getResponsibility(String poStr, List<Object> obj);

	/**
	 * 查询用户的责任管理
	 * @param  
	 * @return List  
	 */
	List<Responsibility> getResponsibility(String ename, Integer userId, String ord, String criteria);
	
	/**
	 * 得到node大小
	 * @return
	 */
	Long getNodeCount(Integer userId, String userName) ;
	
	/**
	 * 查询未分配给用户的责任
	 * 
	 * @param    已分配责任占位符
	 * @return List   已分配责任列表
	 */
	List<Responsibility> getNotSelectRespons(String poStr, List<Object> obj);
}
