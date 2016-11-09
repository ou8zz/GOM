/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.validation;

import org.springframework.validation.Errors;

import com.sqe.gom.model.Asset;
import com.sqe.gom.util.RegexUtil;

/**
 * @description validate user address.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Feb 8, 2012  10:10:56 PM
 * @version 3.0
 */
public class AssetValidator {
	public void validate(Asset a, Errors errors) {
		if(RegexUtil.isEmpty(a.getAssetState())) {
			errors.rejectValue("assetState", "required", "申领状态不能为空");
		}
	}
}