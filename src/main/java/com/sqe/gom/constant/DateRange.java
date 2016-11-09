package com.sqe.gom.constant;

public enum DateRange {
	DAY("日"), WEEK("周"), MONTH("月"),QUARTER("季度"),YEAR("年"),MORNING("早报");

	private String des;

	DateRange(String des) {
		this.des = des;
	}

	public String getDes() {
		return des;
	}
}
