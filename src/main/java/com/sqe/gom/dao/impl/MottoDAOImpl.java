/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import org.springframework.stereotype.Repository;

import com.sqe.gom.dao.MottoDAO;
import com.sqe.gom.model.Motto;

/**
 * @description 
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Repository("mottoDao")
public class MottoDAOImpl extends GenericHibernateDAO<Motto> implements MottoDAO {
	public MottoDAOImpl() {
		super(Motto.class);
	}
	
	@Override
	public Motto getMotto() {
		return (Motto) queryForObject("SELECT m FROM Motto AS m", null);
	}
}
