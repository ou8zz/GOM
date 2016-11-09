/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.IOException;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.ProcessService;
import com.sqe.gom.app.UserService;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.ProcessType;
import com.sqe.gom.model.ProcessInfo;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;


/**
 * @description
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jun 19, 2012  8:45:07 PM
 * @version 3.0
 */
@Controller
public class ProcessController {
	private Log log = LogFactory.getLog(ProcessController.class);
	private Map<String, Object> m = new HashMap<String, Object>();
	private ProcessService processService;
	private UserService userService;
	private PrintWriter out;
	
	@Resource(name="processService")
	public void setProcessService(ProcessService processService) {
		this.processService = processService;
	}
	
	@Resource(name="userService")
	public void setUserService(UserService userSerivce) {
		this.userService = userSerivce;
	}
	
	@RequestMapping(method=RequestMethod.GET, value="/admin/process_config.htm")
	public String setupProcess(Model model) {
		model.addAttribute("dpts", userService.getGroups(GroupType.DEPARTMENT, null));
		model.addAttribute("ptns", userService.getGroups(GroupType.POSITION, null));
		ProcessInfo process = new ProcessInfo();
		model.addAttribute("process", process);
		return "admin/process";
	}
	
	/**
	 * entry list of leaves.
	 * 
	 * @param req  The HTTP request
	 * @return   list of leaves.
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/app/get_user.htm")
	public void getUser(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		String name = req.getParameter("name");
		
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(userService.login(name, null),new TypeToken<UserGroup>() {}.getType()));
		} catch (Exception ex) {
			log.error("get login user have a error!", ex);
		} finally {
			if(out != null) {out.flush();out.close();}
		}
	}
	
	/**
	 * save or update process entity
	 */
	@RequestMapping(method=RequestMethod.POST, value="/admin/save_process.htm")
	public void saveProcess(@ModelAttribute("process") ProcessInfo process, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		try {
			out = res.getWriter();
			if(RegexUtil.isEmpty(process.getAssignType()) || RegexUtil.isEmpty(process.getNodeCode()) || RegexUtil.isEmpty(process.getNodeName()) || RegexUtil.isEmpty(process.getProcess()))
				m.put("result", HandlerState.PARAM_EMPTY);
			else {
				HandlerState hs = processService.saveProcessInfo(process);
				if(hs == HandlerState.SUCCESS) {
					m.put("process", processService.getProcessInfo(ProcessType.valueOf(process.getProcess()), process.getNodeCode()));
				}
				m.put("result", hs);
			}
			
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String, Object>>() {}.getType(),true));
		}catch(IOException ex) {
			log.error("have an error when save process", ex);
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		}finally{
			if(out != null){out.flush(); out.close();}
			m.clear();
		}
	}
	
	/**
	 *query process by type
	 */
	@RequestMapping(method=RequestMethod.GET, value="/admin/get_processes.htm")
	public void getProcess(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<ProcessInfo> grid = new JGridHelper<ProcessInfo>();
		grid.jgridHandler(req, res, "p.");
		
		try {
			out = res.getWriter();
			
			String type = req.getParameter("type");
			
			if(RegexUtil.notEmpty(type)) {
				out.write(JsonUtils.toJson(processService.getProcesses(ProcessType.valueOf(type), grid),new TypeToken<JGridBase<ProcessInfo>>() {}.getType()));
			}
		} catch (Exception e) {
			log.error("/admin/get_processes.htm have an error!", e);
		} finally {
			if(out != null) {out.flush();out.close();}
			grid = null;
		}
	}
}
