/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.security;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.access.AccessDeniedHandler;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.util.JsonUtils;

/**
 * @description	能处理Ajax的错误提示
 * @author Ole
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 11, 2013
 * @version 3.0
 */
public class AjaxAccessDeniedHandlerImpl implements AccessDeniedHandler  {
	private String errorPage;
	
	@Override
	public void handle(HttpServletRequest req, HttpServletResponse res, AccessDeniedException accessDeniedException) throws IOException, ServletException {
		boolean isAjax = "XMLHttpRequest".equals(req.getHeader("X-Requested-With"));  
		//如果是ajax请求  
        if (isAjax) {
        	Map<String, Object> m = new HashMap<String, Object>();
    		res.setHeader("Cache-Control", "no-cache");
            res.setContentType("application/json");
//            res.setContentType("text/html;charset=UTF-8");
            PrintWriter out = res.getWriter();
            m.put("error1", "abc");
            out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));	
            out.flush();
            out.close();
        } else {
        	if (!res.isCommitted()) {
                if (errorPage != null) {
                    // Put exception into request scope (perhaps of use to a view)
                    req.setAttribute(WebAttributes.ACCESS_DENIED_403, accessDeniedException);

                    // Set the 403 status code.
                    res.setStatus(HttpServletResponse.SC_FORBIDDEN);

                    // forward to error page.
                    RequestDispatcher dispatcher = req.getRequestDispatcher(errorPage);
                    dispatcher.forward(req, res);
                } else {
                    res.sendError(HttpServletResponse.SC_FORBIDDEN, accessDeniedException.getMessage());
                }
            }
        }  
	}
	
	public void setErrorPage(String errorPage) {
		if ((errorPage != null) && !errorPage.startsWith("/")) {
			throw new IllegalArgumentException("errorPage must begin with '/'");
		}

		this.errorPage = errorPage;
	}
}
