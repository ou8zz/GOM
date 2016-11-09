/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.w3c.dom.Document;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.ZtreeService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.model.Ztree;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.util.XmlHelper;
import com.sqe.gom.vo.Trees;
import com.sqe.gom.vo.UserGroup;

/**
 * @description SWOT Action
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 19, 2012
 * @version 3.0
 */
@Controller
public class ZtreeController {
	private Log log = LogFactory.getLog(ZtreeController.class);
//	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private HandlerState str = HandlerState.FAILED;
	private ZtreeService ztreeService;
	
	@Autowired
	public void setZtreeService(ZtreeService ztreeService) {
		this.ztreeService = ztreeService;
	}
	
	//后台树目录
	@RequestMapping(method = RequestMethod.GET, value = "/admin/trees.htm")
	public String getZtrees() { return "admin/ztree"; }
	
	//后台树配置
	@RequestMapping(method = RequestMethod.GET, value = "/admin/tree_config.htm")
	public String getTreeConfig() { return "admin/tree_config"; }
	
	//后台基础配置Ztree JSP页面
	@RequestMapping(method = RequestMethod.GET, value = "/admin/basic_tree.htm")
	public String getBasicZtree() { return "admin/basic_tree"; }
	
	/**
	 * 展现所有Tree方法（XML输出）
	 * @param req
	 * @param res
	 * @param nodeid 加载这个节点的子节点
	 * @param isBasic 是否为基础配置(true) OR 所有配置(null)
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/get_ztrees.htm")
	public void getZtrees(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("application/xhtml+xml;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String nodeid = req.getParameter("nodeid");
		String isBasic = req.getParameter("isBasic");
		int level = 0;
		boolean b = false;
		PrintWriter out = null;
		try {
			out = res.getWriter();
			if(RegexUtil.notEmpty(isBasic)) b = true;
			if(RegexUtil.notEmpty(nodeid) && Integer.parseInt(nodeid) > 0) {
				level = Integer.parseInt(req.getParameter("n_level"));
				level++;
			}
			Document doc = ztreeService.getZtrees(nodeid, level, b);
			XmlHelper.OutputXmlStream(new DOMSource(doc), new StreamResult(out));
		} catch (Exception e) {
			log.error("url admin/get_ztrees.htm have a error!", e);
		} finally {
			if (out != null) { out.flush(); out.close(); }
		}
	}
	
	@Resource(name="sessionRegistry")
    private SessionRegistry sessionRegistry;
	/**
	 * 左侧Tree加载URL
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/get_left_tree.htm")
	public void getUserZtrees(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String id = req.getParameter("id");
//		String name = req.getParameter("n");
//		String level = req.getParameter("lv");
		PrintWriter out = null;
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		try {
			ug.setLocale(req.getLocale());		//set当前国际化语言
        	ug.setOnlineUsers(sessionRegistry.getAllPrincipals().size());
            req.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug);	//添加session
			
			out = res.getWriter();
			List<Trees> list = ztreeService.getLeftTree(id, ug.getId());
			out.write(JsonUtils.toJson(list));
		} catch (Exception e) {
			log.error("get url get_left_tree.htm have a error!", e);
		} finally {
			if (out != null) { out.flush(); out.close(); }
		}
	}
	
	/**
	 * 加载所有Tree
	 * @param uid 如果uid不为空，则加载用户关联的所有tree
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/get_trees.htm")
	public void getUserNotZtrees(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String userId = req.getParameter("uid");
		PrintWriter out = null;
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(ztreeService.getZtrees(userId), new TypeToken<List<Ztree>>() {}.getType(), true));
		} catch (Exception e) {
			log.error("get action get_trees.htm have a error!", e);
		} finally {
			if (out != null) { out.flush(); out.close(); }
		}
	}
	
	/**
	 * 基础菜单
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/get_basic_tree.htm")
	public void getBasicZtree(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String bool = req.getParameter("basic");
		boolean b = false;
		PrintWriter out = null;
		try {
			out = res.getWriter();
			if(RegexUtil.notEmpty(bool)) b = Boolean.valueOf(bool); 
			out.write(JsonUtils.toJson(ztreeService.getBasicZtree(b), new TypeToken<List<Ztree>>() {}.getType(), true));
		} catch (Exception e) {
			log.error("get action get_basic_tree.htm have a error!", e);
		} finally {
			if (out != null) { out.flush(); out.close(); }
		}
	}
	
	/**
	 * 保存用户配置的tree
	 * @param isAdd 基础配置属性，如果不为空则添加，否则为移除
	 * @param zid[]	需要配置的ztreeID (不能为空)
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/admin/save_treeConfig.htm")
	public void saveUserZtree(HttpServletRequest req, HttpServletResponse res){
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String uid = req.getParameter("uid");
		String isAdd = req.getParameter("isAdd");
		String[] zid = req.getParameterValues("zid[]");
		PrintWriter out = null;
		try {
			out = res.getWriter();
			if(RegexUtil.notEmpty(uid)) {
				ztreeService.editUserTree(Integer.parseInt(uid), zid);
			} else {
				ztreeService.editBasicTree(isAdd, zid);
			}
			str = HandlerState.SUCCESS;
		} catch (IOException e) {
			str = HandlerState.ERROR;
		} catch (NullPointerException e) {
			str = HandlerState.PARAM_EMPTY;
		}finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(), true));	
			m.clear();
			if (out != null) { out.flush(); out.close(); }
		}
	}
	
	/**
	 * 前台<添加，编辑>Tree
	 * @param zt
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/admin/save_ztree.htm")
	public void saveZtree(@ModelAttribute("zt") Ztree zt, HttpServletRequest req, HttpServletResponse res){
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		PrintWriter out = null;
		try {
			out = res.getWriter();
			if(RegexUtil.isEmpty(zt.getName()) || RegexUtil.isEmpty(zt.getTitle())) {
				str = HandlerState.PARAM_EMPTY;
			} else {
				ztreeService.saveZtree(zt);
				str = HandlerState.SUCCESS;
				m.put("ztree", zt);
			}
		} catch (IOException e) {
			str = HandlerState.ERROR;
		}finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(), true));	
			m.clear();
			if (out != null) { out.flush(); out.close(); }
		}
	}

}
