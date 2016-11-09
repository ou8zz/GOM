/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;

import com.sqe.gom.constant.DateRange;
import com.sqe.gom.constant.ItemType;
import com.sqe.gom.model.SwotConfig;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description swot service
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 19, 2012
 * @version 3.0
 */
@Transactional
public interface SwotService {
	/**
	 * 稳定模式A百分比/B公差
	 * 
	 * @param sc
	 * @param data
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	List<String> stable(SwotConfig sc, List<Float> data);
	
	/**
	 * 改善模式
	 * @param sc
	 * @param data
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	List<String> improve(SwotConfig sc, List<Float> data);
	
	/**
	 * 进阶稳定模式
	 * @param sc
	 * @param data
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	List<String> advanced(SwotConfig sc, List<Float> data);
	
	/**
	 * 添加或修改config
	 * @param sc
	 */
	@PreAuthorize("hasRole('Admin')")
	void saveSwotConfig(SwotConfig sc);
	
	/**
	 * 根据项目类型查询配置
	 * @param item
	 * @param range
	 * @return
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	SwotConfig getSwotConfig(ItemType item, DateRange range);
	
	/**
	 * 分页查询config
	 * @param ord
	 * @param criteria
	 * @param page
	 * @return
	 */
	@PreAuthorize("hasRole('Admin')")
	JGridBase<SwotConfig> getSwotConfigs(JGridHelper<SwotConfig> grid);
	
	/**
	 * 删除swot config
	 * @param id
	 */
	@PreAuthorize("hasRole('Admin')")
	void removeSwotConfig(Integer id);
}
