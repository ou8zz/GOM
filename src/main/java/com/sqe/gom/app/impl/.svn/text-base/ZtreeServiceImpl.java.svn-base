/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.sqe.gom.app.ZtreeService;
import com.sqe.gom.constant.MenuType;
import com.sqe.gom.dao.UserDAO;
import com.sqe.gom.dao.ZtreeDAO;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Logs;
import com.sqe.gom.model.Ztree;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.util.XmlHelper;
import com.sqe.gom.vo.Trees;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 20, 2012
 * @version 3.0
 */
@Service("ztreeService")
public class ZtreeServiceImpl implements ZtreeService {
	private Log log = LogFactory.getLog(ZtreeServiceImpl.class);
	private ZtreeDAO ztreeDao;
	private UserDAO userDao;
	public static Map<String, List<Trees>> treeMap = new HashMap<String, List<Trees>>();
	
	@Autowired
	public void setZtreeDao(ZtreeDAO ztreeDao) {
		this.ztreeDao = ztreeDao;
	}
	
	@Autowired
	public void setUserDao(UserDAO userDao) {
		this.userDao = userDao;
	}
	
	@Override
	public void removeTreeMap(String ename) {
		if(RegexUtil.notEmpty(treeMap) && RegexUtil.notEmpty(treeMap.get(ename))) {
			treeMap.remove(ename);
		}
	}
	
	/**
	 * 1.如果ID为空，添加一条记录
	 * 2.如果PID不为空，则在这个父类下添加一条子类，并找到这个父类下最大的NODE在新的NODE +0.1; 添加操作
	 * 3.如果PID为空，则找到所有顶级类中最大的NODE +1; 添加操作
	 * 4.如果ID不为空，修改这个记录
	 */
	@Override
	public void saveZtree(Ztree zt) {
		Logs lf = new Logs();
		lf.setDated(new Date());
		
		if(RegexUtil.isEmpty(zt.getId())) {
			if(RegexUtil.notEmpty(zt.getPid())) {
				Ztree parent = ztreeDao.query(zt.getPid());
				zt.setParent(parent);
				String str = ztreeDao.getMaxNode(zt.getPid());
				if(RegexUtil.notEmpty(str)) {
					int i = str.lastIndexOf(".");
					String nodePre = str.substring(0, i+1);
					int node = Integer.parseInt(str.substring(i+1));
					node = node + 1;
					zt.setNode(String.valueOf(nodePre+node));
				} else zt.setNode(parent.getNode() + ".1");
			} else {
				String str = ztreeDao.getMaxNode(null);
				if(RegexUtil.notEmpty(str)) {
					Integer node = Integer.parseInt(str);
					node = node + 1;
					zt.setNode(String.valueOf(node));
				} else zt.setNode(String.valueOf(1));
			}
			zt.setMenuType(MenuType.Custom);
			ztreeDao.create(zt);
			
			lf.setLogger("新增菜单");
			lf.setMessage("菜单 " +zt.getName()+" 添加成功，分配路径为："+zt.getUrl() + "， 分配节点 " + zt.getNode());
			log.debug(JsonUtils.toJson(lf));
		}
		else {
			ztreeDao.updateZtree(zt);
			
			lf.setLogger("编辑菜单");
			lf.setMessage("菜单 " +zt.getName()+" 提交成功，编辑后路径为："+zt.getUrl());
			log.debug(JsonUtils.toJson(lf));
		}
	}
	
	@Override
	public void editUserTree(int uid, String[] zid) {
		GomUser user = userDao.query(uid);
		removeTreeMap(user.getEname()); 		//如果修改用户菜单，则清空当前用户缓存
		Set<Ztree> set = new HashSet<Ztree>();
			
		for(String i : zid) {
			Ztree tree = ztreeDao.query(Integer.parseInt(i));
			if(RegexUtil.notEmpty(tree.getParent())) set.add(tree.getParent());
			set.add(tree);
		}
		user.setTrees(set);
		userDao.update(user);
		
		Logs lf = new Logs();
		lf.setDated(new Date());
		lf.setLogger("用户菜单调整");
		lf.setMessage("您于" +DateUtil.forMatDate() + " 调整用户 "+ user.getCname() + "(" + user.getEname() + ") 菜单成功。");
		log.debug(JsonUtils.toJson(lf));
	}
	
	//更新所有父类
	private void updateParent(Ztree parent) {
		if(RegexUtil.notEmpty(parent)) {
			ztreeDao.updateZtree(parent.getId(), MenuType.General);
			updateParent(parent.getParent());
		}
	}
	
	@Override
	public void editBasicTree(String isAdd, String[] zid) {
		int i=0;
		if(RegexUtil.notEmpty(isAdd)) {
			//添加基础树
			for(String j : zid) {
				if(RegexUtil.notEmpty(j)) i = Integer.parseInt(j);
				//Ztree parent = ztreeDao.query(i).getParent();
				updateParent(ztreeDao.query(i));
				//ztreeDao.updateZtree(i, MenuType.General);
			}
		} else {
			//移除基础树
			for(String j : zid) {
				if(RegexUtil.notEmpty(j)) i = Integer.parseInt(j);
				ztreeDao.updateZtree(i, MenuType.Custom);
			}
		}
		
		//日志记录
		Logs lf = new Logs();
		lf.setDated(new Date());
		lf.setLogger("基础菜单调整");
		lf.setMessage("您于" + DateUtil.forMatDate() + " 重新调整基础菜单，详情请查看左侧树菜单页面 ");
		log.debug(JsonUtils.toJson(lf));
	}
	
	@Override
	public Document getZtrees(String nodeId, int level, boolean isBasic) {
		String criteria = "";
		String cell = "cell";
		Document doc = XmlHelper.createXML();
		doc.setXmlVersion("1.0");
		Element rows = doc.createElement("rows");
		doc.appendChild(rows);
		
		if(RegexUtil.notEmpty(nodeId)) criteria += " AND z.parent.id=" + nodeId;
		else criteria += " AND z.parent is null";
		
		//如果为基础用户
		if(isBasic) criteria += " AND z.menuType=0";
		
		List<Ztree> list = ztreeDao.getBeanZtrees(criteria);
		for(Ztree zt : list) {
			int parentId = 0;
			boolean open = false;
			if(RegexUtil.notEmpty(zt.getParent())) parentId = zt.getParent().getId();
			if(zt.getChildren().isEmpty()) open = true;
			Element row = XmlHelper.createElement(rows, "row");
			row.setAttribute("id", zt.getId().toString());
			XmlHelper.createElement(row, cell, zt.getName());
			XmlHelper.createElement(row, cell, zt.getTitle());
			XmlHelper.createElement(row, cell, zt.getUrl());
			XmlHelper.createElement(row, cell, zt.getPosition());
			XmlHelper.createElement(row, cell, zt.getRole());
			XmlHelper.createElement(row, cell, String.valueOf(zt.getMenuType()));
			XmlHelper.createElement(row, cell, String.valueOf(zt.getId()));
			XmlHelper.createElement(row, cell, zt.getIco());
			XmlHelper.createElement(row, cell, zt.getNode());
			XmlHelper.createElement(row, cell, String.valueOf(zt.getMenuType()));
			XmlHelper.createElement(row, cell, String.valueOf(level));
			XmlHelper.createElement(row, cell, String.valueOf(parentId));
			XmlHelper.createElement(row, cell, String.valueOf(open));
			XmlHelper.createElement(row, cell, String.valueOf(false));
			XmlHelper.addInfoToXML(rows, row);
		}
		return doc;
	}
	
	@Override
	public List<Ztree> getZtrees(String userId) {
		if(RegexUtil.notEmpty(userId)) {
			List<Ztree> notBasicTree = ztreeDao.getZtrees(" GROUP BY z.id ORDER BY z.node", " AND z.menuType<>0 OR z.parent is null");
			
			List<Ztree> list = ztreeDao.getUserZtrees(" GROUP BY z.id ORDER BY z.node", " AND z.parent is null OR z.menuType<>0 AND u.id="+userId);
			
			for(Ztree az : notBasicTree) {
				az.setUser(0);
				for(Ztree uz : list) {
					if(az.getId().equals(uz.getId())) az.setUser(1);
				}
			}
			return notBasicTree;
		} else {
			return ztreeDao.getZtrees(" ORDER BY z.node", null);
		}
	}
	
	@Override
	public List<Ztree> getBasicZtree(boolean bool) {
		if(bool) return ztreeDao.getBeanZtrees(" AND z.menuType=0");
		return ztreeDao.getBeanZtrees(" AND z.menuType=1 OR z.parent is null");
	}
	
	@Override
	public List<Trees> getLeftTree(String nodeId, Integer uid) {
		GomUser user = userDao.query(uid);
		if(RegexUtil.notEmpty(treeMap) && RegexUtil.notEmpty(treeMap.get(user.getEname()))) 
			return treeMap.get(user.getEname());
		
		List<Ztree> list = null;
		String c = "";
		if(user.isGeneric()) {
			c = " OR z.menuType=0";	//如果为基础用户
		}
		if(RegexUtil.notEmpty(uid)) {
			list = ztreeDao.getUserZtrees(" GROUP BY z.id ORDER BY z.node", " AND u.id=" + uid + c);
		}
		
		List<Trees> trees = new ArrayList<Trees>();
		for(Ztree z : list) {
			Trees t = new Trees();
			t.setId(z.getId());
			if(RegexUtil.notEmpty(z.getParent())) t.setpId(z.getParent().getId());
			else {t.setpId(0); t.setOpen("true");}
			if(!z.getChildren().isEmpty()) t.setIsParent("true"); 
			else t.setIsParent("false");
			t.setTitle(z.getTitle());
			t.setName(z.getName());
			t.setUrl(z.getUrl());
			if(RegexUtil.notEmpty(z.getIco())) t.setIco("../images/"+z.getIco());
			t.setTarget("_self");
			t.setRole(z.getRole());
			t.setPosition(z.getPosition());
			trees.add(t);	
		}
		//添加到内存
		treeMap.put(user.getEname(), trees);
		return trees;
	}
	
}
