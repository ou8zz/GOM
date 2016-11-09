/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


/**
 * @description  Set request's character encoding. The default encoding is set to UTF-8
 * @see javax.servlet.Filter
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 7, 2011  10:54:30 PM
 * @version 3.0
 */
public class EncodingFilter implements Filter {
	private Log log = LogFactory.getLog(getClass());

	private String encoding = "UTF-8";

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.Filter#destroy()
	 */
	public void destroy() {
		log.info("EncodingFilter destroyed.");

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest,
	 *      javax.servlet.ServletResponse, javax.servlet.FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding(encoding);
		chain.doFilter(request, response);

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.Filter#init(javax.servlet.FilterConfig)
	 */
	public void init(FilterConfig filterConfig) throws ServletException {
		String encoding = filterConfig.getInitParameter("encoding");
		if (encoding != null && !"".equals(encoding.trim()))
			this.encoding = encoding.trim();
		log.info("Request character encoding is set to " + encoding);
	}
}
