package com.sqe.gom.constant;

/**
 * @description state of approval.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jul 5, 2011  11:41:16 PM
 * @version 3.0
 */
public enum ApprovalStatus {
	APPROVAL("批准"),REJECT("拒绝"),REVOKE("驳回"),AGREE("同意"),DISAGREE("不同意");
	
	private String des;
	
	ApprovalStatus(String des) {
		this.des = des;
	}
	
	public String getDes() {
		return des;
	}
}