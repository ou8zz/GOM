package com.sqe.gom.web.core;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.GomService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.model.Config;
import com.sqe.gom.model.Logs;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

@Controller
public class ConfigController {
	private Log log = LogFactory.getLog(ConfigController.class);
	private GomService gomService;
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();

	@Autowired
	public void setGomService(GomService gomService) {
		this.gomService = gomService;
	}
	
	@ModelAttribute("configs")
	public Collection<Config> getConfigs() {
		return gomService.getConfigs();
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/admin/config.htm")
	public String setupPosition(Model model) {
		Config def = new Config();
		model.addAttribute("def", def);
		return "admin/config";
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/admin/get_configs.htm")
	public void getConfigs(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		JGridHelper<Config> grid = new JGridHelper<Config>();
		String pre = "c.";
		grid.jgridHandler(req, res, pre);
		String cgroup = req.getParameter("group");
		
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(gomService.getConfigByGroup(cgroup, pre, grid), new TypeToken<JGridBase<Config>>() {}.getType()));
		}catch(Exception ex) {
			log.error("occurred an error when get configDef list", ex);
		}finally {
			if(out !=null){out.flush(); out.close();}
			grid = null;
		}
	}

	
	@RequestMapping(method = RequestMethod.POST, value = "/admin/save_config.htm")
	public void saveConfig(@ModelAttribute("def")Config def, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		try {
			out = res.getWriter();
			m.clear();
			if(RegexUtil.isEmpty(def.getKey()) || RegexUtil.isEmpty(def.getName())) m.put("result", HandlerState.PARAM_EMPTY);
			else {
				if(RegexUtil.isEmpty(def.getValue())) def.setValue(null);
				if(RegexUtil.notEmpty(def.getGroup())) def.setKey(def.getGroup() + "." + def.getKey());
				gomService.saveConfig(def);
				m.put("key", def.getKey());
				m.put("result", HandlerState.SUCCESS);
				out.write(JsonUtils.toJson(m, new TypeToken<Map<String, Object>>() {}.getType()));
				
				Logs lf = new Logs();
				lf.setLogger("参数配置");
				lf.setDated(new Date());
				lf.setMessage("添加key:"+def.getKey()+"对应"+def.getName()+"操作成功");
				log.debug(JsonUtils.toJson(lf));
			}
		} catch (IOException ex) {
			log.error("occurred an error when save config information", ex);
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String, Object>>() {}.getType()));
		}finally {
			if(out != null) {out.flush();out.close();}
			m.clear();
		}
	}
}
