package com.sqe.gom.web.core;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.UserService;
import com.sqe.gom.app.ZtreeService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.dao.ConfigDAO;
import com.sqe.gom.model.Login;
import com.sqe.gom.model.Logs;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.UserGroup;

/**
 * @description handler user login information.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 7, 2011  11:04:25 PM
 * @version 3.0
 */
@Controller
public class LoginController {
	private Log log = LogFactory.getLog(LoginController.class);
	private UserService userService;
	private ZtreeService ztreeService;
	private ConfigDAO configDao;
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private HandlerState str = HandlerState.FAILED;
	private Boolean isLogin = true;

	@Autowired
	public void setUserService(UserService userSerivce) {
		this.userService = userSerivce;
	}
	
	@Autowired
	public void setZtreeService(ZtreeService ztreeService) {
		this.ztreeService = ztreeService;
	}
	
	@Resource(name="configDao")
	public void setConfigDao(ConfigDAO configDao) {
		this.configDao = configDao;
	}
	
	@RequestMapping(method=RequestMethod.GET, value = "/login.htm")
	public String loginPage() {return "login";}
	
	//临时登录（仅供测试用）
	@RequestMapping(method=RequestMethod.POST, value = "/tempLogin.htm")
	public void tempLogin(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		res.setCharacterEncoding("UTF-8");
		
		try {
			out = res.getWriter();
			UserGroup user = userService.login(req.getParameter("ename"), "905dcb52b6585ac391ffcf8162cd6c99");
			req.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), user);
			if(RegexUtil.notEmpty(user)) {
				if(isLogin) {
					isLogin = false;
					String ip = getRemortIP(req);
					Login l = new Login();
					l.setUg(user);
					l.setLoginIP(ip);
					l.setReportMark(false);
					l.setLoginTake(DateUtil.formatCurDateToTime());
					str = userService.saveLogin(l);
					user.setLocale(req.getLocale());
					addCookie(user, req.getServerName(), res);	//添加cookie
				} 
				isLogin = true;
			}
		} catch (Exception e) {
			str = HandlerState.ERROR;
			log.error("tempLogin.htm have error !", e);
		} finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			m.clear();
			if (out != null) {out.flush();out.close();}
		}
		//req.getRequestDispatcher("app/index.htm").forward(req, res);
	}
	
	/**
	 * 登录成功查询是否有异常 
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/login_abnormal.htm")
	public void checkLoginAbnormal(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		PrintWriter pw = null;
		try {
			pw = res.getWriter();
			if(userService.checkLoginAbnormal(ug.getId())) str = HandlerState.PARAM_EMPTY;
			else str = HandlerState.SUCCESS;
		} catch (Exception e) {
			str = HandlerState.ERROR;
			log.error("/app/login_abnormal.htm have error !", e);
		}finally {
			pw.write(JsonUtils.toJson(str));	
			if (pw != null) {
				pw.flush();
				pw.close();
			}
		}
	}
	
	/**
	 *  check cname or ename is exist
	 *  
	 * @param req  request of http
	 * @param res  response of http
	 */
	@RequestMapping(method=RequestMethod.POST, value = "/login.htm")
	public void login(HttpServletRequest req, HttpServletResponse res) {
		m.clear();
		res.setContentType("text/html; charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		String name = null;
		String pwd = null;
		String num = null;
		String ip = getRemortIP(req);
		int c = 0;
		//防止多重点击提交
		if(isLogin) {
			name = req.getParameter("userName");
			pwd = req.getParameter("password");
			num = req.getParameter("num");
			if(RegexUtil.notEmpty(num)) c = Integer.valueOf(num);
		} 
		isLogin = true;
		
		try {
			out = res.getWriter();
			//begin logic
			if(RegexUtil.notEmpty(name)&& RegexUtil.notEmpty(pwd) && c > 0) {
				m.put("c", c);
				m.put("result", HandlerState.FAILED);
				
				// number condition
				if(c >= 1) {
					String code = req.getParameter("code");
					String rc = (String)req.getSession().getAttribute(SessionAttr.RANDCODE.name());
					if(!code.equalsIgnoreCase(rc)) {
						m.put("result", HandlerState.PARAM_EMPTY);
						m.put("msg", "验证码有误，请重新输入");
					} else {
						//login condition
						UserGroup user = userService.login(name, pwd);
						if(RegexUtil.notEmpty(user) && RegexUtil.notEmpty(user.getEname())) {
							Login l = new Login();
							l.setUg(user);
							l.setLoginIP(ip);
							l.setReportMark(false);
							l.setLoginTake(DateUtil.formatCurDateToTime());
							str = userService.saveLogin(l);
							user.setLocale(req.getLocale());		//set当前国际化语言
							req.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), user);	//添加session
							addCookie(user, req.getServerName(), res);	//添加cookie
							m.put("result", str);
							m.put("page", "app/index.htm");
							
							Logs lf = new Logs();
							lf.setDated(new Date());
							lf.setUserId(user.getId());
							lf.setLogger("登录成功");
							lf.setMessage("用户"+name+" 于 "+ DateUtil.formatDate(new Date())+" 登录系统，登录IP："+ip);
							log.debug(JsonUtils.toJson(lf));
							
						}else {
							//check lock time have expired and user exist?
							String[] str = userService.chkLogLock(name, pwd);
							m.put("msg", str[0]);
							if(Integer.valueOf(str[1]) > 0) m.put("c", str[1]);
						}
					}
				} 
				
				if(c >= 5){
					userService.lockUser();
					m.put("msg", "账户已锁定，请30分钟后再登录");
					out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
					
					Logs lf = new Logs();
					lf.setDated(new Date());
					lf.setLogger("账户已锁定");
					lf.setMessage("用户"+name+" 于 "+ DateUtil.formatDate(new Date())+" 登录系统错误次数过多，因被暂时锁定停止使用30分钟，请稍后重试。");
					log.warn(JsonUtils.toJson(lf));
				}
			}
			else {m.put("result", HandlerState.PARAM_EMPTY);m.put("msg", "帐户有误，请核实");}
		
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		} catch (IOException e) {
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		}finally {
			m.clear();
			if (out != null) { out.flush(); out.close(); }
		}
	}
	
	//登出、发送报表
	@RequestMapping(method = RequestMethod.GET, value = "/logout.htm")
	public void logout(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		String report = req.getParameter("report");
		
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		try {
			if(RegexUtil.notEmpty(ug)) {
				userService.loginOut(ug, report);			//登出操作
				req.getSession().removeAttribute(SessionAttr.USER_TAKEN.name());	//清空SESSION
				removeCookies(req, res);											//清空Cookie
				ztreeService.removeTreeMap(ug.getEname());							//清空用户ZtreeMap
				delAllFile(configDao.getConfig("fileUpload.rootPath").getValue() + "temp/");	//清空临时文件目录
			}
			req.getRequestDispatcher("/index.html").forward(req, res);				//跳转index页面
		} catch (IOException e) {
			log.error("/logout.htm have error!", e);
		} catch (ServletException e) {
			log.error("have an error occurred when logout system.");
		}
	}
	
	//删除目录下所有文件
	private void delAllFile(String filepath) throws IOException {
		File f = new File(filepath);// 定义文件路径
		if (f.exists() && f.isDirectory()) {// 判断是文件还是目录
			if (f.listFiles().length == 0) {// 若目录下没有文件则直接删除
				//f.delete();
			} else {// 若有则把文件放进数组，并判断是否有下级目录
				File delFile[] = f.listFiles();
				int i = f.listFiles().length;
				for (int j = 0; j < i; j++) {
					if (delFile[j].isDirectory()) {
						delAllFile(delFile[j].getAbsolutePath());// 递归调用del方法并取得子目录路径
					}
					delFile[j].delete();// 删除文件
				}
			}
		}
	}
	
	//获得IP
	private String getRemortIP(HttpServletRequest request) {
		if (request.getHeader("x-forwarded-for") == null) {
			return request.getRemoteAddr();
		}
		return request.getHeader("x-forwarded-for");
	} 
	
	//添加cookie
	private void addCookie(UserGroup user, String host, HttpServletResponse res) throws UnsupportedEncodingException  {
		String userJson = JsonUtils.toJson(user, new TypeToken<UserGroup>() {}.getType());
		Cookie cookie = new Cookie(SessionAttr.USER_TAKEN.name(), URLEncoder.encode(userJson, "utf-8"));
		cookie.setMaxAge(15*60*60);		//保存15个小时
		cookie.setDomain(host);
		res.addCookie(cookie);
	}
	
	//移除所有cookie
	private void removeCookies(HttpServletRequest req, HttpServletResponse res) {
		Cookie[] cookies = req.getCookies();
		if(RegexUtil.notEmpty(cookies) && cookies.length > 0) {
			for (Cookie cookie : cookies) {
				cookie.setMaxAge(0);
				res.addCookie(cookie);
			}
		}
	}
}
