/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.util.Date;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.sqe.gom.app.MottoService;
import com.sqe.gom.dao.MottoDAO;
import com.sqe.gom.model.Logs;
import com.sqe.gom.model.Motto;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;

/**
 * @description	格言
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Service("mottoService")
public class MottoServiceImpl implements MottoService {
	private Log log = LogFactory.getLog(getClass());
	private MottoDAO mottoDao;
	
	@Resource(name="mottoDao")
	public void setMottoDao(MottoDAO mottoDao) {
		this.mottoDao = mottoDao;
	}
	
	@Override
	public Motto getMotto() {
		return mottoDao.getMotto();
	}
	
	@Override
	public void saveMotto(Motto m) {
		Logs lf = new Logs();
		lf.setDated(new Date());
		
		if(RegexUtil.notEmpty(m.getId())) {
			mottoDao.update(m);
			
			lf.setLogger("更新格言");
			lf.setMessage("您于 "+ DateUtil.forMatDate() + " 修改了格言。");
			log.debug(JsonUtils.toJson(lf));
		} else {
			mottoDao.create(m);
			
			lf.setLogger("添加格言");
			lf.setMessage("您于 "+ DateUtil.forMatDate() + " 添加格言成功。");
			log.debug(JsonUtils.toJson(lf));
		}
	}
}
