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
		if(null == leave.getStartDate()) {
			errors.rejectValue("startDate", "required","请假开始时间 比如:2011-8-23-11 12:30:00");
		} 
		if(null == leave.getEndDate()) {
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

		if(!StringUtils.hasLength(leave.getEvent())) {
			errors.rejectValue("event", "required", "事件不能空 ");
		}
		
		if(!StringUtils.hasLength(leave.getAgent())) {
			errors.rejectValue("agent", "required", "代理人不能空");
		}
		
		if(!StringUtils.hasLength(leave.getHandOver())) {
			errors.rejectValue("handOver", "required", "交接不能空 ");
		}
	}

	@SuppressWarnings("rawtypes")
	public boolean supports(Class clazz) {
		return clazz.equals(Leave.class);
	}
}
