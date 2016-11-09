/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.w3c.dom.Document;

import com.sqe.gom.model.Category;
import com.sqe.gom.model.Resource;
import com.sqe.gom.util.Page;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 9, 2011
 * @version 3.0
 */
@Transactional
public interface ResourceService {
	
	/** Category表操作, 注意更新时的path的关联更新
	 * 比如：name=手册 path=/IT部，
	 * 假如 IT 部被更新，那么他的子类手册的path也要更新！
	 * 首先添加或更新Category
	 * 根据ID判断是更新还是保存
	 * @param Cate 
	 * @return  
	 */
	@PreAuthorize("hasRole('Manager') or hasRole('Director')")
	void saveCategory(Category cate);

	/**
	 * 得到被遍历好的Category的树形数组
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	List<Category> getCtree();
	
	/**
	 * 初始化category树形Document
	 */
	@PreAuthorize("hasRole('User')")
	Document getCategories(String nid, int level);
	
	/**
	 * 删除Category 根据ID，并要删除程序启动时内存中的数据
	 * @param Cate id  
	 * @return 
	 */
	@PreAuthorize("hasRole('Manager') or hasRole('Director')")
	void removeCategory (int id);
	
	/** Resource表操作
	 * 保存或更新资源, （根据ID判断是更新还是保存）
	 * @param Resource r  
	 * @return 
	 */
	@PreAuthorize("hasRole('User') and hasRole('Manager') or hasRole('Director')")
	void saveResource(Resource r, UserGroup u);
	
	/**
	 * 添加文件时间
	 * @param id
	 */
	@PreAuthorize("hasRole('User')")
	void addDownloadDate(int id);
	
	/**
	 * 查询文件数据   <前台Jsp>
	 * @param criteria 查询条件
	 * @param page  分页信息
	 * @return List<Resource>
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	List<Resource> getResources(String type, String name, Page page);
	
	/**
	 * 查询文件数据    <后台Grid>
	 * @param grid jquery对象
	 * @return List<Resource>
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	List<Resource> getResources(JGridHelper<Resource> grid);
	
	/**
	 * 获得视频文件
	 */
	@PreAuthorize("hasRole('User')")
	List<Resource> getVideos();
	
	/**
	 * 查询文件数据    <后台Grid>
	 * @param grid jquery对象
	 * @param ename 用户名
	 * @return List<Res>
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	JGridBase<Resource> getHowtodos(JGridHelper<Resource> grid, String ename);
	
	/**
	 * 得到如何做文件列表select
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	List<Resource> getResourceSelect();
	
	/**
	 * 查询Howtodos根据ID
	 * @param id
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	String getHowtodos(int id, String image, String path);
	
	/**
	 * 删除Resource根据ID
	 * @param id
	 */
	@PreAuthorize("hasRole('Manager') or hasRole('Director')")
	void removeResource(String[] id);
}
