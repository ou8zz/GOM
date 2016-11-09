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
import com.sqe.gom.app.GomQueryService;
import com.sqe.gom.app.SummaryService;
import com.sqe.gom.constant.DateRange;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.constant.TaskType;
import com.sqe.gom.model.ReportConfig;
import com.sqe.gom.util.AjaxPageTag;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.UserGroup;

/**
 * @description 报表项目统计
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Controller
public class SummaryController {
	private Log log = LogFactory.getLog(SummaryController.class);
	private PrintWriter out;
	private SummaryService summaryService;
	private GomQueryService queryService;
	private Map<String, Object> m = new HashMap<String, Object>();
	
	@Autowired
	public void setSummaryService(SummaryService summaryService) {
		this.summaryService = summaryService;
	}
	@Autowired
	public void setQueryService(GomQueryService queryService) {
		this.queryService = queryService;
	}

	
	//预览页面
	@RequestMapping(method = RequestMethod.GET, value = "/app/summary.htm")
	public String getSummary() {return "app/summary";}
	
	/**
	 * 日报测试
	 * @param rc
	 * @param result
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/report.htm")
	public void getDaily(@ModelAttribute("rc")ReportConfig rc, BindingResult result, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		try {
			out = res.getWriter();
			int count = 0;
			if(DateRange.MORNING.equals(rc.getType())) {
				String ot = summaryService.sendMorningPaper(rc, ug).toString();
				out.write(ot);	
				return;
			}
			else if(DateRange.DAY.equals(rc.getType())) count = 1;
			else if(DateRange.WEEK.equals(rc.getType())) count = 7;
			else if(DateRange.MONTH.equals(rc.getType())) count = 30;
			else if(DateRange.QUARTER.equals(rc.getType())) count = 90;
			else if(DateRange.YEAR.equals(rc.getType())) count = 365;
			System.out.println("come in !!! ");
			summaryService.sendReport(rc, ug, count);
			out.write(HandlerState.SUCCESS.toString());	
		} catch (IOException e) {
			log.error("/report.htm have error!", e);
		}
	}
	
	/**
	 * 预览
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/get_summary.htm")
	public void getPlans(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String type = req.getParameter("type");
		String spid = req.getParameter("pid");
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		int pid = 1;
		try {
			out = res.getWriter();
			if(RegexUtil.notEmpty(spid)) pid = Integer.parseInt(spid);
			Page page = new Page(pid, 15);
			
			//出勤
			if("attendance".equals(type)) {
				String[] uids = req.getParameterValues("uids[]");
				if(RegexUtil.isEmpty(uids) || uids.length < 1) {
					uids = new String[]{ug.getId().toString()};
				}
				m.put("attendance", summaryService.getAttendance(uids));
			} 
			//计划
			else if("plan".equals(type)) {
				m.put("plan", queryService.getTasks(ug.getEname(), false, TaskType.PLAN, null, null, DateUtil.previous(7), DateUtil.previous(0), page));
				m.put("page", AjaxPageTag.getPageTag(page, pid, "dispose", "plan"));
			} 
			//需要做
			else if("doing".equals(type)) {
				m.put("plan", queryService.getTasks(ug.getEname(), false, null, ProcessStatus.InProgress, null, DateUtil.previous(7), DateUtil.previous(0), page));
				m.put("page", AjaxPageTag.getPageTag(page, pid, "dispose", "doing"));
			}
			//日报
			else if("daily".equals(type)) {
				m.put("plan", queryService.getTasks(ug.getEname(), false, null, ProcessStatus.Completed, null, DateUtil.previous(2), DateUtil.previous(-1), null));
				m.put("doing", queryService.getTasks(ug.getEname(), false, null, ProcessStatus.InProgress, null, DateUtil.previous(2), DateUtil.previous(-1), null));
				m.put("help", queryService.getTasks(ug.getEname(), true, null, null, null, DateUtil.previous(2), DateUtil.previous(0), null));
				m.put("resp", queryService.getResponsibility(ug.getId()));
				m.put("daytask", queryService.getTasks(ug.getEname(), false, null, null, DateRange.DAY, null, null, null));
			}
			//周报
			else if("weekly".equals(type)) {
				m.put("plan", queryService.getTasks(ug.getEname(), false, null, ProcessStatus.Completed, null, DateUtil.previous(7), DateUtil.previous(0), null));
				m.put("doing", queryService.getTasks(ug.getEname(), false, null, ProcessStatus.InProgress, null, DateUtil.previous(7), DateUtil.previous(0), null));
				m.put("help", queryService.getTasks(ug.getEname(), true, null, null, null, DateUtil.previous(7), DateUtil.previous(0), null));
				m.put("resp", queryService.getResponsibility(ug.getId()));
				m.put("meeting", queryService.getMeetings(null, DateUtil.previous(7), DateUtil.previous(-1)));
				m.put("imgs", summaryService.getReportImg(ug.getId(), DateRange.WEEK));
			}
			//月报
			else if("monthly".equals(type)) {
				m.put("plan", queryService.getTasks(ug.getEname(), false, null, ProcessStatus.Completed, null, DateUtil.previous(30), DateUtil.previous(0), null));
				m.put("doing", queryService.getTasks(ug.getEname(), false, null, ProcessStatus.InProgress, null, DateUtil.previous(30), DateUtil.previous(0), null));
				m.put("help", queryService.getTasks(ug.getEname(), true, null, null, null, DateUtil.previous(30), DateUtil.previous(0), null));
				m.put("resp", queryService.getResponsibility(ug.getId()));
				m.put("meeting", queryService.getMeetings(null, DateUtil.previous(30), DateUtil.previous(-1)));
				m.put("imgs", summaryService.getReportImg(ug.getId(), DateRange.DAY));
			}
			//管理责任
			else if("resp".equals(type)) {
				m.put("resp", queryService.getResponsibility(ug.getId()));
			}
			//登录
			else if("login".equals(type)) {
				m.put("login", queryService.getLogs(ug.getId(), DateUtil.previous(7), DateUtil.previous(-1)));
			} 
		} catch (Exception e) {
			m.put("result", HandlerState.ERROR);
			log.error("/app/get_summary.htm have error!", e);
		} finally {
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(), JsonUtils.DEFAULT_DATE_PATTERN, true));	
			if (out != null) {out.flush();out.close();}
			m.clear();
		}	
	}
	
}
