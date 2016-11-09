/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.constant.GroupType;
import com.sqe.gom.dao.UserDAO;
import com.sqe.gom.model.Address;
import com.sqe.gom.model.Education;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.UserGroup;

/**
 * @description  userDAO implements entity class.
 * @see com.sqe.gom.dao.GenericDAO
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jul 28, 2011  11:22:04 PM
 * @version 3.0
 */
@SuppressWarnings("unchecked")
@Repository("userDao")
public class UserDAOImpl extends GenericHibernateDAO<GomUser> implements UserDAO {
	public UserDAOImpl() {
		super(GomUser.class);
	}
	
	@Override
	public GomUser checkUser(String name, String pwd, boolean isLogin) {
		StringBuilder q = new StringBuilder("from GomUser as u where ");
		if(RegexUtil.verify("^[a-zA-Z_\\-]+([\\w\\-]+)*",name)) q.append("ename=?");
		else if(RegexUtil.verify("^[\\w\\-]+(\\.[\\w\\-]+)*@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$", name)) q.append("email=?");
		
		if(isLogin) q.append(" and u.lock=false and u.active=true");
		if(RegexUtil.notEmpty(pwd)) {
			q.append(" and u.pwd=?");
			return (GomUser)queryForObject(q.toString(), new Object[]{name, pwd});
		}
		
		return (GomUser)queryForObject(q.toString(), new Object[] {name});
	}
	
	@Override
	public List<String> getDptUserMail(Integer groupId, GroupType type) {
		return (List<String>)queryForList("SELECT u.email FROM GomUser as u left join u.groups as g WHERE g.id=? AND g.type=? AND u.email is not null", new Object[]{groupId, type});
	}
	
	@Override
	public UserGroup getLoginUser(String name, String pwd, boolean isLogin) {
		StringBuilder qq = new StringBuilder("from GomUser as u where ");
		if(RegexUtil.verify("^[a-zA-Z_\\-]+([\\w\\-]+)*",name)) qq.append("u.ename=?");
		else if(RegexUtil.verify("^[\\w\\-]+(\\.[\\w\\-]+)*@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$", name)) qq.append("u.email=?");
		
		UserGroup ug = null;
		GomUser gu;
		
		if(isLogin) qq.append(" and u.lock=false and u.active=true");
		if(RegexUtil.notEmpty(pwd)) {
			qq.append(" and u.pwd=?");
			gu = (GomUser)queryForObject(qq.toString(), new Object[]{name, pwd});
			
		}
		else gu = (GomUser)queryForObject(qq.toString(), new Object[]{name});
		
		if(RegexUtil.notEmpty(gu)){
			ug = new UserGroup();
			ug.setId(gu.getId());
			ug.setType(gu.getType());
			ug.setCell(gu.getCell());
			ug.setCname(gu.getCname());
			ug.setEmail(gu.getEmail());
			ug.setEname(gu.getEname());
			ug.setJobNo(gu.getJobNo());
			ug.setPortrait(gu.getPortrait());
			ug.setPwd(gu.getPwd());
			ug.setComment(DateUtil.formatDateTime(new Date()));	//添加登录时间
			
			Iterator<GomGroup> it = gu.getGroups().iterator();
			while(it.hasNext()) {
				GomGroup g = it.next();
				if(g.getType().equals(GroupType.DEPARTMENT)){ug.setDepartment(g.getEname());ug.setCdepartment(g.getCname());ug.setDptId(g.getId());}
				else if(g.getType().equals(GroupType.POSITION)){ug.setPosition(g.getEname());ug.setCposition(g.getCname());ug.setPstId(g.getId());}
				else if(g.getType().equals(GroupType.ROLE)){ug.setRole(g.getEname());ug.setCrole(g.getCname());ug.setRoleId(g.getId());}
			}
		}
		
		return ug;
	}
	
	@Override
	public List<UserGroup> getAgents(String groupName, GroupType type, String userName) {
		return (List<UserGroup>)queryForList("select new com.sqe.gom.vo.UserGroup(u.id,u.jobNo,u.ename,u.cname,u.email,u.cell,g.ename,g.cname) from GomUser as u left join u.groups as g where g.ename=? and g.type=? and u.ename<>?", new Object[]{groupName, type, userName});
	}
	
	@Override
	public UserGroup getUser(String userName) {
		return (UserGroup)queryForObject("select new com.sqe.gom.vo.UserGroup(u.id,u.jobNo,u.ename,u.cname,u.email,u.cell,d.id,d.cname,p.id,p.cname) from GomUser as u left join u.groups as d left join u.groups as p where u.ename=? and d.type=? and p.type=?", new Object[]{userName, GroupType.DEPARTMENT, GroupType.POSITION});
	}
	
	@Override
	public List<Education> getEducation(Integer uid, String ord) {
		String sql = "FROM Education as p WHERE p.user.id=" + uid;
		if(RegexUtil.notEmpty(ord)) sql += ord;
		
		return (List<Education>)queryForList(sql, new Object[]{});
	}
	
	@Override
	public List<Address> getAddress(Integer uid, String ord) {
		String sql = "SELECT new com.sqe.gom.model.Address(p.id,p.contact,p.relation,p.address,p.zipcode,p.cell,p.phone,p.addrType,p.user.id) FROM Address as p WHERE p.user.id=" + uid;
		if(RegexUtil.notEmpty(ord)) sql += ord;
		
		return (List<Address>)queryForList(sql, new Object[]{});
	}

	@Override
	public List<GomUser> getInactiveUser(boolean active, boolean lock, String ord, String criteria, Page page) {
		List<GomUser> ls = Collections.emptyList();
		String q = " FROM GomUser AS u LEFT JOIN u.groups as p LEFT JOIN u.groups AS d WHERE u.active=? and u.lock=? and p.type=? and d.type=?";
		String sql = "SELECT new com.sqe.gom.model.GomUser(u.id,u.jobNo,u.ename,u.cname,u.cell,u.gender,u.idcard,u.idScan,u.portrait,u.nation,u.censusType,u.birthday,u.bank,u.accountNo,u.email,u.emailPwd,u.height,u.privateMail,u.phone,u.telExt,u.marriage,u.generic,d.id,d.cname,p.id,p.cname)";
		if(RegexUtil.notEmpty(criteria)) q += " AND" + criteria;
		if(RegexUtil.notEmpty(ord)) q += ord;
		if(RegexUtil.notEmpty(page)) {
			ls = (List<GomUser>)queryForList("SELECT COUNT(*)" + q, sql + q + " GROUP BY d.cname", new Object[]{active,lock,GroupType.POSITION,GroupType.DEPARTMENT},page);
		}
		return ls;
	}
	
	@Override
	public UserGroup getUserByDepartAndPosit(String position, String department) {
		return (UserGroup)queryForObject("select new com.sqe.gom.vo.UserGroup(u.id,u.jobNo,u.ename,u.cname,u.email,u.cell,g.id,g.ename,g.cname,d.id,d.ename,d.cname) from GomUser as u left join u.groups as g left join u.groups as d where g.ename=? and g.type=? and d.ename=? and d.type=?" , new Object[]{position, GroupType.POSITION, department, GroupType.DEPARTMENT});
	}
	
	@Override
	public List<UserGroup> getUsers(String order, boolean lock, String criteria, Page page) {
		StringBuffer sb = new StringBuffer("FROM GomUser AS u LEFT JOIN u.groups as d LEFT JOIN u.groups AS p WHERE u.lock=? and d.type=? and p.type=?");
		
		if(RegexUtil.notEmpty(criteria)) sb.append(criteria);
		String csql = "SELECT COUNT(*) " + sb.toString();
		if(RegexUtil.notEmpty(order)) sb.append(order);

		return (List<UserGroup>)queryForList(csql,  "SELECT new com.sqe.gom.vo.UserGroup(u.id,u.jobNo,u.ename,u.cname,u.gender,u.type,d.id,d.cname,p.id,p.cname) " + sb.toString(), new Object[]{lock, GroupType.DEPARTMENT, GroupType.POSITION}, page);
	}
	
	@Override
	public List<UserGroup> getUsersConfig(String order, String criteria, Page page) {
		StringBuffer sb = new StringBuffer("FROM GomUser AS u LEFT JOIN u.groups as d LEFT JOIN u.groups AS p LEFT JOIN u.groups AS r WHERE d.type=? AND p.type=? AND r.type=?");
		
		if(RegexUtil.notEmpty(criteria)) sb.append(criteria);
		String csql = "SELECT COUNT(*) " + sb.toString();
		if(RegexUtil.notEmpty(order)) sb.append(order);

		return (List<UserGroup>)queryForList(csql,  "SELECT new com.sqe.gom.vo.UserGroup(u.id,u.jobNo,u.ename,u.cname,u.gender,u.type,d.id,d.cname,p.id,p.cname,r.id,r.cname) " + sb.toString(), new Object[]{GroupType.DEPARTMENT, GroupType.POSITION, GroupType.ROLE}, page);
	}
	
	@Override
	public List<UserGroup> getUsersByDpt(Integer groupId, Integer userId, GroupType groupType, boolean ismgr) {
		if(ismgr) return (List<UserGroup>)queryForList("SELECT new com.sqe.gom.vo.UserGroup(u.id,u.ename,u.cname,u.email) FROM GomUser as u left join u.groups as p left join u.groups as d WHERE u.active=? AND u.id<>? AND d.id=? AND d.type=? AND p.type=? AND p.ename <> ?", new Object[]{true, userId, groupId, GroupType.DEPARTMENT, groupType, "Employee"});
		else {
			String isUser = "";
			if(RegexUtil.notEmpty(userId)) isUser = " AND u.id<>" + userId;  
			return (List<UserGroup>)queryForList("SELECT new com.sqe.gom.vo.UserGroup(u.id,u.ename,u.cname,u.email) FROM GomUser as u left join u.groups as d WHERE u.active=? AND d.id=? AND d.type=?" + isUser, new Object[]{true, groupId, groupType});
		}
	}
	
	@Override
	public int updateUserActive(int uid, boolean active){
		return executeUpdate("update GomUser set active=? where id=?", new Object[]{active, uid});
	}
	
	@Override
	public int updateUserLock(int uid, boolean lock){
		return executeUpdate("update GomUser set lock=? where id=?", new Object[]{lock, uid});
	}
	
	@Override
	public int updateUserExitDate(int uid, Date exitDate){
		return executeUpdate("update GomUser set exitDate=? where id=?", new Object[]{exitDate, uid});
	}
	
	@Override
	public int updateUser(GomUser apply){
		List<Object> obj = new ArrayList<Object>();
		StringBuffer sql= new StringBuffer("UPDATE GomUser SET ");
		
		if(RegexUtil.notEmpty(apply.getPwd())) {
			sql.append("pwd=?");
			obj.add(apply.getPwd());
		}
		else if(RegexUtil.notEmpty(apply.getEntryDate())) {
			sql.append("entryDate=?");
			obj.add(apply.getEntryDate());
			
			if(RegexUtil.notEmpty(apply.getBank())) {
				sql.append(", bank=?");
				obj.add(apply.getBank());
			}
			
			if(RegexUtil.notEmpty(apply.getTelExt())) {
				sql.append(", telExt=?");
				obj.add(apply.getTelExt());
			}
		}else if(RegexUtil.notEmpty(apply.getBank())){
			sql.append("bank=?");
			obj.add(apply.getBank());
			
			if(RegexUtil.notEmpty(apply.getEntryDate())) {
				sql.append(", entryDate=?");
				obj.add(apply.getEntryDate());
			}
			
			if(RegexUtil.notEmpty(apply.getTelExt())) {
				sql.append(", telExt=?");
				obj.add(apply.getTelExt());
			}
		}else if(RegexUtil.notEmpty(apply.getTelExt())) {
			sql.append("telExt=?");
			obj.add(apply.getTelExt());
			
			if(RegexUtil.notEmpty(apply.getEntryDate())) {
				sql.append(", entryDate=?");
				obj.add(apply.getEntryDate());
			}
			
			if(RegexUtil.notEmpty(apply.getBank())) {
				sql.append(", bank=?");
				obj.add(apply.getBank());
			}
		}else return 0;
		
		if(RegexUtil.notEmpty(apply.getType())) {
			sql.append(", type=?");
			obj.add(apply.getType());
		}
		
		if(RegexUtil.notEmpty(apply.getFullDate())) {
			sql.append(", fullDate=?");
			obj.add(apply.getFullDate());
		}
		
		if(RegexUtil.notEmpty(apply.getAccountNo())) {
			sql.append(", accountNo=?");
			obj.add(apply.getAccountNo());
		}
		
		if(RegexUtil.notEmpty(apply.getCell())) {
			sql.append(", cell=?");
			obj.add(apply.getCell());
		}
		
		if(RegexUtil.notEmpty(apply.getPhone())) {
			sql.append(", phone=?");
			obj.add(apply.getPhone());
		}
		
		if(RegexUtil.notEmpty(apply.getPrivateMail())) {
			sql.append(", privateMail=?");
			obj.add(apply.getPrivateMail());
		}

		if(RegexUtil.notEmpty(apply.getCensusType())) {
			sql.append(", censusType=?");
			obj.add(apply.getCensusType());
		}
		
		if(RegexUtil.notEmpty(apply.getIdcard())) {
			sql.append(", idcard=?");
			obj.add(apply.getIdcard());
		}
		
		if(RegexUtil.notEmpty(apply.getIdScan())) {
			sql.append(", idScan=?");
			obj.add(apply.getIdScan());
		}
		
		if(RegexUtil.notEmpty(apply.getPortrait())) {
			sql.append(", portrait=?");
			obj.add(apply.getPortrait());
		}
		
		if(RegexUtil.notEmpty(apply.getEmail())) {
			sql.append(", email=?");
			obj.add(apply.getEmail());
		}
		
		if(RegexUtil.notEmpty(apply.getEmailPwd())) {
			sql.append(", emailPwd=?");
			obj.add(apply.getEmailPwd());
		}
		
		if(RegexUtil.notEmpty(apply.getHeight())) {
			sql.append(", height=?");
			obj.add(apply.getHeight());
		}
		
		if(RegexUtil.notEmpty(apply.getMarriage())) {
			sql.append(", marriage=?");
			obj.add(apply.getMarriage());
		}
		
		if(RegexUtil.notEmpty(apply.isActive())) {
			sql.append(", active=?");
			obj.add(apply.isActive());
		}
		
		if(RegexUtil.notEmpty(apply.isGeneric())) {
			sql.append(", generic=?");
			obj.add(apply.isGeneric());
		}
		
		if(RegexUtil.notEmpty(apply.getId())) {
			if(obj.isEmpty()) return 0;
			else {
				sql.append(" where id=?");
				obj.add(apply.getId());
				return executeUpdate(sql.toString(), obj.toArray());
			}
		}
		
		return 0;
	}
	
	@Override
	public Integer getMaxJobNo() {
		return ((Long)queryForObject("SELECT count(*) from GomUser", null)).intValue();
	}

	@Override
	public UserGroup getUserGroup(String ename, GroupType type) {
		return (UserGroup)queryForObject("select new com.sqe.gom.vo.UserGroup(u.id,u.jobNo,u.ename,u.cname,u.email,g.ename, g.cname) from GomUser as u left join u.groups as g where u.ename=? and g.type=?", new Object[] {ename,type});
	}

	@Override
	public GomGroup getGroup(int uid, GroupType type) {
		return (GomGroup)queryForObject("select g from GomGroup as g left join g.users as u where u.id=? and g.type=?", new Object[] {uid, type});
	}
}