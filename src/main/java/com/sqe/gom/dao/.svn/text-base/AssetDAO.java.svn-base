/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.model.Asset;
import com.sqe.gom.util.Page;

/**
 * @description Asset DAO manager interface
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
public interface AssetDAO extends GenericDAO<Asset> {
	
	/**
	 * 根据条件criteria 分页Page 查询所以公司资产  ord 排序
	 * @param ord
	 * @param condition
	 * @param page
	 * @return
	 */
	List<Asset> getAssets(String ord, String criteria, Page page);
	
	/**
	 * 根据资产ID查询此物资可用数量
	 * @param id
	 * @return
	 */
	int getAssetBuyNum(int id);
	
	/**
	 * 根据找到的id更改可用数量
	 * @param id
	 */
	void updateAssetBuyNum(int id, int num);
}
