/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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
import com.sqe.gom.app.AssetService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.model.Borrow;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description 借出单据控制管理
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Controller
public class BorrowController {
	private Log log = LogFactory.getLog(BorrowController.class);
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private HandlerState str = HandlerState.FAILED;
	private AssetService assetService;
	
	@Autowired
	public void setAssetService(AssetService assetService) {
		this.assetService = assetService;
	}
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(df,false));
	}	
		
	//领用记录页面
	@RequestMapping(method = RequestMethod.GET, value = "/app/borrow_records.htm")
	public String borrowPage() { return "app/borrows"; }
	
	/**
	 * 显示所有借据列表<根据operate判断用户查询条件>
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/app/get_borrows.htm")
	public void getBorrowsApp(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<Borrow> grid = new JGridHelper<Borrow>();
		grid.jgridHandler(req, res, "b.");
 		String operate = req.getParameter("operate");
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(assetService.getBorrows(grid,ug.getEname(),operate), new TypeToken<JGridBase<Borrow>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN,true));
		} catch (Exception e) {
			log.error("get_borrows.htm have a error!", e);
		} finally {
			if (out != null) {out.flush();out.close();}
			grid = null;
		}
	}
	
	/**
	 * 借据编辑<申领,审核,回执>
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/save_borrow.htm")
	public void saveBorrow(@ModelAttribute("borrow") Borrow borrow, BindingResult result,
			HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String operate = req.getParameter("operate");
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		try {
			out = res.getWriter();
			if(result.hasErrors())  {
				str = HandlerState.PARAM_EMPTY;
			} else {
				str = assetService.saveBorrow(borrow, ug.getEname(), operate);
				m.put("borrow", borrow);
			}
		} catch (Exception e) {
			str = HandlerState.ERROR;
			log.error("/app/save_borrow.htm have error !", e);
		} finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(), JsonUtils.SHORT_DATE_PATTERN, true));	
			m.clear();
			if (out != null) {
				out.flush();
				out.close();
			}	
		}
	}
	
	/**
	 * 删除借据<只有管理员后台可用>
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/admin/del_borrow.htm")
	public void deleteBorrow(@RequestParam("id")Integer id, HttpServletResponse res) {
		if(null != id) {
			try {
				out = res.getWriter();
				assetService.removeBorrow(id);
				str = HandlerState.SUCCESS;
			} catch (Exception e) {
				str = HandlerState.ERROR;
				log.error("/admin/del_borrow.htm have error!", e);
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
	
}
