/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.constant.ResourceType;
import com.sqe.gom.model.Experience;
import com.sqe.gom.util.Page;

/**
 * @description 培训Experience接口
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 10, 2012
 * @version 3.0
 */
public interface ExperienceDAO extends GenericDAO<Experience> {
		
	/**
	 * 根据条件criteria 查询心得 或 如何做
	 * @param type MANUAL("手册"), MATERIAL("教材"),TECHNICAL("技术档"),EXPERIENCE("心得"),HOW("如何做");
	 * @param start, end
	 * @return
	 */
	List<Experience> getExperiences(ResourceType type, String user, String start, String end);
	
	/**
	 * 得到一个培训的所有用户心得
	 * @param start, end
	 * @return
	 */
	List<Experience> getExperiences(String ord, String criteria, Page page);
	
	/**
	 * 更新Experience
	 * @param exper
	 * @return
	 */
	int updateExperience(Experience exper);
	
}
