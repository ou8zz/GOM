/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import org.springframework.stereotype.Repository;

import com.sqe.gom.dao.SignatureDAO;
import com.sqe.gom.model.Signature;

/**
 * @description 
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Repository("signatureDao")
public class SignatureDAOImpl extends GenericHibernateDAO<Signature> implements SignatureDAO {
	public SignatureDAOImpl() {
		super(Signature.class);
	}
	
	@Override
	public Signature getSignature(Integer uid) {
		return (Signature) queryForObject("FROM Signature AS s WHERE s.user.id=?", new Object[]{uid});
	}
}
