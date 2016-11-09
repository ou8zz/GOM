/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.text.DecimalFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.MessagingException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.sqe.gom.app.MailService;
import com.sqe.gom.app.ProcessService;
import com.sqe.gom.app.SummaryService;
import com.sqe.gom.app.SwotService;
import com.sqe.gom.constant.ApprovalStatus;
import com.sqe.gom.constant.AssignType;
import com.sqe.gom.constant.DateRange;
import com.sqe.gom.constant.EmployeeCate;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.ItemType;
import com.sqe.gom.constant.LeaveType;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.ProcessType;
import com.sqe.gom.constant.TaskType;
import com.sqe.gom.dao.AbnormalDAO;
import com.sqe.gom.dao.ConfigDAO;
import com.sqe.gom.dao.DepartureDAO;
import com.sqe.gom.dao.FixedTaskDAO;
import com.sqe.gom.dao.LeaveDAO;
import com.sqe.gom.dao.LoginDAO;
import com.sqe.gom.dao.ProcessInfoDAO;
import com.sqe.gom.dao.ProjectDAO;
import com.sqe.gom.dao.ResponsibilityDAO;
import com.sqe.gom.dao.SummaryDAO;
import com.sqe.gom.dao.TaskDAO;
import com.sqe.gom.dao.TraceDAO;
import com.sqe.gom.dao.UserDAO;
import com.sqe.gom.exception.GomException;
import com.sqe.gom.model.Abnormal;
import com.sqe.gom.model.Config;
import com.sqe.gom.model.Departure;
import com.sqe.gom.model.FixedTask;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Leave;
import com.sqe.gom.model.Login;
import com.sqe.gom.model.Logs;
import com.sqe.gom.model.MailHeader;
import com.sqe.gom.model.ProcessInfo;
import com.sqe.gom.model.Project;
import com.sqe.gom.model.Summary;
import com.sqe.gom.model.Task;
import com.sqe.gom.model.Trace;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description The process implement class enity.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Apr 15, 2012  9:45:28 PM
 * @version 3.0
 */
@Service("processService")
public class ProcessServiceImpl implements ProcessService {
	private Log log = LogFactory.getLog(ProcessServiceImpl.class);
	private LeaveDAO leaveDao;
	private TraceDAO traceDao;
	private TaskDAO taskDao;
	private FixedTaskDAO fixedTaskDao;
	private ProjectDAO projectDao;
	private UserDAO userDao;
	private DepartureDAO departureDao;
	private ConfigDAO configDao;
	private ProcessInfoDAO processDao;
	private MailService mailService;
	private ResponsibilityDAO responDao;
	private SummaryDAO summaryDao;
	private SwotService swotService;
	private AbnormalDAO abnormalDao;
	private LoginDAO loginDao;
	private SummaryService summaryService;
	
	
	@Resource(name="leaveDao")
	public void setLeaveDao(LeaveDAO leaveDao) {
		this.leaveDao = leaveDao;
	}
	@Resource(name="traceDao")
	public void setTraceDao(TraceDAO traceDao) {
		this.traceDao = traceDao;
	}
	@Resource(name="taskDao")
	public void setTaskDao(TaskDAO taskDao) {
		this.taskDao = taskDao;
	}
	@Resource(name="fixedTaskDao")
	public void setFixedTaskDao(FixedTaskDAO fixedTaskDao) {
		this.fixedTaskDao = fixedTaskDao;
	}
	@Resource(name="projectDao")
	public void setProjectDao(ProjectDAO projectDao) {
		this.projectDao = projectDao;
	}
	@Resource(name="userDao")
	public void setUserDao(UserDAO userDao) {
		this.userDao = userDao;
	}
	@Resource(name="departureDao")
	public void setDepartureDao(DepartureDAO departureDao) {
		this.departureDao = departureDao;
	}
	@Resource(name="configDao")
	public void setConfigDao(ConfigDAO configDao) {
		this.configDao = configDao;
	}
	@Resource(name="processDao")
	public void setProcessDao(ProcessInfoDAO processDao) {
		this.processDao = processDao;
	}
	@Resource(name="mailService")
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}
	@Resource(name = "responsibilityDao")
	public void setResponDao(ResponsibilityDAO responDao) {
		this.responDao = responDao;
	}
	@Resource(name = "summaryDao")
	public void setSummaryDao(SummaryDAO summaryDao) {
		this.summaryDao = summaryDao;
	}
	@Resource(name = "swotService")
	public void setSwotService(SwotService swotService) {
		this.swotService = swotService;
	}
	@Resource(name = "abnormalDao")
	public void setAbnormalDao(AbnormalDAO abnormalDao) {
		this.abnormalDao = abnormalDao;
	}
	@Resource(name = "loginDao")
	public void setLoginDao(LoginDAO loginDao) {
		this.loginDao = loginDao;
	}
	@Resource(name = "summaryService")
	public void setSummaryService(SummaryService summaryService) {
		this.summaryService = summaryService;
	}
	
	/**********************************  START LEAVE PROCESS   ****************************
	 * save leave entity and start leave process.
	 */
	@Override
	public HandlerState startLeave(Leave leave, UserGroup user) throws GomException {
		HandlerState str = HandlerState.FAILED;
		
		leave.setState(ProcessStatus.InProgress);
		leave.setUser(new GomUser(user.getId()));
		leave.setApplyDate(new Date());
		leave.setRelationAddr(user.getEmail());
		if(RegexUtil.notEmpty(leave.getAgent())){
			UserGroup ug = userDao.getUser(leave.getAgent());
			leave.setAgentCname(ug.getCname());
			leave.setAgentJobNo(ug.getJobNo());
			leave.setAgentDpt(ug.getCdepartment());
			leave.setAgentPst(ug.getCposition());
		}
		// create new leave entity and save it.
		leaveDao.create(leave);
		
		Logs lf = new Logs();
		lf.setDated(new Date());
		lf.setLogger("请假");
		lf.setUserId(user.getId());
		
		if(leave.getId() > 0) {
			Trace trace = new Trace();
			trace.setType(ProcessType.LEAVE);
			trace.setProcessId(leave.getId());
			trace.setNodeOrder(1);
			trace.setActor(user.getEname());
			trace.setApproval(ApprovalStatus.APPROVAL);
			trace.setOperator(leave.getAgent());
			trace.setAttachment(leave.getAttachment());
			
			//查询下一节点
			ProcessInfo nextProcess = processDao.getProcessInfo(ProcessType.LEAVE, null, 2);
			updateTrace(trace, nextProcess, new HashMap<String, Object>());
			str = HandlerState.SUCCESS;
			
			lf.setMessage(user.getEname() + "于："+DateUtil.formatDate(leave.getApplyDate())+" 申请 " + leave.getType().getDes() + " 为期："+leave.getDays() + " 事因为 " +leave.getEvent() + " 请等待上级审核！");
			log.debug(JsonUtils.toJson(lf));
			
		}else {
			str = HandlerState.FAILED;
			lf.setMessage(user.getEname() + "于："+DateUtil.formatDate(leave.getApplyDate())+" 申请 " + leave.getType().getDes() + " 失败了 ");
			log.warn(JsonUtils.toJson(lf));
		}
		
		return str;
	}
	
	public Leave getLeave(Integer uid, ProcessStatus state) {
		return leaveDao.getLeave(uid, state);
	}
	
	@Override
	public JGridBase<Leave> getLeaves(JGridHelper<Leave> grid, UserGroup user) {
		Trace trace = new Trace();
		trace.setType(ProcessType.LEAVE);
		trace.setActor(user.getEname());
		trace.setState(ProcessStatus.Reserved);
		trace.setApproval(ApprovalStatus.AGREE);
		
		String od = " ORDER BY l.";
		if(RegexUtil.notEmpty(grid.getJq().getSidx()))od += grid.getJq().getSidx() + " " + grid.getJq().getSord();
		else od += "applyDate";
		
		List<Leave> Leaves = leaveDao.getLeaves(trace, grid.getQ(), od, grid.getP());
		if(!Leaves.isEmpty()) {
			grid.getJq().setList(Leaves);
			grid.getJq().setRecords(grid.getP().getTotalCount());
			grid.getJq().setTotal(grid.getP().getPageCount());
		}
		
		return grid.getJq();
	}
	
	@Override
	public HandlerState updateLeave(Leave leave, UserGroup user) throws GomException {
		HandlerState result;
		Leave l = new Leave();
		l.setId(leave.getId());
		
		Trace trace = new Trace();
		trace.setId(leave.getTraceId());
		trace.setType(ProcessType.LEAVE);
		trace.setProcessId(leave.getId());
		trace.setState(ProcessStatus.Reserved);
		trace.setApproval(leave.getApproval());
		trace.setNodeOrder(leave.getNodeOrder());
		trace.setNodeCode(leave.getNodeCode());
		trace.setOpinion(leave.getOpinion());
		trace.setOrOpinion(leave.getOrOpinion());
		
		if(RegexUtil.isEmpty(leave.getRelationAddr())) l.setRelationAddr(user.getEmail());
		else l.setRelationAddr(leave.getRelationAddr() + ";" + user.getEmail());
		
		//查询下一节点信息
		ProcessInfo nextProcess = processDao.getProcessInfo(trace.getType(), null, trace.getNodeOrder() + 1);;
		
		Logs lf = new Logs();
		lf.setDated(new Date());
		lf.setUserId(user.getId());
		
		if(leave.getNodeCode().equals("Agent")) {
			trace.setOperator(leave.getRecipient());
			lf.setLogger("代理人审核");
			lf.setMessage(user.getEname() + leave.getApproval().getDes() + " 为 " + leave.getEname() + " 代理 " + leave.getType().getDes() + " 期间的工作为期"+ leave.getDays());
		}
		else if(leave.getNodeCode().equals("Director")){
			lf.setLogger("主管审核");
			if(RegexUtil.notEmpty(leave.getReported()) && leave.getReported() && RegexUtil.notEmpty(leave.getSuperior())) {
				trace.setOperator(leave.getSuperior());
				lf.setMessage("由于请假天数高于" + user.getEname() + " 所管理内，自动将请示上经经理审批！ ");
			}else {
				nextProcess = processDao.getProcessInfo(trace.getType(), null, trace.getNodeOrder() + 2); //若不向上级汇报，可直接通过
				lf.setMessage(user.getEname() + leave.getApproval().getDes() + leave.getEname() + " 的请假，审核提交通过");
			}
			
			
		}
		else if(leave.getNodeCode().equals("Apply")){
			if(RegexUtil.notEmpty(leave.getAgent())){
				UserGroup ug = userDao.getUser(leave.getAgent());
				leave.setAgentCname(ug.getCname());
				leave.setAgentJobNo(ug.getJobNo());
				leave.setAgentDpt(ug.getCdepartment());
				leave.setAgentPst(ug.getCposition());
				leave.setState(ProcessStatus.InProgress);
				leave.setUser(new GomUser(user.getId()));
				trace.setOperator(leave.getAgent());
				trace.setAttachment(leave.getAttachment());
			}
			leaveDao.update(leave);
			
			lf.setLogger("请假回执");
			lf.setMessage(user.getEname() + " 再次请求由 " + leave.getAgent() + " 代理其工作，重新提交 " + leave.getType().getDes() + " 为期 " + leave.getDays() + " 天");
		}
		
		Map<String, Object> params = new HashMap<String, Object>();
		if(RegexUtil.isEmpty(nextProcess)) result = HandlerState.PARAM_EMPTY;
		else {
			if(nextProcess.getNodeCode().equals("Email")) {
				params.clear();
				StringBuffer subject = new StringBuffer(leave.getEname());
				subject.append("将于").append(DateUtil.formatDate(leave.getStartDate())).append("至").append(DateUtil.formatDate(leave.getEndDate())).append("休假").append(leave.getDays()).append("天").append("，工作代理人").append(leave.getAgentDpt()).append(leave.getAgent());
				params.put("subject", subject.toString());
				// query to/cc address
				List<String> ccls = traceDao.getEntryApprovalMail(trace.getProcessId(), trace.getType());
				StringBuffer cc = new StringBuffer();
				for(String ss : ccls) {
					if(leave.getRelationAddr().indexOf(ss) == -1) {
						cc.append(ss).append(";");
					}
				}
				
				params.put("cc", cc.toString());
				params.put("to", leave.getRelationAddr());
				leave.setApplyDate(new Date());
				params.put("leave", leave);
			}
			
			ProcessStatus ps = updateTrace(trace, nextProcess, params);
			if(ps.equals(ProcessStatus.Completed)) {
				l.setState(ProcessStatus.Completed);
				
				//记录调休或请假
				Summary s = new Summary();
				s.setUser(new GomUser(user.getId()));
				s.setData(leave.getDays().floatValue());
				s.setDated(new Date());
				if(leave.getType().equals(LeaveType.LEAVE_IN_LIEU)) s.setSwotConfig(swotService.getSwotConfig(ItemType.LIEU, DateRange.DAY));
				else s.setSwotConfig(swotService.getSwotConfig(ItemType.LEAVE, DateRange.DAY));
				summaryDao.create(s);
			}
			if(!leave.getNodeCode().equals("Apply")) {
				if(leave.getApproval().equals(ApprovalStatus.APPROVAL) || leave.getApproval().equals(ApprovalStatus.REJECT)) leaveDao.updateLeave(l);
			}
			
			result = HandlerState.SUCCESS;
			log.debug(JsonUtils.toJson(lf));
		}
			
		return result;
	}
	
	@Override
	public JGridBase<Leave> getLeaveRecord(Integer userId, JGridHelper<Leave> grid) {
		String od = " ORDER BY l.";
		if(RegexUtil.notEmpty(grid.getJq().getSidx()))od += grid.getJq().getSidx() + " " + grid.getJq().getSord();
		else od += "applyDate";
		
		List<Leave> ls = leaveDao.getLeaves(userId, " AND l.state="+ProcessStatus.Completed.ordinal(), od, grid.getP());
		
		grid.getJq().setList(ls);
		grid.getJq().setRecords(grid.getP().getTotalCount());
		grid.getJq().setTotal(grid.getP().getPageCount());
		
		return grid.getJq();
	}
	/*******  END LEAVE PROCESS   ********/

	/**************** START ENTRY PROCESS *************/
	/**
	 * Start entry process
	 */
	@Override
	public HandlerState startEntrant(GomUser regUser) throws GomException {
		HandlerState res;
		
		// first add staff node and completed it.
		Trace trace = new Trace();
		trace.setType(ProcessType.ENTRY);
		trace.setProcessId(regUser.getId());
		trace.setNodeOrder(1);
		trace.setActor(regUser.getEname());
		trace.setApproval(ApprovalStatus.APPROVAL);
		
		//查询此用户入职流程是否已启动
		Trace newEntry = traceDao.getTrace(regUser.getId(), trace.getType(), "newEntrant");
		if(RegexUtil.isEmpty(newEntry)) {
			//查询下一节点
			ProcessInfo nextProcess = processDao.getProcessInfo(ProcessType.ENTRY, null, 2);
			updateTrace(trace, nextProcess, new  HashMap<String, Object>());
			res = HandlerState.SUCCESS;
		}else res = HandlerState.FAILED;
		
		return res;
	}

	/**
	 * get list of new entrant.
	 */
	@Override
	public JGridBase<GomUser> getEntrants(String actor, JGridHelper<GomUser> grid){
		Trace trace = new Trace();
		trace.setType(ProcessType.ENTRY);
		trace.setActor(actor);
		trace.setState(ProcessStatus.Reserved);
		trace.setApproval(ApprovalStatus.AGREE);
		
		String od = " ORDER BY u.";
		if(RegexUtil.notEmpty(grid.getJq().getSidx()))od += grid.getJq().getSidx() + " " + grid.getJq().getSord();
		else od += "ename DESC";
		
		List<GomUser> users = traceDao.getEntryUser(trace, od, grid.getQ(), grid.getP());
		if(!users.isEmpty()) {
			grid.getJq().setList(users);
			grid.getJq().setRecords(grid.getP().getTotalCount());
			grid.getJq().setTotal(grid.getP().getPageCount());
		}
		
		return grid.getJq();
	}

	@Override
	public HandlerState updateEntrant(GomUser entrant, UserGroup user) {
		Trace trace = new Trace();
		trace.setId(entrant.getTraceId());
		trace.setType(ProcessType.ENTRY);
		trace.setApproval(entrant.getApproval());
		trace.setProcessId(entrant.getId());
		trace.setNodeOrder(entrant.getNodeOrder());
		trace.setNodeCode(entrant.getNodeCode());
		trace.setAttachment(user.getEmail());
		
		GomUser guser = new GomUser();
		guser.setId(entrant.getId());
		if(entrant.getNodeCode().equals("Personnel")) {
			guser.setEntryDate(entrant.getEntryDate());
			guser.setType(entrant.getType());
			guser.setFullDate(entrant.getFullDate());
			guser.setBank(entrant.getBank());
			guser.setAccountNo(entrant.getAccountNo());
			guser.setCensusType(entrant.getCensusType());
			guser.setIdcard(entrant.getIdcard());
			trace.setOperator(entrant.getEmailPwd());
		}else if(entrant.getNodeCode().equals("Technology")){
			guser.setTelExt(entrant.getTelExt());
			guser.setEmail(entrant.getEmail());
			guser.setEmailPwd(entrant.getEmailPwd());
			guser.setActive(entrant.isActive());
		}
		//update user by need 
		userDao.updateUser(guser);
		
		//查询下一节点信息
		ProcessInfo nextProcess = processDao.getProcessInfo(trace.getType(), null, trace.getNodeOrder() + 1);
		Map<String, Object> params = new HashMap<String, Object>();
		if(RegexUtil.isEmpty(nextProcess)) return HandlerState.FAILED;
		else {
			if(nextProcess.getNodeCode().equals("Email")) {
				params.clear();
				StringBuffer subject = new StringBuffer("欢迎新同事");
				subject.append(entrant.getEname()).append("加入").append(configDao.getConfigValue("basis.company.en")).append(entrant.getCdepartment());
				params.put("subject", subject.toString());
				// query to/cc address
				List<String> tols = userDao.getDptUserMail(entrant.getDptId(), GroupType.DEPARTMENT);
				List<String> ccls = traceDao.getEntryApprovalMail(trace.getProcessId(), trace.getType());
				StringBuffer cc = new StringBuffer();
				StringBuffer to = new StringBuffer();
				for(String ss : ccls) {
					cc.append(ss).append(";");
					if(tols.contains(ss)){ss += ";"; tols.remove(ss);}
				}
				params.put("cc", cc.toString());
				
				for(String ts : tols) {
					to.append(ts).append(";");
				}

			params.put("to", to.toString());
			entrant.setExitDate(new Date());
			params.put("register", entrant);
		}
		
		updateTrace(trace, nextProcess, params);
		return HandlerState.SUCCESS;
		}
	}

	/******************** START DEPARTURE PROCESS  ********************/
	@Override
	public Departure getDeparture(Integer userId, ProcessStatus state) {
		return departureDao.getDeparture(0, userId, state, false);
	}

	/**
	 * 保存离职申请信息，并启动流程
	 */
	@Override
	public HandlerState startDeparture(Departure dep, UserGroup user) {
		HandlerState res;
		Trace trace = new Trace();
		trace.setNodeOrder(1);
		trace.setOperator(dep.getRecipient());
		trace.setApproval(ApprovalStatus.APPROVAL);
		
		GomUser gu = userDao.query(user.getId());
		if(RegexUtil.notEmpty(gu)) {
//			dep.setRecipient(null);
//			dep.setRecipientDpt(null);
			dep.setState(ProcessStatus.InProgress);
			gu.addDeparture(dep);
			gu.setExitDate(dep.getExitDate());
			userDao.update(gu);
			
			//get departure id
			Departure departure = departureDao.getDeparture(0, gu.getId(), ProcessStatus.InProgress, false);
			trace.setProcessId(departure.getId());
			trace.setActor(user.getEname());
			ProcessInfo nextProcess = processDao.getProcessInfo(ProcessType.DEPARTURE, null, 2);
			updateTrace(trace, nextProcess, new  HashMap<String, Object>());
			res = HandlerState.SUCCESS;
			
			Logs lf = new Logs();
			lf.setUserId(user.getId());
			lf.setLogger("离职申请");
			lf.setMessage("用户"+gu.getEname()+"于("+DateUtil.forMatDate()+")申请" +DateUtil.formatDate(dep.getExitDate())+ "离职，请求接收人 "+dep.getRecipient()+"，离职原因："+dep.getReason());
			log.debug(JsonUtils.toJson(lf));
		}else {
			res = HandlerState.FAILED;
			Logs lf = new Logs();
			lf.setUserId(user.getId());
			lf.setLogger("离职申请");
			lf.setMessage("用户"+gu.getEname()+"于("+DateUtil.forMatDate()+")申请" +DateUtil.formatDate(dep.getExitDate())+ "离职 请求失败！");
			log.debug(JsonUtils.toJson(lf));
		}
		
		return res;
	}
	
	@Override
	public HandlerState updateDeparture(Departure dep, UserGroup user) {
		try {
			if(!dep.getNodeCode().equals("Adjustment")){
				if(dep.getApproval().equals(ApprovalStatus.APPROVAL)) {
					if(dep.getNodeCode().equals("Apply")) {
						dep.setToMailAddr(user.getEmail());
					}else {
						String addr = dep.getToMailAddr();
						if(RegexUtil.notEmpty(user.getEmail())) {
							if(RegexUtil.isEmpty(addr)) addr = user.getEmail();
							else addr += ";" + user.getEmail();
						}
						dep.setToMailAddr(addr);
					}
				}
			}else {
				if(RegexUtil.notEmpty(dep.getReason()) && dep.getReason().startsWith(",")) dep.setReason(dep.getReason().substring(1));
				if(RegexUtil.notEmpty(dep.getRecipientDpt()) && dep.getRecipientDpt().startsWith(",")) dep.setRecipientDpt(dep.getRecipientDpt().substring(1));
				if(RegexUtil.notEmpty(dep.getRecipient()) && dep.getRecipient().startsWith(",")) dep.setRecipient(dep.getRecipient().substring(1));
			}

			Trace trace = new Trace();
			trace.setId(dep.getTraceId());
			trace.setType(ProcessType.DEPARTURE);
			trace.setApproval(dep.getApproval());
			trace.setProcessId(dep.getId());
			trace.setNodeOrder(dep.getNodeOrder());
			trace.setNodeCode(dep.getNodeCode());
			if (dep.getNodeCode().equals("Technology")) {
				if (RegexUtil.notEmpty(dep.getReason()) && dep.getReason().startsWith(","))
					trace.setOpinion(dep.getEname() + "的电脑密码：" + dep.getReason().substring(1));
				else
					trace.setOpinion(dep.getEname() + "的电脑密码：" + dep.getReason());
				userDao.updateUserActive(dep.getUserId(), dep.isActive());
			} else {
				trace.setAttachment(dep.getAttachment());
				trace.setOpinion(dep.getReason()); // 新添意见
			}

			trace.setOrOpinion(dep.getOpinion()); // 原有意见

			if (!dep.getNodeCode().equals("Financial"))
				dep.setSalaryDate(null);
			else {
				Trace preActor = departureDao.getTraceByProcess(dep.getId(), "Director", 2);
				trace.setOperator(preActor.getActor());
			}

			if (dep.getNodeCode().equals("Personnel")) {
				if (RegexUtil.notEmpty(dep.getRecipient()) && dep.getRecipient().startsWith(",")) dep.setRecipient(dep.getRecipient().substring(1));
				if (dep.getApproval().equals(ApprovalStatus.APPROVAL)) userDao.updateUserExitDate(dep.getUserId(), dep.getExitDate());
				trace.setOperator(dep.getRecipient());
				
				Logs lf = new Logs();
				lf.setUserId(user.getId());
				lf.setLogger("离职审核");
				lf.setMessage("人事部 " + user.getEname() + "于("+DateUtil.forMatDate()+") 收到 " + dep.getEname() + " 的离职申请并 " + dep.getApproval().getDes()+" 此操作");
				log.debug(JsonUtils.toJson(lf));
			} 
			else if (dep.getNodeCode().equals("Receiver")) {
				dep.setHandover(dep.getReason());
				dep.setRecipientJobNo(user.getJobNo());
				dep.setRecipientPst(user.getCposition());
				
				Logs lf = new Logs();
				lf.setUserId(user.getId());
				lf.setLogger("离职审核");
				lf.setMessage("接收人"+user.getEname()+"于("+DateUtil.forMatDate()+") 收到 "+dep.getEname()+" 的离职申请并 " +dep.getApproval().getDes()+" 此操作");
				log.debug(JsonUtils.toJson(lf));
			} 
			else if (dep.getNodeCode().equals("Apply")) {
				if (dep.getApproval().equals(ApprovalStatus.APPROVAL)) userDao.updateUserExitDate(dep.getUserId(), dep.getExitDate());
				
				Logs lf = new Logs();
				lf.setUserId(user.getId());
				lf.setLogger("离职申请");
				lf.setMessage("用户"+user.getEname()+"于("+DateUtil.forMatDate()+")重新提交离职申请" +DateUtil.formatDate(dep.getExitDate())+ "离职，请求接收人 "+dep.getRecipient()+"，离职原因："+dep.getReason());
				log.debug(JsonUtils.toJson(lf));
			}

			// 查询下一节点信息
			ProcessInfo nextProcess = processDao.getProcessInfo(trace.getType(), null, trace.getNodeOrder() + 1);
			Map<String, Object> params = new HashMap<String, Object>();
			if (RegexUtil.notEmpty(nextProcess) && nextProcess.getNodeCode().equals("Email")) {
				params.clear();
				StringBuffer subject = new StringBuffer(dep.getUserDpt());
				subject.append(dep.getEname()).append("将于").append(DateUtil.formatDate(dep.getExitDate())).append("离职，他的职务接收人").append(dep.getRecipientDpt()).append(dep.getRecipient());
				params.put("subject", subject.toString());
				params.put("to", dep.getToMailAddr());

				List<String> clist = userDao.getDptUserMail(dep.getDptId(), GroupType.DEPARTMENT);
				String[] to = dep.getToMailAddr().split(";");
				for (String ss : to) {
					if (clist.contains(ss)) {
						ss += ";";
						clist.remove(ss);
					}
				}

				StringBuffer sb = new StringBuffer();
				for (String s2 : clist) {
					sb.append(s2).append(";");
				}

				params.put("cc", sb.toString());
				params.put("dep", dep);
			}

			ProcessStatus ps = updateTrace(trace, nextProcess, params);
			if (ps.equals(ProcessStatus.Completed))
				dep.setState(ProcessStatus.Completed);
			if (dep.getApproval().equals(ApprovalStatus.APPROVAL) || dep.getApproval().equals(ApprovalStatus.REJECT))
				departureDao.updateDeparture(dep);

			return HandlerState.SUCCESS;
		} catch (Exception ex) {
			log.error("have an error when update departure", ex);
			return HandlerState.ERROR;
		}
	}

	/**
	 * query all will been check departure process.
	 * 
	 * @param actor
	 *            The actor of this node of process
	 * @param grid
	 *            The jQGrid plugin initial.
	 * @return list of jqGrid
	 */
	@Override
	public JGridBase<Departure> getDepartures(String actor, JGridHelper<Departure> grid) {
		Trace trace = new Trace();
		trace.setActor(actor);
		trace.setType(ProcessType.DEPARTURE);
		trace.setState(ProcessStatus.Reserved);
		trace.setApproval(ApprovalStatus.AGREE);

		String od = " ORDER BY d.";
		if (RegexUtil.notEmpty(grid.getJq().getSidx()))
			od += grid.getJq().getSidx() + " " + grid.getJq().getSord();
		else
			od += "id";

		List<Departure> departures = departureDao.getDepartures(trace, od, grid.getQ(), grid.getP());
		if (!departures.isEmpty()) {
			grid.getJq().setList(departures);
			grid.getJq().setRecords(grid.getP().getTotalCount());
			grid.getJq().setTotal(grid.getP().getPageCount());
		}

		return grid.getJq();
	}

	public Departure getDepartureTrace(String actor) {
		Trace trace = new Trace();
		trace.setActor(actor);
		trace.setType(ProcessType.DEPARTURE);
		trace.setState(ProcessStatus.Reserved);

		List<Departure> dep = departureDao.getDepartures(trace, null, null, new Page(1));
		if (dep.isEmpty()) return null;
		else return dep.get(0);
	}

	/******************** END DEPARTURE PROCESS ********************/

	/** 工作安排--------START--------------------------------------------------------*/
	 
	@Override
	public JGridBase<Task> getTasks(JGridHelper<Task> grid, String ename, Boolean help, String taskType, String state, String role) {
		List<Task> list = Collections.emptyList();
		Trace trace = new Trace();
		trace.setState(ProcessStatus.Reserved);
		trace.setActor(ename);

		StringBuilder q = new StringBuilder();
		String ord = " ORDER BY t.";
		if (RegexUtil.notEmpty(grid.getJq().getSidx()))
			ord += grid.getJq().getSidx() + " " + grid.getJq().getSord();
		else
			ord += "id";

		if (RegexUtil.notEmpty(taskType))
			q.append(" AND t.taskType=").append(TaskType.valueOf(taskType).ordinal());
		else if (RegexUtil.notEmpty(state))
			q.append(" AND t.state=").append(ProcessStatus.valueOf(state).ordinal());
		if (help)
			q.append(" AND t.needHelp=").append(Boolean.TRUE);

		grid.setQ(q.toString());

		if ("order".equals(role)) {
			List<FixedTask> fls = fixedTaskDao.getTaskNotFixed(null);
			if (!fls.isEmpty()) {
				for (FixedTask f : fls) {
					Task task = new Task();
					task.setState(ProcessStatus.Ready);
					task.setExpectedStart(new Date());
					task.setTaskTitle(f.getTaskTitle());
					task.setCreateDate(new Date());
					task.setExpectedHours(f.getHours());
					task.setFixed(f);
					task.setAssignor(ename);
					task.setCompletedRate("0");
					task.setDescribe(f.getDescribe());
					task.setTaskType(TaskType.REGULAR);
					taskDao.create(task);
				}
			}
			list = taskDao.getTasks(ord, grid.getQ(), grid.getP());
		} 
		else if(RegexUtil.notEmpty(state) && ProcessStatus.InProgress.equals(ProcessStatus.valueOf(state))) {
			q.append(" AND t.expectedStart <='").append(DateUtil.formatDate(DateUtil.previous(-7)));
			q.append("' AND t.expectedStart >='").append(DateUtil.formatDate(DateUtil.previous(30))).append("'");
			grid.setQ(q.toString());
			list = taskDao.getTasks(trace, ord, grid.getQ(), grid.getP()); 	// 追踪进度查询
		} 
		else {
			list = taskDao.getTasks(ord, grid.getQ(), grid.getP()); 		// 工作任务查询
		} 

		grid.getJq().setList(list);
		grid.getJq().setRecords(grid.getP().getTotalCount());
		grid.getJq().setTotal(grid.getP().getPageCount());

		return grid.getJq();
	}

	@Override
	public void startTask(Task task, String ename) {
		Trace trace = new Trace();
		trace.setType(ProcessType.TASK);
		trace.setApproval(ApprovalStatus.APPROVAL);
		trace.setNodeOrder(1);
		trace.setAttachment(task.getAttachment());

		Logs lf = new Logs();
		lf.setDated(new Date());
		if (RegexUtil.isEmpty(task.getCompletedRate())) task.setCompletedRate("0");
		if (RegexUtil.isEmpty(task.getId())) {
			// 添加任务
			task.setCreateDate(new Date());
			task.setState(ProcessStatus.Ready); // 设置未分配状态

			if (TaskType.TEMPORARY.equals(task.getTaskType())) { // 如果是临时任务,直接可执行任务,否则添加分配流程
				task.setState(ProcessStatus.InProgress);
				task.setExpectedStart(new Date());
				task.setActualStart(new Date());
				taskDao.create(task);

				trace.setActor(task.getExecutor());
				trace.setOperator(task.getAssignor());
				trace.setNodeCode("Executor");
				trace.setNodeOrder(3);
				trace.setProcessId(task.getId());
				UserGroup ug = userDao.getLoginUser(task.getAssignor(), null, false);
				trace.setDepartment(ug.getDepartment());

				ProcessInfo nextProcess = processDao.getProcessInfo(ProcessType.TASK, "Director", 5);
				updateTrace(trace, nextProcess, null);

				lf.setLogger("临时任务");
				lf.setMessage(task.getTaskType().getDes() + "工作" + task.getTaskTitle() + "预计于" + DateUtil.formatDate(task.getExpectedStart()) + "开始至" + DateUtil.formatDate(task.getExpectedEnd()) + "结束，预计" + task.getExpectedHours() + " 小时工作，由 " + task.getExecutor() + " 执行， " + task.getAssignor() + "进行下一步进度审核！");
				log.debug(JsonUtils.toJson(lf));
			} else {
				task.setAssignor(ename);
				if (TaskType.PLAN.equals(task.getTaskType())) {
					Project pj = projectDao.query(task.getProId());
					task.setProject(pj);
					// task.setExpectedHours(Float.parseFloat(pj.getExpectedTime())
					// * (Float.parseFloat(task.getOccupyRate())/100));
				} 
				else if (TaskType.REGULAR.equals(task.getTaskType()))
					task.setFixed(fixedTaskDao.query(task.getFixedId()));

				taskDao.create(task);

				trace.setNodeCode("AddTask");
				trace.setActor(ename);
				trace.setNodeOrder(1);
				trace.setProcessId(task.getId());
				trace.setOperator("Allocation");

				ProcessInfo nextProcess = processDao.getProcessInfo(ProcessType.TASK, "Allocation", 2);
				updateTrace(trace, nextProcess, null);
				
				lf.setLogger("工作任务");
				lf.setMessage(task.getTaskType().getDes() + "工作" + task.getTaskTitle() + " 预计" + task.getExpectedHours() + " 小时工作 由下一步工作分配者进行分配！");
				log.debug(JsonUtils.toJson(lf));
			}
			
		} else {
			// 分配任务
			if (RegexUtil.notEmpty(task.getResponId())) {
				task.setResponsibility(responDao.query(Integer.parseInt(task.getResponId())));
				task.setState(ProcessStatus.InProgress); // 正在进行中
				taskDao.updateTask(task);

				Trace t = new Trace();
				t.setId(task.getTraceId());
				t.setActor(ename);
				t.setIcon("green.jpg");
				t.setState(ProcessStatus.Completed);
				traceDao.updateTrace(t);

				trace.setProcessId(task.getId());
				trace.setOperator(task.getExecutor());
				trace.setNodeOrder(2);
				trace.setId(task.getTraceId());

				ProcessInfo nextProcess = processDao.getProcessInfo(ProcessType.TASK, null, 3);
				updateTrace(trace, nextProcess, null);
				
				//计划
				GomUser gu = userDao.checkUser(task.getExecutor(), null, false);
				Login login = loginDao.getLog(gu.getId(), 0);
				Summary s = new Summary();
				s.setUser(gu);
				s.setData(task.getExpectedHours().floatValue());
				s.setDated(new Date());
				s.setDateMark(login.getDateMark());
				s.setSwotConfig(swotService.getSwotConfig(ItemType.PLAN, DateRange.DAY));
				summaryDao.create(s);
				
				lf.setLogger("分配工作");
				lf.setMessage("您的工作分配由 " + task.getExecutor() + " 执行，工作类型 " + task.getTaskType().getDes() + "工作" + task.getTaskTitle() + "预计于" + DateUtil.formatDate(task.getExpectedStart()) + "开始至" + DateUtil.formatDate(task.getExpectedEnd()) + "结束，预计" + task.getExpectedHours() + " 小时工作，由 " + task.getExecutor() + " 执行 ");
				log.debug(JsonUtils.toJson(lf));
			} else {
				taskDao.updateTask(task);
				
				lf.setLogger("添加任务");
				lf.setMessage("添加 " + task.getTaskType().getDes() + "工作" + task.getTaskTitle() + "，预计" + task.getExpectedHours() + " 小时工作 ");
				log.debug(JsonUtils.toJson(lf));
			}
		}
	}

	@Override
	public void taskTrace(String ename, Trace trace) {
		trace.setArrow("down_green_arrow.jpg");
		trace.setIcon("green.jpg");
		trace.setState(ProcessStatus.Completed);
		
		//执行人
		if(trace.getNodeCode().equals("Executor")) {
			trace.setApproval(ApprovalStatus.APPROVAL);
			Task t = taskDao.query(trace.getProcessId());
			trace.setOperator(t.getAssignor());
		
			//如果需要帮忙
			Task task = new Task();
			if(RegexUtil.notEmpty(trace.getNeedHelp()) && trace.getNeedHelp()) {
				trace.setOperator(trace.getBacker());
				task.setNeedState(trace.getNeedState());
				task.setNeedHelp(true);
				ProcessInfo nextProcess = processDao.getProcessInfo(ProcessType.TASK, null, 4);
				updateTrace(trace, nextProcess, null);
				
				//修改需要帮忙状态
				Task needHelp = new Task();
				needHelp.setId(task.getId());
				needHelp.setNeedHelp(true);
				taskDao.updateTask(needHelp);
				
				//日志记录
				Logs lf = new Logs();
				lf.setDated(new Date());
				lf.setLogger("需要帮忙");
				lf.setMessage(ename+"于"+DateUtil.forMatDate()+"请求"+t.getAssignor()+"帮忙"+t.getTaskType().getDes()+"工作"+t.getTaskTitle()+"预计从"+DateUtil.formatDate(t.getExpectedStart())+"开始至"+DateUtil.formatDate(t.getExpectedEnd())+"结束");
				log.debug(JsonUtils.toJson(lf));
			}
			else {
				String delay = "";
				if(RegexUtil.notEmpty(trace.getDelay())) {
					task.setDelay(trace.getDelay());
					delay = " 延误 " + trace.getDelay();
				}
				ProcessInfo nextProcess = processDao.getProcessInfo(ProcessType.TASK, null, 5);
				updateTrace(trace, nextProcess, null);
				
				Logs lf = new Logs();
				lf.setDated(new Date());
				lf.setLogger("工作执行");
				lf.setMessage(t.getTaskType().getDes()+"工作"+t.getTaskTitle()+" 由 "+ename+" 于 "+ DateUtil.formatDate(t.getActualStart())+" 开始至 "+DateUtil.formatDate(t.getActualEnd())+"结束，实际花费"+t.getActualHours()+"小时，已完成"+t.getCompletedRate()+"%  "+delay);
				log.debug(JsonUtils.toJson(lf));
			}
			
			task.setState(ProcessStatus.InProgress);
			task.setId(trace.getProcessId());
			taskDao.updateTask(task);
		} 
		//需要帮忙 支持人 帮忙完成再次转回执行人
		else if(trace.getNodeCode().equals("Help")){
			trace.setApproval(ApprovalStatus.APPROVAL);
			Task task = taskDao.query(trace.getProcessId());
			trace.setOperator(task.getExecutor());
			ProcessInfo nextProcess = processDao.getProcessInfo(ProcessType.TASK, null, 3);
			updateTrace(trace, nextProcess, null);
			
			//修改需要帮忙状态
			Task t = new Task();
			t.setId(task.getId());
			t.setNeedHelp(false);
			taskDao.updateTask(t);
			
			//日志记录
			Logs lf = new Logs();
			lf.setDated(new Date());
			lf.setLogger("需要帮忙");
			lf.setMessage(ename+"已经于"+DateUtil.forMatDate()+"完成"+task.getExecutor()+"请求帮忙的"+task.getTaskType().getDes()+"工作"+task.getTaskTitle()+"花费"+task.getActualHours()+"小时");
			log.debug(JsonUtils.toJson(lf));
		}
		//指派者
		else if(trace.getNodeCode().equals("Director")) {
			Task task = taskDao.query(trace.getProcessId());
			trace.setNodeOrder(4);
			trace.setOperator(task.getExecutor());
			trace.setOrOpinion(trace.getOpinion());
			
			ProcessInfo nextProcess = processDao.getProcessInfo(ProcessType.TASK, null, 6);
			updateTrace(trace, nextProcess, null);
			
			//工作者信息
			GomUser gu = userDao.checkUser(task.getExecutor(), null, false);
			Login login = loginDao.getLog(gu.getId(), 0);
			Summary s = new Summary();
			
			//如果是固定任务完成，生成下次的固定工作
			if(TaskType.REGULAR.equals(task.getTaskType()) && ApprovalStatus.APPROVAL.equals(trace.getApproval())) {
				Task t = new Task();
				t.setState(ProcessStatus.InProgress);
				t.setCreateDate(DateUtil.previous(-1));
				t.setTaskTitle(task.getTaskTitle());
				t.setTaskType(task.getTaskType());
				t.setExecutor(task.getExecutor());
				t.setAssignor(task.getAssignor());
				t.setCreateDate(new Date());
				t.setResponsibility(task.getResponsibility());
				t.setFixed(task.getFixed());
				t.setExpectedStart(task.getExpectedStart());
				t.setExpectedEnd(task.getExpectedEnd());
				t.setExpectedHours(task.getExpectedHours());
				t.setActualStart(task.getActualStart());
				t.setActualEnd(task.getActualEnd());
				t.setActualHours(task.getActualHours());
				taskDao.create(t);
				
				Trace p = new Trace();
				p.setType(ProcessType.TASK);
				p.setApproval(ApprovalStatus.APPROVAL);
				p.setActor(t.getAssignor());
				p.setOperator(t.getExecutor());
				p.setNodeCode("Allocation");
				p.setNodeOrder(2);
				p.setProcessId(t.getId());
				
				ProcessInfo executorNode = processDao.getProcessInfo(ProcessType.TASK, "Executor", 3);
				updateTrace(p, executorNode, null);
				
			} 
			//如果计划工作完成(模块或项目)
			else if(TaskType.PLAN.equals(task.getTaskType()) && ApprovalStatus.APPROVAL.equals(trace.getApproval())) {
				Project p = new Project();
				p.setId(task.getProId());
				p.setState(ProcessStatus.Completed);
				projectDao.updateProject(p);
			}
			
			//如果批准，结束这个工作完成度
			if(ApprovalStatus.APPROVAL.equals(trace.getApproval())) {
				task.setState(ProcessStatus.Completed);
				task.setActualEnd(new Date());
				float fh = task.getActualEnd().getTime() - task.getActualStart().getTime();	//计算实际工时
				task.setActualHours(Float.valueOf(RegexUtil.formatDecimal(fh/(1000*60*60), "#.#")));
				task.setCompletedRate("100");
				taskDao.updateTask(task);
				
				//实际
				s = new Summary();
				s.setUser(gu);
				s.setData(task.getActualHours().floatValue());
				s.setDated(new Date());
				s.setDateMark(login.getDateMark());
				s.setSwotConfig(swotService.getSwotConfig(ItemType.PRACTICAL, DateRange.DAY));
				summaryDao.create(s);
				
				//贡献
				s = new Summary();
				s.setUser(gu);
				s.setData(task.getActualHours().floatValue());
				s.setDated(new Date());
				s.setDateMark(login.getDateMark());
				s.setSwotConfig(swotService.getSwotConfig(ItemType.CONTRIBUTION, DateRange.DAY));
				summaryDao.create(s);
				
				//延误
				if(RegexUtil.notEmpty(task.getDelay())) {
					s = new Summary();
					s.setUser(gu);
					s.setData(1f);
					s.setDated(new Date());
					s.setDateMark(login.getDateMark());
					s.setSwotConfig(swotService.getSwotConfig(ItemType.DELAY, DateRange.DAY));
					summaryDao.create(s);
				}
				
				//日志
				Logs lf = new Logs();
				lf.setDated(new Date());
				lf.setLogger("工作审核");
				lf.setMessage(ename+" 已经于 "+DateUtil.forMatDate()+" 审核 "+task.getExecutor()+" 提交的 "+task.getTaskType().getDes()+" 工作 "+task.getTaskTitle()+" 花费 "+task.getActualHours()+" 小时完成任务，完成度 "+task.getCompletedRate()+"%，审核通过");
				log.debug(JsonUtils.toJson(lf));
			} else {
				//日志
				Logs lf = new Logs();
				lf.setDated(new Date());
				lf.setLogger("工作审核");
				lf.setMessage(ename+" 已经于 "+DateUtil.forMatDate()+" 驳回 "+task.getExecutor()+" 提交的 "+task.getTaskType().getDes()+" 工作 "+task.getTaskTitle()+" 审核不通过");
				log.debug(JsonUtils.toJson(lf));
			}
		}
	}

	@Override
	public HandlerState editTaskTime(int id, boolean b) {
		// 记录工作结束时间
		if (b) {
			Task t = taskDao.query(id);
			try {
				long dd = (new Date().getTime() - t.getActualStart().getTime()) / 60000;
				t.setActualHours(Float.parseFloat(String.valueOf(dd)));
				// 100%*(结束时间-开始时间)/给定工时＝完成率
				DecimalFormat format = new DecimalFormat("#.0");
				String comp = format.format((t.getExpectedHours() / t.getActualHours()) * 100); // 转换成字符串
				if (Float.parseFloat(comp) > 100) comp = "100";
				t.setCompletedRate(comp);
				t.setCompletedRate("99");
				t.setActualEnd(new Date());
			} catch (NumberFormatException e) {
				log.error("process task editTaskTime Medthed is NumberFormat Error! " + e);
				return HandlerState.FAILED;
			}
			taskDao.updateTask(t);
			
			Logs lf = new Logs();
			lf.setDated(new Date());
			lf.setLogger("工作结束");
			lf.setMessage("工作" + t.getTaskTitle() + "已于" + DateUtil.forMatDate() + " 结束，工作完成比例 " + t.getCompletedRate() + "%");
			log.debug(JsonUtils.toJson(lf));
		}
		// 记录工作开始时间
		else {
			Task task = new Task();
			task.setId(id);
			task.setState(ProcessStatus.InProgress);
			task.setActualStart(new Date());
			taskDao.updateTask(task);
			
			Logs lf = new Logs();
			lf.setDated(new Date());
			lf.setLogger("工作开始");
			lf.setMessage("工作已于" + DateUtil.forMatDate() + " 开始 ");
			log.debug(JsonUtils.toJson(lf));
		}
		return HandlerState.SUCCESS;
	}

	@Override
	public void abolishTask(int id, ProcessStatus state) {
		Task task = new Task();
		task.setId(id);
		task.setState(state);
		taskDao.updateTask(task);
		
		Logs lf = new Logs();
		lf.setDated(new Date());
		if(ProcessStatus.Obsolete.equals(state)) {
			lf.setLogger("工作废除");
			lf.setMessage("工作已经成功废除！工作ID号" + id);
		} else {
			lf.setLogger("恢复工作");
			lf.setMessage("工作任务已经恢复正常状态！工作ID号" + id);
		}
		log.debug(JsonUtils.toJson(lf));
	}
	/**  工作安排---------------END----------------------------------------------------- */

	
	/** 日报退出异常流程----------------------------START-------------------------------- */
	@Override
	public JGridBase<Abnormal> getAbnormals(JGridHelper<Abnormal> grid, String user, String sh) {
		List<Abnormal> list = null;
		Trace trace = new Trace();
		trace.setActor(user);
		trace.setState(ProcessStatus.Reserved);

		String od = " ORDER BY a.";
		if (RegexUtil.notEmpty(grid.getJq().getSidx()))
			od += grid.getJq().getSidx() + " " + grid.getJq().getSord();
		else
			od += "id DESC";
		
		//如果sh=sh为流程需要审核的异常，sh=user用户当前自己的异常，sh=early用户以前的异常,else所有异常
		if(RegexUtil.notEmpty(sh) && sh.equals("sh")) list = abnormalDao.getAbnormals(trace, od, grid.getQ(), grid.getP());
		else if(RegexUtil.notEmpty(sh) && RegexUtil.notEmpty(user) && sh.equals("user")) {
			grid.setQ(" AND a.state=3 AND u.ename='"+user+"'");
			list = abnormalDao.getAbnormals(od, grid.getQ(), grid.getP());
		}
		else if(RegexUtil.notEmpty(sh) && RegexUtil.notEmpty(user) && sh.equals("early")) {
			grid.setQ(" AND a.state=5 AND u.ename='"+user+"'");
			list = abnormalDao.getAbnormals(od, grid.getQ(), grid.getP());
		}
		else {
			grid.setQ(" AND a.state=5");
			list = abnormalDao.getAbnormals(od, grid.getQ(), grid.getP());
		}
		
		if (!list.isEmpty()) {
			grid.getJq().setList(list);
			grid.getJq().setRecords(grid.getP().getTotalCount());
			grid.getJq().setTotal(grid.getP().getPageCount());
		}
		return grid.getJq();
	}
	
	@Override
	public HandlerState saveAbnormal(Abnormal abnormal, UserGroup user) {
		Trace trace = new Trace();
		trace.setType(ProcessType.ABNORMAL);
		trace.setApproval(ApprovalStatus.APPROVAL);
		trace.setOpinion(abnormal.getDes());
		trace.setActor(user.getEname());
		trace.setOperator(abnormal.getIndirect());
		trace.setNodeCode("Director");
		trace.setNodeOrder(1);
		trace.setId(abnormal.getTraceId());
		trace.setProcessId(abnormal.getId());
		
		//向上级汇报
		if(RegexUtil.notEmpty(abnormal.getIndirect())) {
			ProcessInfo nextProcess = processDao.getProcessInfo(ProcessType.ABNORMAL, "Indirect", 3);
			updateTrace(trace, nextProcess, null);

			//记录日志
			Logs lf = new Logs();
			lf.setDated(new Date());
			lf.setLogger("异常提交");
			lf.setMessage("您于 " + DateUtil.forMatDate() + " 向上级 " + abnormal.getIndirect() + " 提交了 " + trace.getType().getDes() + " 请等待进度审核！");
			log.debug(JsonUtils.toJson(lf));
		} else {
			//申请异常
			abnormal.setUser(new GomUser(user.getId()));
			abnormal.setState(ProcessStatus.InProgress);
			abnormalDao.create(abnormal);
			trace.setOperator(abnormal.getReporter());
			trace.setProcessId(abnormal.getId());
			
			ProcessInfo nextProcess = processDao.getProcessInfo(ProcessType.ABNORMAL, "Director", 2);
			updateTrace(trace, nextProcess, null);

			//记录日志
			Logs lf = new Logs();
			lf.setDated(new Date());
			lf.setLogger("异常提交");
			lf.setMessage("您于 " + DateUtil.forMatDate() + " 提交了 " + abnormal.getType().getDes() + " 异常，由直接汇报人 " + abnormal.getReporter() + " 进行异常检查 请等待进度审核！");
			log.debug(JsonUtils.toJson(lf));
		}
		return HandlerState.SUCCESS;
	}
	
	@Override
	public HandlerState updateAbnormals(String[] ids, String[] traceIds, ApprovalStatus status, UserGroup user) {
		StringBuilder names = new StringBuilder();
		try {
			int i = 0;
			for(String id : ids) {
				if(RegexUtil.notEmpty(id)) {
					int aid = Integer.parseInt(id);
					Trace trace = new Trace();
					trace.setId(Integer.parseInt(traceIds[i]));
					trace.setType(ProcessType.ABNORMAL);
					trace.setApproval(status);
					trace.setOpinion(status.getDes());
					trace.setNodeOrder(2);
					trace.setProcessId(aid);

					ProcessInfo nextProcess = processDao.getProcessInfo(ProcessType.ABNORMAL, "Email", 4);
					
					GomUser gu = abnormalDao.query(aid).getUser();
					
					Map<String, Object> params = new HashMap<String, Object>();
					StringBuffer subject = new StringBuffer();
					subject.append(gu.getEname() + " 异常审核"+status.getDes()+"！");
					params.put("subject", subject.toString());
					params.put("to", gu.getEmail());
					params.put("cc", "");
					params.put("content", "用户 " + gu.getEname() + " 的异常已经由 " + user.getEname() + " 审核为：" + status.getDes());
					names.append(gu.getEname()).append(",");
					
					updateTrace(trace, nextProcess, params);
					
					//如果异常被上级批准，解除用户异常状态
					if(ApprovalStatus.APPROVAL.equals(status)) {
						List<Integer> loginIds = loginDao.logAbnormal(gu.getId());
						for(Integer lid : loginIds) {
							Login login = new Login();
							login.setId(lid);
							login.setReportMark(true);
							loginDao.save(login);
							
							//修改异常状态完成
							abnormalDao.updateAblState(ProcessStatus.Completed, gu.getId());
						}
						
						//如果审核通过，补发日报
						UserGroup ug = new UserGroup();
						ug.setComment(user.getComment());
						ug.setId(gu.getId());
						ug.setEname(gu.getEname());
						ug.setCname(gu.getCname());
						ug.setEmail(gu.getEmail());
						summaryService.sendReport(ug);
					}
				}
				i++;
			}
			//记录日志
			Logs lf = new Logs();
			lf.setDated(new Date());
			lf.setLogger("异常提交");
			lf.setMessage("您于 " + DateUtil.forMatDate() + " 批量对用户  " + names.toString()+" 异常审核已经通过！");
			log.debug(JsonUtils.toJson(lf));
		} catch (NumberFormatException e) {
			return HandlerState.PARAM_EMPTY;
		}
		return HandlerState.SUCCESS;
	}
	/** 日报退出异常流程----------------------------END-------------------------------- */
	
	@Override
	public List<Trace> getTraces(Integer processId, ProcessType type) {
		return traceDao.getTraces(processId, type);
	}
	
	@Override
	public Trace getTrace(Integer processId, ProcessType type, ProcessStatus state, String nodeCode, String actor) {
		return traceDao.getUserTrace(processId, type, nodeCode, actor, state);
	}

	@Override
	public int getEmployeeDay(EmployeeCate type) {
		String md = null;
		if (EmployeeCate.FIELDWORK.equals(type))
			md = configDao.getConfigValue("departure.fieldwork.days");
		else if (EmployeeCate.TRAINING_PERIOD.equals(type))
			md = configDao.getConfigValue("departure.training.days ");
		else if (EmployeeCate.QUALIFIED.equals(type))
			md = configDao.getConfigValue("departure.qualified.days");

		if (RegexUtil.isEmpty(md))
			return 0;
		else
			return Integer.parseInt(md);
	}

	@Override
	public HandlerState saveProcessInfo(ProcessInfo process) {
		if (RegexUtil.notEmpty(process.getProcess())) {
			process.setType(ProcessType.valueOf(process.getProcess()));
		}

		Logs lf = new Logs();
		lf.setDated(new Date());
		
		if (RegexUtil.isEmpty(process.getId()) || process.getId() == 0) {
			ProcessInfo ps = processDao.getProcessInfo(process.getType(), process.getNodeCode(), 0);
			if (RegexUtil.isEmpty(ps)) {
				int count = processDao.getProcessOrder(process.getType()) + 1;
				process.setNodeOrder(count);
				processDao.create(process);
				
				lf.setLogger("流程创建");
				lf.setMessage("您的 "+process.getType().getDes()+" 节点 "+process.getNodeName()+" 创建成功，流程代码："+process.getNodeCode());
				log.debug(JsonUtils.toJson(lf));
			}

			return HandlerState.SUCCESS;
		} else {
			processDao.update(process);
			
			lf.setLogger("流程更新");
			lf.setMessage("您的"+process.getType().getDes()+"流程节点"+process.getNodeName()+"提交成功，流程代码："+process.getNodeCode());
			log.debug(JsonUtils.toJson(lf));
			
			return HandlerState.SUCCESS;
		}
	}

	public ProcessInfo getProcessInfo(ProcessType type, String nodeCode) {
		return processDao.getProcessInfo(type, nodeCode, 0);
	}

	@Override
	public JGridBase<ProcessInfo> getProcesses(ProcessType type,
			JGridHelper<ProcessInfo> grid) {
		ProcessInfo process = new ProcessInfo();
		process.setType(type);
		String od = " ORDER BY p.";
		if (RegexUtil.notEmpty(grid.getJq().getSidx()))
			od += grid.getJq().getSidx() + " " + grid.getJq().getSord();
		else
			od += "id asc";

		List<ProcessInfo> ls = processDao.getProcesses(process, od,
				grid.getQ(), grid.getP());

		grid.getJq().setList(ls);
		grid.getJq().setRecords(grid.getP().getTotalCount());
		grid.getJq().setTotal(grid.getP().getPageCount());

		return grid.getJq();
	}

	private void sendMail(String tplName, Map<String, Object> params, String subject, String toaddr, String cc) {
		MailHeader mh = new MailHeader();
		mh.setFrom(configDao.getConfigValue("basis.mail.user"));
		if (RegexUtil.notEmpty(toaddr))
			mh.setTo(toaddr.split(";"));
		if (RegexUtil.notEmpty(cc))
			mh.setCc(cc.split(";"));
		mh.setSubject(subject);

		try {
			if(RegexUtil.notEmpty(tplName))
				mailService.sendMail(null, mh, mailService.getHtmlBody(tplName, params));
			else {
				mailService.sendMail(null, mh, params.get("content").toString());
			}
				
		} catch (MessagingException ex) {
			log.error("when send " + tplName + " templeted mail occurred an error", ex);
		}
	}

	/**
	 * 对流程Trace记录的封装
	 * 
	 * @param trace
	 *            当流程为新启动时，actor(即申请人的ID不能为空)，简单的说创建新流程时需传入申请人actor，
	 *            和下一个节点执行人Operator,反之更新的话，只需Operator{动态，多人，职务}
	 *            当前节点实例[其中nodeOrder
	 *            (节点顺序)，nodeCode(流程节点名称),processId(外链表ID),type(流程类型),
	 *            approval(审批状态),department（若执行者为职务，
	 *            则指定职务部门Ename）,operator(动态或者多人情况下，需指定执行者Ename)]
	 * 
	 * @param nextProcess
	 *            下一个节点实例
	 * @param params
	 *            邮件发送参数,其中包括主题 素subject、发件人地址to、抄送地址cc，Map
	 *            Key名称依次为subject,to,cc
	 */
	private ProcessStatus updateTrace(Trace trace, ProcessInfo nextProcess, Map<String, Object> params) {
		Trace next = new Trace();
		next.setDeliverTime(new Date());
		next.setProcessId(trace.getProcessId());

		Trace end = new Trace();
		end.setArrow("right_green_arrow.jpg");
		end.setIcon("end_green.jpg");
		end.setDeliverTime(new Date());
		end.setProcessId(trace.getProcessId());
		end.setState(ProcessStatus.Completed);
		end.setActor("End");

		if (trace.getApproval().equals(ApprovalStatus.APPROVAL)) {
			// update current node trace
			Trace current = new Trace();
			current.setDeliverTime(new Date());
			current.setId(trace.getId());
			current.setAttachment(trace.getAttachment());
			current.setArrow("right_green_arrow.jpg");
			current.setIcon("green.jpg");
			current.setState(ProcessStatus.Completed);
			current.setOpinion(handlerOpinion(trace));
			if (RegexUtil.isEmpty(trace.getActor()))
				traceDao.updateTrace(current);
			else {

				current.setActor(trace.getActor());
				current.setProcessId(trace.getProcessId());
				ProcessInfo newProcess = processDao.getProcessInfo(nextProcess.getType(), null, trace.getNodeOrder());
				newProcess.addTrace(current);
				processDao.update(newProcess);
			}

			if (RegexUtil.notEmpty(nextProcess)) {
				if (nextProcess.getNodeCode().equals("Email")) {
					// 若不为空，且节点代码为Email则，表有邮件发送需求，并结束流程
					sendMail(nextProcess.getActor(), params, params.get("subject").toString(), params.get("to").toString(), params.get("cc").toString());

					// 结束流程
					ProcessInfo endProcess = processDao.getProcessInfo(nextProcess.getType(), null, trace.getNodeOrder() + 2);
					endProcess.addTrace(end);
					processDao.update(endProcess);
					return ProcessStatus.Completed;
				} else if (nextProcess.getNodeCode().equals("End")) {
					nextProcess.addTrace(end);
					processDao.update(nextProcess);
					return ProcessStatus.Completed;
				} else {
					// 断续下一节点流程
					// add next node trace
					if (nextProcess.getAssignType().equals(AssignType.DYNAMIC) || nextProcess.getAssignType().equals(AssignType.PEOPLE))
						next.setActor(trace.getOperator());
					else if (nextProcess.getAssignType().equals(AssignType.POSITION)) {
						UserGroup mgr = userDao.getUserByDepartAndPosit(nextProcess.getActor(), trace.getDepartment());
						next.setActor(mgr.getEname());
					} else if (nextProcess.getAssignType().equals(AssignType.PARAMETER)) {
						Config config = configDao.query(nextProcess.getActor());
						next.setActor(config.getValue());
					} else
						next.setActor(nextProcess.getActor());

					next.setArrow("right_green_arrow.jpg");
					next.setIcon("active.gif");
					next.setState(ProcessStatus.Reserved);

					Trace nextTrace = traceDao.getTrace(trace.getProcessId(), nextProcess.getType(), nextProcess.getNodeCode());
					if (RegexUtil.isEmpty(nextTrace)) {
						nextProcess.addTrace(next);
						processDao.update(nextProcess);
					} else {
						next.setId(nextTrace.getId());
						traceDao.updateTrace(next);
					}

					return ProcessStatus.InProgress;
				}
			} else
				return ProcessStatus.InProgress;
		} else if (trace.getApproval().equals(ApprovalStatus.REVOKE)) {
			// update current node
			next.setAttachment(trace.getAttachment());
			next.setArrow("left_yellow_arrow_.jpg");
			next.setIcon("yellow.jpg");
			next.setOpinion(handlerOpinion(trace));
			next.setState(ProcessStatus.Completed);
			next.setId(trace.getId());
			traceDao.updateTrace(next);

			// update previous node
			ProcessInfo preProcess = processDao.getProcessInfo(
					nextProcess.getType(), null, trace.getNodeOrder() - 1,
					trace.getProcessId());
			if (RegexUtil.notEmpty(preProcess)) {
				Trace previous = new Trace();
				previous.setId(preProcess.getTraceId());
				previous.setIcon("active.gif");
				previous.setState(ProcessStatus.Reserved);
				traceDao.updateTrace(previous);
			}

			return ProcessStatus.InProgress;
		} else {
			// update current node
			next.setAttachment(trace.getAttachment());
			next.setOpinion(handlerOpinion(trace));
			next.setState(ProcessStatus.Completed);
			next.setId(trace.getId());
			next.setIcon("red.jpg");
			traceDao.updateTrace(next);

			ProcessInfo endProcess = processDao.getProcessInfo(
					nextProcess.getType(), "End", 0);
			end.setIcon("end_red.jpg");
			end.setArrow("right_red_arrow.jpg");
			end.setOpinion("你的申请被拒绝");

			endProcess.addTrace(end);
			processDao.update(endProcess);

			return ProcessStatus.Completed;
		}
	}

	private String handlerOpinion(Trace trace) {
		String opinion;
		if (RegexUtil.isEmpty(trace.getOrOpinion())
				&& RegexUtil.notEmpty(trace.getOpinion())) {
			opinion = trace.getApproval().getDes() + "," + trace.getOpinion();
		} else {
			if (RegexUtil.isEmpty(trace.getOpinion()))
				opinion = trace.getOrOpinion();
			else
				opinion = trace.getOrOpinion() + "<br/>"
						+ trace.getApproval().getDes() + ","
						+ trace.getOpinion();
		}

		return opinion;
	}
}