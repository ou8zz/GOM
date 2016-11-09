/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.ProcessService;
import com.sqe.gom.constant.ApprovalStatus;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.ProcessType;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.model.Abnormal;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 25, 2012
 * @version 3.0
 */
@Controller
public class AbnormalController {
	private Log log = LogFactory.getLog(AddressController.class);
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private HandlerState str = HandlerState.FAILED;
	private ProcessService processService;
	
	@Resource(name="processService")
	public void setProcessService(ProcessService processService) {
		this.processService = processService;
	}
	
	//异常审核
	@PreAuthorize("hasRole('Manager') or hasRole('Director') or hasRole('Assistant') or hasRole('CEO')")
	@RequestMapping(method = RequestMethod.GET, value = "/app/check_abnormal.htm")
	public String abnormalsPage() { return "app/abnormals"; }
	
	//我的异常列表
	@RequestMapping(method = RequestMethod.GET, value = "/app/my_abnormal.htm")
	public String myAbnormalPage() { return "app/my_abnormal"; }
	
	/**
	 * 前台异常列表数据加载
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/app/get_abnormals.htm")
	public void getAbnormal(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<Abnormal> grid = new JGridHelper<Abnormal>();
		grid.jgridHandler(req, res, "a.");
		UserGroup ug = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		String sh = req.getParameter("sh");
		try {
			out = res.getWriter();
			JGridBase<Abnormal> list = processService.getAbnormals(grid, ug.getEname(), sh);
			out.write(JsonUtils.toJson(list, new TypeToken<JGridBase<Abnormal>>() {}.getType()));
		} catch (Exception e) {
			log.error("/app/get_abnormals.htm have a error!", e);
		} finally {
			if(out != null) {out.flush();out.close();}
			grid = null;
		}
	}
	
	/**
	 * 异常流程 显示
	 * @param req
	 * @param res
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/get_abnormal_trace.htm")
	public void getAbnormalTrace(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String processId = req.getParameter("processId");
		try {
			out = res.getWriter();
			if(RegexUtil.notEmpty(processId)) {
				m.put("abnormal", processService.getTraces(Integer.parseInt(processId),ProcessType.ABNORMAL));
				str = HandlerState.SUCCESS;
			}
		} catch (Exception e) {
			log.error("get_abnormal_trace.htm have a error!", e);
			str = HandlerState.ERROR;
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
	 * 开始流程/审核
	 * @param abnormal
	 * @param result
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/save_abnormal.htm")
	public void saveAbnormal(@ModelAttribute("abnormal") Abnormal abnormal, BindingResult result, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		UserGroup ug = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		String[] ids = req.getParameterValues("ids[]");
		String[] traceIds = req.getParameterValues("traceIds[]");
		String status = req.getParameter("status");
		try {
			out = res.getWriter();
			//批量审核流程
			if(RegexUtil.notEmpty(ids) && RegexUtil.notEmpty(traceIds) && RegexUtil.notEmpty(status)) {
				ug.setComment(req.getSession().getServletContext().getRealPath("/images/"));
				str = processService.updateAbnormals(ids, traceIds, ApprovalStatus.valueOf(status), ug);
			} else {
				//创建异常流程/向上级汇报
				str = processService.saveAbnormal(abnormal, ug);
			}
			
		} catch (Exception e) {
			str = HandlerState.ERROR;
			log.error("/app/save_abnormal.htm have error!", e);
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
	
}
