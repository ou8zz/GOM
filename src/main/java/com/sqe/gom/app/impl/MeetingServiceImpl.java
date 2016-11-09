/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.mail.MessagingException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.mail.MailAuthenticationException;
import org.springframework.stereotype.Service;

import com.sqe.gom.app.MailService;
import com.sqe.gom.app.MeetingService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.dao.MeetingDAO;
import com.sqe.gom.dao.UserDAO;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.MailHeader;
import com.sqe.gom.model.Meeting;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.HtmTools;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description	会议
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Service("meetingService")
public class MeetingServiceImpl implements MeetingService {
	private Log log = LogFactory.getLog(getClass());
	private MeetingDAO meetingDao;
	private UserDAO userDao;
	private MailService mailService;
	private HandlerState status = HandlerState.FAILED;
	
	@Resource(name="meetingDao")
	public void setMeetingDao(MeetingDAO meetingDao) {
		this.meetingDao = meetingDao;
	}
	
	@Resource(name="userDao")
	public void setUserDao(UserDAO userDao) {
		this.userDao = userDao;
	}

	@Resource(name="mailService")
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}

	@Override
	public List<Meeting> getMettings(String time, Page page) {
		return meetingDao.getMeetings("ORDER BY m.time", null, page);
	}
	
	@Override
	public JGridBase<Meeting> getMettings(JGridHelper<Meeting> grid) {
		String ord = " ORDER BY m.";
		if(RegexUtil.notEmpty(grid.getJq().getSidx())) ord += grid.getJq().getSidx() + " " + grid.getJq().getSord();
		else ord += "id";
		
		grid.getJq().setList(meetingDao.getMeetings(ord, grid.getQ(), grid.getP()));
		grid.getJq().setRecords(grid.getP().getTotalCount());
		grid.getJq().setTotal(grid.getP().getPageCount());
		return grid.getJq();
	}
	
	@Override
	public HandlerState saveMeeting(Meeting m) {
		GomUser fromUser = userDao.checkUser(m.getHost(), null, false);
		if(RegexUtil.isEmpty(fromUser)) return HandlerState.FAILED;
		
		String[] pas = m.getParticipants().split(",");
		String[] tt = new String[pas.length]; 
		for(int i=0; i<pas.length; i++) {
			String guemail = userDao.checkUser(pas[i], null, false).getEmail();
			if(RegexUtil.isEmpty(guemail)) return HandlerState.UNSUPPORT;	//如果没找到用户邮箱返回错误
			tt[i] = guemail;
		}
		
		MailHeader mh = new MailHeader();
		mh.setFrom(fromUser.getEmail());
		mh.setTo(tt);
		mh.setSubject(m.getTitle());
		StringBuilder content = new StringBuilder("<b>Dear All: </b><br/>");
		
		try {
			//更新会议
			if(RegexUtil.notEmpty(m.getId())) {
				m.setContent(HtmTools.escapeHTML(m.getContent()));
				if(m.getContent().length() >= 2000) return HandlerState.INVALID;
				meetingDao.updateMeeting(m);
				
				content.append(" 会议主题：").append(m.getTitle()).append("<br/> 于: ").append(DateUtil.formatDateTime(m.getTime())).append("开始");
				content.append("<br/> 会议内容：").append(HtmTools.unescapeHTML(m.getContent())).append("<br/> 说明：").append(m.getExplain());
				
				mailService.sendMail(fromUser, mh, content.toString());
			}
			//发起会议
			else {
				meetingDao.create(m);	
				
				content.append(" 请:").append(m.getParticipants()).append(" 于: ").append(DateUtil.formatDateTime(m.getTime())).append(" 到：").append(m.getLocale());
				content.append(" 参加会议;<br/>").append(" 会议主题：").append(m.getTitle()).append("<br/> 说明：").append(m.getExplain());
				mailService.sendMail(fromUser, mh, content.toString());
			}
			status = HandlerState.SUCCESS;
		} catch (MessagingException e) {
			status = HandlerState.ERROR;
			log.error("MeetingService send mail MessagingException!", e);
		} catch (MailAuthenticationException e) {
			status = HandlerState.UNSUPPORT;
			log.error("MeetingService send mail MailAuthenticationException!", e);
		} catch (NullPointerException e) {
			status = HandlerState.ERROR;
			log.error("MeetingService send mail NullPointerException!", e);
		}
		return status;
	}

}
