/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.constant.MenuType;
import com.sqe.gom.model.Ztree;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 20, 2012
 * @version 3.0
 */
public interface ZtreeDAO extends GenericDAO<Ztree> {
	
	/**
	 * get Ztree
	 * @param ord
	 * @param criteria
	 * @return
	 */
	List<Ztree> getZtrees(String ord, String criteria);
	
	/**
	 * 用户配置tree表
	 * @param ord
	 * @param criteria
	 * @return
	 */
	List<Ztree> getUserZtrees(String ord, String criteria);
	
	/**
	 * 获得菜单实体，非构造方法
	 * @param type
	 * @return
	 */
	List<Ztree> getBeanZtrees(String criteria);
	
	/**
	 * 根据ID拿到他的子类中 最大的NODE
	 * 或拿到最高父类中 最大的NODE
	 * @param id
	 * @return
	 */
	String getMaxNode(Integer id);
	
	/**
	 * 修改Ztree 
	 * @param z
	 */
	void updateZtree(Ztree z);
	
	/**
	 *	修改role
	 * @param type
	 * @param zid
	 */
	void updateZtree(Integer zid, MenuType type);
}
