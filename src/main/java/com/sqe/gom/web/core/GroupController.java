package com.sqe.gom.web.core;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.UserService;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.model.Logs;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;
import com.sqe.gom.web.validation.GroupValidator;

/**
 * @description group management controller
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 7, 2011 11:04:25 PM
 * @version 3.0
 */
@Controller
public class GroupController {
	private Log log = LogFactory.getLog(GroupController.class);
	private UserService userService;
	private PrintWriter out;
	private HandlerState str = HandlerState.FAILED;
	private Map<String, Object> m = new HashMap<String, Object>();

	@Autowired
	public void setUserService(UserService userSerivce) {
		this.userService = userSerivce;
	}

	/**
	 * entry group manager page.
	 * 
	 * @param model  initial an empty GomGroup entity
	 * @return  initial of GomGroup entity.
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/group_config.htm")
	public String setupGroup(Model model) {
		GomGroup g = new GomGroup();
		model.addAttribute("g", g);
		return "admin/group";
	}

	/**
	 * group jGrid manager method.
	 * 
	 * @param req  request of http
	 * @param res  response of http
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/get_group.htm")
	public void groupMgr(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<GomGroup> grid = new JGridHelper<GomGroup>();
		grid.jgridHandler(req, res, "g.");
		GroupType type = GroupType.valueOf(GroupType.class,req.getParameter("type"));
		
		try {
			out = res.getWriter();
			String od = " ORDER BY g." + grid.getJq().getSidx() + " " + grid.getJq().getSord();
			List<GomGroup> ls = userService.getGroups(od, grid.getQ(), grid.getP(), type);
			grid.getJq().setList(ls);
			grid.getJq().setRecords(grid.getP().getTotalCount());
			grid.getJq().setTotal(grid.getP().getPageCount());
			out.write(JsonUtils.toJson(grid.getJq(), new TypeToken<JGridBase<GomGroup>>() {}.getType()));
			out.flush();
			out.close();
		} catch (Exception e) {
			log.error("get group list have a error!", e);
		} finally {
			if(out != null) {out.flush();out.close();}
			grid = null;
		}
	}
	
	/**
	 *  check cname or ename is exist
	 *  
	 * @param req  request of http
	 * @param res  response of http
	 */
	@RequestMapping(method=RequestMethod.POST, value = "/admin/check_group.htm")
	public void checkGroup(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		GomGroup g = new GomGroup();
		String id = req.getParameter("id");
		String cname = req.getParameter("cname");
		String ename = req.getParameter("ename");
		GroupType type = GroupType.valueOf(GroupType.class, req.getParameter("type"));
		g.setCname(cname);
		g.setEname(ename);
		g.setType(type);
		if(RegexUtil.notEmpty(id)) g.setId(Integer.valueOf(id));
		
		try {
			out = res.getWriter();
			if(userService.checkGroupIsNull(g))
				str = HandlerState.SUCCESS;
			else str = HandlerState.FAILED;
			
			out.write(str.name());
		} catch (IOException e) {
			out.write(HandlerState.ERROR.name());
		}finally {
			if(out != null) {out.flush();out.close();}
			g = null;
		}
	}

	/**
	 * save or update a group entity
	 * 
	 * @param g group entity.
	 * @param result The response of this method.
	 * @param res This response status
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/admin/save_group.htm")
	public void processSubmit(@ModelAttribute("g") GomGroup g, BindingResult result, HttpServletResponse res) {
		new GroupValidator().validate(g, result);
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		Logs lf = new Logs();
		lf.setDated(new Date());
		try {
			out = res.getWriter();
			if (!result.hasErrors()) {
				if(RegexUtil.notEmpty(g.getId())) {
					lf.setLogger("组编辑");
					lf.setMessage("您更新组 " + g.getType().getDes() + " 为 " + g.getCname() + "(" + g.getEname() + ") 操作成功");
				} else {
					lf.setLogger("新增组");
					lf.setMessage("添加 " + g.getType().getDes() + " 为 " + g.getCname() + "(" + g.getEname() + ") 操作成功");
				}
				
				userService.saveGroup(g);
				if(RegexUtil.notEmpty(g.getId())) m.put("g", g);
				else m.put("g", userService.getGroup(g));
				str = HandlerState.SUCCESS;
				
				log.debug(JsonUtils.toJson(lf));
			} 
			else str = HandlerState.PARAM_EMPTY;
			
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		} catch (IOException e) {
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		}finally {
			m.clear();
			if(out != null) {out.flush();out.close();}
		}
	}
	
	/**
	 * 
	 * @param id  The entity of identify.
	 * @param res   handler of response.
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/del_group.htm")
	public void removeGroup(@RequestParam("id")int id, @RequestParam("ename")String ename,HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		try {
			out = res.getWriter();
			userService.removeGroup(id);
			m.put("result", HandlerState.SUCCESS);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		} catch (IOException e) {
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		}finally {
			m.clear();
			if(out != null) {out.flush();out.close();}
		}
	}
}
