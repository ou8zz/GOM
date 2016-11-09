/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 8, 2012
 * @version 3.0
 */
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.poi.hssf.record.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Text;

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

import com.sqe.gom.model.Responsibility;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.XmlHelper;

public class WordTest {
	private static ResponsibilityService responsibilityService;
	
	@Autowired
	public void setResponsibilityService(ResponsibilityService responsibilityService) {
		this.responsibilityService = responsibilityService;
	}
	
	public static void main(String[] args) {
		//testResponsibilityService();
		SimpleDateFormat myFormatter = new SimpleDateFormat("yyyy-MM-dd");  
	    java.util.Date date;
		try {
			date = myFormatter.parse("1999-10-10");
			java.util.Date mydate= myFormatter.parse("1999-09-30");  
			long  day=(date.getTime()-mydate.getTime())/(24*60*60*1000);  
			//System.out.println(day);  
		} catch (ParseException e) {
			e.printStackTrace();
		}  
		String str = "10.1.10";
		int i = str.lastIndexOf(".");
		String st1 = str.substring(0, i+1);
		String st2 = str.substring(i+1);
		int node = Integer.parseInt(st2);
		node = node + 1;
		System.out.println(st1 + node);
		System.out.println(node);
	}
	
	/**
	 * @param args
	 */
	public static void testResponsibilityService() {
		Document doc = XmlHelper.createXML();
		doc.setXmlVersion("1.0");
		Element rows = doc.createElement("rows");
		Element row = XmlHelper.createElement(rows, "row");
		row.setAttribute("id", "1");
		
		XmlHelper.createElement(row, "cell", "id");
		XmlHelper.createElement(row, "cell", "funcode");
		XmlHelper.createElement(row, "cell", "swot");
		XmlHelper.createElement(row, "cell", "responsiblilyty");
		XmlHelper.createElement(row, "cell", "explanation");
		XmlHelper.createElement(row, "cell", "describe");
		XmlHelper.createElement(row, "cell", "actualspecificgravity");
		XmlHelper.createElement(row, "cell", "0");
		XmlHelper.createElement(row, "cell", "0");
		XmlHelper.createElement(row, "cell", "0");
		XmlHelper.createElement(row, "cell", "true");
		XmlHelper.createElement(row, "cell", "false");
		
		doc.appendChild(rows);
		try {
			DOMSource domSource = new DOMSource(doc);
			File file = new File("e://MobileNetRule.xml");
			if (!file.exists()) file.createNewFile();
			FileOutputStream fos = new FileOutputStream(file);
			StreamResult xmlResult = new StreamResult(fos);
			XmlHelper.OutputXmlStream(domSource, xmlResult);
			
			System.out.println(doc.getDocumentURI());
			
			System.out.println(file.getAbsolutePath());
			
		} catch (IOException e) {
			System.out.println(e.getMessage());
		} 
		
		
		
	}
	private DocumentBuilder builder;

	/**
	 * Creates an subscribe document of the user subscribe status list.
	 * 
	 * @return the DOM tree of the subscribe document
	 */
	public Document buildDocument(Short ver, List<Responsibility> sub) {
		Document doc = builder.newDocument();
		Element svgElement = doc.createElement("status");
		doc.appendChild(svgElement);
		svgElement.setAttribute("version", "" + ver);
		for (int i = 0; i < sub.size(); i++) {
			Element serviceElement = doc.createElement("service");
			Text textnode = doc.createTextNode(String.valueOf(sub.get(i).getId()));
			serviceElement.setAttribute("id", "" + sub.get(i).getFuncode());
			svgElement.appendChild(serviceElement);
			serviceElement.appendChild(textnode);
		}
		return doc;
	}

	
	public static String replacePh(String base, String placeHolder, String value) {
		if (!base.contains(placeHolder)) {
			// don't want to use log now because I want to keep it simple...
			System.out.println("### WARN: couldn't find the place holder: "
					+ placeHolder);
			return base;
		}
		return base.replace(placeHolder, value);
	}

	public static void method7() {
		String path = "e://zec1.doc";
		File f = new File(path);
		f.delete();
		// writer(path, method6());
	}

	public static String method6(String title, String text, String version,
			Date createDate, Date updateDate) {
		IDocument myDoc = new Document2004();
		myDoc.encoding(Encoding.UTF_8); // or ISO8859-1. Default is UTF-8
		myDoc.addEle(BreakLine.times(1).create()); // this is one breakline

		// 页眉
		String image = Image
				.from_WEB_URL("http://www.google.com/images/logos/ps_logo2.png")
				.setHeight("40").setWidth("80").create().getContent();
		IElement titles = TableCell
				.with(Paragraph.with("这是文件主题名").withStyle()
						.align(ParagraphStyle.Align.CENTER).create())
				.withStyle().gridSpan(4).create();
		IElement fileName = TableCell.with(Paragraph.withPieces(
				ParagraphPiece.with("文件名称").withStyle().bold().fontSize("12")
						.create()).create());
		IElement versions = TableCell.with(Paragraph
				.withPieces(ParagraphPiece.with(version)).withStyle()
				.align(ParagraphStyle.Align.CENTER).create());
		TableV2 tbl2 = new TableV2();
		tbl2.addRow(TableRow.with(fileName, titles, image));
		tbl2.addRow(TableRow.with("创建日期", DateUtil.formatDate(createDate),
				"更新日期", DateUtil.formatDate(updateDate), "版本", versions));
		myDoc.getHeader().addEle(tbl2);

		// 页尾
		myDoc.getFooter().addEle(Paragraph.with("SQE SERVICE INC.  ").create());
		myDoc.getFooter()
				.addEle(Paragraph
						.with("Tel: +862150597791 or 862150596472               Fax: +86-21-50596473")
						.create());
		myDoc.getFooter()
				.addEle(Paragraph
						.with("E-mail:Linda@sqeservice.com                           www.sqeservice.com")
						.create());

		// 内容
		Paragraph paragraph = Paragraph.with(text).create();
		myDoc.addEle(paragraph);

		// ParagraphPiece myParPieceJava =
		// ParagraphPiece.with("I like Java and ").withStyle().font(Font.COURIER).create();
		// ParagraphPiece myParPieceRuby =
		// ParagraphPiece.with("Ruby!!! ").withStyle().bold().italic().create();
		// myDoc.addEle(Paragraph.withPieces(myParPieceJava,
		// myParPieceRuby).create());

		String myWord = myDoc.getContent();
		System.out.println(myWord);

		return myWord;
	}

	public static void writer(String path, String text) {
		try {
			FileWriter fw = new FileWriter(path, true);
			PrintWriter out = new PrintWriter(fw);
			if (text.equals("") || text == null) {
				out.println(text);
			} else {
				out.println(text);
			}
			out.close();
			fw.close();
			System.out.println("OK-----------");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
