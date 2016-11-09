/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.Date;
import java.util.List;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.model.Address;
import com.sqe.gom.model.Education;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.util.Page;
import com.sqe.gom.vo.UserGroup;

/**
 * @description database operator user entity.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jul 27, 2011  7:15:20 PM
 * @version 3.0
 */
public interface UserDAO extends GenericDAO<GomUser> {
	/**
	 * query user by pwd and name that among ename, cell or email.
	 * 
	 * @return result of query user entity.
	 */
	GomUser checkUser(String name, String pwd, boolean isLogin);
	
	/**
	 * get list of department users Email String.
	 * @param groupId   The user entry groupId that will be query
	 * @param type The type of group
	 * @return  been format to string of list email.
	 */
	List<String> getDptUserMail(Integer groupId, GroupType type);
	
	/**
	 * query user by pwd and name that among ename, cell or email.
	 * 
	 * @param name  The name of login user.
	 * @param pwd  The password for login user.
	 * @param isLogin  True of False
	 * @param type  group property of type.
	 * @return result of query user entity.
	 */
	UserGroup getLoginUser(String name, String pwd, boolean isLogin);
	
	/**
	 * query user jobNo,department, position and ename/cname ect.
	 * 
	 * @param userName
	 * @return
	 */
	UserGroup getUser(String userName);
	
	/**
	 * 根据groupName和groupType查询代理人，不包括userName参数
	 * @param groupName	组名字
	 * @param type		组类型
	 * @param userName	用户名
	 * @return
	 */
	List<UserGroup> getAgents(String groupName, GroupType type, String userName);
	
	/**
	 * get address list of user
	 * @param uid
	 * @param ord
	 * @return
	 */
	List<Address> getAddress(Integer uid, String ord);
	
	/**
	 * get education list of user
	 * @param uid  The user identify
	 * @param ord The order of education
	 * @return  list of education.
	 */
	List<Education> getEducation(Integer uid, String ord);
	
	/**
	 * get list of new users that are entries in the comment.
	 * 
	 * @param active  true of false
	 * @param lock    true of false
	 * @param ord    ASC or DESC
	 * @param criteria   The other criteria for user
	 * @param page  The information for page
	 * @return  list of users
	 */
	List<GomUser> getInactiveUser(boolean active, boolean lock, String ord, String criteria, Page page);
	
	/**
	 * 查询所有激活、未锁定账户的基本信息（包括部门、职务等）
	 * 
	 * @param order  
	 * @param criteria
	 * @param page
	 * @return
	 */
	List<UserGroup> getUsers(String order, boolean lock, String criteria, Page page);
	
	/**
	 * 查询所有激活、未锁定账户的基本信息（部门,职务,角色）
	 * 
	 * @param order  
	 * @param criteria
	 * @param page
	 * @return
	 */
	List<UserGroup> getUsersConfig(String order, String criteria, Page page);
	
	/**
	 * Query specific group of user by UID and type.
	 * 
	 * @param uid  user identify.
	 * @param type sub-class entity.
	 * @return specific sub-class entity.
	 */
	GomGroup getGroup(int uid, GroupType type);
	
	/**
	 * Get user belong to group name by ename and group type.
	 * 
	 * @param ename  user English name.
	 * @param type   group property
	 * @return  user basic information and group name.
	 */
	UserGroup getUserGroup(String ename, GroupType type);
	
	/**
	 * get result of userGroup
	 * 
	 * @param position  The user position in company
	 * @param department  The user work in which department on company
	 * @return get userGroup entity property
	 */
	UserGroup getUserByDepartAndPosit(String position,String department);
	
	/**
	 * 查询用户，以部门或职位或是否为管理层（必须为action=true的用户）
	 * @param groupId
	 * @param userId
	 * @param groupType
	 * @param ismgr
	 * @return
	 */
	List<UserGroup> getUsersByDpt(Integer groupId, Integer userId, GroupType groupType, boolean ismgr);
	
	/**
	 * update user lock property by ename
	 * @param uid  The user identify that is unique
	 * @param lock  true or false
	 * @return  The number of been updated
	 */
	int updateUserLock(int uid, boolean lock);
	
	/**
	 * 是否激活用户
	 * @param uid		用户ID
	 * @param active	激活boolean true : false
	 * @return	返回成功：失败  0：1
	 */
	int updateUserActive(int uid, boolean active);
	
	/**
	 * 设置用户离职日期
	 * @param uid		用户ID
	 * @param exitDate	离职日期
	 * @return	返回成功：失败  0：1
	 */
	int updateUserExitDate(int uid, Date exitDate);
	
	/**
	 * approval and update user information
	 * 
	 * @param reg  GomUser visual object entity.
	 * @return  been update number
	 */
	int updateUser(GomUser apply);
	
	/**
	 * 得到最大工作号
	 * @return	返回最大工作号JobNo
	 */
	Integer getMaxJobNo();
}