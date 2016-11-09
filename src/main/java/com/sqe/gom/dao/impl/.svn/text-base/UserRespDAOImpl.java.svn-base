package com.sqe.gom.dao.impl;

import org.springframework.stereotype.Repository;

import com.sqe.gom.dao.UserRespDAO;
import com.sqe.gom.model.UserResp;

@Repository("userRespDao")
public class UserRespDAOImpl extends GenericHibernateDAO<UserResp> implements
		UserRespDAO {

	public UserRespDAOImpl() {
		super(UserResp.class);
	}
	
	public int updateUserResp(UserResp ur) {
		return executeUpdate("update UserResp set expected=? where id=?", new Object[]{ur.getExpected(), ur.getId()});
	}
	
	public int getExpected(Integer userId, String node) {
		return (Integer)queryForObject("SELECT r.expected FROM UserResp AS r LEFT JOIN r.user AS u LEFT JOIN r.respon AS p WHERE p.parent.id IS NULL AND u.id=? AND r.node=?", new Object[]{userId, node});
	}
}
