/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web;

import static org.junit.Assert.assertEquals;

import java.util.Date;

import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;

import com.sqe.gom.BaseTest;
import com.sqe.gom.app.AssetService;
import com.sqe.gom.constant.ApplyState;
import com.sqe.gom.constant.AssetState;
import com.sqe.gom.constant.AssetType;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.model.Asset;
import com.sqe.gom.model.Borrow;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.BorrowController;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 1, 2012
 * @version 3.0
 */
public class BorrowContrallerTest extends BaseTest {
	private AssetService assetService;
	private BorrowController borrowController;
	private MockHttpServletRequest request;
	private MockHttpServletResponse response;
	private Asset asset;
	private Borrow borrow;
	
	@Autowired
	public void setAssetService(AssetService assetService) {
		this.assetService = assetService;
	}
	
	@Before
	public void setUp() throws Exception {
		borrowController = new BorrowController();
		borrowController.setAssetService(assetService);
		request =  new MockHttpServletRequest("GET","/borrow.htm");  
		response = new MockHttpServletResponse();
		
		asset = new Asset();
		asset.setAssetName("sqe11");
		asset.setAssetType(AssetType.COMPUTER);
		asset.setAscription("asscreption");
		asset.setDes("详细说明");
		asset.setBuyNum(1);
		asset.setUnit("条");
		asset.setAssetState(AssetState.AVAILABLE);
		asset.setAdmin("sqe11");
		asset.setBuyer("sqe22");
		asset.setBuyDate(new Date());
		asset.setWarrantyDate(new Date());
		asset.setAttachment("this a attachment");
	}
		
	@Test
	public void saveBorrow() {
		
		assetService.saveAsset(asset);
		
		borrow = new Borrow();
		borrow.setFunCode("F-001");
		borrow.setApplyState(ApplyState.AGREE);
		borrow.setReceiveNum(1);
		borrow.setReceiver("sqe11");
		borrow.setReceiveDate(new Date());
		borrow.setReturnDate(new Date());
		borrow.setOverStaff("sqe11");
		borrow.setRemark("内容");
		borrow.setAsset(asset);
		borrow.setAssetId(asset.getId());
		
		assetService.saveBorrow(borrow, "sqe11", "apply");
		
		request.addParameter("operate","apply"); 
		//request.addParameter("operate","admin"); 
		
		BindingResult result = new BindException("", "test");
		borrowController.saveBorrow(borrow, result, request, response);
		
		assertEquals(200, response.getStatus());
		
	}
	
	@Test
	public void getBorrowsApp() {
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
		
		request.addParameter("page","1");   
		request.addParameter("rows","10"); 
		request.addParameter("sidx","id");   
		request.addParameter("sord","ASC"); 
		UserGroup ug = new UserGroup();
		ug.setEname("sqse_ename");
		request.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug);
		
		borrowController.getBorrowsApp(request, response);
		
		assertEquals(200, response.getStatus());
	}

	@Test
	public void deleteBorrow() {
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
		
		borrowController.deleteBorrow(b.getId(), response);
		
		assertEquals(200, response.getStatus());
	}
}
