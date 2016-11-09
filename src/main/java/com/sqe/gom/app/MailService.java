/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import java.util.Map;

import javax.mail.MessagingException;

import org.springframework.mail.MailAuthenticationException;

import com.sqe.gom.model.MailHeader;
import com.sqe.gom.model.GomUser;

/**
 * @description This interface encapsulates all mail method.
 * @see org.springframework.mail.javamail.JavaMailSender
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 16, 2011 10:21:18 PM
 * @version 3.0
 */
public interface MailService {
	/**
	 * This method can send simple HTML or template HTML mail, also send
	 * attachments or contain InLine complex template HTML mail.
	 * 
	 * @param user   If null method will use default mail account.
	 * @param mh     It contains all the parameter for mail requires.
	 * @param mailText This String text transform from FreeMarker template.
	 * @throws MessagingException
	 */
	boolean sendMail(GomUser user, MailHeader mh, String mailText) throws MessagingException;
	
	/**
	 * If provide mail account valid will be return true boolean flag.
	 * 
	 * @param user  The user model instance.
	 * @return  true of false
	 */
	boolean testMailAccount(GomUser user) throws MailAuthenticationException;
	
	/**
	 * Get remove turn HTML string
	 * 
	 * @param tplName  The freeMarker template file name
	 * @param params   Will be use in the freeMarker template
	 * @return delete turn string of HTML
	 */
	String getHtmlBody(String tplName, Map<String, Object> params);
}
