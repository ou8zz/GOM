package com.sqe.gom.web.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import com.sqe.gom.model.GomGroup;

public class GroupValidator implements Validator{
	@SuppressWarnings("rawtypes")
	@Override
	public boolean supports(Class clazz) {
		return GomGroup.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "ename", "ename.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "cname", "cname.required");
		ValidationUtils.rejectIfEmpty(errors, "type", "type.required");
	}
}
