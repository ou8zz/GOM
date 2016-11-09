package com.sqe.gom.web.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.sqe.gom.model.Task;
import com.sqe.gom.util.RegexUtil;

public class TaskValidator implements Validator{
	@SuppressWarnings("rawtypes")
	public boolean supports(Class clazz) {  
        return Task.class.equals(clazz);  
    } 
	
	@Override
	public void validate(Object obj, Errors errors) {
		Task wt = (Task) obj;
		if (!RegexUtil.notEmpty(wt.getTaskTitle())) {
			errors.rejectValue("taskTitle", "required", "不能为空");
		}
		if (!RegexUtil.notEmpty(wt.getUnit())) {
			errors.rejectValue("unit", "required", "不能为空");
		}
//		if (!RegexUtil.notEmpty(wt.getExecutor())) {
//			errors.rejectValue("executor", "required", "不能为空");
//		}
//		if (!RegexUtil.notEmpty(wt.getAssignor())) {
//			errors.rejectValue("assignor", "required", "不能为空");
//		}
	}

}
