/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.validation;

import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;

import com.sqe.gom.model.GomUser;
import com.sqe.gom.util.RegexUtil;

/**
 * @description <code>Validator</code> for <code>Register</code> forms.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 7, 2011 11:36:03 PM
 * @version 3.0
 */
public class UserValidator {
	public void validate(GomUser reg, Errors errors) {
		if(RegexUtil.isEmpty(reg.getId())) {
			if(!StringUtils.hasLength(reg.getEname())) {
				errors.rejectValue("ename", "required", "英文名不能为空");
			} else if (!RegexUtil.verify("^[a-zA-Z][a-zA-Z0-9_]{3,16}$", reg.getEname())) {
				errors.rejectValue("ename", "required", "用户名长度必须大于4位可以是字母数字");
			}
			if(!StringUtils.hasLength(reg.getPwd())) {
				errors.rejectValue("pwd", "required", "密码不能为空");
			}
			if (reg.getDptId() == 0) {
				errors.rejectValue("department", "required", "请选择部门");
			}
			if (reg.getPstId() == 0) {
				errors.rejectValue("position", "required", "请选择职位");
			}
			if (reg.getPortrait() == null) {
				errors.rejectValue("portrait", "required", "请选择一个自己的头像");
			} else if (!RegexUtil.verify(".*gif||.*png||.*jpg$", reg.getPortrait())) {
				errors.rejectValue("portrait", "required", "只允许GIF,PNG,JPG图片");
			}
			if (reg.getIdScan() == null) {
				errors.rejectValue("idScan", "required", "请选择JPG格式的身份证扫描件");
			}
		}
		
		
		if(!StringUtils.hasLength(reg.getCname())) {
			errors.rejectValue("cname", "required", "中文名不能为空");
		} else if (!RegexUtil.verify("^[\u4e00-\u9fa5]+$", reg.getCname())) {
			errors.rejectValue("cname", "required", "只允许中文字符");
		}
		
		if(!StringUtils.hasLength(reg.getCell())) {
			errors.rejectValue("cell", "required", "手机号为空");
		} 

		if (null == reg.getGender()) {
			errors.rejectValue("gender", "required", "请选择性别");
		}
		if (!StringUtils.hasLength(reg.getIdcard())) {
			errors.rejectValue("idcard", "required", "身份证号为必填");
		} 
		if (!StringUtils.hasLength(reg.getNation())) {
			errors.rejectValue("nation", "required", "请填写民族");
		} else if (!RegexUtil.verify("^[\u4e00-\u9fa5]+$", reg.getNation())) {
			errors.rejectValue("nation", "required", "请填写正确的民族");
		}
		if (null == reg.getCensusType()) {
			errors.rejectValue("censusType", "required", "请选择户籍类型");
		}
		if (!RegexUtil.notEmpty(reg.getBirthday())) {
			errors.rejectValue("birthday", "required", "出生日期 比如:2011-08-23");
		}
		if (!StringUtils.hasLength(reg.getBank())) {
			errors.rejectValue("bank", "required", "请填写银行开户名称");
		}
		if (!StringUtils.hasLength(reg.getAccountNo())) {
			errors.rejectValue("accountNo", "required", "请填写银行账号");
		}
		if(null == reg.getMarriage()) {
			errors.rejectValue("marriage", "required", "请填写婚姻状况");
		}
		
		if(!StringUtils.hasLength(reg.getHeight())) {
			errors.rejectValue("height", "required", "身高不能为空");
		}
		if(!StringUtils.hasLength(reg.getPrivateMail())) {
			errors.rejectValue("privateMail", "required", "私人邮箱不能为空");
		}
		if(!StringUtils.hasLength(reg.getPhone())) {
			errors.rejectValue("phone", "required", "固话不能为空");
		}
	}
}