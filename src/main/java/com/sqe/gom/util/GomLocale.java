/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.util;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.i18n.AcceptHeaderLocaleResolver;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 18, 2013
 * @version 3.0
 */
public class GomLocale extends AcceptHeaderLocaleResolver {

	private Locale myLocal;   
	
	public Locale resolveLocale(HttpServletRequest request) {   
		return myLocal;   
	}
	
	public void setLocale(HttpServletRequest request, HttpServletResponse response, Locale locale) {   
		System.out.println("语言---------------- " + locale.getLanguage());
		myLocal = locale;   
	}   
	     
}
