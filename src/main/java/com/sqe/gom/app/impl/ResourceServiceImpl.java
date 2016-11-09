/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.sqe.gom.app.ResourceService;
import com.sqe.gom.constant.ResourceType;
import com.sqe.gom.dao.CategoryDAO;
import com.sqe.gom.dao.ResourceDAO;
import com.sqe.gom.model.Category;
import com.sqe.gom.model.Experience;
import com.sqe.gom.model.Logs;
import com.sqe.gom.model.Resource;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.ManagerWord;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.util.XmlHelper;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 9, 2011
 * @version 3.0
 */
@Service("resourceService")
public class ResourceServiceImpl implements ResourceService {
	private Log log = LogFactory.getLog(getClass());
	private CategoryDAO categoryDao;
	private ResourceDAO resourceDao;
	private List<Resource> select = new ArrayList<Resource>();
	
	@Autowired
	public void setCategoryDao(CategoryDAO categoryDao) {
		this.categoryDao = categoryDao;
	}
	
	@Autowired
	public void setResourceDao(ResourceDAO resourceDao) {
		this.resourceDao = resourceDao;
	}

	@Override
	public void saveCategory(Category c) {
		if(RegexUtil.notEmpty(c.getId())) {
			categoryDao.updateCategory(c);
		} else {
			if(RegexUtil.notEmpty(c.getPid())) {
				Category parent = categoryDao.query(c.getPid());
				c.setParent(parent);
				String str = categoryDao.getMaxNode(c.getPid());
				if(RegexUtil.notEmpty(str)) {
					int i = str.lastIndexOf(".");
					String nodePre = str.substring(0, i+1);
					int node = Integer.parseInt(str.substring(i+1));
					node = node + 1;
					c.setNode(String.valueOf(nodePre+node));
				} else c.setNode(parent.getNode() + ".1");
			} else {
				String str = categoryDao.getMaxNode(null);
				if(RegexUtil.notEmpty(str)) {
					Integer node = Integer.parseInt(str);
					node = node + 1;
					c.setNode(String.valueOf(node));
				} else c.setNode(String.valueOf(1));
			}
			categoryDao.create(c);
		}
	}
	
	@Override
	public List<Category> getCtree() {
		return categoryDao.getCategories(null);
	}

	@Override
	public Document getCategories(String nid, int level) {
		StringBuilder criteria = new StringBuilder();
		if(RegexUtil.notEmpty(nid)) criteria.append(" AND p.id=").append(nid);
		else criteria.append(" AND p is null");
		
		List<Category> list = categoryDao.getCategories(criteria.toString(), " ORDER BY p.node");
		
		String cell = "cell";
		Document doc = XmlHelper.createXML();
		doc.setXmlVersion("1.0");
		Element rows = doc.createElement("rows");
		doc.appendChild(rows);
		for(Category c : list) {
			int parentId = 0;
			boolean open = false;
			if(RegexUtil.notEmpty(c.getPid())) parentId = c.getParent().getId();
			if(c.getChildren().isEmpty()) open = true;
			
			Element row = XmlHelper.createElement(rows, "row");
			row.setAttribute("id", String.valueOf(c.getId()));
			XmlHelper.createElement(row, cell, String.valueOf(c.getId()));
			XmlHelper.createElement(row, cell, c.getName());
			XmlHelper.createElement(row, cell, String.valueOf(c.getNode()));
			XmlHelper.createElement(row, cell, String.valueOf(level));
			XmlHelper.createElement(row, cell, String.valueOf(parentId));
			XmlHelper.createElement(row, cell, String.valueOf(open));
			XmlHelper.createElement(row, cell, String.valueOf(false));
			XmlHelper.addInfoToXML(rows, row);
		}
		return doc;
	}

	@Override
	public void saveResource(Resource r, UserGroup ug) {
		r.setUploadEname(ug.getEname());
		r.setMaintainDpt(ug.getCdepartment());
		if(RegexUtil.notEmpty(r.getPath())) r.setCategory(categoryDao.query(r.getPath()));		//添加分组
		
		Logs lf = new Logs();
		lf.setDated(new Date());
		lf.setUserId(ug.getId());
		
		if(RegexUtil.notEmpty(r.getId())) {
			//执行更新
			String ver = RegexUtil.formatDecimal(Float.parseFloat(r.getVersion().substring(2)), "#.##");	//格式化小数点后一位
			r.setVersion("V-"+RegexUtil.formatDecimal(Float.parseFloat(ver)+0.1f, "#.##"));			//更新自动升级版本0.1
			r.setUpdateDate(new Date());
			if(!r.getAttachment().equals(ug.getComment())) r.setUploadDate(new Date());				//如何附件不是原来的附件，则更新上传时间
			resourceDao.updateResource(r);
			
			lf.setLogger("更新文件");
			lf.setMessage("您更新 "+r.getResourceType().getDes() + " " + r.getTitle() + " 文件编号 " + r.getNumber() + " 更新版本号 "+r.getVersion()+" 操作成功。");
			log.debug(JsonUtils.toJson(lf));
		} else {
			//执行添加
			if(RegexUtil.notEmpty(r.getAttachment())) r.setUploadDate(new Date());  			//如果是添加新的附件，则添加上传时间
			r.setIsValid(true);
			r.setVersion("V-1.0");
			r.setUploadDate(new Date());
			r.setCreateDate(new Date());
			resourceDao.create(r);
			
			lf.setLogger("新增文件");
			lf.setMessage("新增"+r.getResourceType().getDes() + " " + r.getTitle() + " 文件编号 " + r.getNumber() + " 版本号 "+r.getVersion()+" 操作成功。");
			log.debug(JsonUtils.toJson(lf));
		}
	}

	@Override
	public void addDownloadDate(int id) {
		resourceDao.updateDowonloadDate(id, new Date());
	}
	
	@Override
	public List<Resource> getResources(String type, String name, Page page) {
		StringBuilder q = new StringBuilder(" AND r.isValid=true");		//前台用户只加载管理员认证过的数据
		if(RegexUtil.notEmpty(type)) q.append(" AND r.resourceType=").append(ResourceType.valueOf(type).ordinal());
		if(RegexUtil.notEmpty(name)) q.append(" AND r.title LIKE '%").append(name).append("%'");
		return resourceDao.getResources(" ORDER BY r.id", q.toString(), page);
	}

	@Override
	public List<Resource> getResources(JGridHelper<Resource> grid) {
		String ord = " ORDER BY " + "r."+grid.getJq().getSidx() + " " + grid.getJq().getSord();
		return resourceDao.getResources(ord, grid.getQ(), grid.getP());
	}

	@Override
	public List<Resource> getVideos(){
		return resourceDao.getResources(" ORDER BY r.createDate", "AND r.isValid=true AND r.resourceType="+ResourceType.VIDEO.ordinal(), null);
	}
	
	@Override
	public JGridBase<Resource> getHowtodos(JGridHelper<Resource> grid, String ename) {
		select.clear();
		String ord = " ORDER BY " + "r."+grid.getJq().getSidx() + " " + grid.getJq().getSord();
		List<Resource> listRes = new ArrayList<Resource>();
		List<Resource> list = resourceDao.getResourceAndHow(ord, grid.getQ(), grid.getP());
		for(Resource r : list) {
			Resource res = new Resource();
			res.setId(r.getId());
			res.setTitle(r.getTitle());
			select.add(r);	//添加全局map
			if(r.getExperience().size() > 0) {
				for(Experience e : r.getExperience()) {
					if(RegexUtil.notEmpty(ename) && e.getStudent().equals(ename)) {
						res = new Resource();
						res.setId(e.getId());
						res.setResourceId(r.getId());
						res.setTitle(r.getTitle());
						res.setVersion(r.getVersion());
						res.setResourceType(r.getResourceType());
						res.setMaintainDpt(r.getMaintainDpt());
						res.setCreateDate(e.getCreateDate());
						res.setUploadEname(e.getStudent());
						res.setDownloadDate(r.getDownloadDate());
						res.setHowGain(e.getGain());
						listRes.add(res);
					} 
				}
			}
		}
		
		grid.getJq().setList(listRes);
		grid.getJq().setRecords(grid.getP().getTotalCount());
		grid.getJq().setTotal(grid.getP().getPageCount());
		
		return grid.getJq();
	}
	
	@Override
	public List<Resource> getResourceSelect() {
		return select;
	}
	
	@Override
	public String getHowtodos(int id, String image, String path) {
		StringBuilder gain = new StringBuilder();
		Date min = new Date(); 						
		Date max = DateUtil.parseDate("1790-01-01"); 
		Resource resource = resourceDao.query(id);
		Date down = resource.getDownloadDate();
		for(Experience e : resource.getExperience()) {
			Date crea = e.getCreateDate();
			if (crea.before(min)) min = crea;	//得到最小日期
			if (crea.after(max)) max = crea;	//得到最大日期
			if(RegexUtil.notEmpty(down) && down.after(resource.getUploadDate())) {
				gain.append(e.getCreateDate()+"\n\n"+e.getGain()+"\n\n");
				min = down;
			} else if(RegexUtil.notEmpty(down) && (down.after(crea) || down.equals(crea))) {
				gain.append(e.getCreateDate()+"\n\n"+e.getGain()+"\n\n");
				min = down;
			} else {
				gain.append(e.getCreateDate()+"\n\n"+e.getGain()+"\n\n");
			}
		}
		if(RegexUtil.notEmpty(gain)) {
			//写入WORD
			String text = ManagerWord.formatText(image, resource.getTitle()+"(如何做)", gain.toString(), resource.getVersion(), min, max, "");
			ManagerWord.writerWord(path+"/how_"+resource.getAttachment(), text);
			return min+"~"+max;
		} else {
			return "没有新增内容";
		}
	}
			
	@Override
	public void removeCategory(int id) {
		categoryDao.delete(id);
	}

	@Override
	public void removeResource(String[] id) {
		for(String i : id) {
			resourceDao.delete(Integer.parseInt(i));
		}
	}

}
