/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.constant.DateRange;
import com.sqe.gom.constant.ItemType;
import com.sqe.gom.dao.SummaryDAO;
import com.sqe.gom.model.Statistics;
import com.sqe.gom.model.Summary;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.Attendance;

/**
 * @description 
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Repository("summaryDao")
@SuppressWarnings("unchecked")
public class SummaryDAOImpl extends GenericHibernateDAO<Summary> implements SummaryDAO {
	public SummaryDAOImpl() {
		super(Summary.class);
	}

	@Override
	public List<Statistics> getSummary(Integer uid, Integer count, DateRange dr) {
		//执行存储过程
		List<Object> os = (List<Object>) queryForProcedure("{call tj_summary(?,?,?,?,?,?,?,?,?,?,?,?)}", new Object[]{dr.ordinal(), DateUtil.forMatDate(), uid, count, ItemType.CONTRIBUTION.ordinal(), ItemType.PLAN.ordinal(), ItemType.PRACTICAL.ordinal(), ItemType.LEAVE.ordinal(), ItemType.LIEU.ordinal(), ItemType.LATE.ordinal(), ItemType.EARLY.ordinal(), ItemType.DELAY.ordinal()}, "SELECT s.data, s.item, s.dated FROM Statistics AS s", "TRUNCATE statistics");
		List<Statistics> list = new ArrayList<Statistics>();
		Statistics s = null;
		Iterator<Object> iter = os.iterator();
		while(iter.hasNext()) {
			Object[] o = (Object[]) iter.next();
			s = new Statistics();
			s.setData((Float) o[0]);
			s.setItem(ItemType.values()[(Byte)(o[1])]);
			s.setDated((Date)(o[2]));
			list.add(s);
		}
		//由于按天数条件和其它类型不一样，查询排序相反，所以这里将按天查询的数据顺序倒过来
		if(DateRange.DAY.equals(dr)) Collections.reverse(list);
		return list;
	}
	
	@Override
	public List<Attendance> getAttendance(Integer uid) {
		List<Attendance> list = new ArrayList<Attendance>();
		Attendance a = null;
		
		//执行存储过程
		String sql = "SELECT a.jobNo, a.ename, a.range, a.day, a.hours, a.leave, a.late, a.compensatory, a.des FROM attendance_tb AS a";
		String trun = "TRUNCATE attendance_tb";
		List<Object> os = (List<Object>) queryForProcedure("{call attendance(?)}", new Object[]{uid}, sql, trun);
		
		Iterator<Object> iter = os.iterator();
		while(iter.hasNext()) {
			Object[] o = (Object[]) iter.next();
			a = new Attendance();
			a.setJobNo((String)o[0]);
			a.setEname((String)o[1]);
			a.setRange(DateRange.values()[(Byte)(o[2])]);
			Object day = o[3];
			Object hours = o[4];
			Object leave = o[5];
			Object late = o[6];
			Object compensatory = o[7];
			if(RegexUtil.notEmpty(day)) a.setDay((Float) day);
			if(RegexUtil.notEmpty(hours)) a.setHours((Float) hours);
			if(RegexUtil.notEmpty(leave)) a.setLeave((Integer) leave);
			if(RegexUtil.notEmpty(late)) a.setLate((Integer) late);
			if(RegexUtil.notEmpty(compensatory)) a.setCompensatory((Integer) compensatory);
			a.setDes((Date) o[8]);
			list.add(a);
		}
		return list;
	}
}
