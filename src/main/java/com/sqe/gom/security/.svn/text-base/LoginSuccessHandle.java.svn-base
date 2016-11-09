/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.security;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;
import javax.security.sasl.AuthenticationException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.UserService;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Login;
import com.sqe.gom.model.Logs;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.UserGroup;

/**
 * @description 登录成功后处理
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 6, 2013
 * @version 3.0
 */
public class LoginSuccessHandle extends SavedRequestAwareAuthenticationSuccessHandler {
	private Log log = LogFactory.getLog(LoginSuccessHandle.class);
	private SessionRegistry sessionRegistry;
	private UserService userService;
	
	@Resource(name = "sessionRegistry")
	public void setSessionRegistry(SessionRegistry sessionRegistry) {
		this.sessionRegistry = sessionRegistry;
	}

	@Resource(name = "userService")
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	/**
	 * 登录成功后在session中添加用户数 登陆成功后如果是ajax登录返回成功状态 如果是不是ajax就设置登陆成功后跳转页面 交给父类
	 */
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws ServletException, IOException {
		Boolean ajax = Boolean.valueOf(request.getParameter("ajax"));
		String url = "";
		String ip = getRemortIP(request);
		
		// 添加user到session
		GomUserDetails principal = (GomUserDetails) authentication.getPrincipal();
		UserGroup ug = new UserGroup();
		GomUser gu = principal.getUser();
		if (RegexUtil.notEmpty(ug)) {
			if (RegexUtil.notEmpty(gu)) {
				ug = new UserGroup();
				ug.setId(gu.getId());
				ug.setType(gu.getType());
				ug.setCell(gu.getCell());
				ug.setCname(gu.getCname());
				ug.setEmail(gu.getEmail());
				ug.setEname(gu.getEname());
				ug.setJobNo(gu.getJobNo());
				ug.setPortrait(gu.getPortrait());
				ug.setPwd(gu.getPwd());
				ug.setComment(DateUtil.formatDateTime(new Date())); // 添加登录时间

				Iterator<GomGroup> it = gu.getGroups().iterator();
				while (it.hasNext()) {
					GomGroup g = it.next();
					if (g.getType().equals(GroupType.DEPARTMENT)) {
						ug.setDepartment(g.getEname());
						ug.setCdepartment(g.getCname());
						ug.setDptId(g.getId());
					} else if (g.getType().equals(GroupType.POSITION)) {
						ug.setPosition(g.getEname());
						ug.setCposition(g.getCname());
						ug.setPstId(g.getId());
					} else if (g.getType().equals(GroupType.ROLE)) {
						ug.setRole(g.getEname());
						ug.setCrole(g.getCname());
						ug.setRoleId(g.getId());
					}
				}
			}
			
			//添加登录记录
			Login l = new Login();
			l.setUg(ug);
			l.setLoginIP(ip);
			l.setReportMark(false);
			l.setLoginTake(DateUtil.formatCurDateToTime());
			HandlerState str = userService.saveLogin(l);
			if(HandlerState.SUCCESS.equals(str)) {
				addCookie(ug, request.getServerName(), response); // 添加cookie
				ug.setLocale(request.getLocale()); // set当前国际化语言
				ug.setOnlineUsers(sessionRegistry.getAllPrincipals().size());
				request.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug); // 添加session
				
				//记录日志
				Logs lf = new Logs();
				lf.setDated(new Date());
				lf.setUserId(ug.getId());
				lf.setLogger("登录成功");
				lf.setMessage("用户"+ug.getEname()+" 于 "+ DateUtil.formatDate(new Date())+" 登录系统，登录IP："+ip);
				log.debug(JsonUtils.toJson(lf));
			} 
			else throw new AuthenticationException("登录出错");

			if (ug.getRole().equals("User")) url = "app/index.htm";
			else if (ug.getRole().equals("Admin")) url = "admin/index.htm";
			
			if (ajax) {
				response.setHeader("Content-Type", "application/json;charset=UTF-8");
				try {
					PrintWriter writer = response.getWriter();
					Map<String, Object> m = new HashMap<String, Object>();
					m.put("url", url);
					m.put("result", HandlerState.SUCCESS);
					writer.write(JsonUtils.toJson(m, new TypeToken<Map<String, Object>>() {}.getType()));
					writer.flush();
					writer.close();
				} catch (IOException ex) {
					log.error("LoginSuccessHandle onAuthenticationSuccess have error !", ex);
				}
			} else {
				setDefaultTargetUrl("/"+url);
				super.onAuthenticationSuccess(request, response, authentication);
			}
		}
	}

	// 获得IP
	private String getRemortIP(HttpServletRequest request) {
		if (request.getHeader("x-forwarded-for") == null) {
			return request.getRemoteAddr();
		}
		return request.getHeader("x-forwarded-for");
	}

	// 添加cookie
	private void addCookie(UserGroup user, String host, HttpServletResponse res) throws UnsupportedEncodingException {
		String userJson = JsonUtils.toJson(user, new TypeToken<UserGroup>() {}.getType());
		Cookie cookie = new Cookie(SessionAttr.USER_TAKEN.name(), URLEncoder.encode(userJson, "utf-8"));
		cookie.setMaxAge(15 * 60 * 60); // 保存15个小时
		cookie.setDomain(host);
		res.addCookie(cookie);
	}
}
