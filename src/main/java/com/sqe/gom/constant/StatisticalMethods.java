/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.constant;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 21, 2012
 * @version 3.0
 */
public enum StatisticalMethods {
	PERCENTAGE("百分比"), STDEV("标准差");

	private String des;

	StatisticalMethods(String des) {
		this.des = des;
	}

	public String getDes() {
		return des;
	}
}
