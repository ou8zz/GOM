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

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.HolidaysService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Holidays;
import com.sqe.gom.model.Lieu;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;
import com.sqe.gom.web.validation.HolidaysValidator;
import com.sqe.gom.web.validation.LieuValidator;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 8, 2012
 * @version 3.0
 */
@Controller
public class HolidaysController {
	private Log log = LogFactory.getLog(HolidaysController.class);
	private HolidaysService holidaysService;
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private HandlerState str = HandlerState.FAILED;
	
	@Resource(name = "holidaysService")
	public void setHolidaysService(HolidaysService holidaysService) {
		this.holidaysService = holidaysService;
	}
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(df,false));
	}
	
	//节假日配置页面
	@RequestMapping(method=RequestMethod.GET, value="/admin/holiday_config.htm")
	public String holidaysPage(Model model) {
		model.addAttribute("holidays", new Holidays());
		return "app/holidays"; 
	}
	
	//调休页面
	@RequestMapping(method=RequestMethod.GET, value="/app/leave_lieu.htm")
	public String lieuPage() { return "app/lieu"; }
	
	/**
	 * 获得节假日列表
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.GET, value="/admin/get_holidays.htm")
	public void getHolidays(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<Holidays> grid = new JGridHelper<Holidays>();
		grid.jgridHandler(req, res, "h.");
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(holidaysService.getHolidays(grid), new TypeToken<JGridBase<Holidays>>() {}.getType(), JsonUtils.SHORT_DATE_PATTERN, true));
		} catch (Exception e) {
			log.error("/app/holidays.htm have a error!", e);
		} finally {
			if(out != null) {out.flush();out.close();}
			grid = null;
		}
	}
	
	/**
	 * 节假日
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.GET, value="/get_holidays.htm")
	public void getHolidays(HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(holidaysService.getHolidays(""), new TypeToken<List<Holidays>>() {}.getType(), true));	
		} catch (Exception e) {
			log.error("/get_holidays.htm have a error!", e);
		} finally {
			if(out != null) {out.flush();out.close();}
		}
	}
	
	/**
	 * 保存节假日
	 * @param holidays
	 * @param reslut
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/admin/save_holidays.htm")
	public void saveHolidays(@ModelAttribute("holidays") Holidays holidays, BindingResult result, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			new HolidaysValidator().validate(holidays, result);
			if(result.hasErrors()) str = HandlerState.PARAM_EMPTY;
			else {
				holidaysService.saveHolidays(holidays);
				m.put("holidays", holidays);
				str = HandlerState.SUCCESS;
			}
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(), JsonUtils.SHORT_DATE_PATTERN, true));	
		} catch (Exception e) {
			log.error("/app/save_holidays.htm have a error!", e);
		} finally {
			if(out != null) {out.flush();out.close();}
		}
	}
	
	
	
	/**
	 * 获得调休列表
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.GET, value="/app/get_lieus.htm")
	public void getLieus(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<Lieu> grid = new JGridHelper<Lieu>();
		grid.jgridHandler(req, res, "l.");
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(holidaysService.getLieu(grid, ug.getId()), new TypeToken<JGridBase<Lieu>>() {}.getType(), JsonUtils.SHORT_DATE_PATTERN, true));
		} catch (Exception e) {
			log.error("/app/holidays.htm have a error!", e);
		} finally {
			if(out != null) {out.flush();out.close();}
			grid = null;
		}
	}

	/**
	 * 保存调休
	 * @param holidays
	 * @param reslut
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/save_lieu.htm")
	public void saveLieu(@ModelAttribute("lieu") Lieu lieu, BindingResult result, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		
		try {
			out = res.getWriter();
			new LieuValidator().validate(lieu, result);
			if(result.hasErrors()) str = HandlerState.PARAM_EMPTY;
			else {
				lieu.setUser(new GomUser(ug.getId()));
				holidaysService.saveLieu(lieu);
				str = HandlerState.SUCCESS;
				m.put("lieu", lieu);
			}
		} catch (Exception e) {
			log.error("/app/save_lieu.htm have a error!", e);
			str = HandlerState.ERROR;
		} finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(), JsonUtils.SHORT_DATE_PATTERN, true));	
			if(out != null) {out.flush();out.close();}
			m.clear();
		}
	}
	
}
