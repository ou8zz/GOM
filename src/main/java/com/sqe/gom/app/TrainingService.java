/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;

import com.sqe.gom.model.Experience;
import com.sqe.gom.model.Training;
import com.sqe.gom.util.Page;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description 培训管理服务层
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Transactional
public interface TrainingService {
	
	/**
	 * 根据条件criteria 分页Page 查询所有培训内容  ord 排序TrainingVo
	 * @param ord
	 * @param condition
	 * @param page
	 * @return TrainingVo
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	JGridBase<Training> getTrainings(JGridHelper<Training> grid);
		
	/**
	 * 根据条件ename 分页Page 查询所有培训内容  ord 排序Experience
	 * @param ename
	 * @param page
	 * @return TrainingVo
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	List<Training> getTrainingAndExperience(String ename, Page page);
	
	/**
	 * 根据条件criteria 查询Experience
	 * @param criteria
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	@Transactional(readOnly=true)
	List<Experience> getGain(String user, String start, String end);
			
	/**
	 * 保存、更新Training
	 * @param training
	 */
	@PreAuthorize("hasRole('User') and hasRole('Assistant') or hasRole('Director') or hasRole('Manager') or hasRole('CEO')")
	void saveTraining(Training training);
	
	/**
	 * 保存、修改Experience到Resource表中
	 * @param experience 附件路径
	 */
	@PreAuthorize("hasRole('User')")
	void saveExperienceAndToResource(Experience experience, String image, String path);
	
	/**
	 * 保存、修改HowToDo到Resource表中
	 * @param experience 附件路径
	 */
	@PreAuthorize("hasRole('User')")
	void saveHowAndToResource(Experience experience);
	
	/**
	 * 根据ID删除资产Training
	 * @param id
	 */
	@PreAuthorize("hasRole('Admin')")
	void removeTraining(int id);
	
	/**
	 * 根据ID删除借据Experience
	 * @param id
	 */
	@PreAuthorize("hasRole('Admin')")
	void removeExperience(int id);
}
