/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.util.Page;

/**
 * @description group DAO manager interface
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Sep 6, 2011  10:33:16 PM
 * @version 3.0
 */
public interface GroupDAO extends GenericDAO<GomGroup>{
	/**
	 * get all groups per page.
	 * 
	 * @param page  type of group
	 * @param page  parameter of page
	 * @return   list of GomGroups
	 */
	List<GomGroup> getGroups(GroupType type, Page page);
	
	/**
	 * 前台分页显示部门，职务，角色分组列表
	 * @param order			排序方式
	 * @param criteria		特殊条件
	 * @param page			分页对象
	 * @param type			根据组类型：ROLE("角色"), DEPARTMENT("部门"), POSITION("职务");
	 * @return	组list集合
	 */
	List<GomGroup> getGroups(String order, String criteria, Page page, GroupType type);
	
	/**
	 * Query group by ename and type.
	 * 
	 * @param ename  The name of group
	 * @return  It has group in database that will return true, or false.
	 */
	GomGroup getGroup(GomGroup g);
	
	/**
	 * 查询用户的部门，职位，角色（如果有）
	 * @param uid
	 * @return
	 */
	List<GomGroup> getGroups(int uid);
}
