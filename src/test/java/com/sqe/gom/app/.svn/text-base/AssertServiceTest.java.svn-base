/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertSame;
import static org.junit.Assert.assertTrue;

import java.util.Date;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.ApplyState;
import com.sqe.gom.constant.AssetState;
import com.sqe.gom.constant.AssetType;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.model.Asset;
import com.sqe.gom.model.Borrow;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 25, 2012
 * @version 3.0
 */
public class AssertServiceTest extends BaseTest {
	private MockHttpServletRequest request;
	private MockHttpServletResponse response;
	private AssetService assetService;
	private Asset asset;
	
	@Autowired
	public void setAssetService(AssetService assetService) {
		this.assetService = assetService;
	}
	
	@Before
	public void setUp() {
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
		if(RegexUtil.notEmpty(asset.getId()))
			assetService.removeAsset(asset.getId());
	}
	
	@Test
	public void getAssetsApp() {
		JGridHelper<Asset> grid = new JGridHelper<Asset>();
		grid.jgridHandler(request, response, "a.");
		grid.getJq().setSidx("id");
		grid.getJq().setSord("ASC");
		grid.getJq().setPage(1);
		grid.getJq().setRows(10);
		
		assetService.saveAsset(asset);
		JGridBase<Asset> list = assetService.getAssets(grid);
		assertTrue(list.getList().size() > 0);
		assertEquals(1, list.getList().size());
	}
	
	@Test
	public void saveAssert() {
		assetService.saveAsset(asset);
		assertNotNull(asset.getId());
	}
	
	@Test
	public void getAssetBuyNum() {
		assetService.saveAsset(asset);
		int i = assetService.getAssetBuyNum(asset.getId());
		assertNotNull(i);
	}
	
	@Test
	public void saveBorrow() {
		assetService.saveAsset(asset);
		
		Borrow b = new Borrow();
		b.setFunCode("F-001");
		b.setApplyState(ApplyState.AGREE);
		b.setReceiveNum(1);
		b.setReceiver("sqe11");
		b.setReceiveDate(new Date());
		b.setReturnDate(new Date());
		b.setOverStaff("sqe11");
		b.setRemark("内容");
		b.setAsset(asset);
		b.setAssetId(asset.getId());
		
		HandlerState hs = assetService.saveBorrow(b, "sqe11", "apply");
		assertSame("SUCCESS", hs.toString());
	}
	
	@Test
	public void updateBorrow() {
		assetService.saveAsset(asset);
		
		Borrow b = new Borrow();
		b.setFunCode("F-001");
		b.setApplyState(ApplyState.AGREE);
		b.setReceiveNum(1);
		b.setReceiver("sqe11");
		b.setReceiveDate(new Date());
		b.setReturnDate(new Date());
		b.setOverStaff("sqe11");
		b.setRemark("内容");
		b.setAsset(asset);
		b.setAssetId(asset.getId());
		
		assetService.saveBorrow(b, "sqe11", "apply");
		assertEquals("F-001", b.getFunCode());
		
		b.setFunCode("F-002");
		b.setApplyState(ApplyState.AGREE);
		b.setReceiveNum(1);
		b.setReceiver("sqe334");
		b.setReceiveDate(new Date());
		b.setReturnDate(new Date());
		b.setOverStaff("sqe44");
		b.setRemark("内容更新");
		b.setAsset(asset);
		
		HandlerState hse = assetService.saveBorrow(b, "sqe11", "admin");
		assertEquals("F-002", b.getFunCode());
		
		assertSame("SUCCESS", hse.toString());
	}
}
