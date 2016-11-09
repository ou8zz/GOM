/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.constant;

/**
 * @description 地址类型
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Sep 5, 2011 8:19:34 AM
 * @version 3.0
 */
public enum AddrType {
	PRESENT("现居住址"), FAMILY("家庭住址"),S_P_F("家庭与现居同一"), CENSUS("户籍地址"), EMERGENCY("紧急联络"),S_C_P("户籍与现居同一"),S_C_F("户籍与家庭同一"),C_P_F("户籍现居家庭同一");

	private String des;

	AddrType(String des) {
		this.des = des;
	}

	public String getDes() {
		return des;
	}
}
