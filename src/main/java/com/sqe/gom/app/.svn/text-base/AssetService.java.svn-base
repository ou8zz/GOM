/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;

import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.model.Asset;
import com.sqe.gom.model.Borrow;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description 资产管理服务层
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Transactional
public interface AssetService {
	
	/**
	 * 根据条件criteria 分页Page 查询所以公司资产  ord 排序Assets
	 * @param ord
	 * @param condition
	 * @param page
	 * @return
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	@Transactional(readOnly=true)
	JGridBase<Asset> getAssets(JGridHelper<Asset> grid);
	
	/**
	 * 根据条件ID 查询当前资产购买数量
	 * @param id
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	int getAssetBuyNum(int id);
	
	/**
	 * 根据条件criteria 分页Page 查询所以公司资产  ord 排序Borrows
	 * @param ord
	 * @param criteria
	 * @param page
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	JGridBase<Borrow> getBorrows(JGridHelper<Borrow> grid, String user, String operate);
		
	/**
	 * 保存、更新Asset公司资产
	 * @param asset
	 */
	@PreAuthorize("hasRole('Assistant') or hasRole('Director') or hasRole('Manager') or hasRole('Admin')")
	void saveAsset(Asset asset);
	
	/**
	 * 保存、修改Borrow借据
	 * @param borrow
	 * @param user
	 * @param operate
	 */
	@PreAuthorize("hasRole('User')")
	HandlerState saveBorrow(Borrow borrow, String user, String operate);
	
	/**
	 * 根据ID删除资产Asset
	 * @param id
	 */
	@PreAuthorize("hasRole('Admin')")
	void removeAsset(int id);
	
	/**
	 * 根据ID删除借据Borrow
	 * @param id
	 */
	@PreAuthorize("hasRole('Admin')")
	void removeBorrow(int id);
}
