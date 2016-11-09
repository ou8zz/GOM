package com.sqe.gom.web.validation;

import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import com.sqe.gom.model.Task;
import com.sqe.gom.util.RegexUtil;

public class TaskValidator {
	public void validate(Task task, Errors errors) {
		if(!StringUtils.hasLength(task.getTaskTitle())) {
			errors.rejectValue("taskTitle", "required", "标题不能为空");
		}
		if(RegexUtil.isEmpty(task.getTaskType())) {
			errors.rejectValue("taskType", "required", "任务类型不能为空");
		}
		if(!StringUtils.hasLength(task.getDescribe())) {
			errors.rejectValue("describe", "required", "描述说明不能为空");
		}
		if(task.getExpectedHours() == 0) {
			errors.rejectValue("expectedHours", "required", "预计工时不能为零");
		}
	}
}
