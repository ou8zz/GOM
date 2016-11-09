/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.InitBinder;
import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.ProcessService;
import com.sqe.gom.app.UserService;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.exception.GomException;
import com.sqe.gom.model.Address;
import com.sqe.gom.model.Education;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.util.TokenProcessor;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;
import com.sqe.gom.web.validation.UserValidator;

/**
 * @description user entry report to submit information.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 7, 2011  11:04:25 PM
 * @version 3.0
 */
@Controller
public class RegController {
	private Log log = LogFactory.getLog(RegController.class);
	private UserService userService;
	private ProcessService processService;
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
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(df,false));
	}
	
	@RequestMapping(method=RequestMethod.GET, value="/reg.htm")
	public String setupReg(Model model, HttpServletRequest req, HttpServletResponse res) {
		GomUser user = (GomUser)req.getSession().getAttribute(SessionAttr.TMP_USER_TAKEN.name());
		model.addAttribute("positions", userService.getGroups(GroupType.POSITION, null));
		model.addAttribute("departments", userService.getGroups(GroupType.DEPARTMENT, null));
		
		//产生随机数（表单号 ）  
        req.getSession().setAttribute("token", tokens.generateToken());
        
		if(RegexUtil.isEmpty(user)) user = new GomUser();
		model.addAttribute("u",user);
		return "userForm";
	}
	
	@RequestMapping(method=RequestMethod.GET, value="/next_edu.htm")
	public String setupEdu(Model model, HttpServletRequest req, HttpServletResponse res) {
		GomUser user = (GomUser)req.getSession().getAttribute(SessionAttr.TMP_USER_TAKEN.name());
		
		Education edu = new Education();
		
		if(RegexUtil.isEmpty(user)) model.addAttribute("edu",edu);
		else {
			List<Education> edus = userService.getEducation(user.getId(), null);
			if(edus.isEmpty()) model.addAttribute("edu",edu);
			else {
				model.addAttribute("edus", edus);
				model.addAttribute("edu", edus.iterator().next());
			}
		}
		
		return "eduForm";
	}
	
	@RequestMapping(method=RequestMethod.GET, value="/next_addr.htm")
	public String setupAddress(Model model, HttpServletRequest req, HttpServletResponse res) {
		GomUser user = (GomUser)req.getSession().getAttribute(SessionAttr.TMP_USER_TAKEN.name());
		
		Address addr = new Address();
		
		if(RegexUtil.isEmpty(user)) model.addAttribute("a",addr);
		else {
			List<Address> addrs = userService.getAddress(user.getId(), null);
			if(addrs.isEmpty()) model.addAttribute("a",addr);
			else {
				model.addAttribute("addrs", addrs);
				Address address = addrs.iterator().next();
				address.setUid(user.getId());
				model.addAttribute("a", address);
			}
		}
		
		return "addrForm";
	}
	
	/**
	 * 查询所有的部门
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/departments.htm")
	public void getAllDepartments(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		try {
			out = res.getWriter();
			List<GomGroup> departments = userService.getGroups(GroupType.DEPARTMENT, null);
			out.write(JsonUtils.toJson(departments, new TypeToken<List<GomGroup>>() {}.getType(), true));
		} catch (IOException e) {
			log.error("have an error when query all departments", e);
		}
	}
	
	/**
	 * 根据部门ID查询职员, 如果ismgr为true则只查询管理层，反之所有用户。
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/dpt_users.htm")
	public void getDptEmployee(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		String dpt = req.getParameter("dpt");
		String type = req.getParameter("type");
		String ismgr = req.getParameter("ismgr");
		String user = req.getParameter("user");			//为true表示包括登录者，为null表示为不包括登录者
		
		try {
			out = res.getWriter();
			if(RegexUtil.notEmpty(dpt) && RegexUtil.notEmpty(type) && RegexUtil.notEmpty(ismgr)) {
				List<UserGroup> users = Collections.emptyList();
				Integer uid = null;
				if(!Boolean.valueOf(user)) {
					UserGroup u = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
					uid = u.getId();
				}
				users = userService.getUsersByDpt(Integer.parseInt(dpt), uid, GroupType.valueOf(type), Boolean.valueOf(ismgr));
				out.write(JsonUtils.toJson(users, new TypeToken<List<UserGroup>>() {}.getType()));
			}
		} catch (IOException e) {
			log.error("have an error when query all users by department", e);
		} finally {
			out.flush();
			out.close();
		}
	}
	
	/**
	 * JQgrid 查询所有用户信息
	 * 
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/get_users.htm")
	public void getUsers(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<UserGroup> grid = new JGridHelper<UserGroup>();
		grid.jgridHandler(req, res, "u.");
		
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
	 * 进入 更新用户基本资料
	 * Jump into update user information
	 */
	@RequestMapping(method=RequestMethod.GET, value="/app/edit_user.htm")
	public String editUser(Model model, HttpServletRequest req) {
		UserGroup user = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		
		if(RegexUtil.notEmpty(user)) {
			GomUser guser = userService.getUser(user.getId());
			guser.setCdepartment(user.getCdepartment());
			guser.setCposition(user.getCposition());
			model.addAttribute("user", guser);
		}else model.addAttribute("user", new GomUser());
		
		return "app/edit_user";
	}
	
	/**
	 * 更新用户基本资料
	 * update user information by specified.
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/update_user.htm")
	public void updateUser(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		String id = req.getParameter("id");
		String idScan = req.getParameter("idScan");
		String portrait = req.getParameter("portrait");
		String cell = req.getParameter("cell");
		String phone = req.getParameter("phone");
		String privateMail = req.getParameter("privateMail");
		String telExt = req.getParameter("telExt");
		String bank = req.getParameter("bank");
		String accountNo = req.getParameter("accountNo");
		
		PrintWriter out;
		try {
			out = res.getWriter();
			if(RegexUtil.isEmpty(id) || RegexUtil.isEmpty(idScan) || RegexUtil.isEmpty(portrait) || RegexUtil.isEmpty(cell) || RegexUtil.isEmpty(phone) || RegexUtil.isEmpty(privateMail) || RegexUtil.isEmpty(telExt) || RegexUtil.isEmpty(bank) || RegexUtil.isEmpty(accountNo)) {
				out.write(HandlerState.PARAM_EMPTY.name());
			}else {
				GomUser user = new GomUser();
				user.setId(Integer.parseInt(id));
				user.setIdScan(idScan);
				user.setPortrait(portrait);
				user.setCell(cell);
				user.setPhone(phone);
				user.setPrivateMail(privateMail);
				user.setTelExt(telExt);
				user.setBank(bank);
				user.setAccountNo(accountNo);
				
				userService.updatePartUserInfor(user);
				
				out.write(HandlerState.SUCCESS.name());
				log.debug("用户信息修改成功:您的信息修改已经生效，被修改用户："+user.getCname()+"，工作号："+user.getJobNo());
			}
			
			out.flush();
			out.close();
		} catch (IOException e) {
			log.error("have an error when update user information", e);
			log.warn("用户信息修改失败:您的信息在修改提交后操作出错了！", e);
		}
	}
	
	@RequestMapping(method=RequestMethod.POST, value="/save_reg.htm")
	public String saveUser(@ModelAttribute("u") GomUser u, BindingResult result, Model model, HttpServletRequest req) {
		new UserValidator().validate(u, result);
		boolean b = tokens.isTokenValue(req);  	//防止重复提交
        
		if(!b) {
			model.addAttribute("edu",new Education());
			return "eduForm";
		} 
		else if (result.hasErrors()) {
	        req.getSession().setAttribute("token", tokens.generateToken());
			return "userForm";
		} 
		else {
			GomUser user = userService.saveUser(u);
			
			if(RegexUtil.notEmpty(user)) {
				try {
					req.getSession().setAttribute(SessionAttr.TMP_USER_TAKEN.name(), user);
					HandlerState hs = processService.startEntrant(user);
					if(hs.equals(HandlerState.SUCCESS)) {
						model.addAttribute("edu",new Education());
						log.debug("用户"+user.getCname()+"入职:用户"+user.getCname()+"入职申请流程已经生效，入职日期："+user.getEntryDate()+"请等待上级入职审核！");
					} else {
				        req.getSession().setAttribute("token", tokens.generateToken());
						return "userForm";
					}
				} catch (GomException ex) {
					log.error("when start entry process occurred error", ex);
					log.warn("用户"+user.getCname()+"入职操作失败:用户"+user.getCname()+"入职申请提交出现了错误！", ex);
				}
			}
			
			return "eduForm";
		}
	}
	
	@RequestMapping(method=RequestMethod.POST, value="/save_edu.htm")
	public String saveEducation(HttpServletRequest req, Model model){
		String edus = req.getParameter("edus");
		String id = req.getParameter("uid");
		int uid = 0;
		
		if(RegexUtil.notEmpty(id)) uid = Integer.valueOf(id);
		Education edu = new Education();
		edu.setUid(uid);
		model.addAttribute("edu", edu);
		
		if(RegexUtil.notEmpty(edus) && uid > 0) {
			try {
				List<Education> es = JsonUtils.fromJson(edus, new TypeToken<List<Education>>(){}, "yyyy-MM-dd");
				if(!es.isEmpty()) {
					userService.saveEducation(uid, es);
					Address addr = new Address();
					addr.setUid(uid);
					model.addAttribute("a", addr);
					log.debug("教育信息填写提交成功:用户ID为"+uid+"，在入职申请时提交了他的教育信息");
					return "addrForm";
				}
			}catch (Exception ex) {
				log.error("occurred an error when save education information and to address",ex);
				log.warn("教育信息提交失败:用户ID为"+uid+"，在入职申请时提交教育信息的操作出现了错误！");
			} 
		}
		
		return "eduForm";
	}
	
	@RequestMapping(method=RequestMethod.POST, value="/save_addr.htm")
	public String saveAddress(HttpServletRequest req, Model model){
		String addrs = req.getParameter("addrs");
		String id = req.getParameter("uid");
		int uid = 0;
		
		if(RegexUtil.notEmpty(id)) uid = Integer.valueOf(id);
		
		if(RegexUtil.notEmpty(addrs) && uid > 0) {
			try {
				List<Address> as = JsonUtils.fromJson(addrs, new TypeToken<List<Address>>(){}, "yyyy-MM-dd");
				if(!as.isEmpty()) {
					userService.saveAddress(as,uid);
					req.getSession().removeAttribute(SessionAttr.TMP_USER_TAKEN.name());
					log.debug("地址信息填写提交成功:用户ID为"+uid+"，在入职申请时提交了他的地址信息");
					return "redirect:index.html";
				}else return "addrForm";
			}catch (Exception ex) {
				log.error("occurred an error when save address information",ex);
				log.warn("地址信息提交失败:用户ID为"+uid+"，在入职申请时提交地址信息的操作出现了错误！");
				return "addrForm";
			} 
		}else {
			Address addr = new Address();
			addr.setUid(uid);
			model.addAttribute("a", addr);
			return "addrForm";
		}
	}
	
	/**
	 *  check cname or ename is exist
	 *  
	 * @param req  request of http
	 * @param res  response of http
	 */
	@SuppressWarnings("unused")
	@RequestMapping(method=RequestMethod.GET, value = "/chk_user.htm")
	public void checkUser(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		String name = req.getParameter("ename");
		String cell = req.getParameter("cell");
		String email = req.getParameter("email");
		
		if(RegexUtil.isEmpty(name)) name = cell;
		//again
		if(RegexUtil.isEmpty(name)) name = email;
		

		PrintWriter out = null;
		boolean b = false;
		try {
			out = res.getWriter();
			b = userService.checkUser(name);
			out.write(String.valueOf(b));
		} catch (IOException e) {
			if(out != null) out.write(String.valueOf(b));
		}finally {
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
	/**
	 * 修改密码操作
	 * @param session
	 * @return
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/save_pwd.htm")
	public void updatePassword(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		String oldPwd = req.getParameter("oldPwd");
		String newPwd = req.getParameter("newPwd");
		String security = req.getParameter("security");
		
		try {
			if(RegexUtil.isEmpty(oldPwd) || RegexUtil.isEmpty(newPwd) || RegexUtil.isEmpty(security)) {
				m.put("result", HandlerState.PARAM_EMPTY);
			}else {
				Object sCode = session.getAttribute(SessionAttr.RANDCODE.name());
				
				if(RegexUtil.isEmpty(sCode)) m.put("result", HandlerState.INVALID);
				else {
					if(sCode.toString().equalsIgnoreCase(security)) {
						UserGroup ug = (UserGroup)session.getAttribute(SessionAttr.USER_TAKEN.name());
						if(oldPwd.equals(ug.getPwd())) {
							GomUser user = new GomUser();
							user.setPwd(newPwd);
							user.setId(ug.getId());
							userService.updatePartUserInfor(user);
							m.put("result", HandlerState.SUCCESS);
							log.debug("用户密码修改成功:用户"+ug.getCname()+"修改了登录密码！");
						}else m.put("result", HandlerState.INPWD);
					}else m.put("result", HandlerState.INVALID);
				}
			}
			
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		}catch(Exception e) {
			m.put("result", HandlerState.ERROR);
			log.warn("密码修改失败:用户修改登录密码出现了错误！", e);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		}finally{
			session.removeAttribute(SessionAttr.RANDCODE.name());
			if(out != null) {out.flush();out.close();}
		}
	}
	
	/**
	 * 发送验证码到邮箱
	 * @param session
	 * @return
	 */
	@RequestMapping(method=RequestMethod.POST, value="/send_security.htm")
	public void sendSecurityMail(HttpServletRequest req, HttpServletResponse res, HttpSession session) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String ename = req.getParameter("ename");
		String pwd = req.getParameter("pwd");
		UserGroup ug = (UserGroup)session.getAttribute(SessionAttr.USER_TAKEN.name());
		HandlerState str = HandlerState.SUCCESS;
		try {
			out = res.getWriter();
			if(RegexUtil.notEmpty(ename)) {
				//登录验证码
				UserGroup user = userService.login(ename, pwd);
				if(RegexUtil.isEmpty(user)) str = HandlerState.FAILED;
				else userService.sendValidateCode(user.getEmail(), "登录验证码", session);
			} else if(RegexUtil.notEmpty(ug)) {
				//修改密码验证码
				userService.sendValidateCode(ug.getEmail(), "修改密码验证码", session);
				log.debug("密码验证码发送成功:发送密码验证码成功！");
			} else str = HandlerState.FAILED;
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		} catch (Exception e) {
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			e.printStackTrace();
			log.error("/send_security.htm", e);
			log.warn("发送密码验证码失败:验证码发送失败！", e);
		} finally {
			m.clear();
			if (out != null) {out.flush();out.close();}
		}
	}
}