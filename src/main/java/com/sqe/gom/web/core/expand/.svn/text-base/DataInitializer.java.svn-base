/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core.expand;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.support.WebBindingInitializer;
import org.springframework.web.context.request.WebRequest;

/**
 * @description Shared WebBindingInitializer for data's custom editors.
 *              <p>Alternatively, such init-binder code may be put into
 *              {@link org.springframework.web.bind.annotation.InitBinder}
 *              annotated methods on the controller classes themselves.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Sep 26, 2011  8:46:06 PM
 * @version 3.0
 */
public class DataInitializer implements WebBindingInitializer {

	@Override
	public void initBinder(WebDataBinder binder, WebRequest req) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		df.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(df, false));
	}
}
