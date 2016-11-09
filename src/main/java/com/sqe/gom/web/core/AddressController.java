/**
 * SQE SERVICE INC. All right reserved.
 */
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

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.UserService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.model.Address;
import com.sqe.gom.model.Logs;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;
import com.sqe.gom.web.validation.AddressValidator;

/**
 * @description user entry report to submit information.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 7, 2011  11:04:25 PM
 * @version 3.0
 */
@Controller
public class AddressController {
	private Log log = LogFactory.getLog(AddressController.class);
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private HandlerState str = HandlerState.FAILED;
	private UserService userService;
	
	@Autowired
	public void setUserService(UserService userSerivce) {
		this.userService = userSerivce;
	}
		
	//用户地址主页面
	@RequestMapping(method = RequestMethod.GET, value = "/app/address.htm")
	public String addressPage() { return "app/address"; }
	
	/**
	 * 后台用户地址展现方法
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/get_address.htm")
	public void getAddressAdmin(HttpServletRequest req, HttpServletResponse res) {
		getAddressApp(req, res);
	}
	
	/**
	 * 前台用户地址展现方法
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/app/get_address.htm")
	public void getAddressApp(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<Address> grid = new JGridHelper<Address>();
		grid.jgridHandler(req, res, "p.");
		UserGroup ug = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		try {
			out = res.getWriter();
			int uid = 0;
			String id = req.getParameter("id");   
			if(RegexUtil.notEmpty(id)) uid = Integer.parseInt(id); 	//后台用户
			else uid = ug.getId();									//前台用户
			String ord = " ORDER BY p.id ASC";
			List<Address> list = userService.getAddress(uid, ord);
			grid.getJq().setList(list);
			grid.getJq().setRecords(grid.getP().getTotalCount());
			grid.getJq().setTotal(grid.getP().getPageCount());
			out.write(JsonUtils.toJson(grid.getJq(), new TypeToken<JGridBase<Address>>() {}.getType()));
		} catch (Exception e) {
			log.error("/app/get_address.htm have a error!", e);
		} finally {
			if(out != null) {out.flush();out.close();}
			grid = null;
		}
	}
	
	/**
	 * 后台用户地址编辑<添加，修改>
	 * @param addr
	 * @param result
	 * @param req
	 * @param res
	 * @param model
	 */
	@RequestMapping(method=RequestMethod.POST, value="/admin/save_address.htm")
	public void saveAppAddress(@ModelAttribute("addr") Address addr, BindingResult result, 
			HttpServletRequest req, HttpServletResponse res, Model model){
		saveAdminAddress(addr, result, req, res);
	}
	
	/**
	 * 前台用户地址编辑<添加，修改>
	 * @param addr
	 * @param result
	 * @param req
	 * @param res
	 * @param model
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/save_address.htm")
	public void saveAdminAddress(@ModelAttribute("addr") Address addr, BindingResult result, 
			HttpServletRequest req, HttpServletResponse res){
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		UserGroup ug = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		String opt = "修改";
		try {
			out = res.getWriter();
			new AddressValidator().validate(addr, result);
			if(result.hasErrors()) {
				str = HandlerState.UNSUPPORT;
			} else {
				if(RegexUtil.isEmpty(addr.getId())) {
					addr.setUid(ug.getId());
					opt = "添加";
				} 
				userService.saveAddress(addr);
				m.put("addr", addr);
				str = HandlerState.SUCCESS;
				
				Logs lf = new Logs();
				lf.setLogger("联系信息");
				lf.setDated(new Date());
				lf.setUserId(ug.getId());
				lf.setMessage(ug.getCname() + opt + addr.getAddrType().getDes() + addr.getRelation() + addr.getContact() + " 的联系电话 " + addr.getCell() + "  地址 " + addr.getAddress());
				log.debug(JsonUtils.toJson(lf));
			}
		} catch (IOException e) {
			str = HandlerState.ERROR;
			log.error("/app/save_address.htm have errors !", e);
		}finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType() , true));	
			m.clear();
			if (out != null) {
				out.flush();
				out.close();
			}
		}	
	}
		
	/**
	 * 后台删除用户地址<可删除多个>
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/admin/del_address.htm")
	public void edlAppAddr(HttpServletRequest req, HttpServletResponse res) {
		delAdminAddrs(req, res);
	}
	
	/**
	 * 前台删除用户地址<可删除多个>
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/app/del_address.htm")
	public void delAdminAddrs(HttpServletRequest req, HttpServletResponse res) {
		String[] id = req.getParameterValues("id[]");
		UserGroup ug = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		if(null != id) {
			try {
				out = res.getWriter();
				userService.removeAddr(id);
				str = HandlerState.SUCCESS;
				
				Logs lf = new Logs();
				lf.setLogger("地址信息");
				lf.setDated(new Date());
				lf.setUserId(ug.getId());
				lf.setMessage(ug.getEname() + " 删除 " + id.length + " 个地址信息 ");
				log.debug(JsonUtils.toJson(lf));
			} catch (Exception e) {
				str = HandlerState.ERROR;
				log.error("/app/del_address.htm have error!", e);
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
