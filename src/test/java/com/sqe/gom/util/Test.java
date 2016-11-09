/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.util;

import java.util.Locale;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Oct 25, 2012
 * @version 3.0
 */
public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		String fileName = "src/main/webapp/WEB-INF/config/gom-service.xml";
		ApplicationContext context = new FileSystemXmlApplicationContext(fileName);
		String name = "";
		name = context.getMessage("ABC", null, Locale.CHINA);
		System.out.println(name);
		
		String namechinese = context.getMessage("customer.name", new Object[] {
				28, "http://www.xxx.com 中文","高兴" }, Locale.SIMPLIFIED_CHINESE);
		
		String nameEnglish = context.getMessage("customer.name", new Object[] {
				27, "http://www.xxx.com English","happy" }, Locale.US);
		
		String nameTAIWAN = context.getMessage("customer.name", new Object[] {
				27, "http://www.xxx.com English", "happy" }, Locale.TAIWAN);
		
		System.out.println("Customer name (Chinese) : " + namechinese);
		
		System.out.println("Customer name (English) : " + nameEnglish);
		
		System.out.println("Customer name (TAIWAN) : " + nameTAIWAN);

	}

}
