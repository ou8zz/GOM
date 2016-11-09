/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.sqe.gom.app.MailService;
import com.sqe.gom.app.ReportConfigService;
import com.sqe.gom.constant.DateRange;
import com.sqe.gom.dao.ConfigDAO;
import com.sqe.gom.dao.ReportConfigDAO;
import com.sqe.gom.dao.SignatureDAO;
import com.sqe.gom.dao.UserDAO;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Logs;
import com.sqe.gom.model.ReportConfig;
import com.sqe.gom.model.Signature;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Service("reportConfigService")
public class ReportConfigServiceImpl implements ReportConfigService {
	private Log log = LogFactory.getLog(getClass());
	private ReportConfigDAO reportConfigDao;
	private SignatureDAO signatureDao;
	private MailService mailService;
	private ConfigDAO configDao;
	private UserDAO userDao;
	
	@Resource(name="reportConfigDao")
	public void setReportConfigDao(ReportConfigDAO reportConfigDao) {
		this.reportConfigDao = reportConfigDao;
	}
	@Resource(name="signatureDao")
	public void setSignatureDao(SignatureDAO signatureDao) {
		this.signatureDao = signatureDao;
	}
	@Resource(name="mailService")
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}
	@Resource(name="configDao")
	public void setConfigDao(ConfigDAO configDao) {
		this.configDao = configDao;
	}
	@Resource(name="userDao")
	public void setUserDao(UserDAO userDao) {
		this.userDao = userDao;
	}
	
	@Override
	public ReportConfig getReportConfig(String type, Integer uid) {
		if(RegexUtil.isEmpty(type)) type = "MORNING";
		ReportConfig rc = reportConfigDao.getReportConfig(DateRange.valueOf(type), uid);
		if(RegexUtil.isEmpty(rc)) return null;
		if(RegexUtil.notEmpty(rc.getStext())) rc.setStext(signatureDao.getSignature(uid).getStext());	//获得用户签名
		else {
			Map<String, Object> signature = new HashMap<String, Object>();
			signature.put("user", userDao.query(uid));
			signature.put("version", configDao.getConfigValue("basis.version"));
			signature.put("web", configDao.getConfigValue("basis.web"));
			signature.put("tel", configDao.getConfigValue("basis.tel"));
			signature.put("fax", configDao.getConfigValue("basis.fax"));
			signature.put("company_cn", configDao.getConfigValue("basis.company.cn"));
			signature.put("company_en", configDao.getConfigValue("basis.company.en"));
			rc.setStext(mailService.getHtmlBody("signature.ftl", signature));
		}
		return rc;
	}
	
	@Override
	public void saveReportConfig(ReportConfig rc) {
		Logs lf = new Logs();
		lf.setDated(new Date());
		
		if(RegexUtil.notEmpty(rc.getId())) {
			reportConfigDao.updateConfig(rc);
			
			lf.setLogger("编辑报表配置");
			lf.setMessage(rc.getType().getDes() + "报已于" + DateUtil.forMatDate() + "被编辑。");
			log.debug(JsonUtils.toJson(lf));
		} else {
			rc.setUser(userDao.query(rc.getUserId()));
			reportConfigDao.create(rc);
			
			lf.setUserId(rc.getUserId());
			lf.setLogger("创建报表配置");
			lf.setMessage(" 于 " + DateUtil.forMatDate() + " 创建 " + rc.getType().getDes() + "报配置。");
			log.debug(JsonUtils.toJson(lf));
		}
		
		lf = new Logs();
		lf.setDated(new Date());
		
		//修改签名
		if(RegexUtil.notEmpty(rc.getStext())) {
			Signature s = signatureDao.getSignature(rc.getUserId());
			if(RegexUtil.isEmpty(s)) {
				s = new Signature();
				s.setStext(rc.getStext());
				s.setUser(new GomUser(rc.getUserId()));
				signatureDao.create(s);
				
				lf.setUserId(rc.getUserId());
				lf.setLogger("添加签名");
				lf.setMessage("您于 " + DateUtil.forMatDate() + " 添加签名成功。");
				log.debug(JsonUtils.toJson(lf));
			} else {
				s.setStext(rc.getStext());
				signatureDao.update(s);
				
				lf.setUserId(rc.getUserId());
				lf.setLogger("编辑签名");
				lf.setMessage("您于 "+ DateUtil.forMatDate() + " 修改了签名。");
				log.debug(JsonUtils.toJson(lf));
			}
		}
	}
}
