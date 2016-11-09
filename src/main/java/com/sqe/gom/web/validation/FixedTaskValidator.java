package com.sqe.gom.web.validation;

import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import com.sqe.gom.model.FixedTask;
import com.sqe.gom.util.RegexUtil;

public class FixedTaskValidator {
	public void validate(FixedTask task, Errors errors) {
		if(!StringUtils.hasLength(task.getTaskTitle())) {
			errors.rejectValue("taskTitle", "required", "标题不能为空");
		}
		if(RegexUtil.isEmpty(task.getFrequency())) {
			errors.rejectValue("frequency", "required", "频率周期不能为空");
		}
		if(task.getHours() == 0 || task.getHours() == 0.0) {
			errors.rejectValue("hours", "required", "预计工时不能为零");
		}
		if(!StringUtils.hasLength(task.getDescribe())) {
			errors.rejectValue("describe", "required", "描述说明不能为空");
		}
		if(RegexUtil.isEmpty(task.getExpectedStart())) {
			errors.rejectValue("expectedStart", "required", "预计开始时间不能为空");
		}
		if(RegexUtil.isEmpty(task.getExpectedEnd())) {
			errors.rejectValue("expectedEnd", "required", "预计开始时间不能为空");
		}
	}
}
