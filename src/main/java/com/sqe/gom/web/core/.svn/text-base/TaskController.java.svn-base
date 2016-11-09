/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.ProcessService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.ProcessType;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.constant.TaskType;
import com.sqe.gom.model.Task;
import com.sqe.gom.model.Trace;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;
import com.sqe.gom.web.validation.TaskValidator;

/**
 * @description 工作管理
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 5, 2012
 * @version 3.0
 */
@Controller
public class TaskController {
	private Log log = LogFactory.getLog(TaskController.class);
	private ProcessService processService;
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private HandlerState str = HandlerState.FAILED;
	
	@Autowired
	public void setProcessService(ProcessService processService) {
		this.processService = processService;
	}

	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(df, false));
	}
	
	
	/**工作任务页面*/
	@PreAuthorize("hasRole('Manager') or hasRole('Director') or hasRole('Assistant')")
	@RequestMapping(method=RequestMethod.GET, value="/app/add_task.htm")
	public String getTaskPage() { return "app/task"; }
	
	/**我的工作任务页面*/
	@RequestMapping(method=RequestMethod.GET, value="/app/my_task.htm")
	public String getMyTaskPage() { return "app/my_task"; }
	
	/**工作命令页面*/
	@PreAuthorize("hasRole('Manager') or hasRole('Director') or hasRole('Assistant')")
	@RequestMapping(method=RequestMethod.GET, value="/app/order_task.htm")
	public String getOrderTaskPage() { return "app/order_task"; }
	
	/**追踪执行页面*/
	@PreAuthorize("hasRole('Manager') or hasRole('Director') or hasRole('Assistant')")
	@RequestMapping(method=RequestMethod.GET, value="/app/track_task.htm")
	public String getApprovalTaskPage() { return "app/approval_task"; }
	
	/**需要帮忙页面*/
	@RequestMapping(method=RequestMethod.GET, value="/app/needing_help.htm")
	public String getNeedHelpPage() { return "app/need_help"; }
	
	/**
	 * ajax展现所有的工作安排app
	 */
	@RequestMapping(method=RequestMethod.GET, value="/app/get_tasks.htm")
	public void getTasks(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<Task> grid = new JGridHelper<Task>();
		grid.jgridHandler(req, res, "p.");
		
		PrintWriter pw = null;
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		String role = req.getParameter("role");
		String taskType = req.getParameter("taskType");
		String state = req.getParameter("state");
		String help = req.getParameter("help");
		
		try {
			pw = res.getWriter();
			JGridBase<Task> list = processService.getTasks(grid, ug.getEname(), Boolean.valueOf(help), taskType, state, role);
			pw.write(JsonUtils.toJson(list, new TypeToken<JGridBase<Task>>() {}.getType(), true));
		} catch (Exception e) {
			log.error("get_tasks.htm have a error!", e);
		} finally {
			if (pw != null) { pw.flush(); pw.close(); }
			grid = null;
		}
	}
	
	/**
	 * 保存新建或编辑的 工作任务
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/save_task.htm")
	public void saveTask(@ModelAttribute("task") Task task, BindingResult result, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		try {
			out = res.getWriter();
			new TaskValidator().validate(task, result);
			if(result.hasErrors()) {
				str = HandlerState.PARAM_EMPTY;
			} else {
				UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
				if(TaskType.TEMPORARY.equals(task.getTaskType()) && RegexUtil.isEmpty(task.getExecutor())){task.setExecutor(ug.getEname());}
				processService.startTask(task, ug.getEname());
				m.put("task", task);
				str = HandlerState.SUCCESS;
			}
		}catch(Exception e) {
			log.error("app/save_task.htm have an error!", e);
			str = HandlerState.ERROR;
		} finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(), JsonUtils.SHORT_DATE_PATTERN, true));
			m.clear();
			if(out != null){out.flush();out.close();}
		}
	}
	
	/**
	 * 工作进度 显示
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/get_taskTrace.htm")
	public void getTaskTrace(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String processId = req.getParameter("processId");
		try {
			out = res.getWriter();
			if(RegexUtil.notEmpty(processId)) {
				m.put("ts", processService.getTraces(Integer.parseInt(processId),ProcessType.TASK));
				str = HandlerState.SUCCESS;
			}
		} catch (Exception e) {
			log.error("get_taskTrace.htm have a error!", e);
			str = HandlerState.ERROR;
		} finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			m.clear();
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
	/**
	 * 工作进度<编辑>
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/save_taskTrace.htm")
	public void saveTaskTrace(@ModelAttribute("tasktrace") Trace trace, BindingResult result, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		
		try {
			out = res.getWriter();
			processService.taskTrace(ug.getEname(), trace); 
			str = HandlerState.SUCCESS;
		} catch (Exception e) {
			log.error("save_taskTrace.htm have a error!", e);
			str = HandlerState.ERROR;
		} finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			m.clear();
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
	/**
	 *	工作开始和结束out
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/edit_time.htm")
	public void editTaskTime(@RequestParam("processId") Integer processId, @RequestParam("state") String state, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			if(state.equals("start")) str = processService.editTaskTime(processId, false);
			else str = processService.editTaskTime(processId, true);
		} catch (Exception e) {
			log.error("edit_time.htm have a error!", e);
			str = HandlerState.ERROR;
		} finally {
			out.write(JsonUtils.toJson(str));
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
	/**
	 * 废除工作任务
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/abolish_task.htm")
	public void abolishTask(@RequestParam("id")Integer id, @RequestParam("state")ProcessStatus state, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			System.out.println("id = " + id + " -- state = " + state);
			processService.abolishTask(id, state);
			str = HandlerState.SUCCESS;
		} catch (Exception e) {
			log.error("/app/abolish_task.htm have a error!", e);
			str = HandlerState.ERROR;
		} finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			m.clear();
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
}