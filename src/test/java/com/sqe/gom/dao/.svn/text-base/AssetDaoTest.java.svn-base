/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.AssetState;
import com.sqe.gom.constant.AssetType;
import com.sqe.gom.dao.AssetDAO;
import com.sqe.gom.model.Asset;
import com.sqe.gom.util.Page;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 27, 2012
 * @version 3.0
 */
public class AssetDaoTest extends BaseTest {
	private AssetDAO assetDao;
	
	@Autowired
	public void setAssetDao(AssetDAO assetDao) {
		this.assetDao = assetDao;
	}
		
	@Test
	public void saveAsset() {
		Asset at = new Asset();
		at.setAssetName("sqe11");
		at.setAssetType(AssetType.COMPUTER);
		at.setAscription("asscreption");
		at.setDes("详细说明");
		at.setBuyNum(1);
		at.setUnit("条");
		at.setAssetState(AssetState.AVAILABLE);
		at.setAdmin("sqe11");
		at.setBuyer("sqe22");
		at.setBuyDate(new Date());
		at.setWarrantyDate(new Date());
		at.setAttachment("aaaaaa");
		assetDao.create(at);		//保存
		assertNotNull(at.getId());
	}
	
	@Test
	public void getAsset() {
		Asset at = new Asset();
		at.setAssetName("sqe11");
		at.setAssetType(AssetType.COMPUTER);
		at.setAscription("asscreption");
		at.setDes("详细说明");
		at.setBuyNum(1);
		at.setUnit("条");
		at.setAssetState(AssetState.AVAILABLE);
		at.setAdmin("sqe11");
		at.setBuyer("sqe22");
		at.setBuyDate(new Date());
		at.setWarrantyDate(new Date());
		at.setAttachment("aaaaaa");
		assetDao.create(at);		//保存
		
		String ord = " ORDER BY a.id ASC";
		List<Asset> list = assetDao.getAssets(ord, null, new Page(1,5));
		assertNotNull(list.size());
	}
	
	@Test
	public void getAssetBuyNum() {
		Asset at = new Asset();
		at.setAssetName("sqe11");
		at.setAssetType(AssetType.COMPUTER);
		at.setAscription("asscreption");
		at.setDes("详细说明");
		at.setBuyNum(1);
		at.setUnit("条");
		at.setAssetState(AssetState.AVAILABLE);
		at.setAdmin("sqe11");
		at.setBuyer("sqe22");
		at.setBuyDate(new Date());
		at.setWarrantyDate(new Date());
		at.setAttachment("aaaaaa");
		assetDao.create(at);		//保存
		
		int i = assetDao.getAssetBuyNum(at.getId());
		
		assertTrue(i>0);
	}
	
	@Test
	public void updateAssetBuyNum() {
		Asset at = new Asset();
		at.setAssetName("sqe11");
		at.setAssetType(AssetType.COMPUTER);
		at.setAscription("asscreption");
		at.setDes("详细说明");
		at.setBuyNum(1);
		at.setUnit("条");
		at.setAssetState(AssetState.AVAILABLE);
		at.setAdmin("sqe11");
		at.setBuyer("sqe22");
		at.setBuyDate(new Date());
		at.setWarrantyDate(new Date());
		at.setAttachment("aaaaaa");
		assetDao.create(at);		//保存
		assetDao.updateAssetBuyNum(at.getId(), 1);
		assertTrue(1 == at.getBuyNum());
	}
}
