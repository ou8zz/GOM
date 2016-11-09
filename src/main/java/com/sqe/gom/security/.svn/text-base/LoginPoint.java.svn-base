package com.sqe.gom.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.util.RegexUtil;

public class LoginPoint extends UsernamePasswordAuthenticationFilter {

	private boolean postOnly = true;  
    private boolean allowEmptyValidateCode = false;
    public static final String SPRING_SECURITY_LAST_USERNAME_KEY = "SPRING_SECURITY_LAST_USERNAME";  
    
    @Override  
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {  
        if (postOnly && !request.getMethod().equals("POST")) {  
            throw new AuthenticationServiceException("Authentication method not supported: " + request.getMethod());  
        }
        String username = obtainUsername(request);
        String password = obtainPassword(request);
        if (username == null) username = "";
        if (password == null) password = "";
        username = username.trim();
        
        //如果有验证码
        if(!allowEmptyValidateCode) validate(request);
        
        UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(username, password);

        // Allow subclasses to set the "details" property
        setDetails(request, authRequest);
        
        Authentication authentication = this.getAuthenticationManager().authenticate(authRequest);
        SecurityContextHolder.getContext().setAuthentication(authentication);
        return authentication;    
    }
    
    /**
     * 验证码
     * @param req
     */
    private void validate(HttpServletRequest req) {
    	int c = 0;
    	String num = req.getParameter("num");
		if(RegexUtil.notEmpty(num)) c = Integer.valueOf(num);
    	String code = req.getParameter("code");
		String rc = (String)req.getSession().getAttribute(SessionAttr.RANDCODE.name());
		if(RegexUtil.notEmpty(code) && !code.equalsIgnoreCase(rc)) {
			throw new AuthenticationServiceException("您的验证码有误，请重新输入");
		} 
		
		if(c >= 5){
			throw new AuthenticationServiceException("loginMax5");
		}
    }
    
    public boolean isPostOnly() {  
        return postOnly;  
    }  
  
    @Override  
    public void setPostOnly(boolean postOnly) {  
        this.postOnly = postOnly;  
    }  
    
    public boolean isAllowEmptyValidateCode() {  
        return allowEmptyValidateCode;  
    }  
  
    public void setAllowEmptyValidateCode(boolean allowEmptyValidateCode) {  
        this.allowEmptyValidateCode = allowEmptyValidateCode;  
    }  

}
