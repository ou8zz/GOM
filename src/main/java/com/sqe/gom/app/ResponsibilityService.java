/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.w3c.dom.Document;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.model.Responsibility;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 6, 2012
 * @version 3.0
 */
@Transactional
public interface ResponsibilityService {
	
	/**
	 * 添加或更新Responsibility根据ID
	 * @param responsibility
	 */
	@PreAuthorize("hasRole('User') and hasRole('Manager') or hasRole('Director')")
	Responsibility saveResponsibility(Responsibility responsibility);
	
	/**
	 * 保存JSON数组
	 * 
	 * @param responsibility  JSON数组
	 * @param userId  The identify of user
	 */
	@PreAuthorize("hasRole('User') and hasRole('Manager') or hasRole('Director')")
	List<Responsibility> saveResponsibilities(String rpts, Integer userId);
	
	/**
	 * copy责任管理
	 * 
	 * @param recevier
	 * @param firer
	 * @return
	 */
	@PreAuthorize("hasRole('User') or hasRole('Manager') or hasRole('Director')")
	List<Responsibility> updateResponsibilities(String recevier, Integer firer);
	
	/**
	 * 更新AJAX封装的responsibility数组
	 * 
	 * @param responsibility  JSON数组
	 */
	@PreAuthorize("hasRole('User') or hasRole('Manager') or hasRole('Director')")
	HandlerState updateResponsibilities(String rpts);
	
	@PreAuthorize("hasRole('User')")
	Responsibility getResponsibility(Integer rid);
	
	/**
	 * 查询未分配给用户的主责任
	 * 
	 * @param responIds 已分配责任ID
	 * @return  list of responsibilities
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	List<Responsibility> getNotSelectRespons(String responIds);
	
	/**
	 * 根据UserId构建责任树
	 * 
	 * @param userId    The identify of user
	 * @param parentId  The identify of responsibility parent
	 * @param isf The query is include responsibility parent identify
	 * @return  XML tree responsibilities
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	Document buildRespTree(Integer userId, Integer parentId, Integer level);
			
	/**
	 * 根据criteria noid得Responsibility
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	List<Responsibility> getResponsibility(String ename, Integer userId, Integer parentId, Boolean isf, String node);

}
