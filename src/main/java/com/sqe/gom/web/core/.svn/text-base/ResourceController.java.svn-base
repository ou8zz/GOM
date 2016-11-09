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
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.ResourceService;
import com.sqe.gom.app.TrainingService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.model.Experience;
import com.sqe.gom.model.Resource;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.PageTag;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.util.TokenProcessor;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description Resource entry report to submit information.
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Aug 7, 2011  11:04:25 PM
 * @version 3.0
 */
@Controller
public class ResourceController {
	private Log log = LogFactory.getLog(ResourceController.class);
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private TokenProcessor tokens = TokenProcessor.getInstance();
	private HandlerState str = HandlerState.FAILED;
	private ResourceService resourceService;
	private TrainingService trainingService;

	@Autowired
	public void setResourceService(ResourceService resourceService) {
		this.resourceService = resourceService;
	}
		
	@Autowired
	public void setTrainingService(TrainingService trainingService) {
		this.trainingService = trainingService;
	}
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(df,false));
	}
	
	//如何做页面
	@RequestMapping(method=RequestMethod.GET, value="/app/howtodo.htm")
	public String howtodoPage(){ return "app/howtodo"; }
	
	//后台文件管理页面
	@RequestMapping(method=RequestMethod.GET, value="/admin/resource_config.htm")
	public String resourcesPage(){ return "admin/resources"; }
	
	/**
	 * 前台查询到所有用户保存过的文件列表
	 * @param m
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.GET, value="/app/resource.htm")
	public String getResourceApp(Model model, HttpServletRequest req, HttpSession session) {
		String resType = "";
		String resTitle = "";
		Integer pageId = 1;
		String pid = req.getParameter("pageId");
		String type = req.getParameter("type");
		String title = req.getParameter("name");
			
		//如果点击下一页或指定页面，则把ID传给pageId; 否则回到第1页
		if(RegexUtil.notEmpty(pid)) pageId = Integer.parseInt(pid);
		Page page = new Page(pageId,20);
		
		//查询
		List<Resource> list = resourceService.getResources(type, title, page);
		
		//分页
		if(RegexUtil.notEmpty(type)) resType = type;
		if(RegexUtil.notEmpty(title)) resTitle = title;
		String strPage = PageTag.getPageTag(page, pageId, req.getRequestURL()+"?type="+resType+"&&name="+resTitle+"&&pageId=");
		model.addAttribute("page", strPage);
		model.addAttribute("list", list);
		model.addAttribute("ftype", resType);
		model.addAttribute("fname", resTitle);
		
		//产生随机数（表单号 ）  
        req.getSession().setAttribute("token", tokens.generateToken());
		return "app/resource";
	}
	
	/**
	 * 获得视频文件
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.GET, value="/app/get_video.htm")
	public void getVideo(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			m.put("video", resourceService.getVideos());
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN,true));
		} catch (IOException e) {
			log.error("/app/get_video.htm have a error!", e);
		} finally {
			m.clear();
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
	/**
	 * 如何做列表URL
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.GET, value="/app/get_howtodos.htm")
	public void getHowtodos(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<Resource> grid = new JGridHelper<Resource>();
		grid.jgridHandler(req, res, "r.");
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(resourceService.getHowtodos(grid,ug.getEname()),new TypeToken<JGridBase<Resource>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN,true));
		} catch (IOException e) {
			log.error("get_howtodos.htm have a error!", e);
		}finally {
			grid = null;
			if (out != null) {out.flush();out.close();}
		}
	}	
	
	/**
	 * 下载如何做新增部分
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/downloadHow.htm")
	public void downloadHow(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String resourceId = req.getParameter("fileName");
		try {
			out = res.getWriter();
			m.put("result", resourceService.getHowtodos(Integer.parseInt(resourceId), req.getSession().getServletContext().getRealPath("/images/sqe_logo.jpg"), req.getSession().getServletContext().getRealPath("/uploads/doc/")));
			str = HandlerState.SUCCESS;
		} catch (Exception e) {
			str = HandlerState.ERROR;
			log.error("/app/downloadHow.htm have a error!", e);
		} finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			m.clear();
			if (out != null) {out.flush();out.close();}
		}
	}	
	
	/**
	 * 下载完成如何做之后，添加一个updateDate
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/updateDownloadDate.htm")
	public void updateDownloadDate(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String resourceId = req.getParameter("resourceId");
		try {
			out = res.getWriter();
			if(RegexUtil.notEmpty(resourceId)) {
				resourceService.addDownloadDate(Integer.parseInt(resourceId));
				str = HandlerState.SUCCESS;
			}
		} catch (Exception e) {
			str = HandlerState.ERROR;
			log.error("/app/updateDownloadDate.htm have a error!", e);
		} finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			m.clear();
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}	
	
	/**
	 * (如何做)下拉框URL
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/select_resources.htm")
	public void getResource(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			m.put("resource", resourceService.getResourceSelect());
		} catch (IOException e) {
			m.put("result", HandlerState.ERROR);
			log.error("select_resources.htm have a error!", e);
		}finally {
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN,true));
			m.clear();
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
	/**
	 * 后台查询到所有用户保存过的文件列表URL
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.GET, value="/admin/get_resources.htm")
	public void getResources(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<Resource> grid = new JGridHelper<Resource>();
		grid.jgridHandler(req, res, "r.");
		try {
			out = res.getWriter();
			List<Resource> list = resourceService.getResources(grid);
			grid.getJq().setList(list);
			grid.getJq().setRecords(grid.getP().getTotalCount());
			grid.getJq().setTotal(grid.getP().getPageCount());
			out.write(JsonUtils.toJson(grid.getJq(),new TypeToken<JGridBase<Resource>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN,true));
		} catch (IOException e) {
			log.error("get_resources.htm have a error!", e);
		}finally {
			grid = null;
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
	/**
	 * 前台文件编辑<添加，修改>
	 * @param Res
	 * @param id
	 * @param result
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/save_resource.htm")
	public void editResource(@ModelAttribute("resource") Resource resource, BindingResult result, HttpServletRequest req, HttpServletResponse res){
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			if(tokens.isTokenValue(req)) {
				UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
				ug.setComment(req.getParameter("oldfile"));
				resourceService.saveResource(resource, ug);
				m.put("res", resource);
				str = HandlerState.SUCCESS;
			}
		} catch (Exception e) {
			str = HandlerState.ERROR;
			log.error("/app/save_resource.htm have error!", e);
		}finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN,true));
			m.clear();
			if (out != null) {
				out.flush();
				out.close();
			}
		}	
	}
	
	/**
	 * 前台如何做编辑<添加，修改>
	 * @param Res
	 * @param id
	 * @param result
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/save_how.htm")
	public void saveHow(@ModelAttribute("experience") Experience experience, BindingResult result, HttpServletRequest req, HttpServletResponse res){
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		UserGroup ug = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		try {
			out = res.getWriter();
			experience.setStudent(ug.getEname());
			trainingService.saveHowAndToResource(experience);
			m.put("how", experience);
			m.put("result", HandlerState.SUCCESS);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(), JsonUtils.SHORT_DATE_PATTERN, true));
		} catch (Exception e) {
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
	 * 后台删除文件URL
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/admin/del_resource.htm")
	public void delResourceAdmin(HttpServletRequest req, HttpServletResponse res) {
		String[] id = req.getParameterValues("id[]");
		try {
			out = res.getWriter();
			resourceService.removeResource(id); 
			m.put("result", HandlerState.SUCCESS);
		} catch (Exception e) {
			m.put("result", HandlerState.ERROR);
		} finally {
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			m.clear();
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}

	
}
