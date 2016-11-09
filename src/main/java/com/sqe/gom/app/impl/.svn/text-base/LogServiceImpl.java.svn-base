/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.LogService;
import com.sqe.gom.constant.LogsType;
import com.sqe.gom.dao.ConfigDAO;
import com.sqe.gom.dao.LogDAO;
import com.sqe.gom.model.Logs;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.HtmTools;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description	日志
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Service("logService")
public class LogServiceImpl implements LogService {
	private Log log = LogFactory.getLog(LogServiceImpl.class);
	private LogDAO logDao;
	private ConfigDAO configDao;
	
	@Resource(name="logDao")
	public void setLogDao(LogDAO logDao) {
		this.logDao = logDao;
	}
	@Resource(name="configDao")
	public void setConfigDao(ConfigDAO configDao) {
		this.configDao = configDao;
	}
	
	@Override
	public JGridBase<Logs> getLogs(JGridHelper<Logs> grid) {
		String ord = " ORDER BY l.";
		if(RegexUtil.notEmpty(grid.getJq().getSidx())) ord += grid.getJq().getSidx() + " " + grid.getJq().getSord();
		else ord += "id";
		
		grid.getJq().setList(logDao.getLogs(ord, grid.getQ(), grid.getP()));
		grid.getJq().setRecords(grid.getP().getTotalCount());
		grid.getJq().setTotal(grid.getP().getPageCount());
		return grid.getJq();
	}
	
	@Override
	public List<Logs> getLogs(String criteria) {
		List<Logs> list = logDao.getLogs(" ORDER BY l.dated", criteria, null);
		for(Logs l : list) {
			l.setMessage(HtmTools.unescapeHTML(l.getMessage()));
		}
		
        try {
        	FileInputStream fr = new FileInputStream(configDao.getConfig("basis.logs.path").getValue() + "gom.log");
            BufferedReader br = new BufferedReader(new InputStreamReader(fr, "UTF-8"));
            String buff = "";
            while((buff = br.readLine()) != null) {
            	if(buff.indexOf(" - ") > 1) {
            		String[] sbuff = buff.split(" - ");
                	if(sbuff.length >= 2 && sbuff[1].startsWith("{") && sbuff[1].endsWith("}")) {
                		Logs ls = JsonUtils.fromJson(sbuff[1], new TypeToken<Logs>(){});
                    	ls.setType(LogsType.SYSTEM);
                    	list.add(ls);
                	}
            	}
            }
            fr.close();
            br.close();
        } catch (IOException e) {
            e.printStackTrace();
            log.error("function List<Logs> getLogs(String criteria) have error !", e);
        }
        
        return list;
	}
	
	@Override
	public void saveLog(Logs logs) {
		logs.setMessage(HtmTools.escapeHTML(logs.getMessage()));
		if(RegexUtil.isEmpty(logs.getId())){
			logs.setDated(DateUtil.previous(0));
			logDao.create(logs);
			
			Logs lf = new Logs();
			lf.setDated(new Date());
			lf.setLogger("日志记录");
			lf.setMessage("日志类型 "+logs.getType().getDes() + " " +  logs.getLogger() + " 添加成功 ");
			log.debug(JsonUtils.toJson(lf));
		} else {
			logDao.updateLog(logs);
			
			Logs lf = new Logs();
			lf.setDated(new Date());
			lf.setLogger("日志记录");
			lf.setMessage("日志类型 "+logs.getType().getDes() + " " +  logs.getLogger() + " 更新成功 ");
			log.debug(JsonUtils.toJson(lf));
		}
	}

}
