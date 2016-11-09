/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.constant;

/**
 * @description 统计项目
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Sep 5, 2011 8:19:34 AM
 * @version 3.0
 */
public enum ItemType {
	//贡献，计划，实际，请假，调休，迟到，早退，延误
	CONTRIBUTION("贡献"), PLAN("计划"), PRACTICAL("实际"), LEAVE("请假"), LIEU("调休"), LATE("迟到"), EARLY("早退"), DELAY("延误");

	private String des;

	ItemType(String des) {
		this.des = des;
	}

	public String getDes() {
		return des;
	}
}
