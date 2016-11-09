/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.w3c.dom.Document;

import com.sqe.gom.model.Product;
import com.sqe.gom.model.Project;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description Project, Product manage service
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 5, 2012
 * @version 3.0
 */
@Transactional
public interface ProjectService {
	
	/**
	 * 检查项目名称或编号是否存在project信息
	 * @param project
	 * @return true or false
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	boolean checkProject(Project project);
	
	/**
	 * 检查项目名称是否存在product信息
	 * @param product
	 * @return true or false
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	boolean checkProduct(String productName);
		
	/**
	 * 分页查询所有项目Project
	 * @param pid
	 * @param level
	 * @return 返回Document
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	Document getProjects(String pid, int level);
	
	/**
	 * 查询所有项目（ID，项目号，项目名）
	 * @param pid
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	List<Project> getProjects(String pid);
	
	/**
	 * 分页查询所有产品Product
	 * @param ord 排序
	 * @param criteria 条件
	 * @param page 分页条件
	 * @return 返回List<ProductVo>
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	JGridBase<Product> getProducts(JGridHelper<Product> grid);

	/**
	 * 获得所有产品
	 * @return 产品集合list
	 */
	@PreAuthorize("hasRole('User')")
	List<Product> getProducts();
	
	/**
	 * 保存或修改project信息
	 * @param project
	 */
	@PreAuthorize("hasRole('Director') or hasRole('Manager')")
	void saveProject(Project project);
	
	/**
	 * 保存或修改Product信息
	 * @param Product
	 */
	@PreAuthorize("hasRole('Director') or hasRole('Manager')")
	void saveProduct(Product product);
	
	/**
	 * 删除一条项目信息
	 * @param 根据id删除
	 */
	@PreAuthorize("hasRole('Director') or hasRole('Manager')")
	void removeProject(int id);
	
	/**
	 * 删除一条产品信息
	 * @param 根据id删除
	 */
	@PreAuthorize("hasRole('Director') or hasRole('Manager')")
	void removeProduct(int id);
}
