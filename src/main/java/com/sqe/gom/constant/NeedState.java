/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.constant;
/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Oct 20, 2012
 * @version 3.0
 */
public enum NeedState {
	EXIGENCY("紧急"),GENERAL("一般"),SECONDARY("次要");
	
	private String des;
	
	NeedState(String des) {
		this.des = des;
	}
	
	public String getDes(){
		return des;
	}
}
