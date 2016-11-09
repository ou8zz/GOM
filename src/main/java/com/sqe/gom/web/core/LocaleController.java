package com.sqe.gom.web.core;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.UserGroup;

/**
 * @description change locale.
 * @author <a href="mailto:sqe_ole@126.com">Ole</a>
 * @date Aug 7, 2012  11:04:25 PM
 * @version 3.0
 */
@Controller
public class LocaleController {
	
	//点击切换语言
	@RequestMapping(method=RequestMethod.POST, value = "/changeLocale.htm")
	public void changeLocale(HttpServletRequest req, HttpServletResponse res, HttpSession session) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		String lang = req.getParameter("lang");
		
		//Locale locale = (Locale) session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
		Locale locale = null;
		
		if(RegexUtil.notEmpty(lang) && lang.equals("zh_TW")) locale = Locale.TRADITIONAL_CHINESE;
		else locale = Locale.SIMPLIFIED_CHINESE;
			
		session.setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, locale);
		UserGroup user = (UserGroup) session.getAttribute(SessionAttr.USER_TAKEN.name());
		user.setLocale(locale);		//set当前国际化语言
		session.setAttribute(SessionAttr.USER_TAKEN.name(), user);	//添加session
		
		//req.getRequestDispatcher("app/index.htm").forward(req, res);
	}
		
	
}
