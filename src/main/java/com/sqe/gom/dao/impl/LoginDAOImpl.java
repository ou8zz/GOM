package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.sqe.gom.dao.LoginDAO;
import com.sqe.gom.model.Login;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

@SuppressWarnings("unchecked")
@Repository("loginDao")
public class LoginDAOImpl extends GenericHibernateDAO<Login> implements LoginDAO {
	public LoginDAOImpl() {super(Login.class);}

	

	@Override
	public Login getLog(int uid, int mins) {
		String sql = "SELECT new com.sqe.gom.model.Login(l.id, l.loginIP, l.loginTime, l.loginTake, l.loginOut, l.reportMark, l.unlockTime) FROM Login AS l WHERE l.user.id=? and ";
		Object[] obj;
		if(mins > 0) {sql += "l.unlockTime<=?"; obj = new Object[]{uid, DateUtil.forwardMin(mins)};}
		else{sql += "l.loginTime like '" + DateUtil.forMatDate() + "%'"; obj = new Object[]{uid};}
		
		return (Login)queryForObject(sql, obj);
	}
	
	@Override
	public Login getLog() {
		return (Login)queryForObject("from Login where loginTime like '" + DateUtil.forMatDate() + "%'", new Object[]{});
	}

	@Override
	public List<Login> getLogs(int uid, Date startDate, Date endDate, Page page) {
		if(startDate.equals(endDate)) {
			GregorianCalendar gc = new GregorianCalendar();
			gc.setTime(startDate);
			gc.add(5, 1);
			endDate = gc.getTime();
		}
		DetachedCriteria dc = DetachedCriteria.forClass(Login.class).add(Property.forName("user.id").eq(uid)).add(Restrictions.between("loginTime", startDate, endDate));
		return (List<Login>)queryForList(dc,page);
	}
	
	@Override
	public List<Integer> logAbnormal(int uid) {
		String sql = "SELECT l.id FROM Login AS l WHERE DATE(l.loginTime)<>CURRENT_DATE AND l.user.id=? AND l.reportMark=? ";
		return (List<Integer>)queryForList(sql, new Object[]{uid, false});
	}
	
	@Override
	public void save(Login l) {
		List<Object> obj = new ArrayList<Object>();
		StringBuffer sql= new StringBuffer("UPDATE Login AS l SET l.reportMark=?");
		obj.add(l.getReportMark());
		
		if(RegexUtil.notEmpty(l.getLoginIP())) {
			sql.append(", l.loginIP=?");
			obj.add(l.getLoginIP());
		}
		if(RegexUtil.notEmpty(l.getLoginTime())) {
			sql.append(", l.loginTime=?");
			obj.add(l.getLoginTime());
		}
		if(RegexUtil.notEmpty(l.getLoginOut())) {
			sql.append(", l.loginOut=?");
			obj.add(l.getLoginOut());
		}
		if(RegexUtil.notEmpty(l.getLoginTake())) {
			sql.append(", l.loginTake=?");
			obj.add(l.getLoginTake());
		}
		if(RegexUtil.notEmpty(l.getUnlockTime())) {
			sql.append(", l.unlockTime=?");
			obj.add(l.getUnlockTime());
		}
		
		if(RegexUtil.notEmpty(l.getId())) {
			sql.append(" WHERE l.id=?");
			obj.add(l.getId());
			executeUpdate(sql.toString(), obj.toArray());
		} 
	}
}
