/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.validation;

import org.springframework.validation.Errors;

import com.sqe.gom.model.Project;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
public class ProjectValidator {
	public void validate(Project project, Errors errors) {
		if (RegexUtil.isEmpty(project.getProjectName())) {
			errors.rejectValue("projectName", "required", "不能为空");
		}
		if (RegexUtil.isEmpty(project.getDirector())) {
			errors.rejectValue("director", "required", "不能为空");
		} 
	}
}
