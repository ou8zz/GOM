/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.Date;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;

import com.sqe.gom.BaseTest;
import com.sqe.gom.app.AssetService;
import com.sqe.gom.constant.AssetState;
import com.sqe.gom.constant.AssetType;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.dao.AssetDAO;
import com.sqe.gom.model.Asset;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.AssetController;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 1, 2012
 * @version 3.0
 */
public class AssetContrallerTest extends BaseTest {
	private AssetService assetService;
	private AssetController assetController;
	private MockHttpServletRequest request;
	private MockHttpServletResponse response;
	private Asset asset;
	private AssetDAO assetDao;
	
	@Autowired
	public void setAssetDao(AssetDAO assetDao) {
		this.assetDao = assetDao;
	}
	
	@Autowired
	public void setAssetService(AssetService assetService) {
		this.assetService = assetService;
	}
	
	@Before
	public void setUp() throws Exception {
		assetController = new AssetController();
		assetController.setAssetService(assetService);
		request =  new MockHttpServletRequest("GET","/asset.htm");  
		response = new MockHttpServletResponse();
		
		asset = new Asset();
		asset.setAssetName("sqe11");
		asset.setAssetType(AssetType.COMPUTER);
		asset.setAscription("asscreption");
		asset.setDes("详细说明");
		asset.setBuyNum(10);
		asset.setUnit("条");
		asset.setAssetState(AssetState.AVAILABLE);
		asset.setAdmin("sqe11");
		asset.setBuyer("sqe22");
		asset.setBuyDate(new Date());
		asset.setWarrantyDate(new Date());
		asset.setAttachment("this a attachment");
	}
	
	@After
	public void tearDown() {
		assetDao.delete(asset);
	}
	
	@Test
	public void saveAsset() throws Exception {
		BindingResult result = new BindException("", "test");
		UserGroup ug = new UserGroup();
		ug.setEname("sqse_ename");
		request.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug);
		assetController.saveAsset(asset, result, request, response);
		
		String str = response.getContentAsString();
		int s = str.indexOf("SUCCESS");
		String success = str.substring(s, s+7);
		assertEquals("SUCCESS", success);
	}

	@Test
	public void getAsset() throws Exception {
		assetDao.create(asset);
		request.addParameter("page","1");   
		request.addParameter("rows","10"); 
		request.addParameter("sidx","id");   
		request.addParameter("sord","ASC"); 
		assetController.getAssetsApp(request, response);
		String str = response.getContentAsString();
		assertNotNull(str);
	}
	
	@Test
	public void deleteAsset() throws Exception {
		assetDao.create(asset);
		assetController.deleteAsset(asset.getId(), request, response);
		
		String str = response.getContentAsString();
		int s = str.indexOf("SUCCESS");
		String success = str.substring(s, s+7);
		assertEquals("SUCCESS", success);
	}
}
