/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.dao.BorrowDAO;
import com.sqe.gom.model.Borrow;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@SuppressWarnings("unchecked")
@Repository("borrowDao")
public class BorrowDAOImpl extends GenericHibernateDAO<Borrow> implements BorrowDAO {
	public BorrowDAOImpl() {super(Borrow.class);}

	@Override
	public List<Borrow> getBorrows(String ord, String criteria, Page page) {
		String count = "SELECT COUNT(*) FROM Borrow AS b WHERE 1=1";
		String sql = "SELECT new com.sqe.gom.model.Borrow(b.id,a.id,a.assetName,b.funCode,b.applyState,b.receiveNum,b.receiver,b.receiveDate,b.returnDate,b.overStaff,b.remark) FROM Borrow AS b LEFT JOIN b.asset AS a WHERE 1=1 ";
		if(RegexUtil.notEmpty(criteria)) {
			count += criteria;
			sql += criteria;
		}
		if(RegexUtil.notEmpty(ord)) sql += ord; 
		if(null == page) return (List<Borrow>)queryForList(sql, null);
		return (List<Borrow>) queryForList(count, sql, null, page);
	}
	
	@Override
	public boolean updateBorrow(Borrow b) {
		List<Object> obj = new ArrayList<Object>();
		StringBuffer sql= new StringBuffer("UPDATE Borrow AS b SET b.applyState=?");
		obj.add(b.getApplyState());
		
		if(RegexUtil.notEmpty(b.getOverStaff())) {
			sql.append(", b.overStaff=?");
			obj.add(b.getOverStaff());
		}
		if(RegexUtil.notEmpty(b.getFunCode())) {
			sql.append(", b.funCode=?");
			obj.add(b.getFunCode());
		}
		if(RegexUtil.notEmpty(b.getReceiveNum())) {
			sql.append(", b.receiveNum=?");
			obj.add(b.getReceiveNum());
		}
		if(RegexUtil.notEmpty(b.getReceiver())) {
			sql.append(", b.receiver=?");
			obj.add(b.getReceiver());
		}
		if(RegexUtil.notEmpty(b.getReceiveDate())) {
			sql.append(", b.receiveDate=?");
			obj.add(b.getReceiveDate());
		}
		if(RegexUtil.notEmpty(b.getReturnDate())) {
			sql.append(", b.returnDate=?");
			obj.add(b.getReturnDate());
		}
		if(RegexUtil.notEmpty(b.getRemark())) {
			sql.append(", b.remark=?");
			obj.add(b.getRemark());
		}
		
		if(RegexUtil.notEmpty(b.getId())) {
			if(obj.isEmpty()) return false;
			else {
				sql.append(" WHERE b.id=?");
				obj.add(b.getId());
				int i = executeUpdate(sql.toString(), obj.toArray());
				if(i > 0) return true;
				else return false;
			}
		} else return false;
	}

}
