/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.validation;

import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import com.sqe.gom.model.Address;
import com.sqe.gom.util.RegexUtil;

/**
 * @description validate user address.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Feb 8, 2012  10:10:56 PM
 * @version 3.0
 */
public class AddressValidator {
	public void validate(Address a, Errors errors) {
		if(!StringUtils.hasLength(a.getContact())) {
			errors.rejectValue("contact", "required", "联系人不能空");
		}
		if(!StringUtils.hasLength(a.getRelation())) {
			errors.rejectValue("relation", "required", "关系不能空");
		}
		if(!StringUtils.hasLength(a.getAddress())) {
			errors.rejectValue("address", "required", "地址不能为空");
		}
		if(!StringUtils.hasLength(a.getZipcode())) {
			errors.rejectValue("zipcode", "required", "邮编不能空");
		}
		if(!StringUtils.hasLength(a.getCell())) {
			errors.rejectValue("cell", "required", "手机不能为空");
		}
		if(!StringUtils.hasLength(a.getPhone())) {
			errors.rejectValue("phone", "required", "电话不能空");
		}
		if(!RegexUtil.notEmpty(a.getAddrType())) {
			errors.rejectValue("addrType", "required", "地址类型不能为空");
		}
	}
}