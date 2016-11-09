/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.constant;
/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 5, 2012
 * @version 3.0
 */
public enum ProductType {
	SOFTWARE("软件"),CONSULTING("咨询服务"),TRAINNING("培训服务");
	
	private String des;
	
	ProductType(String des) {
		this.des = des;
	}
	
	public String getDes() {
		return des;
	}
}
