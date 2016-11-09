/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.sqe.gom.model.Holidays;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 11, 2012
 * @version 3.0
 */
@SuppressWarnings("rawtypes")
public class HolidaysValidator implements Validator {

	@Override
	public boolean supports(Class clazz) {
		return clazz.equals(Holidays.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Holidays h = (Holidays) target;
		if(RegexUtil.isEmpty(h.getName())) {
			errors.rejectValue("name", "required", "节假日名称不能为空");
		}
		if(RegexUtil.isEmpty(h.getStartDate())) {
			errors.rejectValue("startDate", "required", "开始日期不能为空");
		}
		if(RegexUtil.isEmpty(h.getEndDate())) {
			errors.rejectValue("endDate", "required", "结束时间不能为空");
		}
		if(RegexUtil.isEmpty(h.getDays())) {
			errors.rejectValue("days", "required", "天数不能为空");
		}
	}
}
