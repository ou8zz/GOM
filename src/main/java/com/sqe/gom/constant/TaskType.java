/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.constant;
/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 28, 2012
 * @version 3.0
 */
public enum TaskType {
	REGULAR("固定"), PLAN("计划"), TEMPORARY("临时");
	
	private String des;

	TaskType(String des) {
		this.des = des;
	}

	public String getDes() {
		return des;
	}
}
