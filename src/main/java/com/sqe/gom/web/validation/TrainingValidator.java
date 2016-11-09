/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.validation;

import org.springframework.validation.Errors;

import com.sqe.gom.model.Training;
import com.sqe.gom.util.RegexUtil;

/**
 * @description validate user address.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Feb 8, 2012  10:10:56 PM
 * @version 3.0
 */
public class TrainingValidator {
	public void validate(Training t, Errors errors) {
		if(RegexUtil.isEmpty(t.getTprogram())) {
			errors.rejectValue("tprogram", "required", "训练项目不能为空");
		}
		if(RegexUtil.isEmpty(t.getTrainingType())) {
			errors.rejectValue("trainingType", "required", "培训类型不能为空");
		}
		if(RegexUtil.isEmpty(t.getTrainingTime()) || t.getTrainingTime() <= 0) {
			errors.rejectValue("trainingTime", "required", "训练时数不能为空");
		}
		if(RegexUtil.isEmpty(t.getFee())) {
			errors.rejectValue("fee", "required", "上课费用不能为空");
		}
		if(RegexUtil.isEmpty(t.getStartDate())) {
			errors.rejectValue("startDate", "required", "开始日期不能为空");
		}
		if(RegexUtil.isEmpty(t.getEndDate())) {
			errors.rejectValue("endDate", "required", "结束日期不能为空");
		}
		if(RegexUtil.isEmpty(t.getQualification())) {
			errors.rejectValue("qualification", "required", "讲师资质不能为空");
		}
	}
}