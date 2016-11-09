/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.MeetingService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.model.Logs;
import com.sqe.gom.model.Meeting;
import com.sqe.gom.util.AjaxPageTag;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;
import com.sqe.gom.web.validation.MeetingValidator;

/**
 * @description	会议
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Oct 20, 2012
 * @version 3.0
 */
@Controller
public class MeetingController {
	private Log log = LogFactory.getLog(MeetingController.class);
	private MeetingService meetingService;
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private HandlerState str = HandlerState.FAILED;
	
	@Autowired
	public void setMeetingService(MeetingService meetingService) {
		this.meetingService = meetingService;
	}

	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(df,false));
	}
	
	//会议记录主页面
	@RequestMapping(method=RequestMethod.GET, value = "/app/meeting.htm")
	public String getMeetingPage() {return "app/meeting";}
	
	/**
	 * 得到会议记录
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.GET, value = "/app/get_meetings.htm")
	public void getMeeting(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String spid = req.getParameter("pid");
		PrintWriter writer = null;
		int pid = 1;
		try {
			writer = res.getWriter();
			if(RegexUtil.notEmpty(spid)) pid = Integer.parseInt(spid);
			
			Page page = new Page(pid,10);
			List<Meeting> list = meetingService.getMettings("", page);
			
			String spage = AjaxPageTag.getPageTag(page, pid, "dispose", "meeting");
			
			m.put("list", list);
			m.put("page", spage);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(), JsonUtils.DEFAULT_DATE_PATTERN, true));	
		} catch (Exception e) {
			log.error("get_meetings.htm have a error!", e);
		} finally {
			if (writer != null) {writer.flush();writer.close();}
		}
	}
	
	@RequestMapping(method=RequestMethod.GET, value = "/app/get_meeting.htm")
	public void getMeetings(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<Meeting> grid = new JGridHelper<Meeting>();
		grid.jgridHandler(req, res, "m.");
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(meetingService.getMettings(grid),new TypeToken<JGridBase<Meeting>>() {}.getType(),true));
		} catch (Exception e) {
			log.error("get_meeting.htm have a error!", e);
		} finally {
			if (out != null) {out.flush();out.close();}
			grid = null;
		}
	}
	
	@RequestMapping(method=RequestMethod.POST, value = "/app/save_meeting.htm")
	public void saveMeeting(@ModelAttribute("meeting") Meeting meeting, BindingResult result, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			if(new MeetingValidator().validate(meeting)) {
				str = meetingService.saveMeeting(meeting);
				
				UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
				Logs lf = new Logs();
				lf.setUserId(ug.getId());
				lf.setDated(new Date());
				if(RegexUtil.notEmpty(meeting)) {
					lf.setLogger("会议报告");
					lf.setMessage("于" + DateUtil.formatDate(meeting.getTime()) + " 参加  " + meeting.getTitle() + " 会议报告， 参会人员包括  " + meeting.getParticipants());
					log.debug(JsonUtils.toJson(lf));
				}
				else {
					lf.setLogger("会议通知");
					lf.setMessage("请" + DateUtil.formatDateTime(meeting.getTime()) + " 于  " + meeting.getLocale()+" 参加  " + meeting.getTitle()+ " 通知 " + meeting.getParticipants() + " 参加会议");
					log.debug(JsonUtils.toJson(lf));
				}
			}
			else str = HandlerState.PARAM_EMPTY;
		} catch (Exception e) {
			str = HandlerState.ERROR;
			log.error("/app/save_meeting.htm have a error!", e);
		} finally {
			m.put("result", str);
			m.put("meeting", meeting);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(), true));	
			m.clear();
			if (out != null) { out.flush(); out.close(); }
		}	
	}
}
