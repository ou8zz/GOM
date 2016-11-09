package com.sqe.gom.constant;

public enum LogsType {
	SYSTEM("系统日志"),NEW("新增功能"),UPDATE("系统更新"),DEBUG("调试日志");
	
	private String des;

	LogsType(String des) {
		this.des = des;
	}

	public String getDes() {
		return des;
	}
}
