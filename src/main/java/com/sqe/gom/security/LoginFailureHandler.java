/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.security;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.model.Logs;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;

/**
 * @description 登录失败处理
 * @author Ole
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 10, 2013
 * @version 3.0
 */
public class LoginFailureHandler extends SimpleUrlAuthenticationFailureHandler {
	private Log log = LogFactory.getLog(LoginFailureHandler.class);
//	private UserService userService;
//
//	@Resource(name = "userService")
//	public void setUserService(UserService userService) {
//		this.userService = userService;
//	}
	
	/**
	 * 登陆错误如果是ajax登录返回错误状态
	 * 如果是提交错误不做处理，直接交给父类
	 */
	@Override
	public void onAuthenticationFailure(HttpServletRequest request,
			HttpServletResponse response, AuthenticationException exception)
			throws IOException, ServletException {
		response.setContentType("text/html;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		Map<String, Object> m = new HashMap<String, Object>();
		Boolean ajax = Boolean.valueOf(request.getParameter("ajax"));
		PrintWriter writer = null;
		if (ajax) {
			try {
				writer = response.getWriter();
				m.put("result", HandlerState.FAILED);
				if("loginMax5".equals(exception.getMessage())) {
					String ename = request.getParameter("j_username");
					//userService.lockUser();
					Logs lf = new Logs();
					lf.setDated(new Date());
					lf.setLogger("账户已锁定");
					lf.setMessage("用户"+ename+" 于 "+ DateUtil.formatDate(new Date())+" 登录系统错误次数过多，因被暂时锁定停止使用30分钟，请稍后重试。");
					log.warn(JsonUtils.toJson(lf));
					
					m.put("msg", "登录系统错误次数过多，因被暂时锁定停止使用30分钟，请稍后重试。");
				} 
				else m.put("msg", exception.getMessage());
				
				m.put("c", Integer.valueOf(request.getParameter("num")));
				writer.write(JsonUtils.toJson(m, new TypeToken<Map<String, Object>>() {}.getType()));
			} catch (IOException ex) {
				log.error("LoginFailureHandler onAuthenticationFailure have error !", ex);
			} finally {
				writer.flush();
				writer.close();
			}
		} else {
			super.onAuthenticationFailure(request, response, exception);
		}
	}

}
