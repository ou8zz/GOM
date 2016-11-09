/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.model.Training;
import com.sqe.gom.util.Page;

/**
 * @description	培训Training接口
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 10, 2012
 * @version 3.0
 */
public interface TrainingDAO extends GenericDAO<Training> {
	
	/**
	 * 根据条件criteria 分页Page 查询所以公司资产  ord 排序
	 * @param ord
	 * @param condition
	 * @param page
	 * @return
	 */
	List<Training> getTrainings(String ord, String criteria, Page page);
	
	/**
	 * 根据条件criteria 分页Page 查询所以公司资产  ord 排序
	 * @param ord
	 * @param condition
	 * @param page
	 * @return
	 */
	List<Training> getTrainingAndExperience(String ord, String criteria, Page page);
}
