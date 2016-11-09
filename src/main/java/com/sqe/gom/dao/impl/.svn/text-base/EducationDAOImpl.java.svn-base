/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.dao.EducationDAO;
import com.sqe.gom.model.Education;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Feb 13, 2012  9:09:58 PM
 * @version 3.0
 */
@Repository("educationDao")
public class EducationDAOImpl extends GenericHibernateDAO<Education> implements
		EducationDAO {

	public EducationDAOImpl() {
		super(Education.class);
	}
	
	@Override
	public void updateEdu(Education edu) {
		List<Object> obj = new ArrayList<Object>();
		StringBuffer sql= new StringBuffer("UPDATE Education AS e SET e.id=?");
		obj.add(edu.getId());
		
		if(RegexUtil.notEmpty(edu.getStartDate())) {
			sql.append(", e.startDate=?");
			obj.add(edu.getStartDate());
		}
		if(RegexUtil.notEmpty(edu.getEndDate())) {
			sql.append(", e.endDate=?");
			obj.add(edu.getEndDate());
		}
		if(RegexUtil.notEmpty(edu.getEd())) {
			sql.append(", e.ed=?");
			obj.add(edu.getEd());
		}
		if(RegexUtil.notEmpty(edu.getSchool())) {
			sql.append(", e.school=?");
			obj.add(edu.getSchool());
		}
		if(RegexUtil.notEmpty(edu.getMajor())) {
			sql.append(", e.major=?");
			obj.add(edu.getMajor());
		}
		if(RegexUtil.notEmpty(edu.getIdno())) {
			sql.append(", e.idno=?");
			obj.add(edu.getIdno());
		}
		if(RegexUtil.notEmpty(edu.getIdScan())) {
			sql.append(", e.idScan=?");
			obj.add(edu.getIdScan());
		}
		if(RegexUtil.notEmpty(edu.getId())) {
			sql.append(" WHERE e.id=?");
			obj.add(edu.getId());
			executeUpdate(sql.toString(), obj.toArray());
		} 
	}
}
