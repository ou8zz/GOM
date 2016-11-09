/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.w3c.dom.Document;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.ProjectService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.model.Project;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.util.XmlHelper;

/**
 * @description 项目管理
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 5, 2012
 * @version 3.0
 */
@Controller
public class ProjectController {
	private Log log = LogFactory.getLog(ProjectController.class);
	private ProjectService projectService;
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private HandlerState str = HandlerState.FAILED;
	
	@Autowired
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
		
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(df,false));
	}	
		
	//项目 主页面
	@PreAuthorize("hasRole('Manager') or hasRole('Director')")
	@RequestMapping(method=RequestMethod.GET, value="/app/project.htm")
	public String projectPage() { return "app/projects"; }
	
	/**
	 * 查询项目,并以AJAX形式返回
	 * 如果pid为空，则返回父项目，反之返回pid所属的所有子项目
	 */
	@RequestMapping(method=RequestMethod.GET, value="/app/get_project.htm")
	public void getProject(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String pid = req.getParameter("pid");
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(projectService.getProjects(pid), new TypeToken<List<Project>>() {}.getType(), JsonUtils.SHORT_DATE_PATTERN, true));
		} catch (Exception e) {
			log.error("/app/get_project.htm have a error!", e);
		} finally {
			if (out != null) {out.flush();out.close();}
		}
	}
	
	/**
	 * jqGrid 树展现所有的项目数据
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/get_projects.htm")
	public void getProjects(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("application/xhtml+xml;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String nodeid = req.getParameter("nodeid");
		int level = 0;
		if(RegexUtil.notEmpty(nodeid) && Integer.parseInt(nodeid) > 0) {
			level = Integer.parseInt(req.getParameter("n_level"));
			level++;
		} 
		try {
			Document doc = projectService.getProjects(nodeid, level);
			XmlHelper.OutputXmlStream(new DOMSource(doc), new StreamResult(res.getOutputStream()));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 保存新建或编辑的项目
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/save_project.htm")
	public void saveProject(@ModelAttribute("project") Project project, BindingResult result, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			
			//检查project的编号 或名称 如果存在则给出占用提示
			if(RegexUtil.notEmpty(project) && RegexUtil.isEmpty(project.getId()) && projectService.checkProject(project)) str = HandlerState.UNSUPPORT;
			else {
				project.setState(ProcessStatus.InProgress);
				projectService.saveProject(project);
				m.put("project", project);
				str = HandlerState.SUCCESS;
			}
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN,true));	
		} catch (Exception e) {
			log.error("occurred an error when save project - /app/save_project.htm", e);
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		}finally {
			m.clear();
			if (out != null) {
				out.flush();
				out.close();
			}	
		}
	}
	
	/**
	 * 根据ID删除项目
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/del_project.htm")
	public void deleteProject(@RequestParam("id")Integer id, HttpServletResponse res) {
		try {
			out = res.getWriter();
			projectService.removeProject(id);
			m.put("result", HandlerState.SUCCESS);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		} catch (Exception e) {
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
		}	
	}
}
