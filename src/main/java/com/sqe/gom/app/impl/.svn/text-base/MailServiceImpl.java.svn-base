/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.mail.MailAuthenticationException;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.sqe.gom.app.MailService;
import com.sqe.gom.dao.ConfigDAO;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.MailHeader;
import com.sqe.gom.util.HtmTools;

import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * @description This class implements MailService.
 * @see com.sqe.gom.app.MailService
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 16, 2011 11:05:17 PM
 * @version 3.0
 */
@Service("mailService")
public class MailServiceImpl implements MailService {
	private Log log = LogFactory.getLog(getClass());
	private ConfigDAO configDao;
	private JavaMailSenderImpl sender;
	private FreeMarkerConfigurer freeMarker; 
	
	@Resource(name="configDao")
	public void setConfigDao(ConfigDAO configDao) {
		this.configDao = configDao;
	}
	
	@Resource(name="freeMarker")
	public void setFreeMarker(FreeMarkerConfigurer freeMarker) {
		this.freeMarker = freeMarker;
	}
	
	private void setMailArg(GomUser u){
		sender = new JavaMailSenderImpl();
		sender.setHost(configDao.getConfigValue("basis.mail.host"));
		
		if(u == null || u.equals("")) {
			sender.setUsername(configDao.getConfigValue("basis.mail.user"));
			sender.setPassword(configDao.getConfigValue("basis.mail.pwd"));
		}else {
			sender.setUsername(u.getEmail());
			sender.setPassword(u.getEmailPwd());
		}
		
		Properties prop = new Properties();
		prop.setProperty("mail.smtp.auth", "true");
		prop.setProperty("mail.smtp.timeout", "30000");
		sender.setJavaMailProperties(prop);
	}
	
	public boolean sendMail(GomUser user, MailHeader mh, String mailText)
			throws MessagingException, MailAuthenticationException{
		setMailArg(user);
		
		MimeMessage msg = sender.createMimeMessage();
		MimeMessageHelper helper;

		if (mh.getAttachment() == null && mh.getInline().isEmpty()) {
			helper = new MimeMessageHelper(msg, false, "UTF-8");
			
			helper.setFrom(mh.getFrom());
			helper.setSubject(mh.getSubject());
			if (mh.getTo() != null)
				helper.setTo(mh.getTo());
			if (mh.getCc()!= null)
				helper.setCc(mh.getCc());
			if (mh.getReplyTo() != null && mh.getReplyTo().equals(""))
				helper.setReplyTo(mh.getReplyTo());
			if (mh.getBcc()!= null)
				helper.setBcc(mh.getBcc());
			
			helper.setText(mailText, true);
		}else {
			helper = new MimeMessageHelper(msg, true, "UTF-8");
			
			helper.setFrom(mh.getFrom());
			helper.setSubject(mh.getSubject());
			if (mh.getTo() != null)
				helper.setTo(mh.getTo());
			if (mh.getCc()!= null)
				helper.setCc(mh.getCc());
			if (mh.getReplyTo() != null && mh.getReplyTo().equals(""))
				helper.setReplyTo(mh.getReplyTo());
			if (mh.getBcc()!= null)
				helper.setBcc(mh.getBcc());
			//helper.setCc("ou_ole@126.com");
			helper.setText(mailText, true);
			
			try {
				if(!mh.getInline().isEmpty()) {
					for(Entry<String, File> m : mh.getInline().entrySet()) {
						//FileSystemResource img = new FileSystemResource(m.getValue());
						helper.addInline(m.getKey(), m.getValue());
					}
				}
				
				if(mh.getAttachment() != null) {
					for(String fileName : mh.getAttachment()) {
						//ClassPathResource path =new ClassPathResource(fileName);
						File path = new File(fileName);
						helper.addAttachment(MimeUtility.encodeWord(path.getName()),path);
					}
				}
			}catch (UnsupportedEncodingException e) {
				log.error("encoding attachment word have occurred", e);
				return false;
			}
		}

		sender.send(msg);
		return true;
	}

	public boolean testMailAccount(GomUser user) throws MailAuthenticationException {
		setMailArg(user);
		MimeMessage msg = sender.createMimeMessage();
		
		try {
			MimeMessageHelper helper = new MimeMessageHelper(msg, false, "UTF-8");
			helper.setFrom(user.getEmail());
			helper.setTo(user.getEmail());
			helper.setText("恭喜您，填写的邮件帐号无误，且测试成功。系统以后将以此帐号和您进行通信！");
			helper.setSubject("您的公司邮件帐号及相关设置生效");
			sender.send(msg);
		} catch (MessagingException e2) {
			return false;
		}
		
		return true;
	}
	
	public String getHtmlBody(String tplName, Map<String, Object> params) {
		String htmlText = null;
		try {
			params.put("company", configDao.getConfigValue("basis.company.en"));
			Template tpl = freeMarker.getConfiguration().getTemplate(tplName);
			htmlText = FreeMarkerTemplateUtils.processTemplateIntoString(tpl, params);
		} catch (IOException e1) {
			log.error("have error in JavaMail template IO", e1);
		} catch (TemplateException e2) {
			log.error("have a error in JavaMail template.", e2);
		}
		
		return HtmTools.delTurn(htmlText);
	}
}