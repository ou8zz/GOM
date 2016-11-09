/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.CommonService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.model.FixedTask;
import com.sqe.gom.model.Logs;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;
import com.sqe.gom.web.validation.FixedTaskValidator;

/**
 * @description 工作管理
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 5, 2012
 * @version 3.0
 */
@Controller
public class FixedTaskController {
	private Log log = LogFactory.getLog(FixedTaskController.class);
	private CommonService commonService;
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	
	@Autowired
	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}

	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		SimpleDateFormat df = new SimpleDateFormat("hh:mm");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(df, false));
	}	
	
	/**
	 * 固定工作显示页面
	 * 
	 * @return  to the page.
	 */
	@RequestMapping(method=RequestMethod.GET, value="/app/fixed_task.htm")
	public String getFixedTasks() {
		return "app/fixed_task";
	}
		
	/**
	 *JQgrid展示固定工作列表
	 *
	 *return list of gird
	 */
	@RequestMapping(method=RequestMethod.GET, value="/app/get_fixedTasks.htm")
	public void getGridFixedTasks(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<FixedTask> grid = new JGridHelper<FixedTask>();
		grid.jgridHandler(req, res, "f.");
		try {
			out = res.getWriter();
			String state = req.getParameter("state");
			out.write(JsonUtils.toJson(commonService.getFixedTasks(grid, state), new TypeToken<JGridBase<FixedTask>>() {}.getType(), true));
		} catch (Exception ex) {
			log.error("get list of getGridFixedTasks have an error!", ex);
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		} finally {grid = null; if (out != null) { out.flush(); out.close(); }}
	}
	
	/**
	 * 查询所有的固定工作
	 */
	@RequestMapping(method=RequestMethod.GET, value="/app/get_fixed_tasks.htm")
	public void getFixedTasks(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");

		try {
			out = res.getWriter();
			
			String state = req.getParameter("state");
			ProcessStatus ps = null;
			if(RegexUtil.notEmpty(state)) ps = ProcessStatus.valueOf(state);
			List<FixedTask> list = commonService.getFixedTasks(ps);
			out.write(JsonUtils.toJson(list,  new TypeToken<List<FixedTask>>() {}.getType(), true));
		}catch (Exception ex) {
			log.error("have an error when get list of fixed tasks!", ex);
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		} finally {m.clear(); if (out != null) {out.flush();out.close();}}
	}
	
	/**
	 * 保存新建或修改的固定工作
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/save_fixedTask.htm")
	public void saveFixedTask(@ModelAttribute("fixedTask") FixedTask ft, BindingResult result, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		UserGroup user = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		try {
			out = res.getWriter();
			new FixedTaskValidator().validate(ft, result);
			
			Logs lf = new Logs();
			lf.setDated(new Date());
			lf.setLogger("固定工作");
			lf.setUserId(user.getId());
			
			if (result.hasErrors()) {
				m.put("result", HandlerState.PARAM_EMPTY);
			} else {
				if(RegexUtil.notEmpty(ft.getId())) lf.setMessage("您编辑固定工作 " + ft.getTaskTitle() + " 更新时间 " + ft.getUpdateDate() + "， 更新详细请查看更新后记录。");
				else lf.setMessage("您于 "+ DateUtil.forMatDate() + " 新增固定工作 " + ft.getTaskTitle() + "， 工作将固定每 "+ft.getFrequency().getDes()+" 从 " + DateUtil.formatDateTime(ft.getExpectedStart()) + " 开始至 " + DateUtil.formatDate(ft.getExpectedEnd()) + " 结束 ");
				
				commonService.saveFixedTask(ft);
				m.put("ft", ft);
				m.put("result", HandlerState.SUCCESS);
				
				log.debug(JsonUtils.toJson(lf));
			}
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(), JsonUtils.DATA_TIME, true));
		} catch (Exception ex) {
			log.error("/app/save_fixedTask.htm have an error!", ex);
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		} finally {m.clear(); if (out != null) {out.flush();out.close();}}
	}
	
	/**
	 * 停止固定工作
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/edit_fixedTask.htm")
	public void abolishFixedTask(@RequestParam("id")Integer id, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");

		try {
			out = res.getWriter();
			if(RegexUtil.isEmpty(id) || id == 0) {
				m.put("result", HandlerState.PARAM_EMPTY);
			}
			else {
				commonService.stopFixedTask(id);
				m.put("result", HandlerState.SUCCESS);
				
				Logs lf = new Logs();
				lf.setDated(new Date());
				lf.setLogger("停止固定工作");
				lf.setMessage("您已经停止使用固定工作" + id);
				log.debug(JsonUtils.toJson(lf));
			}
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		} catch (Exception ex) {
			log.error("have an error when update fixed task to abolished!", ex);
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		} finally {m.clear(); if (out != null) {out.flush();out.close();}}
	}
}
