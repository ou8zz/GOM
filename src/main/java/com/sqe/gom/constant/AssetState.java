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
public enum AssetState {
	 IN_SHELF_LIFE("保修期内"), OUT_SHELF_LIFE("过保修期"), AVAILABLE("可使用"), UNAVAILABLE("不可用"), DAMAGE("已损坏"), REPAIRCING("报修中");
	 
	 private String des;
	 
	 AssetState(String des) {
		this.des = des;
	 }

	public String getDes() {
		return des;
	}
}
