/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.sqe.gom.app.UserService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.model.Education;
import com.sqe.gom.model.Logs;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;
import com.sqe.gom.web.validation.EducationValidator;

/**
 * @description user entry report to submit information.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 7, 2011  11:04:25 PM
 * @version 3.0
 */
@Controller
public class EducationController {
	private Log log = LogFactory.getLog(EducationController.class);
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private Integer userId;
	private HandlerState str = HandlerState.FAILED;
	private UserService userService;
	
	@Autowired
	public void setUserService(UserService userSerivce) {
		this.userService = userSerivce;
	}
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(df,false));
	}	
		
	//用户教育经历页面
	@RequestMapping(method=RequestMethod.GET, value="/app/education.htm")
	public String education() { return "app/education"; }
	
	/**
	 * 后台用户教育经历展现
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/get_education.htm")
	public void getEducationAdmin(HttpServletRequest req, HttpServletResponse res) {
		getEducationApp(req, res);
	}
	
	/**
	 * 前台用户教育经历展现
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/app/get_education.htm")
	public void getEducationApp(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<Education> grid = new JGridHelper<Education>();
		grid.jgridHandler(req, res, "p.");
		UserGroup ug = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		try {
			out = res.getWriter();
			int uid = 0;
			String id = req.getParameter("id");   
			if(RegexUtil.notEmpty(id)) uid = Integer.parseInt(id); 	//后台用户操作
			else uid = ug.getId();	
			//前台用户操作
			String ord = " ORDER BY p.id ASC";
			List<Education> list = userService.getEducation(uid, ord);
			grid.getJq().setList(list);
			grid.getJq().setRecords(grid.getP().getTotalCount());
			grid.getJq().setTotal(grid.getP().getPageCount());
			out.write(JsonUtils.toJson(grid.getJq(), new TypeToken<JGridBase<Education>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN,true));
		} catch (Exception e) {
			log.error("/app/get_education.htm have a error!", e);
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
			grid = null;
		}
	}
	
	/**
	 * 后台用户教育编辑<添加，修改>
	 * @param edu
	 * @param result
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/admin/save_education.htm")
	public void saveAppEducation(@ModelAttribute("education") Education education, BindingResult result, 
			HttpServletRequest req, HttpServletResponse res) {
		saveAdminEducation(education, result, req, res);
	}
	
	/**
	 * 前台用户教育编辑<添加，修改>
	 * @param edu
	 * @param result
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/save_education.htm")
	public void saveAdminEducation(@ModelAttribute("education") Education education, BindingResult result, 
			HttpServletRequest req, HttpServletResponse res){
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		List<Education> edus = new ArrayList<Education>();
		String uid = req.getParameter("uid");
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		new EducationValidator().validate(education, result);
		Logs lf = new Logs();
		lf.setDated(new Date());
		try {
			out = res.getWriter();
			if(result.hasErrors()) {
				str = HandlerState.ERROR;
			}else if(RegexUtil.notEmpty(education.getId())) {
				userService.updateEducation(education);
				str = HandlerState.SUCCESS;
				
				
				lf.setLogger("修改教育");
				lf.setUserId(ug.getId());
				lf.setMessage(ug.getCname() + "于" + DateUtil.forMatDate() + " 修改了 " + education.getSchool()+"的教育经历");
				log.debug(JsonUtils.toJson(lf));
			} else {
				if(RegexUtil.notEmpty(uid)) userId = Integer.parseInt(uid);
				else userId = ug.getId();
				edus.add(education);
				userService.saveEducation(userId, edus);
				str = HandlerState.SUCCESS;
				m.put("edu", education);
				
				lf.setLogger("新增教育");
				lf.setUserId(userId);
				lf.setMessage(ug.getCname() + " 于 " + DateUtil.forMatDate() + " 添加教育经历 " + education.getEd() + " 从 " + DateUtil.formatDate(education.getStartDate()) + "至" + DateUtil.formatDate(education.getEndDate()) + "就读于" + education.getSchool() + " 的  " + education.getMajor() + " 专业 ");
				log.debug(JsonUtils.toJson(lf));
			}
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(), JsonUtils.SHORT_DATE_PATTERN, true));	
		} catch (IOException e) {
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		}finally {
			m.clear();
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
	/**
	 * 后台删除用户教育经历<可删除多个>
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/del_education.htm")
	public void delAppEdu(HttpServletRequest req, HttpServletResponse res) {
		delAdminEdus(req, res);
	}
	
	/**
	 * 前台删除用户教育经历<可删除多个>
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/app/del_education.htm")
	public void delAdminEdus(HttpServletRequest req, HttpServletResponse res) {
		String[] id = req.getParameterValues("id[]");
		if(null != id) {
			try {
				out = res.getWriter();
				userService.removeEdu(id);
				m.put("result", HandlerState.SUCCESS);
				
				Logs lf = new Logs();
				lf.setLogger("教育信息");
				lf.setMessage("删除" + id.length + "条教育信息，ID号为："+id);
				log.debug(JsonUtils.toJson(lf));
				out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			} catch (Exception e) {
				m.put("result", HandlerState.ERROR);
				out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			} finally {
				if (out != null) {
					out.flush();
					out.close();
				}
			}
		}
	}
	
}
