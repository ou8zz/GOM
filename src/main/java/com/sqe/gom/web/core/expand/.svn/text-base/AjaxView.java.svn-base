package com.sqe.gom.web.core.expand;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.view.AbstractView;

import com.google.gson.Gson;

/**
 * @description AJAX view handler
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 7, 2011 11:04:25 PM
 * @version 3.0
 */
public class AjaxView extends AbstractView {
	private final Log log = LogFactory.getLog(AjaxView.class);

	@Override
	protected void renderMergedOutputModel(@SuppressWarnings("rawtypes") Map m, HttpServletRequest req, HttpServletResponse res) throws Exception {
		log.info("Resolving AJAX request view -" + m);
		Gson json = new Gson();
		String jsonStr = json.toJson(m);
		res.setContentType("text/plain;charset=UTF-8");
		res.getOutputStream().write(jsonStr.getBytes());
	}
}
