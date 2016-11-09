/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import static org.junit.Assert.assertNotNull;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.ApplyState;
import com.sqe.gom.dao.AssetDAO;
import com.sqe.gom.dao.BorrowDAO;
import com.sqe.gom.model.Borrow;
import com.sqe.gom.util.Page;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 27, 2012
 * @version 3.0
 */
public class BorrowDaoTest extends BaseTest {
	private AssetDAO assetDao;
	private BorrowDAO borrowDao;
	
	@Autowired
	public void setAssetDao(AssetDAO assetDao) {
		this.assetDao = assetDao;
	}
	
	@Autowired
	public void setBorrowDao(BorrowDAO borrowDao) {
		this.borrowDao = borrowDao;
	}
		
	@Test
	public void saveBorrow() {
		Borrow b = new Borrow();
		b.setFunCode("f-001");
		b.setApplyState(ApplyState.AGREE);
		b.setReceiveNum(1);
		b.setReceiver("sqe11");
		b.setReceiveDate(new Date());
		b.setReturnDate(new Date());
		b.setOverStaff("sqe11");
		b.setRemark("内容");
		b.setAsset(assetDao.query(1));
		borrowDao.create(b);
		assertNotNull(b.getId());
	}
	
	@Test
	public void getBorrow() {
		Borrow b = new Borrow();
		b.setFunCode("f-001");
		b.setApplyState(ApplyState.AGREE);
		b.setReceiveNum(1);
		b.setReceiver("sqe11");
		b.setReceiveDate(new Date());
		b.setReturnDate(new Date());
		b.setOverStaff("sqe11");
		b.setRemark("内容");
		b.setAsset(assetDao.query(1));
		borrowDao.create(b);
		
		String ord = " ORDER BY a.id ASC";
		List<Borrow> list = borrowDao.getBorrows(ord, null, new Page(1,5));
		assertNotNull(list.size());
	}
	
	@Test
	public void updateBorrow() {
		Borrow b = new Borrow();
		b.setFunCode("f-001");
		b.setApplyState(ApplyState.AGREE);
		b.setReceiveNum(1);
		b.setReceiver("sqe11");
		b.setReceiveDate(new Date());
		b.setReturnDate(new Date());
		b.setOverStaff("sqe11");
		b.setRemark("内容");
		b.setAsset(assetDao.query(1));
		borrowDao.create(b);
		
		borrowDao.update(b);
		assertNotNull(b.getId());
	}
}
