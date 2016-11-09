/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.AssetService;
import com.sqe.gom.app.UserService;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.model.Asset;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;
import com.sqe.gom.web.validation.AssetValidator;

/**
 * @description 公司资产管理
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Controller
public class AssetController {
	private Log log = LogFactory.getLog(AssetController.class);
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private HandlerState str = HandlerState.FAILED;
	private AssetService assetService;
	private UserService userService;
	
	@Autowired
	public void setAssetService(AssetService assetService) {
		this.assetService = assetService;
	}
	
	@Autowired
	public void setUserService(UserService userSerivce) {
		this.userService = userSerivce;
	}
	
	@ModelAttribute("departments")
    public Collection<GomGroup> getDepartments() {
        return userService.getGroups(GroupType.DEPARTMENT, null);
    }	
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(df,false));
	}	
	
	//资产主页面
	@PreAuthorize("hasRole('Director') or hasRole('Manager') or hasRole('Assistant')")
	@RequestMapping(method = RequestMethod.GET, value = "/app/asset_config.htm")
	public String getAssetsApp(Model model) { return "app/assets"; }
	
	//后台资产主页面
	@RequestMapping(method = RequestMethod.GET, value = "/admin/asset_config.htm")
	public String getAssetsAdmin(Model model) { return "admin/assets"; }
	
	//物资申领页面
	@RequestMapping(method = RequestMethod.GET, value = "/app/apply_asset.htm")
	public String applyAssets() { return "app/apply_assets"; }
	
	//申领待批页面
	@RequestMapping(method = RequestMethod.GET, value = "/app/approving_asset.htm")
	public String handleAsset() { return "app/handle_asset"; }
	
	//申领回执页面
	@RequestMapping(method = RequestMethod.GET, value = "/app/receipt_asset.htm")
	public String receiptAsset() { return "app/receipt_asset"; }
	
	/**资产列表*/
	@RequestMapping(method = RequestMethod.POST, value = "/get_assets.htm")
	public void getAssetsApp(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<Asset> grid = new JGridHelper<Asset>();
		grid.jgridHandler(req, res, "a.");
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(assetService.getAssets(grid),new TypeToken<JGridBase<Asset>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN,true));
		} catch (Exception e) {
			log.error("get get_assets.htm have a error!", e);
		} finally {
			if (out != null) {out.flush();out.close();}
			grid = null;
		}
	}
	
	/**
	 * 资产编辑<添加，修改>
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/save_asset.htm")
	public void saveAsset(@ModelAttribute("asset") Asset asset, BindingResult result, 
			HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		try {
			out = res.getWriter();
			asset.setAdmin(ug.getEname());
			new AssetValidator().validate(asset, result);
			if(result.hasErrors()) str = HandlerState.PARAM_EMPTY;
			else {
				assetService.saveAsset(asset);
				str = HandlerState.SUCCESS;
				m.put("asset", asset);
			}
		} catch (Exception e) {
			str = HandlerState.ERROR;
			log.error("action save_asset.htm have error !", e);
		}finally {
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
	 * 删除资产
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/del_asset.htm")
	public void deleteAsset(@RequestParam("id")Integer id, HttpServletRequest req, HttpServletResponse res) {
		try {
			out = res.getWriter();
			assetService.removeAsset(id);
			str = HandlerState.SUCCESS;
		} catch (Exception e) {
			str = HandlerState.ERROR;
			log.error("action del_asset.htm have error!", e);
		} finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			m.clear();
			if (out != null) {out.flush();out.close();}
		}	
	}
	
	
}
