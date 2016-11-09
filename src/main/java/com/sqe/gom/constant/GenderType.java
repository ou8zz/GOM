/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.constant;

/**
 * @description user sex
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Sep 4, 2011 9:48:21 PM
 * @version 3.0
 */
public enum GenderType {
	M("男"), F("女");

	GenderType(String des) {
		this.des = des;
	}

	private String des;

	public String getDes() {
		return des;
	}
}
