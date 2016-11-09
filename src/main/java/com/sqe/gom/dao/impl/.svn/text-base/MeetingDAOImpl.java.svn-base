/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.dao.MeetingDAO;
import com.sqe.gom.model.Meeting;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

/**
 * @description	会议记录DAO实现
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Oct 20, 2012
 * @version 3.0
 */
@Repository("meetingDao")
@SuppressWarnings("unchecked")
public class MeetingDAOImpl extends GenericHibernateDAO<Meeting> implements MeetingDAO {
	public MeetingDAOImpl() {
		super(Meeting.class);
	}
	
	@Override
	public List<Meeting> getMeetings(String ord, String criteria, Page page) {
		String count = "SELECT COUNT(*) FROM Meeting WHERE 1=1 ";
		String sql = "FROM Meeting AS m WHERE 1=1 ";
		if(RegexUtil.notEmpty(criteria)) {count += criteria;sql += criteria;}
		if(RegexUtil.notEmpty(ord)) sql += ord; 
		if(RegexUtil.isEmpty(page)) return (List<Meeting>) queryForList(sql, null);
		return (List<Meeting>) queryForList(count, sql, null, page);
	}

	@Override
	public void updateMeeting(Meeting m) {
		List<Object> list = new ArrayList<Object>();
		StringBuffer sql= new StringBuffer("UPDATE Meeting AS m SET m.participants=?");
		list.add(m.getParticipants());
		
		if(RegexUtil.notEmpty(m.getIsTrace())) {
			sql.append(", m.isTrace=?");
			list.add(m.getIsTrace());
		}
		if(RegexUtil.notEmpty(m.getTraceDate())){
			sql.append(", m.traceDate=?");
			list.add(m.getTraceDate());
		}
		if(RegexUtil.notEmpty(m.getEndDate())){
			sql.append(", m.endDate=?");
			list.add(m.getEndDate());
		}
		if(RegexUtil.notEmpty(m.getContent())){
			sql.append(", m.content=?");
			list.add(m.getContent());
		}
		if(RegexUtil.notEmpty(m.getExplain())) {
			sql.append(", m.explain=?");
			list.add(m.getExplain());
		}
		if(RegexUtil.notEmpty(m.getId())) {
			sql.append(" where m.id=?");
			list.add(m.getId());
			executeUpdate(sql.toString(), list.toArray());
		}
	}

}
