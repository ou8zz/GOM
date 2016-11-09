/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.validation;

import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import com.sqe.gom.model.Education;
import com.sqe.gom.util.RegexUtil;

/**
 * @description validate user education.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Sep 26, 2011 9:39:32 PM
 * @version 3.0
 */
public class EducationValidator {
	public void validate(Education e, Errors errors) {
		if(!RegexUtil.notEmpty(e.getStartDate())) {
			errors.rejectValue("startDate", "required", "教育培训开始日期 比如:2011-8-23");
		}
		if(!RegexUtil.notEmpty(e.getEndDate())) {
			errors.rejectValue("endDate", "required", "教育培训结束时间 比如:2011-8-23");
		}
		if(!StringUtils.hasLength(e.getEd())) {
			errors.rejectValue("ed", "required", "学历简称  高中，大专，本科等,或者也可以是职称");
		}
		if(!StringUtils.hasLength(e.getSchool())) {
			errors.rejectValue("school", "required", "请填写学校名称");
		}
		if(!StringUtils.hasLength(e.getMajor())) {
			errors.rejectValue("major", "required", "请填写专业");
		}
	}
}
