/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.ResponsibilityService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.dao.ResponsibilityDAO;
import com.sqe.gom.dao.UserDAO;
import com.sqe.gom.dao.UserRespDAO;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Logs;
import com.sqe.gom.model.Responsibility;
import com.sqe.gom.model.UserResp;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.util.XmlHelper;
import com.sqe.gom.vo.UserGroup;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 6, 2012
 * @version 3.0
 */
@Service("responsibilityService")
public class ResponsibilityServiceImpl implements ResponsibilityService {
	private Log log = LogFactory.getLog(getClass());
	private ResponsibilityDAO responsibilityDao;
	private UserDAO userDao;
	private UserRespDAO userRespDao;

	@Resource(name = "responsibilityDao")
	public void setResponsibilityDao(ResponsibilityDAO responsibilityDao) {
		this.responsibilityDao = responsibilityDao;
	}

	@Resource(name = "userDao")
	public void setUserDao(UserDAO userDao) {
		this.userDao = userDao;
	}

	@Resource(name = "userRespDao")
	public void setUserRespDao(UserRespDAO userRespDao) {
		this.userRespDao = userRespDao;
	}

	@Override
	public Responsibility saveResponsibility(Responsibility resp) {
		Logs lf = new Logs();
		lf.setDated(new Date());
		
		if(RegexUtil.isEmpty(resp.getId())) {
			if(RegexUtil.notEmpty(resp.getParentId())) resp.setParent(new Responsibility(resp.getParentId()));
			responsibilityDao.create(resp);
			
			lf.setLogger("新增管理责任");
			lf.setMessage("成功添加管理责任" + resp.getName() + " FCode "+resp.getFuncode()+" 分配说明 "+resp.getExplanation());
			log.debug(JsonUtils.toJson(lf));
		}
		else {
			responsibilityDao.updateResponsibility(resp);
			
			lf.setLogger("更新管理责任");
			lf.setMessage("已于 " + DateUtil.forMatDate() + " 修改管理责任："+resp.getName() + " FCode "+resp.getFuncode()+" 分配说明 "+resp.getExplanation());
			log.debug(JsonUtils.toJson(lf));
		}
		
		return resp;
	}
	
	public List<Responsibility> saveResponsibilities(String rpts, Integer userId) {
		List<UserResp> rs= JsonUtils.fromJson(rpts, new TypeToken<List<UserResp>>(){});
		
		if(!rs.isEmpty()) {
			int count = responsibilityDao.getNodeCount(userId, null).intValue();
			count++;
			int sc = 1;
			GomUser user = userDao.query(userId);
		
			for(UserResp r : rs) {
				Responsibility respon = responsibilityDao.query(r.getResponId());
				
				if(RegexUtil.notEmpty(r.getResponId()) && r.getResponId() > 0) r.setRespon(respon); //关联责任
				if(RegexUtil.notEmpty(userId) && userId > 0) r.setUser(user);  //关联用户
				
				if(RegexUtil.isEmpty(r.getId())) {
					if(!RegexUtil.verify("\\d*", r.getNode())) {
						r.setNode(String.valueOf(count));
					}else {
						r.setNode(count + "." + sc);
						sc++;
					}//end verify number
					userRespDao.create(r);
					
					Logs lf = new Logs();
					lf.setDated(new Date());
					lf.setUserId(userId);
					lf.setLogger("分配责任");
					lf.setMessage("已成功为用户" + user.getEname() +" 分配 " + respon.getName() + " 比重 " + r.getExpected() + "%， FCode "+ respon.getFuncode());
					log.debug(JsonUtils.toJson(lf));
					
				}else {
					userRespDao.updateUserResp(r);
					
					Logs lf = new Logs();
					lf.setDated(new Date());
					lf.setUserId(userId);
					lf.setLogger("分配责任");
					lf.setMessage("已成功为用户" + user.getEname() +" 重新分配 " + respon.getName() + " 比重 " + r.getExpected() + "%， FCode "+ respon.getFuncode());
					log.debug(JsonUtils.toJson(lf));
					
				}
				
			}

			return responsibilityDao.getResponsibility(null, userId, " ORDER BY ur.node ", "AND ur.node like '" + count + "%' ");
		}else return Collections.emptyList();
	}
	
	public List<Responsibility> updateResponsibilities(String receiver, Integer firer) {
		List<Responsibility> receivers = getResponsibility(receiver, 0, 0, true, null);
		
		if(receivers.isEmpty()) {
			return Collections.emptyList();
		}else{
			List<Responsibility> rpts = Collections.emptyList();
			
			StringBuffer sb = new StringBuffer();
			List<Object> sql = new ArrayList<Object>();
			sql.add(firer);
			for(Responsibility rr : receivers) {
				sb.append("?,");
				sql.add(rr.getId());
			}
			
			String str = sb.toString();
			List<Responsibility> beenCpResp = responsibilityDao.getResponsibility(str.substring(0, str.length()-1), sql);
			
			if(!beenCpResp.isEmpty()){
				UserGroup ug = userDao.getUser(receiver);
				Responsibility rp = null;
				
				int count = responsibilityDao.getNodeCount(0, receiver).intValue();
				
				for(Responsibility nr : beenCpResp) {
					System.out.println(nr.getId() + " funcode=" + nr.getFuncode());
					count++;
					if(RegexUtil.isEmpty(rp)) rp = nr;
					UserResp ur = new UserResp();
					ur.setExpected(nr.getExpected());
					ur.setNode(String.valueOf(count));
					ur.setRespon(new Responsibility(nr.getId()));
					ur.setUser(new GomUser(ug.getId()));
					userRespDao.update(ur);
					
					//取得子类
					List<Responsibility> ps = getResponsibility(null, nr.getUserId(), 0, false, nr.getNode());
					respRecursive(ps, count, ug.getId());
					if(rpts.isEmpty()) rpts = ps;
					rpts.add(nr);
					
					Logs lf = new Logs();
					lf.setDated(new Date());
					lf.setLogger("复制离职人责任到接收人");
					lf.setMessage("已成功将离职人管理责任 " + nr.getName() + " 复制到接收人 " + ug.getEname() + " 分配比重为 " + ur.getExpected() + "%， FCode " + nr.getFuncode());
					log.debug(JsonUtils.toJson(lf));
				}
			}
			
			return rpts;
		}
	}

	@Override
	public HandlerState updateResponsibilities(String rpts) {
		List<UserResp> rs= JsonUtils.fromJson(rpts, new TypeToken<List<UserResp>>(){});
		
		if(rs.isEmpty()) return HandlerState.FAILED;
		else {
			for(UserResp r : rs) {
				if(RegexUtil.notEmpty(r.getId()) && r.getId() > 0) {
					userRespDao.updateUserResp(r);
				}
			}
			return HandlerState.SUCCESS;
		}
	}
	
	public Responsibility getResponsibility(Integer rid) {
		if(rid > 0) return responsibilityDao.query(rid);
		else return null;
	}
	
	public List<Responsibility> getNotSelectRespons(String responIds) {
		StringBuffer sb = new StringBuffer();
		List<Object> sql = new ArrayList<Object>();
		
		if(RegexUtil.isEmpty(responIds)) {
			return responsibilityDao.getNotSelectRespons(null, null);
		}else {
			String[] responsIDs = responIds.split(",");
			
			for(String id : responsIDs) {
				sb.append("?,");
				sql.add(Integer.parseInt(id));
			}
			
			String str = sb.toString();
			return responsibilityDao.getNotSelectRespons(str.substring(0, str.length()-1), sql);
		}
	}
	
	public Document buildRespTree(Integer userId, Integer parentId, Integer level) {
		List<Responsibility> list = null;
		if(userId > 0) {
			if(parentId > 0) list = getResponsibility(null, userId, 0, false, parentId.toString());
			else list = getResponsibility(null, userId, parentId, true, null);
			return buildUserTree(list, level);
		} else {
			list = getResponsibility(null, userId, parentId, true, null);
			return buildRespTree(list, level);
		}
	}

	@Override
	public List<Responsibility> getResponsibility(String ename, Integer userId, Integer parentId, Boolean isf, String node) {
		List<Responsibility> list = Collections.emptyList();
		String crit;
		
		if(isf) {
			if(parentId == 0) crit = "AND r.parent.id is null";
			else crit = "AND r.parent.id = " + parentId;
		}else crit = null;
		
		if(RegexUtil.notEmpty(node)){
			if(RegexUtil.isEmpty(crit)) crit = "AND ur.node like '" + node + ".%'";
			else crit += " AND ur.node like '" + node + ".%'";
		}
		
		if(RegexUtil.notEmpty(ename) || userId > 0)  list = responsibilityDao.getResponsibility(ename, userId, " ORDER BY ur.node", crit);
		else list = responsibilityDao.getResponsibilities(crit);
		
		return list;
	}

	private void respRecursive(List<Responsibility> ls, Integer count, Integer userId) {
		int c = 1;
		for(Responsibility nr : ls) {
			UserResp ur = new UserResp();
			ur.setExpected(nr.getExpected());
			ur.setNode(count + "." + c);
			ur.setRespon(new Responsibility(nr.getId()));
			ur.setUser(new GomUser(userId));
			userRespDao.update(ur);
			c++;
		}
	}
	
	//构建管理 责任树
	private Document buildRespTree(List<Responsibility> list, int level){
		String cell = "cell";
		Document doc = XmlHelper.createXML();
		doc.setXmlVersion("1.0");
		Element rows = doc.createElement("rows");
		doc.appendChild(rows);
		for(Responsibility r : list) {
			boolean open = false;
			if(RegexUtil.isEmpty(r.getParentId())) open = false;
			else open = true;
			Element row = XmlHelper.createElement(rows, "row");
			row.setAttribute("id", r.getId().toString());
			XmlHelper.createElement(row, cell, String.valueOf(r.getId()));
			XmlHelper.createElement(row, cell, r.getFuncode());
			XmlHelper.createElement(row, cell, r.getName());
			XmlHelper.createElement(row, cell, r.getExplanation());
			XmlHelper.createElement(row, cell, String.valueOf(level));
			XmlHelper.createElement(row, cell, String.valueOf(r.getParentId()));
			XmlHelper.createElement(row, cell, String.valueOf(open));
			XmlHelper.createElement(row, cell, String.valueOf(false));
			    
			XmlHelper.addInfoToXML(rows, row);
		}
		return doc;
	}
	
	//构建用户树管理责任
	private Document buildUserTree(List<Responsibility> list, int level){
		String cell = "cell";
		Document doc = XmlHelper.createXML();
		doc.setXmlVersion("1.0");
		Element rows = doc.createElement("rows");
		doc.appendChild(rows);
		
		String parentId = "0";
		boolean open = false;
		
		Integer fexpected = 0;
		for(Responsibility r : list) {
			Element row = XmlHelper.createElement(rows, "row");
			if(RegexUtil.verify("\\d*", r.getNode())){
				open = false;
				row.setAttribute("id", r.getNode());
				XmlHelper.createElement(row, cell, r.getNode());
			}else {
				open = true;
				row.setAttribute("id", r.getId().toString());
				XmlHelper.createElement(row, cell, String.valueOf(r.getId()));
			}
			
			XmlHelper.createElement(row, cell, r.getFuncode());
			XmlHelper.createElement(row, cell, r.getName());
			XmlHelper.createElement(row, cell, r.getExpected().toString());
			
			if(RegexUtil.verify("\\d*", r.getNode())){
				fexpected =  r.getExpected();
				XmlHelper.createElement(row, cell, r.getExpected().toString());
			}else {
				parentId = r.getNode().split("\\.")[0];
				if(fexpected == 0) fexpected = userRespDao.getExpected(r.getUserId(), parentId);
				if(r.getNode().startsWith(parentId + ".") && fexpected != 100){
					Double actual = fexpected*r.getExpected()/100.00;
					XmlHelper.createElement(row, cell, actual.toString());	
				}else XmlHelper.createElement(row, cell, r.getExpected().toString());
			}
			
			XmlHelper.createElement(row, cell, r.getExplanation());
			XmlHelper.createElement(row, cell, String.valueOf(level));
			XmlHelper.createElement(row, cell, String.valueOf(parentId));
			XmlHelper.createElement(row, cell, String.valueOf(open));
			XmlHelper.createElement(row, cell, String.valueOf(false));
				    
			XmlHelper.addInfoToXML(rows, row);
		}
		
		return doc;
	}
}
