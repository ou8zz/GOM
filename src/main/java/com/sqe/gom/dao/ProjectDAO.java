/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.sqe.gom.model.Project;

/**
 * @description project DAO manager interface
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 5, 2012
 * @version 3.0
 */
@Transactional
public interface ProjectDAO extends GenericDAO<Project> {
	
	/**
	 * 根据条件criteria 分页Page 查询所以公司资产  ord 排序
	 * @param ord
	 * @param condition
	 * @return
	 */
	List<Project> getProjects(String ord, String criteria);
	
	/**
	 * 报表查询Project未完成接口
	 * @param criteria
	 * @return
	 */
	List<Project> getProjects(String criteria);
		
	/**
	 * 查询项目编号和名称是否存在
	 * @param pro
	 * @return
	 */
	Project getProject(Project pro);
	
	/**
	 * 修改项目Project
	 * @param p
	 * @return 返回成功或失败0:1
	 */
	int updateProject(Project p);
}