/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.util;

import java.awt.Color;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.List;
import java.util.Map;

import com.lowagie.text.BadElementException;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.sqe.gom.constant.ItemType;
import com.sqe.gom.model.Borrow;
import com.sqe.gom.model.Meeting;
import com.sqe.gom.model.Responsibility;
import com.sqe.gom.model.SwotResult;
import com.sqe.gom.model.Task;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 17, 2013
 * @version 3.0
 */
public class PDFHelper {
	//获得绝对路径//   /target/classes/  目录下
	private static String path = PDFHelper.class.getResource("/").getPath();
	
	//字体文件
	private static BaseFont bfChinese;
	
	//返回中文字Paragraph
	public static Paragraph getCineseString(String content) {
	    return new Paragraph(content, getChineseFont(12, false));
	}
	
	//设置字体-返回中文字体
	protected static Font getChineseFont(int nfontsize, boolean isBold) {
		Font fontChinese = null;
		try {
			bfChinese = BaseFont.createFont(path + "/SIMYOU.TTF", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
			if (isBold) {
				fontChinese = new Font(bfChinese, nfontsize, Font.BOLD);
			} else {
				fontChinese = new Font(bfChinese, nfontsize, Font.NORMAL);
			}
		} catch (DocumentException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return fontChinese;
	}
	
	@SuppressWarnings("unchecked")
	public static File getPDF(String path, Map<String, Object> params) throws MalformedURLException {
		Rectangle rectPageSize = new Rectangle(PageSize.A4);	//定义A4页面大小
	    rectPageSize = rectPageSize.rotate();					//实现A4页面的横置
	    Document document = new Document(rectPageSize, 50, 50, 10, 10);//其余4个参数，设置了页面的4个边距 
        //将要生成的 pdf 文件的路径输出流  
        FileOutputStream pdfFile;
        File file = null;
		try {
			file = new File(path);
			pdfFile = new FileOutputStream(file);
			
			// 用 Document 对象、File 对象获得 PdfWriter 输出流对象
			PdfWriter writer = PdfWriter.getInstance(document, pdfFile);
			writer.setStrictImageSequence(true); 	//使图片换行按顺序排列
			
			document.open(); // 打开 Document 文档

			List<Task> weekDevote = (List<Task>) params.get("weekDevote");
			List<Task> doing = (List<Task>) params.get("doing");
			List<Task> help = (List<Task>) params.get("help");
			List<Responsibility> resp = (List<Responsibility>) params.get("resp");
			List<Meeting> meeting = (List<Meeting>) params.get("meeting");
			List<Borrow> borrows = (List<Borrow>) params.get("borrows");
			List<SwotResult> list = (List<SwotResult>) params.get("weekly");
			if(RegexUtil.isEmpty(list)) list = (List<SwotResult>) params.get("monthly");
			else if(RegexUtil.isEmpty(list)) list = (List<SwotResult>) params.get("quarterly");
			else if(RegexUtil.isEmpty(list)) list = (List<SwotResult>) params.get("yearly");

			//图表
			createTable(ItemType.CONTRIBUTION, params, document);
			createTable(ItemType.PLAN, params, document);
			createTable(ItemType.PRACTICAL, params, document);
			createTable(ItemType.DELAY, params, document);
			createTable(ItemType.EARLY, params, document);
			createTable(ItemType.LEAVE, params, document);
			createTable(ItemType.LATE, params, document);
			createTable(ItemType.LIEU, params, document);
			
			
			//统计数据
			if (RegexUtil.notEmpty(list)) {
				document.add(getCineseString("总趋势"));
				
				PdfPTable table = new PdfPTable(13);
				table.setSpacingBefore(10);
				table.setSpacingAfter(10);
				
				table.addCell("SWOT");
				// 产生表格标题行
				for (int i = 0; i < 12; i++) {
					SwotResult sr = list.get(i);
					PdfPCell cell = new PdfPCell(new Paragraph(sr.getDay()));
					table.addCell(cell);
				}
				// 表格主体
				int j = 1;
				for (SwotResult sr : list) {
					if (j % 12 == 1) {
						table.addCell(getCineseString(sr.getTitle()));
					}
					PdfPCell cell = new PdfPCell(new Paragraph(sr.getData().toString()));
					cell.setBackgroundColor(getColor(sr.getSwot()));
					table.addCell(cell);
					if (j % 12 == 0) {
						table.completeRow();
					}
					j++;
				}
				table.setWidthPercentage(100);  
				document.add(table);
			}

			// 一周贡献
			if (RegexUtil.notEmpty(weekDevote)) {
				document.add(getCineseString("一周贡献"));
				
				float[] widths = {40f, 165f, 50f, 50f, 50f, 60f, 90f, 90f};
				PdfPTable weeks = new PdfPTable(8);
				weeks.setSpacingBefore(10);
				weeks.setSpacingAfter(10);
				weeks.setWidthPercentage(widths, new Rectangle(PageSize.A4));
				
				PdfPCell cell = new PdfPCell(new Paragraph("SWOT"));
				weeks.addCell(cell);
				weeks.addCell(getCineseString("任务标题"));
				weeks.addCell(getCineseString("工作类型"));
				weeks.addCell(getCineseString("预计工时"));
				weeks.addCell(getCineseString("实际工时"));
				weeks.addCell(getCineseString("完成比例(%)"));
				weeks.addCell(getCineseString("开始时间 "));
				weeks.addCell(getCineseString("结束时间"));
				weeks.completeRow();

				for (Task t : weekDevote) {
					PdfPCell swot = new PdfPCell();
					swot.setBackgroundColor(getColor(t.getSwot()));
					weeks.addCell(swot);
					weeks.addCell(new PdfPCell(getCineseString(t.getTaskTitle())));
					weeks.addCell(new PdfPCell(getCineseString(t.getTaskType().getDes())));
					weeks.addCell(String.valueOf(t.getExpectedHours()));
					weeks.addCell(String.valueOf(t.getActualHours()));
					weeks.addCell(t.getCompletedRate());
					weeks.addCell(DateUtil.formatDateTime(t.getActualStart()));
					weeks.addCell(DateUtil.formatDateTime(t.getActualEnd()));
					weeks.completeRow();
				}
				weeks.setWidthPercentage(100);  
				document.add(weeks);
			}

			//一周需要做
			if (RegexUtil.notEmpty(doing)) {
				document.add(getCineseString("一周需要做"));
				
				float[] widths = {175f, 70f, 70f, 80f, 100f, 100f};
				PdfPTable doings = new PdfPTable(6);
				doings.setSpacingBefore(10);
				doings.setSpacingAfter(10);
				doings.setWidthPercentage(widths, new Rectangle(PageSize.A4));
				doings.addCell(getCineseString("任务标题"));
				doings.addCell(getCineseString("工作类型"));
				doings.addCell(getCineseString("预计工时"));
				doings.addCell(getCineseString("完成比例(%)"));
				doings.addCell(getCineseString("开始时间 "));
				doings.addCell(getCineseString("结束时间"));
				doings.completeRow();

				for (Task t : doing) {
					doings.addCell(new PdfPCell(getCineseString(t.getTaskTitle())));
					doings.addCell(new PdfPCell(getCineseString(t.getTaskType().getDes())));
					doings.addCell(String.valueOf(t.getExpectedHours()));
					doings.addCell(t.getCompletedRate());
					doings.addCell(DateUtil.formatDateTime(t.getExpectedStart()));
					doings.addCell(DateUtil.formatDateTime(t.getExpectedEnd()));
					doings.completeRow();
				}
				doings.setWidthPercentage(100);  
				document.add(doings);
			}
			
			//需要帮忙
			if (RegexUtil.notEmpty(help)) {
				document.add(getCineseString("需要帮忙"));
				
				float[] widths = {175f, 70f, 70f, 80f, 100f, 100f};
				PdfPTable helps = new PdfPTable(7);
				helps.setSpacingBefore(10);
				helps.setSpacingAfter(10);
				helps.setWidthPercentage(widths, new Rectangle(PageSize.A4));
				helps.addCell(getCineseString("任务标题"));
				helps.addCell(getCineseString("工作类型"));
				helps.addCell(getCineseString("预计工时"));
				helps.addCell(getCineseString("完成比例(%)"));
				helps.addCell(getCineseString("开始时间 "));
				helps.addCell(getCineseString("结束时间"));
				helps.completeRow();

				for (Task t : help) {
					helps.addCell(new PdfPCell(getCineseString(t.getTaskTitle())));
					helps.addCell(new PdfPCell(getCineseString(t.getTaskType().getDes())));
					helps.addCell(String.valueOf(t.getExpectedHours()));
					helps.addCell(t.getCompletedRate());
					helps.addCell(DateUtil.formatDateTime(t.getExpectedStart()));
					helps.addCell(DateUtil.formatDateTime(t.getExpectedEnd()));
					helps.completeRow();
				}
				helps.setWidthPercentage(100);  
				document.add(helps);
			}
			
			//责任管理
			if (RegexUtil.notEmpty(resp)) {
				document.add(getCineseString("责任管理"));
				
				float[] widths = {60f, 120f, 80f, 335f};
				PdfPTable resps = new PdfPTable(4);
				resps.setSpacingBefore(10);
				resps.setSpacingAfter(10);
				resps.setWidthPercentage(widths, new Rectangle(PageSize.A4));
				resps.addCell(getCineseString("功能代码"));
				resps.addCell(getCineseString("主旨"));
				resps.addCell(getCineseString("比重(%)"));
				resps.addCell(getCineseString("说明"));
				resps.completeRow();

				for (Responsibility r : resp) {
					resps.addCell(r.getFuncode());
					resps.addCell(new PdfPCell(getCineseString(r.getName())));
					resps.addCell(String.valueOf(r.getExpected()));
					resps.addCell(new PdfPCell(getCineseString(r.getExplanation())));
				}
				resps.setWidthPercentage(100);
				document.add(resps);
			}
			
			//会议
			if (RegexUtil.notEmpty(meeting)) {
				document.add(getCineseString("会议记录"));
				
				float[] widths = {80f, 90f, 60f, 60f, 215f, 90f};
				PdfPTable meetings = new PdfPTable(6);
				meetings.setSpacingBefore(10);
				meetings.setSpacingAfter(10);
				meetings.setWidthPercentage(widths, new Rectangle(PageSize.A4));
				
				meetings.addCell(getCineseString("会议主题"));
				meetings.addCell(getCineseString("时间"));
				meetings.addCell(getCineseString("主持人"));
				meetings.addCell(getCineseString("记录人"));
				meetings.addCell(getCineseString("参会人员"));
				meetings.addCell(getCineseString("地点"));
				meetings.completeRow();

				for (Meeting m : meeting) {
					meetings.addCell(new PdfPCell(getCineseString(m.getTitle())));
					meetings.addCell(DateUtil.formatDateTime(m.getTime()));
					meetings.addCell(new PdfPCell(getCineseString(m.getHost())));
					meetings.addCell(new PdfPCell(getCineseString(m.getNotes())));
					meetings.addCell(new PdfPCell(getCineseString(m.getParticipants())));
					meetings.addCell(new PdfPCell(getCineseString(m.getLocale())));
				}
				meetings.setWidthPercentage(100);
				document.add(meetings);
			}
			
			//借据表
			if (RegexUtil.notEmpty(borrows)) {
				document.add(getCineseString("借据表"));
				
				float[] widths = {40f, 80f, 95f, 90f, 90f, 200f};
				PdfPTable borrow = new PdfPTable(6);
				borrow.setSpacingBefore(10);
				borrow.setSpacingAfter(10);
				borrow.setWidthPercentage(widths, new Rectangle(PageSize.A4));
				borrow.addCell("SWOT");
				borrow.addCell(getCineseString("用户"));
				borrow.addCell(getCineseString("主旨"));
				borrow.addCell(getCineseString("领取日期"));
				borrow.addCell(getCineseString("归还日期"));
				borrow.addCell(getCineseString("说明"));
				borrow.completeRow();

				for (Borrow b : borrows) {
					PdfPCell swot = new PdfPCell();
					swot.setBackgroundColor(getColor(b.getSwot()));
					borrow.addCell(swot);
					borrow.addCell(b.getReceiver());
					borrow.addCell(new PdfPCell(getCineseString(b.getAssetName())));
					borrow.addCell(DateUtil.formatDate(b.getReceiveDate()));
					borrow.addCell(DateUtil.formatDate(b.getReturnDate()));
					borrow.addCell(new PdfPCell(getCineseString(b.getRemark())));
				}
				borrow.setWidthPercentage(100);
				document.add(borrow);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (BadElementException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		} finally {
			document.close();  
		}
		
		return file;
	}
	
	/**
	 * 根据项目类型对项目生成图表和数据表写入Pdf文件
	 * @param item			项目类型
	 * @param params		各项目数据集
	 * @param document		Pdf文件
	 * @throws DocumentException
	 * @throws MalformedURLException
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	private static void createTable(ItemType item, Map<String, Object> params, Document document) throws DocumentException, MalformedURLException, IOException {
		File img = (File) params.get(item.name()+"img");
		List<SwotResult> list = (List<SwotResult>) params.get(item.name());
		
		if(RegexUtil.notEmpty(img) && RegexUtil.notEmpty(list)) {
			document.add(getCineseString(item.getDes()));
			document.add(Image.getInstance(img.getPath()));
			
			PdfPTable st = new PdfPTable(20);
			float[] widths = {20f, 20f, 20f, 20f, 20f, 20f, 20f, 20f, 20f, 20f, 20f, 20f, 20f, 20f, 20f, 20f, 20f, 20f, 20f, 20f};
			st.setSpacingBefore(5);
			st.setSpacingAfter(5);
			st.setWidthPercentage(widths, new Rectangle(PageSize.A4));

			for (SwotResult s : list) {
				st.addCell(String.valueOf(s.getDay()));
			}
			st.completeRow();
			for (SwotResult s : list) {
				st.addCell(String.valueOf(s.getData()));
			}
			st.completeRow();
			for (SwotResult s : list) {
				PdfPCell cell = new PdfPCell(new Phrase(" "));
				cell.setBackgroundColor(getColor(s.getSwot()));
				st.addCell(cell);
			}
			st.setWidthPercentage(100); 
			document.add(st);
		}
	}
	
	/**
	 * 根据swot颜色转换成Color类型
	 * @param swot
	 * @return
	 */
	private static Color getColor(String swot) {
		Color color = null;
		if ("green".equals(swot)) color = Color.GREEN;
		else if ("red".equals(swot)) color = Color.RED;
		else if ("blue".equals(swot)) color = Color.BLUE;
		else if ("yellow".equals(swot)) color = Color.YELLOW;
		return color;
	}
}
