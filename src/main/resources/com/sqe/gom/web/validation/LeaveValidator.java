/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.validation;

import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import com.sqe.gom.model.Leave;

/**
 * @description 请假验证类
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Oct 23, 2011 9:44:00 PM
 * @version 3.0
 */
public class LeaveValidator implements Validator {
	public void validate(Object obj, Errors errors) {
		Leave leave = (Leave) obj;
		if (null == leave.getStartDate()) {
			errors.rejectValue("startDate", "required","请假开始时间 比如:2011-8-23-11 12:30:00");
		} 
		if (null == leave.getEndDate()) {
			errors.rejectValue("endDate", "required","请假结束时间 比如:2011-8-23-11 12:30:00");
		}else{
			try {
				if (!leave.getStartDate().before(leave.getEndDate())) {
					errors.rejectValue("endDate", "required","请假开始时间不能大于或等于请假结束时间");
				}
			} catch (Exception e) {
				errors.rejectValue("endDate", "required", "请假时间格式有问题");
				e.printStackTrace();
			}
		}

		if (!StringUtils.hasLength(leave.getEvent())) {
			errors.rejectValue("event", "required", "表明请假理由等 等 ");
		}
		if (!StringUtils.hasLength(leave.getHandOver())) {
			errors.rejectValue("handOver", "required", "一些交接的工作");
		}
		if (leave.getType() == null) {
			errors.rejectValue("type", "required", "请选择请假类型");
		}
		if (leave.getDays() <= 0) {
			errors.rejectValue("days", "required", "请假天数不能为空且不能小于0");
		}
	}

	@SuppressWarnings("rawtypes")
	public boolean supports(Class clazz) {
		return clazz.equals(Leave.class);
	}
}
