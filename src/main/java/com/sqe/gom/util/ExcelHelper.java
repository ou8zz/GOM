package com.sqe.gom.util;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import jxl.Sheet;
import jxl.Workbook;

public class ExcelHelper {
	
	public static List<Float> getExcelForSwot(File file) {
		List<Float> list = new ArrayList<Float>();
		try {
			
			Workbook book = Workbook.getWorkbook(file);

			// 获得第一个sheet,默认有三个
			Sheet sheet = book.getSheet(0);
			// 一共有多少行多少列数据
			int rows = sheet.getRows();
			int columns = sheet.getColumns();

			boolean hasText = false;
			for (int i = 1; i < rows; i++) {
				// 过滤掉没有文本内容的行
				for (int j = 0; j < columns; j++)
					if (sheet.getCell(j, i).getContents() != "") {
						hasText = true;
						break;
					}
				if (hasText) {
					//st = new SwotResult();
					//st.setData(Float.valueOf(sheet.getCell(0, i).getContents()));
					//st.setSwotType(SwotType.valueOf(sheet.getCell(1, i).getContents()));
					list.add(Float.valueOf(sheet.getCell(0, i).getContents()));
				}
			}
			book.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
