/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.filter;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.Trees;
import com.sqe.gom.vo.UserGroup;

/**
 * @description 登录拦截
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Nov 20, 2011  3:31:35 PM
 * @version 3.0
 */
public class AuthenticationFilter implements Filter {
	HttpSession session;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
		session =req.getSession(false);
		
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		/**
		 * author just in ray
		 * make sure browser no cache.
		 */
		res.setHeader("Cache-Control", "no-cache");
		res.setHeader("Cache-Control", "no-store");
		res.setDateHeader("Expires", 0);
		res.setHeader("Pragma", "no-cache");
		
		//get context root path
		String curURL = req.getRequestURI();
		// get current file name cut other to compare
		String tarURL = curURL.substring(curURL.indexOf("/", 1), curURL.length());
		
		/**  控制用户访问Url
		if(req.getMethod().equals("GET") && session != null && session.getAttribute(SessionAttr.USER_TAKEN.name()) != null) {
			UserGroup user = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
			Map<String, List<Trees>> treeMap = ZtreeServiceImpl.treeMap;
			
			if(!treeMap.isEmpty() && RegexUtil.notEmpty(treeMap.get(user.getEname()))) {
				List<Trees> list = treeMap.get(user.getEname());
				boolean bool = getUserUrl(tarURL, list);
				if(!bool) {
					String sendUrl = "/denyAccess.html";
					if(curURL.indexOf("gom") > 0) sendUrl = "/gom/denyAccess.html";
					res.sendRedirect(sendUrl);
				}
			}
		}*/
		
		//判断当前页是否是重定向以后的登录页，若是就不做session的判断，防止出现死循环
		if(!"/gom/index.html".equals(tarURL)) {
			if(session == null || session.getAttribute(SessionAttr.USER_TAKEN.name()) == null) {
				req.getSession().setAttribute("LOGIN_URL", curURL);
				
				//如果浏览器session不存在，检查cookie是否存在
				Cookie[] cookies = req.getCookies();  
		        UserGroup user = null;
		        if (RegexUtil.notEmpty(cookies)) {  
					for (Cookie cookie : cookies) {
						if (SessionAttr.USER_TAKEN.name().equals(cookie.getName())) {
							// 取得cookie
							user = JsonUtils.fromJson(URLDecoder.decode(cookie.getValue(), "utf-8"), new TypeToken<UserGroup>() {}.getType());
						}
					}
					// 如果存在添加session否则返回到登录页面
					if (RegexUtil.notEmpty(user)) req.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), user);
					else {
						String sendUrl = "/index.html";
						if(curURL.indexOf("gom") > 0) sendUrl = "/gom/index.html";
						res.sendRedirect(sendUrl);
					}
		        }
			}
		}
		
		chain.doFilter(req, res);
	}

	@Override
	public void destroy() {
		session.invalidate();
	}
	
	/**
	 * 判断访问Url是否于用户关联存在
	 * @param tarUrl
	 * @param list
	 * @return
	 */
	boolean getUserUrl(String tarUrl, List<Trees> list) {
		for(Trees t : list) {
			if(t.getUrl().length() > 1) {
				int i = tarUrl.indexOf("get_");
				int j = tarUrl.indexOf("save_");
				int k = tarUrl.indexOf("edit_");
				int l = tarUrl.indexOf("del_");
				int m = tarUrl.indexOf("next_");
				int n = tarUrl.indexOf("check_");
				int v = tarUrl.indexOf("chk_");
				int d = tarUrl.indexOf("download");
				int x = tarUrl.indexOf("index");
				
				//如果URL前缀带有以上字符表通过
				boolean val = (i>0 || j>0 || k>0 || l>0 || m>0 || n>0 || v>0 || d>0 || x>0) ? true:false;
				if(val) return true;
				
				//如果URL为用户tree中的表通过
				String tUrl = t.getUrl().substring(t.getUrl().indexOf("/", 1), t.getUrl().length());
				if(tarUrl.equals(tUrl)) {
					return true;
				}
			}
		}
		return false;
	}
	
}
