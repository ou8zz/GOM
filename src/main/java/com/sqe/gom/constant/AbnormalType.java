/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.constant;

/**
 * @description 异常类型
 * @author <a href="mailto:sqe_ole@sqeservice.com">James</a>
 * @date Sep 5, 2012 8:19:34 AM
 * @version 3.0
 */
public enum AbnormalType {
	SERVER("服务器故障"), POWER("电力故障"),TASK("工作冲突");

	private String des;

	AbnormalType(String des) {
		this.des = des;
	}

	public String getDes() {
		return des;
	}
}
