/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.w3c.dom.Document;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.ResourceService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.model.Category;
import com.sqe.gom.model.Logs;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.util.XmlHelper;

/**
 * @description user entry report to submit information.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 7, 2011  11:04:25 PM
 * @version 3.0
 */
@Controller
public class CategoryController {
	private Log log = LogFactory.getLog(CategoryController.class);
	private PrintWriter out;
	private Map<String, Object> map = new HashMap<String, Object>();
	private HandlerState str = HandlerState.FAILED;
	private ResourceService resourceService;
		
	@Resource(name = "resourceService")
	public void setResourceService(ResourceService resourceService) {
		this.resourceService = resourceService;
	}
		
	//后台文件分组配置
	@RequestMapping(method = RequestMethod.GET, value = "/app/resource_category.htm")
	public String getCategorys() { return "admin/category"; }
	
	/**
	 * 目录表树形显示 
	 * @param req
	 * @param res
	 * @return
	 */
	@RequestMapping(method=RequestMethod.POST, value="/get_ctree.htm")
	public void getPaths(HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(resourceService.getCtree()));
		} catch (Exception e) {
			log.error("get_ctree.htm have a error!", e);
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
		}
    }
	
	/**
	 * Category信息输出显示 
	 * @param req
	 * @param res
	 * @return
	 */
	@RequestMapping(method=RequestMethod.GET, value="/app/get_category.htm")
	public void getCategory(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("application/xhtml+xml;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String nodeid = req.getParameter("nodeid");
		int level = 0;
		if(RegexUtil.notEmpty(nodeid) && Integer.parseInt(nodeid) > 0) {
			level = Integer.parseInt(req.getParameter("n_level"));
			level++;
		} 
		try {
			Document doc = resourceService.getCategories(nodeid, level);
			XmlHelper.OutputXmlStream(new DOMSource(doc), new StreamResult(res.getOutputStream()));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * category信息操作<添加，保存>
	 * @param u
	 * @param result
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/save_category.htm")
	public void saveCategory(@ModelAttribute("c") Category c, BindingResult result, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String opt = "添加";
		try {
			out = res.getWriter();
			if(RegexUtil.notEmpty(c.getId())) opt = "修改";
			if(RegexUtil.notEmpty(c.getName())) {
				resourceService.saveCategory(c);
				str = HandlerState.SUCCESS;
				
				Logs lf = new Logs();
				lf.setLogger("文件分组");
				lf.setDated(new Date());
				lf.setMessage(c.getName()+opt+"操作成功，Category ID号为："+c.getId());
				log.debug(JsonUtils.toJson(lf));
			} 
		} catch (Exception e) {
			str = HandlerState.ERROR;
			log.error("/admin/save_category.htm have a error!", e);
		} finally {
			map.put("result", str);
			out.write(JsonUtils.toJson(map, new TypeToken<Map<String,Object>>() {}.getType()));
			map.clear();
			if (out != null) {out.flush();out.close();}
		}
	}

	/**
	 * category信息操作<删除>
	 * @param id
	 * @param result
	 * @return
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/del_category.htm")
	public void deleteCategory(@RequestParam("id")Integer id, HttpServletResponse res) {
		try {
			out = res.getWriter();
			if(RegexUtil.notEmpty(id)) {
				resourceService.removeCategory(id);
				str = HandlerState.SUCCESS;
				
				Logs lf = new Logs();
				lf.setLogger("删除分组");
				lf.setDated(new Date());
				lf.setMessage("您的删除操作成功，ID号为："+id);
				log.debug(JsonUtils.toJson(lf));
			} 
		} catch (Exception e) {
			str = HandlerState.ERROR;
			log.error("/admin/del_category.htm have a error!", e);
		} finally {
			map.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(map, new TypeToken<Map<String,Object>>() {}.getType()));
			map.clear();
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
}
