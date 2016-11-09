/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Collection;
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
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.UserService;
import com.sqe.gom.constant.AddrType;
import com.sqe.gom.constant.CensusType;
import com.sqe.gom.constant.GenderType;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.model.Education;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Logs;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.vo.Addrs;
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
public class UserController {
	private Log log = LogFactory.getLog(UserController.class);
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
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
		
	@ModelAttribute("departments")
    public Collection<GomGroup> getDepartments() {
        return userService.getGroups(GroupType.DEPARTMENT, null);
    }
	
	@ModelAttribute("positions")
    public Collection<GomGroup> getPositions() {
        return userService.getGroups(GroupType.POSITION, null);
    }
	
	@ModelAttribute("roles")
    public Collection<GomGroup> getRoles() {
        return userService.getGroups(GroupType.ROLE, null);
    }
	
	@ModelAttribute("genders")
    public Map<GenderType,String> getGenders() {
		Map<GenderType,String> m = new HashMap<GenderType,String>();
		m.put(GenderType.F, GenderType.F.getDes());
		m.put(GenderType.M, GenderType.M.getDes());
        return m;
    }
	
	@ModelAttribute("censuses")
    public Map<CensusType,String> getCensuses() {
		Map<CensusType,String> m = new HashMap<CensusType,String>();
		m.put(CensusType.COUNTRYSIDE, CensusType.COUNTRYSIDE.getDes());
		m.put(CensusType.TOWN, CensusType.TOWN.getDes());
        return m;
    }
	
	@ModelAttribute("addrs")
    public Map<AddrType,String> getAddrs() {
		Map<AddrType,String> m = new HashMap<AddrType,String>();
		m.put(AddrType.CENSUS,AddrType.CENSUS.getDes());
		m.put(AddrType.PRESENT, AddrType.PRESENT.getDes());
		m.put(AddrType.FAMILY, AddrType.FAMILY.getDes());
		m.put(AddrType.EMERGENCY, AddrType.EMERGENCY.getDes());
        return m;
    }
	
	//登录时打开主页面
	@PreAuthorize("hasRole('User')")
	@RequestMapping(method = RequestMethod.GET, value = "/app/index.htm")
	public String setupindexuser() {return "app/index";}
	
	@PreAuthorize("hasRole('Admin')")
	@RequestMapping(method = RequestMethod.GET, value = "/admin/index.htm")
	public String setupindexadmin() {return "app/index";}

	//修改密码页面
	@PreAuthorize("hasRole('User')")
	@RequestMapping(method = RequestMethod.GET, value = "/app/update_pwd.htm")
	public String updatePwd() { return "app/update_pwd"; }
	
	/**
	 * ajax查询所有部门
	 * @param res
	 * @return departments list 返回所有部门
	 */
	@RequestMapping(method=RequestMethod.POST, value="/get_departments.htm")
	public void getDepartment(HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		PrintWriter writer = null;
		try {
			writer = res.getWriter();
			List<GomGroup> list = userService.getGroups(GroupType.DEPARTMENT, null);
			m.put("departments", list);
		} catch (Exception e) {
			log.error("get_departments.htm have a error!", e);
			str = HandlerState.ERROR;
		} finally {
			m.put("result", str);
			writer.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(), JsonUtils.SHORT_DATE_PATTERN, true));
			m.clear();
			if (writer != null) {writer.flush();writer.close();}
		}
	}
	
	/**
	 * ajax查询所有职位
	 * @param res
	 * @return departments list 返回所有职位
	 */
	@RequestMapping(method=RequestMethod.POST, value="/get_positions.htm")
	public void getPosition(HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			List<GomGroup> list = userService.getGroups(GroupType.POSITION, null);
			m.put("positions", list);
		} catch (Exception e) {
			log.error("get_positions.htm have a error!", e);
			str = HandlerState.ERROR;
		} finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(), JsonUtils.SHORT_DATE_PATTERN, true));
			m.clear();
			if (out != null) {out.flush();out.close();}
		}
	}
	
	/**
	 * ajax查询所有角色
	 * @param res
	 * @return role list 返回所有角色
	 */
	@RequestMapping(method=RequestMethod.POST, value="/get_roles.htm")
	public void getRole(HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			List<GomGroup> list = userService.getGroups(GroupType.ROLE, null);
			m.put("roles", list);
		} catch (Exception e) {
			log.error("get_roles.htm have a error!", e);
			str = HandlerState.ERROR;
		} finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(), JsonUtils.SHORT_DATE_PATTERN, true));
			m.clear();
			if (out != null) {out.flush();out.close();}
		}
	}

	/**
	 * 根据输入的用户名模糊搜索用户
	 * @param ename
	 * @param req
	 * @param res
	
	@RequestMapping(method=RequestMethod.POST, value="/app/get_search_users.htm")
	public void getSearchUsers(@RequestParam("ename") String ename, HttpServletResponse res) {
		getOut(res, "users", userService.getUsers(ename));
	} */
	
	
	/**
	 * 检查用户是否正确〈存在〉-- app用户 
	 * 返回用户ID
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/check_user.htm")
	public void checkUserApp(@RequestParam("ename")String ename, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			if(!userService.checkUser(ename)) str = HandlerState.SUCCESS;
			else str = HandlerState.ERROR;
		} catch (Exception e) {
			log.error("app/check_user.htm action have a error!", e);
			str = HandlerState.ERROR;
		} finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			m.clear();
			if (out != null) { out.flush();out.close();}
		}
	}
	
	/**
	 * Admin后台用户操作--------------------------------------------------------------------------------------------------
	 * 后台admin用户展现页面jsp
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(method=RequestMethod.GET, value="/admin/list_users.htm")
	public String getUser(Model model) {
		GomUser gu = new GomUser();
		Education e = new Education();
		Addrs a = new Addrs();
		model.addAttribute("u", gu);
		model.addAttribute("e", e);
		model.addAttribute("a", a);
		return "admin/users";
	}
	
	/**
	 * ajax展现所有后台admin用户数据
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/get_users.htm")
	public void getAdminUsers(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<GomUser> grid = new JGridHelper<GomUser>();
		grid.jgridHandler(req, res, "u.");
		try {
			out = res.getWriter();
			JGridBase<GomUser> list = userService.getInactiveUser("u.", true, grid);
			out.write(JsonUtils.toJson(list,new TypeToken<JGridBase<GomUser>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN, true));
		} catch (Exception e) {
			log.error("admin/get_users.htm action have a error!", e);
		} finally {
			if (out != null) {out.flush();out.close();}
			grid = null;
		}
	}
	
	/**
	 * 后台修改用户编辑<修改>
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/admin/save_user.htm")
	public void saveUser(@ModelAttribute("u") GomUser u, BindingResult result, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			new UserValidator().validate(u, result);
			if(result.hasErrors()) str = HandlerState.PARAM_EMPTY;
			else {
				userService.updatePartUserInfor(u);
				str = HandlerState.SUCCESS;
				
				Logs lf = new Logs();
				lf.setDated(new Date());
				lf.setLogger("后台编辑用户信息");
				lf.setMessage("您已成功修改用户 "+ u.getCname() +"(" + u.getEname() + "), 工号为" + u.getJobNo() + "。" );
				log.debug(JsonUtils.toJson(lf));
			}
		} catch (Exception e) {
			str = HandlerState.ERROR;
			log.error("/admin/save_user.htm have a error!", e);
		} finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			m.clear();
			if (out != null) {out.flush();out.close();}
		}
		
	}
	
	/**
	 * 删除用户
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/del_user.htm")
	public void deleteUser(@RequestParam("id")Integer id, HttpServletResponse res) {
		try {
			out = res.getWriter();
			userService.delUser(id);
			str = HandlerState.SUCCESS;
		} catch (Exception e) {
			str = HandlerState.ERROR;
			log.error("/admin/del_user.htm have a error!", e);
		} finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			m.clear();
			if (out != null) { out.flush(); out.close();}
		}	
	}
	
	/**
	 * app前台用户操作--------------------------------------------------------------------------------------------------
	 * app用户职务和角色配置
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/user_config.htm")
	public String userConfig(ModelMap model) {
		GomUser u = new GomUser();
		model.addAttribute("u", u);
		return "admin/user_config";
	}
	
	/**
	 * ajaxGrid查询用户信息
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/get_users_config.htm")
	public void getUsers(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<UserGroup> grid = new JGridHelper<UserGroup>();
		grid.jgridHandler(req, res, "u.");
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(userService.getUsers(true, req.getParameter("dptId"), req.getParameter("pstId"), grid), new TypeToken<JGridBase<UserGroup>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN, true));
		} catch (Exception e) {
			log.error("get_users_config.htm have a error!", e);
		} finally {
			if (out != null) {out.flush();out.close();} 
			grid = null;
		}
	}
	
	/**
	 * 保存用户部门，职务，角色配置
	 * @param u
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/admin/save_userConfig.htm")
	public void saveUserConfig(@ModelAttribute("u") UserGroup u, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			userService.updateUserAuthority(u);
			str = HandlerState.SUCCESS;
		} catch (IOException e) {
			str = HandlerState.ERROR;
			log.error("/admin/save_userConfig.htm have a error!", e);
		} finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			m.clear();
			if (out != null) { out.flush(); out.close(); }
		}
	}
}
