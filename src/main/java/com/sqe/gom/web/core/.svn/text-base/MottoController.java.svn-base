/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.MottoService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.model.Motto;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;

/**
 * @description 公司格言
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Controller
public class MottoController {
	private Log log = LogFactory.getLog(MottoController.class);
	private PrintWriter out;
	private MottoService mottoService;
	private Map<String, Object> m = new HashMap<String, Object>();
	private HandlerState str = HandlerState.FAILED;
	
	@Resource(name="mottoService")
	public void setMottoService(MottoService mottoService) {
		this.mottoService = mottoService;
	}
		
	//格言页面
	@RequestMapping(method = RequestMethod.GET, value = "/admin/motto_config.htm")
	public String getMotto(Model model) {
		model.addAttribute("motto", mottoService.getMotto());
		return "app/motto";
	}

	//保存格言
	@RequestMapping(method = RequestMethod.POST, value = "/admin/save_motto.htm")
	public void saveMotto(@ModelAttribute("motto")Motto motto, BindingResult result, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			if(RegexUtil.notEmpty(motto.getMottoText())) {
				mottoService.saveMotto(motto);
				m.put("motto", motto);
				str = HandlerState.SUCCESS;
			} else str = HandlerState.PARAM_EMPTY;
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(), true));	
		} catch (IOException e) {
			log.error("/save_motto.htm have error!", e);
		}
	}
	
}
