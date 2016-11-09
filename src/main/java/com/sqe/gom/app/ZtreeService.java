/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.w3c.dom.Document;

import com.sqe.gom.model.Ztree;
import com.sqe.gom.vo.Trees;

/**
 * @description Ztree service
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 19, 2012
 * @version 3.0
 */
@Transactional
public interface ZtreeService {
	
	/**
	 * 清空用户ztreeMap
	 * @param ename
	 */
	void removeTreeMap(String ename);
	
	/**
	 * 添加或修改Ztree
	 * @param zt
	 */
	@PreAuthorize("hasRole('Admin')")
	void saveZtree(Ztree zt);
	
	/**
	 * 编辑用户tree
	 * @param uid
	 * @param zid
	 */
	@PreAuthorize("hasRole('Admin')")
	void editUserTree(int uid, String[] zid);
	
	/**
	 * 编辑基础tree配置
	 * @param isAdd
	 * @param zid
	 */
	@PreAuthorize("hasRole('Admin')")
	void editBasicTree(String isAdd, String[] zid);
		
	/**
	 * 查询用户tree
	 * @param uid
	 * @return
	 */
	@PreAuthorize("hasRole('Admin')")
	@Transactional(readOnly=true)
	List<Ztree> getZtrees(String userId);
	
	/**
	 * 查询所有Ztree OR 查询基础配置Ztree
	 * @param nodeId
	 * @param isBasic
	 * @return
	 */
	@PreAuthorize("hasRole('Admin')")
	@Transactional(readOnly=true)
	Document getZtrees(String nodeId, int level, boolean isBasic);
	
	/**
	 * 查询所有Ztree
	 * @param nodeId
	 * @return Trees (VO XML)
	 */
	@Transactional(readOnly=true)
	List<Trees> getLeftTree(String nid, Integer uid);
	
	/**
	 * 查询基础树
	 * @return
	 */
	List<Ztree> getBasicZtree(boolean bool);
}
