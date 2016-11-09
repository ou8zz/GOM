/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.security;

import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.rememberme.TokenBasedRememberMeServices;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.vo.UserGroup;

/**
 * @description	自定义Security Cookie
 * @author Ole
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 13, 2013
 * @version 3.0
 */
public class GomTokenBasedRememberMeServices extends TokenBasedRememberMeServices {
	
	public GomTokenBasedRememberMeServices(String key, UserDetailsService userDetailsService) {
        super(key, userDetailsService);
    }
	
	@Override
	protected void setCookie(String[] tokens, int maxAge, HttpServletRequest request, HttpServletResponse response) {
		UserGroup user = (UserGroup)request.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		String[] tokensWithIPAddress = Arrays.copyOf(tokens, tokens.length+1);  
		tokensWithIPAddress[tokensWithIPAddress.length-1] = JsonUtils.toJson(user, new TypeToken<UserGroup>() {}.getType());
		super.setCookie(tokens, maxAge, request, response);
	}

}
