/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;

import com.sqe.gom.constant.ApprovalStatus;
import com.sqe.gom.constant.EmployeeCate;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.ProcessType;
import com.sqe.gom.exception.GomException;
import com.sqe.gom.model.Abnormal;
import com.sqe.gom.model.Departure;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Leave;
import com.sqe.gom.model.ProcessInfo;
import com.sqe.gom.model.Task;
import com.sqe.gom.model.Trace;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description  Interface of leave BPM that implement start new process, get task by user ename
 *               and completing a user task. That detail lookup the method annotation please.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 20, 2011, 10:29:08 AM
 * @version 3.0
 */
@Transactional
public interface ProcessService {
	/**
	 * To start a leave BPM process
	 * 
	 * @param params  all the process parameters.
	 * @param users  all the relation user.
	 * @return this process instance id
	 */
	@PreAuthorize("hasRole('User')")
	HandlerState startLeave(Leave leave, UserGroup user) throws GomException;
	
	/**
	 * get list of leaves that wrapped by jqGrid
	 * @param grid  The list of leaves wrapper
	 * @param user The logined user
	 * @return  list of jqGrid leaves
	 */
	@PreAuthorize("hasRole('User') and hasRole('Employee') or hasRole('Assistant') or hasRole('Director') or hasRole('Manager')")
	JGridBase<Leave> getLeaves(JGridHelper<Leave> grid, UserGroup user);
	
	/**
	 * get current node instance.
	 * 
	 * @param processInstanceId   the process instance id
	 * @return  name of node
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	JGridBase<Leave> getLeaveRecord(Integer userId, JGridHelper<Leave> grid);
	
	/**
	 * get leave entity by userId and processStatus
	 * 
	 * @param uid   The identify of user
	 * @param state  The state of process
	 * @return result of leave
	 */
	@PreAuthorize("hasRole('User')")
	Leave getLeave(Integer uid, ProcessStatus state);
	
	/**
	 * The task will completing by userId
	 * 
	 * @param l
	 * @param userId
	 * @throws InterruptedException
	 * 
	 * @return result of process trace.
	 */
	@PreAuthorize("hasRole('User') and hasRole('Employee') or hasRole('Assistant') or hasRole('Director') or hasRole('Manager')")
	HandlerState updateLeave(Leave leave, UserGroup user) throws GomException;
	
	/**
	 * to start entry process
	 * 
	 * @param params  The parameters of this process
	 * @param users  The users relation to this process
	 * @return   processId
	 * @throws InterruptedException
	 */
	HandlerState startEntrant(GomUser regUser) throws GomException;
	
	/**
	 * get list of register that from entry process
	 * @param userId  The ENAME property of user entity.
	 * @return  list of registers
	 * @throws InterruptedException
	 */
	@PreAuthorize("hasRole('User')")
	JGridBase<GomUser> getEntrants(String actor, JGridHelper<GomUser> grid);
	
	/**
	 * A entry task will completing by userId
	 * 
	 * @param reg  The entry new user information wrapped  
	 * @param userId  The approval this process HR or Admin
	 * @throws InterruptedException
	 */
	@PreAuthorize("hasRole('User') and hasRole('Employee') or hasRole('Assistant') or hasRole('Director') or hasRole('Manager')")
	HandlerState updateEntrant(GomUser entrant, UserGroup user);
	
	/**
	 * start new departure process service
	 * @param dep  The entity of departure
	 * @param user The login user
	 * @return enum of handlerState
	 */
	@PreAuthorize("hasRole('User')")
	HandlerState startDeparture(Departure dep, UserGroup user);
	
	/**
	 * query all will been check departure process.
	 * 
	 * @param actor  The actor of this node of process
	 * @param grid   The jQGrid plugin initial.
	 * @return  list of jqGrid
	 */
	@PreAuthorize("hasRole('User') or hasRole('Manager') or hasRole('Director') or hasRole('Assistant') or hasRole('CEO')")
	JGridBase<Departure> getDepartures(String actor, JGridHelper<Departure> grid);
	
	/**
	 * update departure that been edited.
	 * 
	 * @param dep  The entity of departure.
	 * @param user The login user
	 * @return Enum of handlerState
	 */
	@PreAuthorize("hasRole('User')")
	HandlerState updateDeparture(Departure dep, UserGroup user);
	
	@PreAuthorize("hasRole('User')")
	Departure getDeparture(Integer userId, ProcessStatus state);
	
	@PreAuthorize("hasRole('User')")
	Departure getDepartureTrace(String actor);
	
	/****************************************Start 工作任务******************************************************/
	/**
	 * 查询所有工作任务
	 * @param grid		grid前台jQuery对象
	 * @param ename		用户ename
	 * @param help		是否需要帮忙，true为需要，false为不需要
	 * @param taskType	工作类型
	 * @param state		工作状态
	 * @param role		查询角色 如：工作任务,工作命令，工作安排;由前台参数传入
	 * @return			JGridBase<Task>
	 */
	@PreAuthorize("hasRole('User')")
	JGridBase<Task> getTasks(JGridHelper<Task> grid, String ename, Boolean help, String taskType, String state, String role);
	
	/**
	 * 添加或修改工作任务
	 * @param task
	 */
	@PreAuthorize("hasRole('User')")
	void startTask(Task task, String ename);
	
	/**
	 * 添加或修改任务进度、
	 * @param ename
	 * @param trace
	 */
	@PreAuthorize("hasRole('User')")
	void taskTrace(String ename, Trace trace);
	
	/**
	 * 设置工作点击计时 ：工作开始和结束时间
	 * @param id	工作ID
	 * @param b		false为开始工作时间 ，true为结束工作时间 
	 * @return 		执行完成或错误
	 */
	@PreAuthorize("hasRole('User')")
	HandlerState editTaskTime(int id, boolean b);
	
	/**
	 * 改变一条工作任务的状态
	 * @param 根据id
	 */
	@PreAuthorize("hasRole('User')")
	void abolishTask(int id, ProcessStatus state);
	/*******************************************END 工作安排*********************************************/
	
	
	
	
	
	/** 日报退出异常流程----------------------------START-------------------------------- */
	
	/**
	 * 异常流程列表
	 * @param grid
	 * @param user
	 * @param sh
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	JGridBase<Abnormal> getAbnormals(JGridHelper<Abnormal> grid, String user, String sh);
	
	/**
	 * 异常流程处理
	 * @param abnormal
	 * @param user
	 */
	@PreAuthorize("hasRole('User')")
	HandlerState saveAbnormal(Abnormal abnormal, UserGroup user);
	
	/**
	 * 流程审核
	 * @param ids
	 * @param traceIds
	 * @param status
	 * @param user
	 */
	@PreAuthorize("hasRole('User')")
	HandlerState updateAbnormals(String[] ids, String[] traceIds, ApprovalStatus status, UserGroup user);
	
	/** 日报退出异常流程----------------------------END-------------------------------- */
	
	
	
	
	
	/**
	 * get list of process trace
	 * 
	 * @param processId  The identify process ID
	 * @param type  The process type
	 * @return  list of process trace
	 */
	@PreAuthorize("hasRole('User')")
	List<Trace> getTraces(Integer processId, ProcessType type);
	
	/**
	 * query trace by processId, processType, processStatus and node
	 * 
	 * @param processId  The identify of process
	 * @param type  The type of process
	 * @param state  The state of process
	 * @param node The name of node
	 * @return The result of query trace
	 */
	@PreAuthorize("hasRole('User')")
	Trace getTrace(Integer processId, ProcessType type, ProcessStatus state, String nodeCode, String actor);
	
	/**
	 * number of emplyee type days
	 * @param type
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	int getEmployeeDay(EmployeeCate type);
	
	/**
	 * 保存流程操作信息
	 * @param process
	 * @return HandlerState 成功或失败
	 */
	@PreAuthorize("hasRole('Admin')")
	HandlerState saveProcessInfo(ProcessInfo process);
	
	/**
	 * 后台查询所有流程
	 * @param type	LEAVE("请假流程"), TASK("工作流程"), ENTRY("入职流程"), DEPARTURE("离职流程"), ABNORMAL("异常流程");
	 * @param grid	jQuery Grid对象
	 * @return
	 */
	@PreAuthorize("hasRole('Admin')")
	JGridBase<ProcessInfo> getProcesses(ProcessType type, JGridHelper<ProcessInfo> grid);
	
	/**
	 * 根据流程类型和节点获得流程对象
	 * @param type LEAVE("请假流程"), TASK("工作流程"), ENTRY("入职流程"), DEPARTURE("离职流程"), ABNORMAL("异常流程");
	 * @param nodeCode ProcessInfo.nodeCode字段
	 * @return
	 */
	@PreAuthorize("hasRole('Admin')")
	ProcessInfo getProcessInfo(ProcessType type, String nodeCode);
}