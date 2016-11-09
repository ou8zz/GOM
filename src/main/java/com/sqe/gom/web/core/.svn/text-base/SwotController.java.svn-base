/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.SwotService;
import com.sqe.gom.constant.DateRange;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.model.SwotConfig;
import com.sqe.gom.model.SwotResult;
import com.sqe.gom.util.ExcelHelper;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description SWOT Action
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 19, 2012
 * @version 3.0
 */
@Controller
public class SwotController {
	private Log log = LogFactory.getLog(TrainingController.class);
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private HandlerState str = HandlerState.FAILED;
	private SwotService swotService;
		
	@Autowired
	public void setSwotService(SwotService swotService) {
		this.swotService = swotService;
	}
	
	//SWOT配置 页面
	@RequestMapping(method = RequestMethod.GET, value = "/admin/swot_config.htm")
	public String swotConfigPage() { return "app/swotconfig"; }
	
	/**
	 * Test	测试SWOT数据
	 * @param sc
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/get_testswot.htm")
	public void getSwot(@ModelAttribute("sc") SwotConfig sc, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		List<String> list = null;
		List<SwotResult> results = new ArrayList<SwotResult>();
		String type = req.getParameter("type");
		try {
			out = res.getWriter();
			//拿到excel表数据
			List<Float> data = ExcelHelper.getExcelForSwot(new File(req.getSession().getServletContext().getRealPath("/uploads/doc/SWOTTest.xls")));
			if("stable".equals(type)) list = swotService.stable(sc, data);
			else if("improve".equals(type)) list = swotService.improve(sc, data);
			int i = sc.getDatum();
			for(String s : list) {
				SwotResult sr = new SwotResult();
				sr.setData(data.get(i));
				sr.setSwot(s);
				results.add(sr);
				i++;
			}
			m.put("list", results);
			m.put("result", HandlerState.SUCCESS);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));	
		} catch (Exception e) {
			log.error("get_testswot.htm have a error!", e);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));	
		} finally {
			m.clear();
			if (out != null) {out.flush();out.close();}
		}
	}
	
	/**
	 * 前台SWOT conifg展现方法
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/get_swotconfig.htm")
	public void getSwotConfigs(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<SwotConfig> grid = new JGridHelper<SwotConfig>();
		grid.jgridHandler(req, res, "p.");
		
		String range = req.getParameter("range");
		try {
			out = res.getWriter();
			if(RegexUtil.notEmpty(range)) grid.setQ(" AND p.range="+DateRange.valueOf(range).ordinal());
			out.write(JsonUtils.toJson(swotService.getSwotConfigs(grid), new TypeToken<JGridBase<SwotConfig>>() {}.getType(),true));
		} catch (Exception e) {
			log.error("get_swotconfig.htm have a error!", e);
		} finally {
			if (out != null) {out.flush();out.close();}
			grid = null;
		}
	}
	
	/**
	 * 前台SWOT Config<添加，编辑>
	 * @param SwotConfig
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/admin/save_swotconfig.htm")
	public void saveSwotConfig(@ModelAttribute("sc") SwotConfig sc, HttpServletRequest req, HttpServletResponse res){
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			if(RegexUtil.isEmpty(sc.getCenterline())) {
				str = HandlerState.PARAM_EMPTY;
			} else {
				swotService.saveSwotConfig(sc);
				str = HandlerState.SUCCESS;
				m.put("sc", sc);
			}
			m.put("result", str);
		} catch (IOException e) {
			m.put("result", HandlerState.ERROR);
		}finally {
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			m.clear();
			if (out != null) {out.flush();out.close();}
		}
	}
	
	/**
	 * 删除SWOT Config
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/admin/del_swotconfig.htm")
	public void saveSwotConfig(@RequestParam("id") Integer id, HttpServletResponse res){
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			swotService.removeSwotConfig(id);
			m.put("result", HandlerState.SUCCESS);
		} catch (IOException e) {
			m.put("result", HandlerState.ERROR);
		}finally {
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			m.clear();
			if (out != null) {out.flush();out.close();}
		}
	}
}
