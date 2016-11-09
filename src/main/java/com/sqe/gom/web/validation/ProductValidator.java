/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.validation;

import org.springframework.validation.Errors;

import com.sqe.gom.model.Product;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
public class ProductValidator {
	public void validate(Product product, Errors errors) {
		if (!RegexUtil.notEmpty(product.getProductName())) {
			errors.rejectValue("productName", "required", "不能为空");
		}
		if (!RegexUtil.notEmpty(product.getProductType())) {
			errors.rejectValue("productType", "required", "不能为空");
		}
		if (!RegexUtil.notEmpty(product.getVersion())) {
			errors.rejectValue("version", "required", "不能为空");
		}
		if (!RegexUtil.notEmpty(product.getNum())) {
			errors.rejectValue("num", "required", "不能为空");
		} else if(!(product.getNum() > 0)) {
			errors.rejectValue("expectedNumber", "required", "不能为空");
		}
		if (!RegexUtil.notEmpty(product.getUnit())) {
			errors.rejectValue("unit", "required", "不能为空");
		}
		if (!RegexUtil.notEmpty(product.getOutputDate())) {
			errors.rejectValue("outputDate", "required", "不能为空");
		}
	}
}
