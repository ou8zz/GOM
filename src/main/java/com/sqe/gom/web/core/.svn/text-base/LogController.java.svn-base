/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.LogService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.model.Logs;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description 日志控制层.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 7, 2012  11:04:25 PM
 * @version 3.0
 */
@Controller
public class LogController {
	private Log log = LogFactory.getLog(LogController.class);
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private HandlerState str = HandlerState.FAILED;
	private LogService logService;

	@Autowired
	public void setLogService(LogService logService) {
		this.logService = logService;
	}

	//日志添加主页面
	@RequestMapping(method = RequestMethod.GET, value = "/admin/log_config.htm")
	public String addressPage() { return "admin/logs"; }
		
	/**
	 * 日志列表
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/get_logs.htm")
	public void getLogs(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<Logs> grid = new JGridHelper<Logs>();
		grid.jgridHandler(req, res, "l.");
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(logService.getLogs(grid), new TypeToken<JGridBase<Logs>>() {}.getType()));
		} catch (Exception e) {
			log.error("/app/get_logs.htm have a error!", e);
		} finally {
			if(out != null) {out.flush();out.close();}
			grid = null;
		}
	}
		
	/**
	 * 登录页面滚动日志列表
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/get_logs.htm")
	public void getAppLogs(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			m.put("logs", logService.getLogs(""));
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));	
		} catch (Exception e) {
			log.error("/get_logs.htm have a error!", e);
		} finally {
			m.clear();
			if(out != null) {out.flush();out.close();}
		}
	}
	
	/**
	 * 日志操作<添加，修改>
	 * @param addr
	 * @param result
	 * @param req
	 * @param res
	 * @param model
	 */
	@RequestMapping(method=RequestMethod.POST, value="/admin/save_log.htm")
	public void saveLog(@ModelAttribute("logs") Logs logs, BindingResult result, HttpServletRequest req, HttpServletResponse res){
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			if(logs.getMessage().length() >= 2000) str = HandlerState.INVALID;
			else {
				logService.saveLog(logs);
				str = HandlerState.SUCCESS;
			}
			m.put("logs", logs);
		} catch (IOException e) {
			str = HandlerState.ERROR;
			log.error("/app/save_log.htm have error!", e);
		}finally {
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
