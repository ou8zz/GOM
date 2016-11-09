/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.util;

import static org.junit.Assert.*;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.junit.Ignore;
import org.junit.Test;

/**
 * @description function test that handle of date util.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 6, 2011, 11:46:10 AM
 * @version 3.0
 */
public class DateUtilTest {
	private Calendar cal = Calendar.getInstance();
	
	@Ignore
	public void testGetPreviousDate() {
		int days = 3;
		GregorianCalendar thisday = new GregorianCalendar();
		cal.setTime(thisday.getTime());
		int d1 = cal.get(Calendar.DAY_OF_YEAR);
		cal.setTime(DateUtil.previous(days));
		int d2 = cal.get(Calendar.DAY_OF_YEAR);
		
		assertEquals(days,d1-d2);
	}
	
	@Ignore
	public void testFieldDateFromCurrent() {
		//前一周
		System.out.println(DateUtil.getFieldDateFromCurrent(Calendar.WEEK_OF_YEAR, -1));
		System.out.println(DateUtil.getFieldDateFromCurrent(Calendar.WEEK_OF_MONTH, -1));
		
		//本月中的前一天
		System.out.println(DateUtil.getFieldDateFromCurrent(Calendar.DAY_OF_MONTH, -1));
		
		//一个星期中的第1天
		System.out.println(DateUtil.getFieldDateFromCurrent(Calendar.DAY_OF_WEEK, 1));
	}
	
	@Ignore
	public void testParseDate() throws Exception {
		String s = "1984-09-23";
		Date expected = DateUtil.parseDate(s);
		cal.setTime(expected);
		int d1 = cal.get(Calendar.SHORT);
		Date actul = new SimpleDateFormat("yyyy-MM-dd").parse(s);
		cal.setTime(actul);
		int d2 = cal.get(Calendar.SHORT);
		assertEquals(d1, d2);
	}
	
	@Test
	public void getWeekend() {
		//取得上周末日期
		List<Date> previous = DateUtil.getCurrentWeekend(DateUtil.getFieldDateFromCurrent(Calendar.WEEK_OF_YEAR, -1));
		for(Date d_1: previous) {
			System.out.println("上周 " + d_1);
		}
		//取得本周末日期
		List<Date> current = DateUtil.getCurrentWeekend(null);
		for(Date d0: current) {
			System.out.println("本周 " + d0);
		}
		//取得下周日期
		List<Date> next = DateUtil.getCurrentWeekend(DateUtil.getFieldDateFromCurrent(Calendar.WEEK_OF_YEAR, 1));
		for(Date d1: next) {
			System.out.println("下周 " + d1);
		}
		System.out.println("一年中第几周 " + DateUtil.getField(Calendar.MONTH, null));
	}
	
	@Test
	public void testQuarter() {
		System.out.println("第" + DateUtil.getQuarter(DateUtil.parseDate("2012-12-01")) + "季度");
	}
}
