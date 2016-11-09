/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.ReportConfigService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.model.ReportConfig;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.UserGroup;

/**
 * @description 个人报表配置管理
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Controller
public class ReportConfigController {
	private Log log = LogFactory.getLog(ReportConfigController.class);
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private ReportConfigService reportConfigService;
	
	@Autowired	
	public void setReportConfigService(ReportConfigService reportConfigService) {
		this.reportConfigService = reportConfigService;
	}

	//主页面
	@RequestMapping(method = RequestMethod.GET, value = "/app/report_config.htm")
	public String getAssetsAdmin(Model model, HttpServletRequest req) {
		UserGroup user = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		ReportConfig rc = reportConfigService.getReportConfig(null, user.getId());
		if(RegexUtil.isEmpty(rc)) rc = new ReportConfig();
		model.addAttribute("rc", rc);
		return "app/report_config";
	}
	
	/**
	 * 根据类型Ajax返回reportConfig
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/get_report_config.htm")
	public void editResource(HttpServletRequest req, HttpServletResponse res){
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String type = req.getParameter("type");
		try {
			out = res.getWriter();
			UserGroup user = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
			ReportConfig rc = reportConfigService.getReportConfig(type, user.getId());
			out.write(JsonUtils.toJson(rc, new TypeToken<ReportConfig>() {}.getType(), true));
		} catch (Exception e) {
			log.error("/app/get_report_config.htm have error!", e);
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
		}	
	}
	
	/**
	 * 配置
	 * @param rc
	 * @param result
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/save_report_config.htm")
	public void editResource(@ModelAttribute("reportConfig") ReportConfig rc, BindingResult result, HttpServletRequest req, HttpServletResponse res){
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
			rc.setUserId(ug.getId());
			reportConfigService.saveReportConfig(rc);
			m.put("id", rc.getId());
			m.put("reslut", HandlerState.SUCCESS);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		} catch (Exception e) {
			out.write(JsonUtils.toJson(HandlerState.ERROR));
			log.error("/app/save_report_config.htm have error!", e);
		}finally {
			m.clear();
			if (out != null) {
				out.flush();
				out.close();
			}
		}	
	}
}
