package com.sqe.gom.web.core.expand;

import java.util.Locale;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.AbstractCachingViewResolver;

/**
 * @description AJAX view resolver
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 7, 2011 11:04:25 PM
 * @version 3.0
 */
public class AjaxResolver extends AbstractCachingViewResolver {
	private final Log log = LogFactory.getLog(AjaxResolver.class);
	private String ajaxPrefix;
	private View ajaxView;

	@Override
	protected View loadView(String viewName, Locale locale) throws Exception {
		log.info("viewName==>" + viewName);
		View view = null;
		if(viewName.startsWith(this.ajaxPrefix)) {
			view=ajaxView;
		}
		return view;
	}

	public String getAjaxPrefix() {
		return ajaxPrefix;
	}

	public View getAjaxView() {
		return ajaxView;
	}

	public void setAjaxPrefix(String ajaxPrefix) {
		this.ajaxPrefix = ajaxPrefix;
	}

	public void setAjaxView(View ajaxView) {
		this.ajaxView = ajaxView;
	}
}
