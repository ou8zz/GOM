/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.constant;
/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Sep 14, 2012
 * @version 3.0
 */
public enum WorkingHoursType {
	EXPECTED("预计"),ACTUAL("实际");
	
	private String des;
	
	WorkingHoursType(String des) {
		this.des = des;
	}

	public String getDes() {
		return des;
	}
	
}
