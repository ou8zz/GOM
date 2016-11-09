/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.Date;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.sqe.gom.model.Resource;
import com.sqe.gom.util.Page;

/**
 * @description Resource DAO Manager
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 9, 2011
 * @version 3.0
 */
@Transactional
public interface ResourceDAO extends GenericDAO<Resource> {

	/**
	 * 查询方法
	 * @param criteria 查询条件
	 * @param page  页面信息
	 * @return List<Res>
	 */
	List<Resource> getResources(String ord, String criteria, Page page);
	
	/**
	 * 查询方法
	 * @param criteria 查询条件
	 * @param page  页面信息
	 * @return List<Resource>
	 */
	List<Resource> getResourceAndHow(String ord, String criteria, Page page);
	
	/**
	 * 根据上传者查询
	 * @param uploadEname 查询条件
	 * @return Resource 类型
	 */
	Resource getResource(String uploadEname);
	
	/**
	 * 修改resource
	 * @param r
	 */
	void updateResource(Resource r);
	
	/**
	 * 更新文件下载时间
	 * @param id
	 * @param downloadDate
	 */
	void updateDowonloadDate(int id, Date downloadDate);
}
