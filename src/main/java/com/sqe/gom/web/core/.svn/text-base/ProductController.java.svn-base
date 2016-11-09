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
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.ProjectService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.model.Product;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;
import com.sqe.gom.web.validation.ProductValidator;

/**
 * @description 产品管理
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 5, 2012
 * @version 3.0
 */
@Controller
public class ProductController {
	private Log log = LogFactory.getLog(ProductController.class);
	private Map<String, Object> m = new HashMap<String, Object>();
	private HandlerState str = HandlerState.FAILED;
	private ProjectService projectService;
	private PrintWriter out;
	
	@Autowired
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
		
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(df,false));
	}	
		
	//产品 主页面
	@PreAuthorize("hasRole('Manager') or hasRole('Director')")
	@RequestMapping(method=RequestMethod.GET, value="/app/product.htm")
	public String productPage() { return "app/products"; }
	
	/**
	 * 构建jqGrid AJAX展示数据
	 */
	@RequestMapping(method=RequestMethod.GET, value="/app/get_products.htm")
	public void getProductsByGrid(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<Product> grid = new JGridHelper<Product>();
		grid.jgridHandler(req, res, "p.");
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(projectService.getProducts(grid), new TypeToken<JGridBase<Product>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN,true));
		} catch (Exception e) {
			log.error("/app/get_products.htm have a error!", e);
			out.write(HandlerState.ERROR.name());
		} finally {
			if (out != null) {out.flush();out.close();}
			grid = null;
		}
	}
	
	/**
	 * 查询所有产品，并返回AJAX数据
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/app/get_product.htm")
	public void getProductsByAJAX(HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(projectService.getProducts(), new TypeToken<List<Product>>() {}.getType(), true));
		} catch (Exception ex) {
			log.error("product query error",ex);
		}finally {
			if (out != null) { out.flush(); out.close(); }	
		}
	}
	
	/**
	 * 保存新建或修改过的项目
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/save_product.htm")
	public void saveProduct(@ModelAttribute("product") Product product, BindingResult result, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		try {
			out = res.getWriter();
			new ProductValidator().validate(product, result);
			if(result.hasErrors()) str = HandlerState.PARAM_EMPTY;
			else {
				//检查productName如果存在则给出占用提示
				if(projectService.checkProduct(product.getProductName())) 
					str = HandlerState.UNSUPPORT;
				else {
					projectService.saveProduct(product);
					str = HandlerState.SUCCESS;
					m.put("product", product);
				}
			}
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN, true));	
		} catch (Exception e) {
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		}finally {
			m.clear();
			if (out != null) { out.flush(); out.close(); }	
		}
	}
	
	/**
	 * 删除项目
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/del_product.htm")
	public void deleteProject(@RequestParam("id")Integer id, HttpServletResponse res) {
		try {
			out = res.getWriter();
			projectService.removeProduct(id);
			m.put("result", HandlerState.SUCCESS);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		} catch (Exception e) {
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
		} finally {
			m.clear();
			if (out != null) { out.flush(); out.close(); }
		}	
	}
}
