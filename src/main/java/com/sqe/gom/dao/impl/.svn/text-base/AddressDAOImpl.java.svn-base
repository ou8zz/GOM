/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;
import com.sqe.gom.dao.AddressDAO;
import com.sqe.gom.model.Address;
import com.sqe.gom.util.RegexUtil;

/**
 * @description AddressDAO implements entity class.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Feb 8, 2012  10:34:07 PM
 * @version 3.0
 */
@Repository("addressDao")
public class AddressDAOImpl extends GenericHibernateDAO<Address> implements AddressDAO {

	public AddressDAOImpl() {
		super(Address.class);
	}
	
	@Override
	public void updateAddr(Address addr) {
		List<Object> obj = new ArrayList<Object>();
		StringBuffer sql= new StringBuffer("UPDATE Address AS a SET a.id=?");
		obj.add(addr.getId());
		
		if(RegexUtil.notEmpty(addr.getContact())) {
			sql.append(", a.contact=?");
			obj.add(addr.getContact());
		}
		if(RegexUtil.notEmpty(addr.getRelation())) {
			sql.append(", a.relation=?");
			obj.add(addr.getRelation());
		}
		if(RegexUtil.notEmpty(addr.getAddress())) {
			sql.append(", a.address=?");
			obj.add(addr.getAddress());
		}
		if(RegexUtil.notEmpty(addr.getZipcode())) {
			sql.append(", a.zipcode=?");
			obj.add(addr.getZipcode());
		}
		if(RegexUtil.notEmpty(addr.getCell())) {
			sql.append(", a.cell=?");
			obj.add(addr.getCell());
		}
		if(RegexUtil.notEmpty(addr.getPhone())) {
			sql.append(", a.phone=?");
			obj.add(addr.getPhone());
		}
		if(RegexUtil.notEmpty(addr.getId())) {
			sql.append(" WHERE a.id=?");
			obj.add(addr.getId());
			executeUpdate(sql.toString(), obj.toArray());
		} 
	}
}
