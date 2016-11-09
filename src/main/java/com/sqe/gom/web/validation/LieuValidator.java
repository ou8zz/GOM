/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.sqe.gom.model.Lieu;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 11, 2012
 * @version 3.0
 */
@SuppressWarnings("rawtypes")
public class LieuValidator implements Validator {

	@Override
	public boolean supports(Class clazz) {
		return clazz.equals(Lieu.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Lieu l = (Lieu) target;
		if(RegexUtil.isEmpty(l.getType())) {
			errors.rejectValue("type", "required", "调休类型不能为空");
		}
		if(RegexUtil.isEmpty(l.getDayoff())) {
			errors.rejectValue("dayoff", "required", "休息日期不能为空");
		}
		if(RegexUtil.isEmpty(l.getWorkedon())) {
			errors.rejectValue("workedon", "required", "调休时间不能为空");
		}
		if(l.getDayoff().equals(l.getWorkedon())) {
			errors.rejectValue("workedon", "required", "休息日期和调休时间不能在同一天");
		}
	}
}
