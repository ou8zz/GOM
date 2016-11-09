/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.dao.AssetDAO;
import com.sqe.gom.model.Asset;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

/**
 * @description 
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Repository("assetDao")
@SuppressWarnings("unchecked")
public class AssetDAOImpl extends GenericHibernateDAO<Asset> implements AssetDAO {
	public AssetDAOImpl() {
		super(Asset.class);
	}

	@Override
	public List<Asset> getAssets(String ord, String criteria, Page page) {
		String count = "SELECT COUNT(*) FROM Asset WHERE 1=1";
		String sql = "SELECT new com.sqe.gom.model.Asset(a.id,a.assetName,a.assetType,a.ascription,a.des,a.buyNum,a.unit,a.assetState,a.admin,a.buyer,a.buyDate,a.warrantyDate,a.controlDate,a.scrapDate,a.attachment) FROM Asset AS a WHERE 1=1";
		if(RegexUtil.notEmpty(criteria)) {count += criteria;sql += criteria;}
		if(RegexUtil.notEmpty(ord)) sql += ord; 
		if(RegexUtil.isEmpty(page)) return (List<Asset>) queryForList(sql, null);
		return (List<Asset>) queryForList(count, sql, null, page);
	}

	@Override
	public int getAssetBuyNum(int id) {
		String sql = "SELECT a.buyNum FROM Asset AS a WHERE a.id=?";
		return (Integer) queryForObject(sql, new Object[]{id});
	}

	@Override
	public void updateAssetBuyNum(int id, int num) {
		executeUpdate("UPDATE Asset AS a SET a.buyNum=? WHERE a.id=?", new Object[]{num, id});
	}
	

}
