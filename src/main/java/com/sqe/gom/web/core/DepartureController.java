/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Collections;
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
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
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
import com.sqe.gom.model.Departure;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.model.Trace;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.util.TokenProcessor;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;
import com.sqe.gom.web.validation.DepartureValidator;

/**
 * @description 离职界面转发控制类
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 5, 2012
 * @version 3.0
 */
@Controller
public class DepartureController {
	private Log log = LogFactory.getLog(DepartureController.class);
	private ProcessService processService;
	private UserService userService;
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private TokenProcessor tokens = TokenProcessor.getInstance();
	
	@Resource(name="userService")
	public void setUserService(UserService userSerivce) {
		this.userService = userSerivce;
	}
	
	@Resource(name="processService")
	public void setProcessService(ProcessService processService) {
		this.processService = processService;
	}
	
	@ModelAttribute("departments")
    public Collection<GomGroup> getDepartments() {
        return userService.getGroups(GroupType.DEPARTMENT, null);
    }
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(df,false));
	}
	
	/**
	 * 进入离职审核页面
	 * @param model
	 * @return
	 */
	@RequestMapping(method=RequestMethod.GET, value="/app/check_departure.htm")
	public String setupDeparture(Model model) {
		Departure dep = new Departure();
		model.addAttribute("dep",dep);
		return "app/departures";
	}
	
	/**
	 * 查询离职申请反馈
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping(method=RequestMethod.GET, value="/app/receipt_departure.htm")
	public String departureTrace(Model model,HttpServletRequest req) {
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		Departure dep = processService.getDeparture(ug.getId(), ProcessStatus.InProgress);
		
		model.addAttribute("dep", dep);
		if(RegexUtil.notEmpty(dep)) {
			model.addAttribute("traces", processService.getTraces(dep.getId(), ProcessType.DEPARTURE));
			log.debug("departure process is in progressing");
		}
		
		return "app/receipt_departure";
	}
	
	/**
	 * 进入用户离职申请
	 */
	@RequestMapping(method=RequestMethod.GET, value="/app/departure.htm")
	public String getDeparture(Model model, HttpServletRequest req, HttpServletResponse res) {
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		
		//查询用户是否存有效的离职记录
		Departure departure = processService.getDeparture(ug.getId(), ProcessStatus.InProgress);
		
		//查询离职申请的直接主管
		UserGroup dtr;
		if(ug.getPosition().equals("Director")) dtr = userService.getUserAndPosition("Manager", ug.getDepartment());
		else if(ug.getPosition().equals("Manager")) dtr = userService.getUserAndPosition("Assistant", "Administration");
		else dtr = userService.getUserAndPosition("Director", ug.getDepartment());
		//查询所有部门
		List<GomGroup> departments = userService.getGroups(GroupType.DEPARTMENT, null);
		
		model.addAttribute("dtr", dtr);
		model.addAttribute("departments", departments);
		
		//当前不存在有效离职记录，则用户可申请离职
		if(RegexUtil.isEmpty(departure)) {
			model.addAttribute("dep", new Departure());
			model.addAttribute("pdays", processService.getEmployeeDay(ug.getType()));
			req.getSession().setAttribute("token", tokens.generateToken());
			return "app/departure";
		}else {
			Departure dep = processService.getDepartureTrace(ug.getEname());
			//流程运行至非当前节点
			if(RegexUtil.isEmpty(dep)) {
				model.addAttribute("dep", departure);
				model.addAttribute("traces", processService.getTraces(departure.getId(), ProcessType.DEPARTURE));
				log.debug("departure process is in progressing");
				return "app/receipt_departure";
			}else {
				model.addAttribute("msg", "你的申请已被驳回，请重新提交！");
				model.addAttribute("dep", dep);
				model.addAttribute("pdays", processService.getEmployeeDay(ug.getType()));
				req.getSession().setAttribute("token", tokens.generateToken());
				return "app/departure";
			}
		}
	}
	
	/**
	 * 离职单 <添加,修改>
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/save_departure.htm")
	public String saveDeparture(@ModelAttribute("dep") Departure dep, ModelMap model, HttpServletRequest req) {
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		if(!tokens.isTokenValue(req)) {
			return "redirect:/app/departure.htm";
		}
		
		if(RegexUtil.notEmpty(dep.getReason()) && RegexUtil.notEmpty(ug)) {
			if(RegexUtil.notEmpty(dep.getId()) && dep.getId() > 0 && RegexUtil.notEmpty(dep.getUserId()) && dep.getUserId() > 0) {
				HandlerState hs = processService.updateDeparture(dep, ug);
				if(hs.equals(HandlerState.SUCCESS)) model.addAttribute("error", "重新提交离职申请成功，请待回复！");
				else model.addAttribute("error", "再次提交申请失败，请稍后再试！");
			}else {
				//申请离职
				dep.setSalaryDate(null);
				processService.startDeparture(dep, ug);
				dep.setUserDpt(ug.getCdepartment());
				dep.setUserPst(ug.getCposition());
				dep.setCname(ug.getCname());
				dep.setEname(ug.getEname());
				model.addAttribute("error", "离职申请成功，请待回复！");
			}
			
			model.addAttribute("dep", dep);
			model.addAttribute("traces", processService.getTraces(ug.getId(), ProcessType.DEPARTURE));
			return "app/get_departure";	
		}else {
			dep = new Departure();
			dep.setUserDpt(ug.getCdepartment());
			dep.setUserPst(ug.getCposition());
			dep.setCname(ug.getCname());
			dep.setEname(ug.getEname());
			
			model.addAttribute("dtr", dep);
			model.addAttribute("pdays", processService.getEmployeeDay(ug.getType()));
			model.addAttribute("error", "离职申请失败，请重新申请！");
			req.getSession().setAttribute("token", tokens.generateToken());
			return "app/departure";
		}
	}
	
	/**
	 *查询所有待审核人员的离职信息
	 */
	@RequestMapping(method=RequestMethod.GET, value="/app/get_departures.htm")
	public void getDepartures(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<Departure> grid = new JGridHelper<Departure>();
		grid.jgridHandler(req, res, "d.");
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		try {
			out = res.getWriter();
			
			if(RegexUtil.notEmpty(ug)) {
				out.write(JsonUtils.toJson(processService.getDepartures(ug.getEname(), grid),new TypeToken<JGridBase<Departure>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN,false));
			}
		}catch(Exception e) {
			log.error("get list of departures have an error!", e);
		}finally{if(out != null){out.flush();out.close();}grid = null;}
	}
	
	
	/**
	 * 离职进度 显示
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/get_departure_traces.htm")
	public void getTasks(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		String processId = req.getParameter("processId");
		String type = req.getParameter("type");
		
		List<Trace> list = Collections.emptyList();;
		try {
			out = res.getWriter();
			if(RegexUtil.notEmpty(processId) && RegexUtil.notEmpty(type)) {
				list = processService.getTraces(Integer.parseInt(processId), ProcessType.valueOf(type));
			}
			m.put("traces", list);
			m.put("result", HandlerState.SUCCESS);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(), JsonUtils.DEFAULT_DATE_PATTERN, false));
		}catch (Exception e) {
			log.error("get list of departure trace have a error!", e);
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(), JsonUtils.DEFAULT_DATE_PATTERN, false));
		}finally {
			m.clear();
			if(out != null) {out.flush();out.close();}
		}
	}
	
	/**
	 * 离职审核流程
	 *
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/edit_departure.htm")
	public void updateDeparture(@ModelAttribute("departure") Departure dep, BindingResult result, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");

		try {
			out = res.getWriter();
			new DepartureValidator().validate(dep, result);
			if(result.hasErrors()) {
				m.put("result", HandlerState.PARAM_EMPTY);
			}else {
				UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
				HandlerState hs = processService.updateDeparture(dep, ug);
				m.put("result", hs);
			}
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));	
		} catch (Exception e) {
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		}finally {
			m.clear();
			if(out != null) {out.flush();out.close();}	
		}
	}
}
