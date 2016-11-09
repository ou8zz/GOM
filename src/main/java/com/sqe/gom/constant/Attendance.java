/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.constant;
/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Sep 14, 2012
 * @version 3.0
 */
public enum Attendance {
	ONDUTY("上班"),OFFDUTY("下班");
	
	private String des;
	
	Attendance(String str) {
		this.des = str;
	}
	
	public String getDes() {
		return des;
	}
}
