/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import static org.junit.Assert.*;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.MessagingException;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import org.springframework.mail.MailAuthenticationException;

import com.sqe.gom.BaseTest;
import com.sqe.gom.model.MailHeader;
import com.sqe.gom.model.GomUser;

import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * @description test mailService function.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 17, 2011  10:09:38 PM
 * @version 3.0
 */
//@Ignore
public class MailServiceTest extends BaseTest {
	private MailHeader mh;
	private GomUser u;
	private MailService mailService;
    private FreeMarkerConfigurer freeMarker;  
	
	@Resource(name="mailService")
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}
	
	@Resource(name="freeMarker")
	public void setFreeMarker(FreeMarkerConfigurer freeMarker) {
		this.freeMarker = freeMarker;
	}
	
	@Before
	public void onSetUpInitData() throws Exception {
		mh = new MailHeader();
		mh.setFrom("sqe_ole@sqeservice.com");
		mh.setTo(new String[] {"sqe_ole@sqeservice.com"});
		mh.setSubject("系统测试邮件");
		
		u = new GomUser();
		u.setEmail("sqe_ole@sqeservice.com");
		u.setEmailPwd("service11");
		u.setEname("sqe_ole");
		u.setCname("测试员");
	}
	
	@Test
	public void testMailSuccess() {
		assertTrue(mailService.testMailAccount(u));
	}
	
	//(expected=MailAuthenticationException.class)
	@Test
	public void testMailFailure() {
		u.setEmailPwd("junwei");
		
		// assert error password
		assertFalse(mailService.testMailAccount(u));
		
		u.setEmailPwd("service11");
		u.setEmail("admin");
		//assert error account
		assertFalse(mailService.testMailAccount(u));
	}
	
	@Test
	public void templateWithInline() {
		boolean f;
		String htmlText = null;
		Map<String,File> m = new HashMap<String, File>();
		m.put("logo_jpg", new File("E:\\workspace\\gom\\src\\main\\webapp\\uploads\\images\\sqe_log.png"));
		mh.setInline(m);
		mh.setSubject("带图片邮件测试");
		
		Map<String, Object> p = new HashMap<String, Object>();
		p.put("u", u);

		try {
			Template tpl = freeMarker.getConfiguration().getTemplate("register.ftl");
			htmlText = FreeMarkerTemplateUtils.processTemplateIntoString(tpl, p);
		} catch (IOException e1) {
			log.error("have error in JavaMail template IO", e1);
		} catch (TemplateException e2) {
			log.error("have a error in JavaMail template.", e2);
		}
		
		try {
			f = mailService.sendMail(u, mh, htmlText);
		} catch (MessagingException e) {
			f=false;
		}
		assertTrue(f);
	}
	
	@Test
	public void templateWithAttachment() {
		boolean f;
		String htmlText = null;
		mh.setAttachment(new String[] {"logo.png"});
		mh.setSubject("带附件邮件测试");
		
		Map<String, Object> p = new HashMap<String, Object>();
		p.put("u", u);

		try {
			Template tpl = freeMarker.getConfiguration().getTemplate("register.ftl");
			htmlText = FreeMarkerTemplateUtils.processTemplateIntoString(tpl, p);
		} catch (IOException e1) {
			log.error("have error in JavaMail template IO", e1);
		} catch (TemplateException e2) {
			log.error("have a error in JavaMail template.", e2);
		}
		
		try {
			f = mailService.sendMail(u, mh, htmlText);
		} catch (MessagingException e) {
			f=false;
		}
		assertTrue(f);
	}
}
