/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.validation;

import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import com.sqe.gom.model.Departure;

/**
 * @description <code>Validator</code> for <code>Departure</code> forms.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jul 1, 2012  3:46:51 PM
 * @version 3.0
 */
public class DepartureValidator {
	public void validate(Departure dep, Errors errors) {
		if(dep.getId() <= 0){
			errors.rejectValue("id", "required", "要更新的ID不能为空");
		}
		if(dep.getUserId() <= 0) {
			errors.rejectValue("userId", "required", "申请人ID不能为空");
		}
		if(dep.getTraceId() <= 0) {
			errors.rejectValue("traceId", "required", "上一流程ID不能为空");
		}
		if(dep.getNodeOrder() <= 0) {
			errors.rejectValue("nodeOrder", "required", "上一流程顺序ID不能为空");
		}
		if(!StringUtils.hasLength(dep.getNodeCode())) {
			errors.rejectValue("nodeCode", "required", "节点代码不能为空");
		}
		if(!StringUtils.hasLength(dep.getReason())) {
			errors.rejectValue("reason", "required", "审批意见不能为空");
		}
	}
}
