/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import word.api.interfaces.IDocument;
import word.api.interfaces.IElement;
import word.w2004.Document2004;
import word.w2004.Document2004.Encoding;
import word.w2004.elements.BreakLine;
import word.w2004.elements.Image;
import word.w2004.elements.Paragraph;
import word.w2004.elements.ParagraphPiece;
import word.w2004.elements.TableV2;
import word.w2004.elements.tableElements.TableCell;
import word.w2004.elements.tableElements.TableRow;
import word.w2004.style.ParagraphStyle;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 8, 2012
 * @version 3.0
 */
public class ManagerWord {
	
	/**
	 * 下载Word
	 * @param req
	 * @param res
	 * @param path
	 */
	public static void downloadWrod(HttpServletRequest req, HttpServletResponse res, String path) {
        // 读到流中
        FileInputStream inputStream;
		try {
			inputStream = new FileInputStream(req.getSession().getServletContext().getRealPath("/uploads/doc/"+path));
			// 循环取出流中的数据
	        byte[] b = new byte[100];
	        int len;
	        while ((len = inputStream.read(b)) > 0)
	            res.getOutputStream().write(b, 0, len);
	        inputStream.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 把信息排版成word格式
	 * @param title
	 * @param text
	 * @param version
	 * @param createDate
	 * @param updateDate
	 * @param email
	 * @return
	 */
	public static String formatText(String path, String title, String text, String version, Date createDate, Date updateDate, String email) {
		IDocument myDoc = new Document2004();
		myDoc.encoding(Encoding.UTF_8); // or ISO8859-1. Default is UTF-8
		myDoc.addEle(BreakLine.times(1).create()); // this is one breakline
		
		//页眉
		String image = Image.from_FULL_LOCAL_PATHL(path).setHeight("40").setWidth("80").create().getContent();
		IElement titles = TableCell.with(Paragraph.with(title).withStyle().align(ParagraphStyle.Align.CENTER).create()).withStyle().gridSpan(4).create();
		IElement fileName = TableCell.with(Paragraph.withPieces( ParagraphPiece.with("文件名称").withStyle().bold().fontSize("12").create() ).create());
		IElement versions = TableCell.with(Paragraph.withPieces( ParagraphPiece.with(version) ).withStyle().align(ParagraphStyle.Align.CENTER).create());
		TableV2 tbl2 = new TableV2();
		tbl2.addRow(TableRow.with(fileName, titles, image) );
		tbl2.addRow(TableRow.with("创建日期", DateUtil.formatDate(createDate), "更新日期", DateUtil.formatDate(updateDate) ,"版本",versions ));
		myDoc.getHeader().addEle(tbl2);
				
		//页尾
		myDoc.getFooter().addEle(Paragraph.with("SQE SERVICE INC.  ").create());
		myDoc.getFooter().addEle(Paragraph.with("Tel: +862150499035 or 862150499065               Fax: +86-21-50499037").create());
		myDoc.getFooter().addEle(Paragraph.with("E-mail:"+email+"                           www.sqeservice.com").create());

		//内容 
		Paragraph paragraph = Paragraph.with(text).create();
		myDoc.addEle(paragraph);
		
		return myDoc.getContent();
	}
		
	/**
	 * 写进word
	 * @param path
	 * @param text
	 */
	public static void writerWord(String path, String text) {
		try {
			FileWriter fw = new FileWriter(path, false);
			PrintWriter out = new PrintWriter(fw);
			if (text.equals("") || text == null) {
				out.println(text);
			} else {
				out.println(text);
			}
			out.close();
			fw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/***
	 * 删除WORD文件
	 * @param file
	 */
	public static void deleteWord(String file) {
		File f = new File(file);
		f.delete();
	}
}
