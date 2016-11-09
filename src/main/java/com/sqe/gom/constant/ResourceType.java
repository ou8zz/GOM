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
public enum ResourceType {
	MANUAL("手册"), MATERIAL("教材"),TECHNICAL("技术档"),EXPERIENCE("心得"),HOW("如何做"),VIDEO("视频");
	
	private String des;

	ResourceType(String des) {
		this.des = des;
	}

	public String getDes() {
		return des;
	}
}
