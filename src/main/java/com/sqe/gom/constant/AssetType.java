/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.constant;
/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
public enum AssetType {
	COMPUTER("计算机"), CONSUMABLES ("办公耗材"), DAILY_OFFICE("办公日用品");
	
	private String des;

	AssetType(String des) {
		this.des = des;
	}

	public String getDes() {
		return des;
	}
}
