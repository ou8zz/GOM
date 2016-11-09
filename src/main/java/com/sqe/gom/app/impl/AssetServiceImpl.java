/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sqe.gom.app.AssetService;
import com.sqe.gom.constant.ApplyState;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.dao.AssetDAO;
import com.sqe.gom.dao.BorrowDAO;
import com.sqe.gom.model.Asset;
import com.sqe.gom.model.Borrow;
import com.sqe.gom.model.Logs;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Service("assetService")
public class AssetServiceImpl implements AssetService {
	private Log log = LogFactory.getLog(getClass());
	private HandlerState str = HandlerState.FAILED;
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

	@Override
	public JGridBase<Asset> getAssets(JGridHelper<Asset> grid) {
		String ord = " ORDER BY a.";
		if(RegexUtil.notEmpty(grid.getJq().getSidx())) ord += grid.getJq().getSidx() + " " + grid.getJq().getSord();
		else ord += "buyDate";
		
		grid.getJq().setList(assetDao.getAssets(ord, grid.getQ(), grid.getP()));
		grid.getJq().setRecords(grid.getP().getTotalCount());
		grid.getJq().setTotal(grid.getP().getPageCount());
		return grid.getJq();
	}
	
	@Override
	public int getAssetBuyNum(int id) {
		return assetDao.getAssetBuyNum(id);
	}
	
	@Override
	public JGridBase<Borrow> getBorrows(JGridHelper<Borrow> grid, String user, String operate) {
		String q = null;
		if("handle".equals(operate)) {	//如果是后台审批者
			q = grid.getJq().generateSearchCriterion(" AND ", "applyState", String.valueOf(ApplyState.HOMING.ordinal()), "ne", "b.");
			q += grid.getJq().generateSearchCriterion(" AND ", "receiver", user, "ne", "b.");
		} else {
			q = grid.getJq().generateSearchCriterion(" AND ", "receiver", user, "eq", "b.");
		}
		
		if(RegexUtil.notEmpty(grid.getQ())) grid.setQ(grid.getQ() + q);
		else grid.setQ(q);
		
		String ord = " ORDER BY b.";
		if(RegexUtil.notEmpty(grid.getJq().getSidx())) ord += grid.getJq().getSidx() + " " + grid.getJq().getSord();
		else ord += "receiveDate";
		
		grid.getJq().setList(borrowDao.getBorrows(ord, q + grid.getQ(), grid.getP()));
		grid.getJq().setRecords(grid.getP().getTotalCount());
		grid.getJq().setTotal(grid.getP().getPageCount());
		
		return grid.getJq();
	}
	
	@Override
	public void saveAsset(Asset asset) {
		Logs lf = new Logs();
		if(RegexUtil.notEmpty(asset.getId())) {
			assetDao.update(asset);		//更新
			
			lf.setLogger("更新资产");
			lf.setDated(new Date());
			lf.setMessage(asset.getAdmin() + "于" + DateUtil.forMatDate() + " 更新产品 " + asset.getAssetName() + " 数量为 " + asset.getBuyNum() + asset.getUnit() + " 物品保修到 "+ DateUtil.formatDate(asset.getWarrantyDate()));
			log.debug(JsonUtils.toJson(lf));
		}
		else {
			assetDao.create(asset);		//新增
			
			lf.setLogger("新增资产");
			lf.setDated(new Date());
			lf.setMessage(asset.getAdmin() + "于" + DateUtil.forMatDate() + " 新增 "+asset.getAssetName() + " 数量为 " + asset.getBuyNum() + asset.getUnit() + " 由 " +asset.getBuyer() +" "+ DateUtil.formatDate(asset.getBuyDate()) + " 购买， 物品保修到 "+ DateUtil.formatDate(asset.getWarrantyDate()));
			log.debug(JsonUtils.toJson(lf));
		}
	}
		
	@Override
	public HandlerState saveBorrow(Borrow borrow, String user, String operate) {
		Logs lf = new Logs();
		lf.setDated(new Date());
		if(RegexUtil.notEmpty(borrow.getId())) {
			if("admin".equals(operate)) {			//后台管理员操作:如果是后台管理员操作
				
				lf.setLogger("借据更新");
				lf.setMessage("后台管理员 "+user+" 于 "+DateUtil.formatDate(borrow.getReceiveDate())+" 对 "+borrow.getAssetName()+" 执行修改操作，并且已经生效");						
				log.debug(JsonUtils.toJson(lf));
			} else if("handle".equals(operate)) {	//审批:如果是审批者，则添加审批者Ename
				borrow.setOverStaff(user);	
				
				lf.setLogger("借据审批");
				lf.setMessage("您于 "+DateUtil.forMatDate()+" 申领请求由 "+user+" 审批通过");
				log.debug(JsonUtils.toJson(lf));
			} else if("receipt".equals(operate)) {	//回执:如果是前台用户回执
				
				lf.setLogger("借据回执");
				lf.setMessage("您已经 "+DateUtil.forMatDate()+" 借据回执操作成功");						
				log.debug(JsonUtils.toJson(lf));
			}
			borrowDao.updateBorrow(borrow);
			str = HandlerState.SUCCESS;
		} else if("apply".equals(operate)) {		//发出申请
			int buyNum = assetDao.getAssetBuyNum(borrow.getAssetId());
			if(borrow.getReceiveNum() > buyNum) {
				str = HandlerState.UNSUPPORT;
			} else {
				Asset as = assetDao.query(borrow.getAssetId());
				borrow.setReceiver(user);	
				borrow.setAsset(as);
				borrowDao.create(borrow);
				str = HandlerState.SUCCESS;
				assetDao.updateAssetBuyNum(borrow.getAssetId(), buyNum-borrow.getReceiveNum());
				
				lf.setLogger("物资申领");
				lf.setMessage(user+" 于 "+DateUtil.forMatDate()+" 申请 "+borrow.getAssetName()+borrow.getReceiveNum()+as.getUnit() + " 申请已经生效，请等待管理员审核！");
				log.debug(JsonUtils.toJson(lf));
			}
		} 
		else str = HandlerState.ERROR;
		return str;
	}

	@Override
	public void removeAsset(int id) {
		assetDao.delete(id);
		
		Logs lf = new Logs();
		lf.setLogger("物资删除");
		lf.setDated(new Date());
		lf.setMessage( "删除操作成功ID号为：" + id);
		log.debug(JsonUtils.toJson(lf));
	}
	
	@Override
	public void removeBorrow(int id) {
		borrowDao.delete(id);
		
		Logs lf = new Logs();
		lf.setLogger("借据删除");
		lf.setDated(new Date());
		lf.setMessage("删除操作成功ID号为：" + id);
		log.debug(JsonUtils.toJson(lf));
	}

}
