/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sqe.gom.app.GomQueryService;
import com.sqe.gom.constant.ApplyState;
import com.sqe.gom.constant.AssetState;
import com.sqe.gom.constant.AssetType;
import com.sqe.gom.constant.Attendance;
import com.sqe.gom.constant.DateRange;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.constant.LeaveType;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.ResourceType;
import com.sqe.gom.constant.TaskType;
import com.sqe.gom.constant.UnfinishedType;
import com.sqe.gom.constant.WorkingHoursType;
import com.sqe.gom.dao.AssetDAO;
import com.sqe.gom.dao.BorrowDAO;
import com.sqe.gom.dao.ExperienceDAO;
import com.sqe.gom.dao.LeaveDAO;
import com.sqe.gom.dao.LoginDAO;
import com.sqe.gom.dao.MeetingDAO;
import com.sqe.gom.dao.ProjectDAO;
import com.sqe.gom.dao.ResponsibilityDAO;
import com.sqe.gom.dao.TaskDAO;
import com.sqe.gom.dao.TrainingDAO;
import com.sqe.gom.dao.UserDAO;
import com.sqe.gom.model.Asset;
import com.sqe.gom.model.Borrow;
import com.sqe.gom.model.Experience;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Leave;
import com.sqe.gom.model.Login;
import com.sqe.gom.model.Meeting;
import com.sqe.gom.model.Project;
import com.sqe.gom.model.Responsibility;
import com.sqe.gom.model.Task;
import com.sqe.gom.model.Training;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.UserGroup;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Sep 7, 2012
 * @version 3.0
 */
@Service("gomQueryService")
public class GomQueryServiceImpl implements GomQueryService {
	private SimpleDateFormat df = new SimpleDateFormat("HH:mm");
	private UserDAO userDao;
	private TaskDAO taskDao;
	private ProjectDAO projectDao;
	private TrainingDAO trainingDao;
	private LoginDAO loginDao;
	private AssetDAO assetDao;
	private BorrowDAO borrowDao;
	private ExperienceDAO experienceDao;
	private ResponsibilityDAO responsibilityDao;
	private LeaveDAO leaveDao;
	private MeetingDAO meetingDao;
	
	@Resource(name="userDao")
	public void setUserDao(UserDAO userDao) {
		this.userDao = userDao;
	}

	@Resource(name="taskDao")
	public void setTaskDao(TaskDAO taskDao) {
		this.taskDao = taskDao;
	}
	
	@Resource(name="projectDao")
	public void setProjectDao(ProjectDAO projectDao) {
		this.projectDao = projectDao;
	}

	@Resource(name="trainingDao")
	public void setTrainingDao(TrainingDAO trainingDao) {
		this.trainingDao = trainingDao;
	}
	
	@Resource(name="loginDao")
	public void setLoginDao(LoginDAO loginDao) {
		this.loginDao = loginDao;
	}

	@Resource(name="assetDao")
	public void setAssetDao(AssetDAO assetDao) {
		this.assetDao = assetDao;
	}

	@Resource(name="borrowDao")
	public void setBorrowDao(BorrowDAO borrowDao) {
		this.borrowDao = borrowDao;
	}

	@Resource(name="experienceDao")
	public void setExperienceDao(ExperienceDAO experienceDao) {
		this.experienceDao = experienceDao;
	}
	
	@Resource(name = "responsibilityDao")
	public void setResponsibilityDao(ResponsibilityDAO responsibilityDao) {
		this.responsibilityDao = responsibilityDao;
	}
	
	@Resource(name="leaveDao")
	public void setLeaveDao(LeaveDAO leaveDao) {
		this.leaveDao = leaveDao;
	}
		
	@Resource(name="meetingDao")
	public void setMeetingDao(MeetingDAO meetingDao) {
		this.meetingDao = meetingDao;
	}

	@Override
	public List<UserGroup> getUsers(GroupType type, String ename) {
		return userDao.getAgents(ename, type, "");
	}
	
	@Override
	public List<Task> getTasks(String ename, Boolean needHelp, TaskType type, ProcessStatus state, DateRange frequency, Date start, Date end, Page page) {
		StringBuilder criteria = new StringBuilder();
		//如果是完成的任务，则按完成时间搜索
		if(ProcessStatus.Completed.equals(state)) {
			if(RegexUtil.notEmpty(start)) criteria.append(" AND t.actualEnd>='").append(DateUtil.formatDateTime(start)).append("'");
			if(RegexUtil.notEmpty(end)) criteria.append(" AND t.actualEnd<='").append(DateUtil.formatDateTime(end)).append("'");
		} else {
			if(RegexUtil.notEmpty(start)) criteria.append(" AND t.createDate>='").append(DateUtil.formatDateTime(start)).append("'");
			if(RegexUtil.notEmpty(end)) criteria.append(" AND t.createDate<='").append(DateUtil.formatDateTime(end)).append("'");
		}
		
		if(RegexUtil.notEmpty(state)) criteria.append(" AND t.state=").append(state.ordinal());
		if(RegexUtil.notEmpty(ename)) criteria.append(" AND t.executor='").append(ename).append("'");
		if(needHelp) criteria.append(" AND t.needHelp=").append(Boolean.TRUE);
		if(RegexUtil.notEmpty(type)) criteria.append(" AND t.taskType=").append(type.ordinal());
		//如果frequency不为空，则表示查询固定工作
		if(RegexUtil.notEmpty(frequency)) {
			criteria.append(" AND f.frequency=").append(frequency.ordinal());
			return taskDao.getTasks(criteria.toString());
		}
		
		return taskDao.getTasks(" ORDER BY t.createDate", criteria.toString(), page);
	}
	
	@Override
	public List<Project> getProjects(Boolean isParent, Integer parentId, ProcessStatus state, Date start, Date end) {
		StringBuilder criteria = new StringBuilder();
		
		if(isParent) criteria.append(" AND f.id IS NULL");
		if(RegexUtil.notEmpty(parentId)) criteria.append(" AND f.id=").append(parentId);
		if(RegexUtil.notEmpty(state)) criteria.append(" AND p.state=").append(state.ordinal());
		if(RegexUtil.notEmpty(start)) criteria.append(" AND p.startDate>='").append(DateUtil.formatDate(start)).append("'");
		if(RegexUtil.notEmpty(end)) criteria.append(" AND p.startDate<='").append(DateUtil.formatDate(end)).append("'");
		
		return projectDao.getProjects(" ORDER BY p.id", criteria.toString());
	}
	
	@Override
	public List<Training> getTrainings(Date start, Date end) {
		StringBuilder sb = new StringBuilder().append(" AND t.startDate>='").append(DateUtil.formatDate(start)).append("' AND t.startDate<='").append(DateUtil.formatDate(end)).append("'");
		return trainingDao.getTrainings(" ORDER BY t.id", sb.toString(), null);
	}
	
	@Override
	public List<Asset> getAssets(AssetType type, AssetState state, Date start, Date end) {
		StringBuilder sql = new StringBuilder();
		if(RegexUtil.notEmpty(type)) sql.append(" AND a.assetType=").append(type.ordinal());
		if(RegexUtil.notEmpty(state)) sql.append(" AND a.assetState=").append(state.ordinal());
		if(RegexUtil.notEmpty(start)) sql.append(" AND a.buyDate >='").append(DateUtil.formatDate(start)).append("'");
		if(RegexUtil.notEmpty(end)) sql.append(" AND a.buyDate <='").append(DateUtil.formatDate(end)).append("'");
		return assetDao.getAssets(null, sql.toString(), null);
	}
	
	@Override
	public List<Borrow> getBorrows(String ename, ApplyState state) {
		StringBuilder criteria = new StringBuilder();
		if(RegexUtil.notEmpty(ename)) criteria.append(" AND b.receiver='").append(ename).append("'");
		if(RegexUtil.notEmpty(state)) criteria.append(" AND b.applyState=").append(state.ordinal());
		return borrowDao.getBorrows(" ORDER BY b.id", criteria.toString(), null);
	}
	
	@Override
	public List<Experience> getExperience(ResourceType type, String user, String start, String end) {
		return experienceDao.getExperiences(type, user, start, end);
	}
	
	@Override
	public List<Responsibility> getResponsibility(Integer userId) {
		return responsibilityDao.getResponsibility(null, userId, " ORDER BY ur.node", null);
	}

	@Override
	public GomUser getEntryAndDeptrueData(String ename) {
		GomUser user = userDao.checkUser(ename, null, false);
		for(GomGroup gg : user.getGroups()) {
			if(GroupType.DEPARTMENT.equals(gg.getType())) {
				user.setCdepartment(gg.getCname());
				break;
			}
		}
		return user;
	}
	
	@Override
	public Login getLog(int uid, int mins) {
		return loginDao.getLog(uid, mins);
	}
	
	@Override
	public List<Login> getLogs(int uid, Date startDate, Date endDate) {
		return loginDao.getLogs(uid, startDate, endDate, null);
	}
	
	@Override
	public int getAttendance(Attendance type, String time, int uid, DateRange field, int range) {
		List<Login> list = loginDao.getLogs(uid, DateUtil.parseDate(formatDate(field, range)), DateUtil.previous(0), null);
		if(list.isEmpty()) return 0;
		int num = 0;
		try {
			for(Login l : list) {
				if(Attendance.ONDUTY.equals(type) && RegexUtil.notEmpty(l.getLoginTake())) {
					String take = l.getLoginTake().split(",")[0];
					if(df.parse(take).after(df.parse(time))) { num++; }
				} else if(Attendance.OFFDUTY.equals(type) && RegexUtil.notEmpty(l.getLoginOut())) {
					System.out.println(df.format(l.getLoginOut()));
					if(df.parse(df.format(l.getLoginOut())).before(df.parse(time))) { num++; }
				}
			}
		} catch (ParseException e) {
			e.printStackTrace();
			return num;
		}
		return num;
	}

	@Override
	public int getLeaveInof(int uid, LeaveType type, DateRange field, int range) {
		StringBuilder criteria = new StringBuilder(" AND l.startDate>='").append(formatDate(field, range)).append("' AND l.startDate<='").append(DateUtil.forMatDate()).append("'");
		if(RegexUtil.notEmpty(type)) criteria.append(" AND l.type=").append(type.ordinal());
		int leaveDays = 0;
		List<Leave> list = leaveDao.getLeaves(uid, criteria.toString(), " ORDER BY l.applyDate", null);
		if(!list.isEmpty()) {
			for(Leave l : list) {leaveDays += l.getDays();}
		}
		return leaveDays;
	}

	@Override
	public List<Leave> getYearLeave(int uid, LeaveType type, Integer start, Integer end) {
		StringBuilder criteria = new StringBuilder();
		Calendar cal = Calendar.getInstance();
		cal.set(start, 0, 01, 0, 0, 0);
		Date st = cal.getTime();
		if(RegexUtil.notEmpty(end) && end > 0) cal.set(end, 0, 01, 0, 0, 0);
		else cal = Calendar.getInstance();
		Date ed = cal.getTime();
		criteria.append(" AND l.startDate>='").append(DateUtil.formatDate(st)).append("' AND l.startDate<='").append(DateUtil.formatDate(ed)).append("'");
		if(RegexUtil.notEmpty(type)) criteria.append(" AND l.type=").append(type.ordinal());
		return leaveDao.getLeaves(uid, criteria.toString(), " ORDER BY l.applyDate", null);
	}
	
	@Override
	public int getWorkingHours(WorkingHoursType type, String ename, DateRange field, int range) {
		StringBuilder criteria = new StringBuilder(" AND t.executor='").append(ename).append("'");
		int hours = 0;
		if(WorkingHoursType.EXPECTED.equals(type)) {
			criteria.append(" AND t.expectedStart>='").append(formatDate(field, range)).append("' AND t.expectedStart<='").append(DateUtil.forMatDate()).append("'");
			List<Task> list = taskDao.getTasks(null, criteria.toString(), null);
			if(!list.isEmpty()) {
				for(Task t : list) {
					if(RegexUtil.notEmpty(t.getExpectedHours())) hours += t.getExpectedHours();
				}
			}
		} else if(WorkingHoursType.ACTUAL.equals(type)) {
			criteria.append(" AND t.actualStart>='").append(formatDate(field, range)).append("' AND t.actualStart<='").append(DateUtil.forMatDate()).append("'");
			List<Task> list = taskDao.getTasks(null, criteria.toString(), null);
			if(!list.isEmpty()) {
				for(Task t : list) {
					if(RegexUtil.notEmpty(t.getActualHours())) hours += t.getActualHours();
				}
			}
		}
		return hours;
	}
	
	@Override
	public int getWorkingUnfinished(UnfinishedType type, String ename, DateRange field, int range) {
		StringBuilder criteria = new StringBuilder();
		int number = 0;
		if(UnfinishedType.WORKTASK.equals(type)) {
			criteria.append(" AND t.executor='").append(ename).append("' AND t.expectedStart>='").append(formatDate(field, range)).append("' AND t.expectedStart<='").append(DateUtil.forMatDate()).append("'");
			List<Task> list = taskDao.getTasks(null, criteria.toString(), null);
			if(!list.isEmpty()) {
				for(Task t : list) {
					if(RegexUtil.isEmpty(t.getActualEnd()) || t.getActualEnd().after(t.getExpectedEnd())) number++;
				}
			}
		} else if(UnfinishedType.PROJECT.equals(type)) {
			criteria.append(" AND p.director='").append(ename).append("' AND p.startDate>='").append(formatDate(field, range)).append("' AND p.endDate<='").append(DateUtil.forMatDate()).append("'");
			List<Project> list = projectDao.getProjects(criteria.toString());
			if(!list.isEmpty()) {
				for(Project p : list) {
					if(RegexUtil.isEmpty(p.getActualEnd()) || p.getActualEnd().after(p.getEndDate())) number++;
				}
			}
		}
		return number;
	}
	
	@Override
	public List<Meeting> getMeetings(String host, Date start, Date end) {
		StringBuilder sb = new StringBuilder();
		if(RegexUtil.notEmpty(host)) sb.append(" AND m.host='").append(host).append("'");
		if(RegexUtil.notEmpty(start)) sb.append(" AND m.time>='").append(DateUtil.formatDate(start)).append("'");
		if(RegexUtil.notEmpty(end)) sb.append(" AND m.time<='").append(DateUtil.formatDate(end)).append("'");
		return meetingDao.getMeetings(" ORDER BY m.time", sb.toString(), null);
	}
	
	private String formatDate(DateRange field, int range) {
		Calendar c = Calendar.getInstance();
		if(DateRange.YEAR.equals(field)) {
			c.add(Calendar.YEAR, -range);
		} else if(DateRange.MONTH.equals(field)) {
			c.add(Calendar.MONTH, -range);
		} else if(DateRange.WEEK.equals(field)) {
			c.add(Calendar.WEEK_OF_YEAR, -range);
		} else if(DateRange.DAY.equals(field)) {
			c.add(Calendar.DAY_OF_MONTH, -range);
		}
		return DateUtil.formatDate(c.getTime());
	}

}
