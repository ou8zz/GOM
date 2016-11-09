/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.dao.TrainingDAO;
import com.sqe.gom.model.Training;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 10, 2012
 * @version 3.0
 */
@SuppressWarnings("unchecked")
@Repository("trainingDao")
public class TrainingDAOImpl extends GenericHibernateDAO<Training> implements TrainingDAO {
	public TrainingDAOImpl() { super(Training.class); }

	@Override
	public List<Training> getTrainingAndExperience(String ord, String criteria, Page page) {
		String count = "SELECT COUNT(*) FROM Training AS t WHERE 1=1";
		String sql = "FROM Training AS t WHERE 1=1";
		if(RegexUtil.notEmpty(criteria)) { count += criteria; sql += criteria; }
		if(RegexUtil.notEmpty(ord)) sql += ord; 
		if(RegexUtil.isEmpty(page)) return (List<Training>) queryForList(sql, null);
		return (List<Training>) queryForList(count, sql, null, page);
	}
	
	@Override
	public List<Training> getTrainings(String ord, String criteria, Page page) {
		String count = "SELECT COUNT(*) FROM Training AS t WHERE 1=1";
		String sql = "SELECT new com.sqe.gom.model.Training(t.id, t.tprogram, t.lecturer, t.trainingType, t.trainingTime, t.fee, t.otherFee, t.startDate, t.endDate, t.qualification, t.tcontent) FROM Training AS t WHERE 1=1";
		if(RegexUtil.notEmpty(criteria)) { count += criteria; sql += criteria; }
		if(RegexUtil.notEmpty(ord)) sql += ord; 
		if(RegexUtil.isEmpty(page)) return (List<Training>) queryForList(sql, null);
		return (List<Training>) queryForList(count, sql, null, page);
	}

}
