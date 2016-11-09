/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.ProcessService;
import com.sqe.gom.app.UserService;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.ProcessType;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Leave;
import com.sqe.gom.model.Trace;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.util.TokenProcessor;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;
import com.sqe.gom.web.validation.LeaveValidator;

/**
 * @description leave BPM controller
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Sep 30, 2011 11:20:13 PM
 * @version 3.0
 */
@Controller
public class LeaveController {
	private Log log = LogFactory.getLog(LeaveController.class);
	private ProcessService processService;
	private UserService userService;
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private TokenProcessor tokens = TokenProcessor.getInstance();

	@Resource(name="processService")
	public void setProcessService(ProcessService processService) {
		this.processService = processService;
	}

	@Resource(name="userService")
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	//请假记录页面
	@RequestMapping(method=RequestMethod.GET, value="/app/leave_records.htm")
	public String leaveRecordPage() { return "app/leave_record"; }
	
	/**
	 * 待批请假页面
	 * @param model
	 * @return
	 */
	@RequestMapping(method=RequestMethod.GET, value="/app/approving_leaves.htm")
	public String setupDeparture(Model model) {
		model.addAttribute("leave",new Leave());
		return "app/leaves";
	}

	/**
	 * if user not inprogress leave test will entry leave page.
	 * 
	 * @param model initial an empty Leave entity
	 * @return initial of Leave entity.
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/app/leave.htm")
	public String leaveForm(Model model, HttpServletRequest req) {
		UserGroup user = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		Leave leave = processService.getLeave(user.getId(), ProcessStatus.InProgress);
		
		if(RegexUtil.isEmpty(leave)) {
			leave = new Leave();
			//查询所有部门
			model.addAttribute("departments", userService.getGroups(GroupType.DEPARTMENT, null));
			model.addAttribute("leave", leave);
			req.getSession().setAttribute("token", tokens.generateToken());
			return "app/leaveForm";
		} else {
			Trace trace = processService.getTrace(leave.getId(), ProcessType.LEAVE, ProcessStatus.Reserved, "Apply", user.getEname());
			if(RegexUtil.isEmpty(trace)) {
				model.addAttribute("leave", leave);
				model.addAttribute("traces",processService.getTraces(leave.getId(),ProcessType.LEAVE));
				return "app/leave";
			}else {
				UserGroup drt = userService.getUser(leave.getRecipient());
				UserGroup agt = userService.getUser(leave.getAgent());
				leave.setRecipientDpt(drt.getDptId());
				leave.setAgentDpt(String.valueOf(agt.getDptId()));
				model.addAttribute("dtr", drt);
				model.addAttribute("trace", trace);
				model.addAttribute("departments", userService.getGroups(GroupType.DEPARTMENT, null));
				model.addAttribute("leave", leave);
				req.getSession().setAttribute("token", tokens.generateToken());
				return "app/leaveForm";
			}
		}
	}
	
	/**
	 *  user apply return receipt
	 *  
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/app/get_leave.htm")
	public String receiptLeave(Model model, HttpServletRequest req, HttpServletResponse res) {
		UserGroup user = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		
		try {
			if(RegexUtil.notEmpty(user)){
				Leave leave = processService.getLeave(user.getId(), ProcessStatus.InProgress);
				
				if(RegexUtil.notEmpty(leave)) {
					model.addAttribute("leave", leave);
					model.addAttribute("traces",processService.getTraces(leave.getId(),ProcessType.LEAVE));
					model.addAttribute("agent",userService.getUser(leave.getAgent()));
					return "app/leave";
				}else {
					model.addAttribute("departments", userService.getGroups(GroupType.DEPARTMENT, null));
					model.addAttribute("leave", new Leave());
					return "app/leaveForm";
				}
			}else return null;
		} catch (Exception ex) {
			log.error("get user receipt leave have a error!", ex);
			return "app/index";
		}
	}

	/**
	 * start new leave task
	 * 
	 * @param leave  The leave form data been submit
	 * @param result  The error message
	 * @param req  The request of HTTP Servelt
	 * @param res  The response of HTTP Servelt
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/save_leave.htm")
	public void saveLeave(@ModelAttribute("leave")Leave leave,BindingResult result, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		HandlerState str = HandlerState.FAILED;

		try {
			out = res.getWriter();
			
			if(tokens.isTokenValue(req)) {
				// validate the model value.
				new LeaveValidator().validate(leave, result);
				if(result.hasErrors()) {
					str = HandlerState.PARAM_EMPTY;
				}else{
					UserGroup user = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
					if(null == user || "".equals(user)) str = HandlerState.PARAM_EMPTY;
					else {
						str = processService.startLeave(leave, user);
					}
				}
			}
		} catch (Exception ex) {
			str = HandlerState.ERROR;
			log.error("occurred an error when start leave BPM", ex);	
		}finally{
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			m.clear(); 
			if(out != null) {out.flush();out.close();}
		}
	}

	
	/**
	 * get lists of user leave tasks.
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(method=RequestMethod.GET, value="/app/get_leaves.htm")
	public void getLeaves(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<Leave> grid = new JGridHelper<Leave>();
		grid.jgridHandler(req, res, "l.");
		UserGroup user = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(processService.getLeaves(grid, user), new TypeToken<JGridBase<Leave>>() {}.getType(), JsonUtils.DEFAULT_DATE_PATTERN, false));
		} catch (Exception ex) {
			out.print("no no no no");
			log.error("get list of leave have an error occurred!", ex);
		}finally{
			grid = null;
			if(out!= null){out.flush();out.close();}
		}
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/app/save_receipt.htm")
	public void receiptStart(@ModelAttribute("leave") Leave leave, BindingResult result, HttpServletRequest req,HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		HandlerState str;
		
		try {
			out = res.getWriter();
			// validate the model value.
			new LeaveValidator().validate(leave, result);
			if(result.hasErrors()) {
				str = HandlerState.PARAM_EMPTY;
			}else{
				UserGroup user = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
				if(null == user || "".equals(user)) str = HandlerState.PARAM_EMPTY;
				else {
					leave.setUser(new GomUser(user.getId()));
					leave.setState(ProcessStatus.InProgress);
					//processService.restartLeaveProcess(leave, user, leave.getOpinion());
					str=HandlerState.SUCCESS;
				}	
			}
			out.write(str.name());
		}catch (Exception e) {
			out.write(HandlerState.ERROR.name());
			log.error("occurred an error when restart leave BPM", e);
			
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}

	/**
	 * The leave process of approve
	 * 
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/edit_leave.htm")
	public void updateLeave(@ModelAttribute("leave") Leave leave, BindingResult result, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();

			new LeaveValidator().validate(leave, result);
			if(result.hasErrors()) {
				m.put("result", HandlerState.PARAM_EMPTY);
			}else {
				UserGroup user = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
				m.put("result", processService.updateLeave(leave, user));
			}
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		}catch(Exception ex) {
			log.error("approvel user leave have a error!", ex);
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		} finally {
			m.clear();
			if(out != null){out.flush();out.close();}
		}
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/app/get_leave_record.htm")
	public void recordLeave(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<Leave> grid = new JGridHelper<Leave>();
		String pre = "l.";
		grid.jgridHandler(req, res, pre);
		try {
			out = res.getWriter();
			UserGroup user = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
			out.write(JsonUtils.toJson(processService.getLeaveRecord(user.getId(), grid), new TypeToken<JGridBase<Leave>>() {}.getType()));
		}catch(Exception ex) {
			log.error("get record list of leaves occurred a error!", ex);
		}finally{
			if(out != null) {out.flush();out.close();}
			grid = null;
		}
	}
}
