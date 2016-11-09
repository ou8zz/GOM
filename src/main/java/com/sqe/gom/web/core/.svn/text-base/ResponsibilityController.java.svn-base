/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.ResponsibilityService;
import com.sqe.gom.app.UserService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.model.Responsibility;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.util.XmlHelper;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description user entry report to submit information.
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 5, 2012  11:04:25 PM
 * @version 3.0
 */
@Controller
public class ResponsibilityController {
	private Log log = LogFactory.getLog(ResponsibilityController.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private ResponsibilityService responsibilityService;
	private UserService userService;
	
	@Autowired
	public void setResponsibilityService(ResponsibilityService responsibilityService) {
		this.responsibilityService = responsibilityService;
	}
	@Autowired
	public void setUserService(UserService userSerivce) {
		this.userService = userSerivce;
	}

	//管理责任主页面
	@PreAuthorize("hasRole('Manager') or hasRole('Director') or hasRole('CEO')")
	@RequestMapping(method=RequestMethod.GET, value="/app/respons_config.htm")
	public String responsibilitys() { return "app/mgr_responsibility"; }
	
	//主管分配页面
	@PreAuthorize("hasRole('Manager') or hasRole('Director')")
	@RequestMapping(method=RequestMethod.GET, value="/app/supervisor_respons.htm")
	public String responConfig() { return "app/respon_config"; }

	//我的责任页面
	@RequestMapping(method=RequestMethod.GET, value="/app/my_respons.htm")
	public String myResponsibility() { return "app/my_responsibility"; }
	
	/**
	 * JQgrid 查询所有需要分配责任的用户信息
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/get_respon.htm")
	public void getUsers(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<UserGroup> grid = new JGridHelper<UserGroup>();
		grid.jgridHandler(req, res, "u.");
		PrintWriter out = null;
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(userService.getUsers(false, req.getParameter("gid"), null, grid),  new TypeToken<JGridBase<UserGroup>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN, true));
		} catch (Exception e) {
			log.error("users_respon.htm have a error!", e);
		} finally {
			if (out != null) {out.flush();out.close();} 
			grid = null;
		}
	}
	
	/**
	 * 用户责任管理树
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/get_responsibility.htm")
	public void getResponsibility(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("application/xhtml+xml;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		String nodeid = req.getParameter("nodeid");
		String n_level = req.getParameter("n_level");
		String isUser =req.getParameter("user");
		//String node =req.getParameter("parentid");
		
		int level = 0;
		int parentId = 0;
		boolean isOwn = false;
		
		try {
			if(RegexUtil.notEmpty(n_level)){level = Integer.parseInt(n_level);level++;}
			if(RegexUtil.notEmpty(nodeid)) parentId = Integer.parseInt(nodeid);
			if(RegexUtil.notEmpty(isUser)) isOwn = Boolean.valueOf(isUser);
			
			Integer userId = 0;
			if(isOwn){
				UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
				userId= ug.getId();
			}
			
			ServletOutputStream out = res.getOutputStream();
			XmlHelper.OutputXmlStream(new DOMSource(responsibilityService.buildRespTree(userId, parentId, level)), new StreamResult(out));
			out.flush();
			out.close();
		} catch (IOException ex) {
			log.error("get user responsibilities have an error", ex);
		} 
	}
	
	//查询指定用户未分配的主责任
	@RequestMapping(method=RequestMethod.POST, value="/app/not_assign_respons.htm")
	public void getNotAssignRespon(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		PrintWriter out = null;
		String responIds = req.getParameter("ids");
		
		try {
			out = res.getWriter();
			if(RegexUtil.isEmpty(responIds)) responIds = null;
			out.write(JsonUtils.toJson(responsibilityService.getNotSelectRespons(responIds), new TypeToken<List<Responsibility>>() {}.getType(), true));
		} catch (Exception ex) {
			log.error("get user responsibilities have an error", ex);
			map.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(map, new TypeToken<Map<String,Object>>() {}.getType()));
		} finally{if(out != null){out.flush(); out.close();} map.clear();}
	}
	
	/**
	 * 查询得到父类或子类责任
	 * 
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/get_responsibilitys.htm")
	public void getUserResponsibility(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		PrintWriter out = null;
		String uid = req.getParameter("uid");		//用户ID
		String ename = req.getParameter("ename");	//用户ename
		String pid = req.getParameter("pid"); 		//父ID
		String isf = req.getParameter("isf"); 		//是否包括父节点ID
		String node = req.getParameter("node"); 	//根据node筛选查询
		String onlyf = req.getParameter("onlyf");  	//仅查询单个实体
		
		try {
			out = res.getWriter();
			
			int parentId = 0;
			int userId = 0;
			if(RegexUtil.notEmpty(pid)) parentId = Integer.parseInt(pid);
			if(RegexUtil.notEmpty(uid)) userId = Integer.parseInt(uid);
			boolean isFather = false;
			if(RegexUtil.notEmpty(isf)) isFather = Boolean.valueOf(isf);
			boolean isOnlyf = false;
			if(RegexUtil.notEmpty(onlyf)) isOnlyf = Boolean.valueOf(onlyf);
			
			if(isOnlyf) out.write(JsonUtils.toJson(responsibilityService.getResponsibility(parentId), new TypeToken<Responsibility>() {}.getType(), true));
			else if(RegexUtil.notEmpty(onlyf) && !isOnlyf && parentId > 0) {
				Responsibility resp = responsibilityService.getResponsibility(parentId);
				List<Responsibility> respons = new ArrayList<Responsibility>();
				respons.add(resp);
				respons.addAll(responsibilityService.getResponsibility(ename, userId, parentId, true, node));
				out.write(JsonUtils.toJson(respons, new TypeToken<List<Responsibility>>() {}.getType(), true));
			}
			else out.write(JsonUtils.toJson(responsibilityService.getResponsibility(ename, userId, parentId, isFather, node), new TypeToken<List<Responsibility>>() {}.getType(), true));
		} catch (IOException ex) {
			log.error("have an error when query user responsibility", ex);
		} finally { if(out != null){out.flush(); out.close();} }
	}
	
	/**
	 * 保存JSon数组
	 * 
	 * @param responsibility
	 * @param result
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/save_responsibilities.htm")
	public void saveResponsibilities(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		PrintWriter out = null;
		
		try {
			out = res.getWriter();
			String rpts = req.getParameter("rpts");
			String userId = req.getParameter("userId");
			
			if(RegexUtil.notEmpty(rpts)){
				if(RegexUtil.isEmpty(userId)){
					map.put("result", responsibilityService.updateResponsibilities(rpts));
					out.write(JsonUtils.toJson(map, new TypeToken<Map<String,Object>>(){}.getType()));
				}else {
					List<Responsibility> list = responsibilityService.saveResponsibilities(rpts, Integer.parseInt(userId));
					out.write(JsonUtils.toJson(list, new TypeToken<List<Responsibility>>(){}.getType(), true));
				}
			}else {
				map.put("result", HandlerState.PARAM_EMPTY);
				out.write(JsonUtils.toJson(map, new TypeToken<Map<String,Object>>(){}.getType()));
			}
		} catch (Exception ex) {
			log.error("have an error when save JSON responsibilities ", ex);
			map.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(map, new TypeToken<Map<String,Object>>(){}.getType()));
		} finally {
			map.clear();
			if(out != null) {out.flush();out.close();}
		}
	}
	
	/**
	 * 复制离职人责任到接收人
	 * 
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/copy_responsibility.htm")
	public void updateRecevierResponsibility(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		PrintWriter out = null;
		String recevier = req.getParameter("recevier");
		String firer = req.getParameter("firer");
		
		try {
			out = res.getWriter();
			
			if(RegexUtil.isEmpty(recevier) || RegexUtil.isEmpty(firer))	{
				map.put("result", HandlerState.PARAM_EMPTY);
				out.write(JsonUtils.toJson(map, new TypeToken<Map<String,Object>>() {}.getType()));
			}else {
				out.write(JsonUtils.toJson(responsibilityService.updateResponsibilities(recevier, Integer.parseInt(firer)), new TypeToken<List<Responsibility>>() {}.getType(), true));
			}
		} catch(Exception ex) {
				log.error("have an error when copy fire responsibilities ", ex);
				map.put("result", HandlerState.ERROR);
				out.write(JsonUtils.toJson(map, new TypeToken<Map<String,Object>>() {}.getType()));
			} finally {
				map.clear();
				if(out != null) {out.flush();out.close();}
			}
	}
		
	/**
	 * responsibility信息操作<添加，修改>
	 * @param resp
	 * @param result
	 * @param res
	 * @return
	 */
	@RequestMapping(method=RequestMethod.POST, value="/save_responsibility.htm")
	public void saveResponsibilityApp(@ModelAttribute("resp") Responsibility resp, BindingResult result, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		PrintWriter out = null;
		
		try {
			out = res.getWriter();
			
			if(RegexUtil.isEmpty(resp.getFuncode()) || RegexUtil.isEmpty(resp.getName()) || RegexUtil.isEmpty(resp.getExplanation())) map.put("result", HandlerState.PARAM_EMPTY);
			else {
				map.put("resp", responsibilityService.saveResponsibility(resp));
				map.put("result", HandlerState.SUCCESS);
			}
			out.write(JsonUtils.toJson(map, new TypeToken<Map<String,Object>>(){}.getType(), JsonUtils.SHORT_DATE_PATTERN, true));
		} catch (Exception e) {
			log.error("when save responsibility have an error occurred!", e);
			map.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(map, new TypeToken<Map<String,Object>>() {}.getType()));
		} finally {
			map.clear();
			if(out != null) {out.flush();out.close();}
		}
	}
}