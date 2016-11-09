/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gdata.client.calendar.CalendarService;
import com.google.gdata.data.DateTime;
import com.google.gdata.data.PlainTextConstruct;
import com.google.gdata.data.calendar.CalendarEntry;
import com.google.gdata.data.calendar.CalendarEventEntry;
import com.google.gdata.data.calendar.CalendarFeed;
import com.google.gdata.data.extensions.When;
import com.google.gdata.util.AuthenticationException;
import com.google.gdata.util.ServiceException;
import com.google.gson.reflect.TypeToken;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;

/**
 * @description  google calendar 
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 27, 2013
 * @version 3.0
 */
@Controller
public class GoogleCalendarController {
	private Log log = LogFactory.getLog(getClass());
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private HandlerState str = HandlerState.FAILED;
	
	/**
	 * 登录Google
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/get_login_google.htm")
	public void getLoginGoogleAccount(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		String email = req.getParameter("email");
		String pwd = req.getParameter("pwd");
		
		try {
			out = res.getWriter();
			str = HandlerState.SUCCESS;
			if(RegexUtil.isEmpty(DateUtil.calendarService)) {
				if(RegexUtil.notEmpty(email) && RegexUtil.notEmpty(pwd)) {
					DateUtil.calendarService = DateUtil.createCalendarService(email, pwd);
				} else str = HandlerState.FAILED;
			}
		} catch (AuthenticationException e) {
			str = HandlerState.ERROR;
			log.error("/get_login_google.htm have a AuthenticationException!", e);
		} catch (IOException e) {
			str = HandlerState.ERROR;
			log.error("/get_login_google.htm have a IOException!", e);
		} finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			m.clear();
			if(out != null) {out.flush();out.close();}
		}
	}
	
	/**
	 * google calendar page
	 * @return to the page.
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/save_calendar.htm")
	public void saveCalendar(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		String st = req.getParameter("startTime");
		String et = req.getParameter("endTime");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		  
		CalendarService cs = DateUtil.calendarService;
		try {
			cs.createBatchRequest(new URL("https://www.google.com/accounts/ClientLogin"));
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		//<iframe width="640" height="360" src="http://www.youtube.com/embed/CEb3GQqdHD4?feature=player_detailpage" frameborder="0" allowfullscreen></iframe>
		
		String href = "";
		try {
			out = res.getWriter();
			
			CalendarEventEntry centry = new CalendarEventEntry();  
			
			//long millis = System.currentTimeMillis();  
			
			centry.setTitle(new PlainTextConstruct(title));  
			centry.setContent(new PlainTextConstruct(content));  
			
			if(RegexUtil.notEmpty(st) && RegexUtil.notEmpty(et)) {
				TimeZone timeZone = TimeZone.getDefault();  
				DateTime startTime = new DateTime(DateUtil.parseDateTime(st), timeZone);  
				DateTime endTime = new DateTime(DateUtil.parseDateTime(st), timeZone);  
				When eventTimes = new When();  
				eventTimes.setStartTime(startTime);  
				eventTimes.setEndTime(endTime);  
				centry.addTime(eventTimes);  
			}
			
			
			URL postUrl = new URL("https://www.google.com/calendar/feeds/sqegom@gmail.com/private/full");
			
			CalendarFeed resultFeed = DateUtil.calendarService.getFeed(postUrl, CalendarFeed.class);  
			  
			List<CalendarEntry> entries = resultFeed.getEntries();  
			for (CalendarEntry entry : entries) {  
			    System.out.println("Select > " + entry.getId() + ", " + entry.getTitle().getPlainText()); 
//			    try {  
//			        entry.delete();  
//			    } catch (InvalidEntryException e) {  
//			        e.printStackTrace();  
//			    } 
			}
			
			CalendarEventEntry eventEntry = DateUtil.calendarService.insert(postUrl, centry);
			
			href = eventEntry.getEditLink().getHref();  
			//res.sendRedirect(href);
			str = HandlerState.SUCCESS;
		} catch (MalformedURLException e) {
			str = HandlerState.ERROR;
			log.error("app/calendar.htm MalformedURLException", e);
		} catch (AuthenticationException e) {
			str = HandlerState.ERROR;
			log.error("app/calendar.htm AuthenticationException", e);
		} catch (IOException e) {
			str = HandlerState.ERROR;
			log.error("app/calendar.htm IOException", e);
		} catch (ServiceException e) {
			str = HandlerState.ERROR;
			log.error("app/calendar.htm ServiceException", e);
		} finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			m.clear();
			if(out != null) {out.flush();out.close();}
		}
		
		System.out.println("Edit URL: " + href);  
		
	}
}
