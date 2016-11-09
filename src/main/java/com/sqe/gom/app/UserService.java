/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;

import com.sqe.gom.constant.GroupType;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.model.Address;
import com.sqe.gom.model.Education;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Login;
import com.sqe.gom.util.Page;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description User, Group manage service
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 7, 2011  11:42:46 PM
 * @version 3.0
 */
@Transactional
public interface UserService {
	/**
	 * query user by user identify
	 * 
	 * @param userId  The identify of user
	 * @return The entity of user.
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	GomUser getUser(Integer userId);
	
	/**
	 * 
	 * @param userName
	 * @return
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	UserGroup getUser(String userName);
	
	/**
	 * receive new user information and handler it in business implement class.
	 * 
	 * @param reg  Information about new user entry report.
	 * @return Map of update register entity
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	GomUser saveUser(GomUser reg);
	
	/**
	 * Get address list of user
	 * 
	 * @param uid  The user identify
	 * @param ord  The order of address
	 * @return list of address
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	@Transactional(readOnly=true)
	List<Address> getAddress(Integer uid, String ord);
	
	/**
	 * Get education list of user
	 * 
	 * @param uid  The user identify
	 * @param ord The order of education
	 * @return  list of education.
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	@Transactional(readOnly=true)
	List<Education> getEducation(Integer uid, String ord);
	
	/**
	 * 根据用户Id对用户的教育信息进行修改和添加操作
	 * @param uid	用户ID
	 * @param edus	用户教育信息集合
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	void saveEducation(int uid, List<Education> edus);
	
	/**
	 * 根据Education对象对教育信息进行修改操作
	 * @param edu	修改Education对象（如果字段为空不修改）
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	void updateEducation(Education edu);
	
	/**
	 * 对用户联系地址信息信息进行修改操作
	 * @param a	修改Address对象（如果字段为空不修改）
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	void saveAddress(Address a);
	
	/**
	 * 根据用户Id对用户的联系信息进行修改和添加操作
	 * @param addrs		修改项目集合
	 * @param userId	用户ID
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	void saveAddress(List<Address> addrs, Integer userId);
	
	/**
	 * 修改用户：部门，职务，角色
	 * @param u
	 */
	@PreAuthorize("hasRole('Admin')")
	void updateUserAuthority(UserGroup u);
	
	/**
	 * 返回更新条数
	 * 
	 * @param user  The information of user
	 * @return  The number of update entity
	 */
	@PreAuthorize("hasRole('User')")
	int updatePartUserInfor(GomUser user);
	
	/**
	 * 删除用户
	 * @param id
	 */
	@PreAuthorize("hasRole('Admin')")
	void delUser(int id);
	
	/**
	 * 检查用户ename是否存在
	 * @param name
	 * @return
	 */
	@Transactional(readOnly=true)
	boolean checkUser(String name);
	
	/**
	 * 登录信息验证接口,通过GomUser表的lock字段来判断此帐户是否锁住
	 * （在连续5次错误后，lock值会变为true；在连续错3次后，客户端AJAX不会再往服务器断传送数据，
	 * 同时服务端即使接到此IP登录的用户，也不会作出处理操作）
	 * 
	 * @param name  用户名可能是ename, email, cell中的一个
	 * @param pwd   用户密码客户端MD5加密后的字符串值
	 * @return    验证成功则返回用户实体信息以便Session保存
	 */
	UserGroup login(String name, String pwd);
	
	/**
	 * 用户登出系统
	 * @param ug
	 * @param report
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	void loginOut(UserGroup ug, String report);
	
	/**
	 * 代理人查找
	 * @param groupName
	 * @param type
	 * @param userName
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	List<UserGroup> getAgents(String groupName, GroupType type, String userName);
	
	/**
	 * get list of new users that are entries in the comment.
	 * 
	 * @param pre  The entity of previous
	 * @param grid The JqGrid format data list.
	 * @return  list of users
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	JGridBase<GomUser> getInactiveUser(String pre, boolean active, JGridHelper<GomUser> grid);
	
	/**
	 * 根据部门职务查找用户
	 * @param position
	 * @param department
	 * @return
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	UserGroup getUserAndPosition(String position, String department);
	
	/**
	 * 
	 * @param dptId
	 * @param userId
	 * @param groupType
	 * @param isMgr
	 * @return
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	List<UserGroup> getUsersByDpt(Integer dptId, Integer userId, GroupType groupType, boolean isMgr);
	
	/**
	 * 按部门分组为用户分配，查询用户基本信息（包括部门、职务等）
	 * @param isRole
	 * @param dptId
	 * @param pstId
	 * @param grid
	 * @return
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	JGridBase<UserGroup> getUsers(boolean isRole, String dptId, String pstId, JGridHelper<UserGroup> grid);
	
	/**
	 * 锁定用户
	 * @param l  The entity of login log
	 */
	void lockUser();


	/**
	 * 用户异常检查
	 * @param userId
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	Boolean checkLoginAbnormal(Integer userId);
	
	/**
	 * 新建或更新登录
	 * @param l 
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	HandlerState saveLogin(Login l);
	
	/**
	 * 检查帐户是否存在，若存在是否处于锁状态，并将之解锁
	 * 
	 * @param name  用户登录名
	 * @return  处理结果状态包括计数和字符说明
	 */
	String[] chkLogLock(String name, String pwd);
	
	/**
	 * load group by Id
	 * 
	 * @param id  the id of entity group
	 * @return GomGroup entity
	 */
	@Transactional(readOnly=true)
	GomGroup loadGroup(Integer id);
	
	/**
	 * get group by ename or cname && type.
	 * @param g  GomGroup entity contains cname, type or ename, type
	 * @return result of GomGroup Entity.
	 */
	@Transactional(readOnly=true)
	GomGroup getGroup(GomGroup g);
	
	/**
	 * get list of groups by criteria.
	 * 
	 * @param order   the query order
	 * @param criteria  the query criteria
	 * @param page      page helper entity
	 * @param type    GroupType enum
	 * @return  list of groups by criterias
	 */
	@Transactional(readOnly=true)
	List<GomGroup> getGroups(String order, String criteria, Page page, GroupType type);
	
	/**
	 * get list of groups by type.
	 * 
	 * @param type    GroupType enum
	 * @param page      page helper entity
	 * @return  list of groups by GroupType
	 */
	@Transactional(readOnly=true)
	List<GomGroup> getGroups(GroupType type, Page page);
	
	/**
	 * check this group is exist
	 * @param g  will be check group entity
	 * @return  true or false(if entity exist will return true, or false)
	 */
	@Transactional(readOnly=true)
	boolean checkGroupIsNull(GomGroup g);
	
	/**
	 * remove group entity from database.
	 * 
	 * @param g  entity instance of group
	 */
	@PreAuthorize("hasRole('Admin')")
	void removeGroup(Integer id);
	
	/**
	 * 删除教育经历 
	 * @param id	根据教育经历 ID数组可以多个删除
	 */
	@PreAuthorize("hasRole('Admin')")
	void removeEdu(String[] id);
	
	/**
	 * 删除地址信息 
	 * @param id	根据地址信息 ID数组可以多个删除
	 */
	@PreAuthorize("hasRole('Admin')")
	void removeAddr(String[] id);
	/**
	 * insert a new GomGroup or update by choice GomGroup entity.
	 * 
	 * @param g will be save GomGroup entity.
	 */
	@PreAuthorize("hasRole('Admin')")
	boolean saveGroup(GomGroup g);
	
	/**
	 * 发送验证码（包括登录验证，修改密码验证）
	 * @param email	用户邮箱
	 * @param text	发送邮件内容
	 * @param session 前台session
	 */
	void sendValidateCode(String email, String text, HttpSession session);
}