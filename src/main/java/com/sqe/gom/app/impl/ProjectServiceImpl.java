/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.sqe.gom.app.ProjectService;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.ProjectType;
import com.sqe.gom.dao.ProductDAO;
import com.sqe.gom.dao.ProjectDAO;
import com.sqe.gom.dao.UserDAO;
import com.sqe.gom.model.Logs;
import com.sqe.gom.model.Product;
import com.sqe.gom.model.Project;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.util.XmlHelper;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description detail information see interface please.
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 5, 2012
 * @version 3.0
 */
@Service("projectService")
public class ProjectServiceImpl implements ProjectService {
	private Log log = LogFactory.getLog(ProjectServiceImpl.class);
	private ProjectDAO projectDao;
	private ProductDAO productDao;
	private UserDAO userDao;
	
	@Resource(name="projectDao")
	public void setProjectDao(ProjectDAO projectDao) {
		this.projectDao = projectDao;
	}
	
	@Resource(name="productDao")
	public void setProductDao(ProductDAO productDao) {
		this.productDao = productDao;
	}
	
	@Resource(name="userDao")
	public void setUserDao(UserDAO userDao) {
		this.userDao = userDao;
	}
	
	@Override
	public void saveProject(Project p) {
		p.setUpdateDate(new Date());
		
		if(RegexUtil.isEmpty(p.getId())) {
			//添加(如果是module添加模块)
			if(p.getType().equals(ProjectType.Module) && RegexUtil.notEmpty(p.getParentId())) {
				p.setParent(new Project(p.getParentId()));
			}
			else if(p.getType().equals(ProjectType.Project) && RegexUtil.notEmpty(p.getProductId())) {
				p.setProduct(new Product(p.getProductId()));
			}
			projectDao.create(p);
			
			Logs lf = new Logs();
			lf.setDated(new Date());
			lf.setLogger("新增"+p.getType().getDes());
			lf.setMessage("于" + DateUtil.forMatDate() + " 添加编号为 " + p.getProjectNo() + " 的  " + p.getType().getDes() + p.getProjectName() + " 计划从 " + DateUtil.formatDate(p.getStartDate()) + " 开始至 " + p.getEndDate() + " 结束， 为时  " + p.getExpectedTime() + " 项目管理者为 "+ p.getDirector());
			log.debug(JsonUtils.toJson(lf));
		} else {
			projectDao.updateProject(p);
			
			Logs lf = new Logs();
			lf.setDated(new Date());
			lf.setLogger("编辑"+p.getType().getDes());
			lf.setMessage("于 " + DateUtil.forMatDate() + " 修改编号为 " + p.getProjectNo() + " 的  " + p.getType().getDes() + p.getProjectName() + " 修改后版本  " + p.getVersion());
			log.debug(JsonUtils.toJson(lf));
		}

	}

	@Override
	public void saveProduct(Product product) {
		if(RegexUtil.isEmpty(product.getId())) {
			//添加
			productDao.create(product);
			
			Logs lf = new Logs();
			lf.setDated(new Date());
			lf.setLogger("新增产品");
			lf.setMessage("于 "+DateUtil.forMatDate()+" 添加 "+product.getProductType().getDes() +" 类产品 " + product.getProductName() + product.getNum() + product.getUnit() + " 操作成功。");
			log.debug(JsonUtils.toJson(lf));
		} else {
			//修改
			productDao.update(product);
			
			Logs lf = new Logs();
			lf.setDated(new Date());
			lf.setLogger("产品编辑");
			lf.setMessage("于 "+DateUtil.forMatDate()+" 编辑 "+product.getProductType().getDes() +" 类产品 " + product.getProductName() + product.getNum() + product.getUnit() + " 修改后版本 " + product.getVersion());
			log.debug(JsonUtils.toJson(lf));
		}
	}
	
	@Override
	public boolean checkProject(Project project) {
		Project pro = projectDao.getProject(project);
		if(RegexUtil.notEmpty(pro)) return true;
		else return false;
	}

	@Override
	public boolean checkProduct(String productName) {
		Product pro = productDao.getProduct(productName);
		if(RegexUtil.notEmpty(pro)) return true;
		else return false;
	}
	
	@Override
	public Document getProjects(String pid, int level) {
		String cell = "cell";
		Document doc = XmlHelper.createXML();
		doc.setXmlVersion("1.0");
		Element rows = doc.createElement("rows");
		doc.appendChild(rows);
		
		StringBuffer cr = new StringBuffer();
		cr.append(" AND p.state=").append(ProcessStatus.InProgress.ordinal());
		if(RegexUtil.notEmpty(pid)) cr.append(" AND f.id=").append(pid);
		else cr.append(" AND f.id IS NULL");
		
		List<Project> list = projectDao.getProjects(" ORDER BY p.startDate", cr.toString());
		
		String director = "";
		Integer dptId = 0;
		for(Project p : list) {
			if(RegexUtil.notEmpty(p.getDirector())) {
				if(RegexUtil.isEmpty(director) || !director.equals(p.getDirector())) {
					UserGroup ug = userDao.getUser(p.getDirector());
					director = p.getDirector();
					dptId = ug.getDptId();
					if(RegexUtil.notEmpty(ug)) p.setDtrDptId(ug.getDptId());
				}else p.setDtrDptId(dptId);
			}
			int parentId = 0;
			boolean open = false;
			if(RegexUtil.notEmpty(p.getParentId())) {
				open = true;
				parentId = p.getParentId();
			}
			Element row = XmlHelper.createElement(rows, "row");
			row.setAttribute("id", p.getId().toString());
			XmlHelper.createElement(row, cell, String.valueOf(p.getId()));
			XmlHelper.createElement(row, cell, String.valueOf(p.getType()));
			XmlHelper.createElement(row, cell, p.getProjectName());
			XmlHelper.createElement(row, cell, p.getProjectNo());
			XmlHelper.createElement(row, cell, p.getVersion());
			XmlHelper.createElement(row, cell, String.valueOf(p.getType().getDes()));
			XmlHelper.createElement(row, cell, p.getDirector());
			XmlHelper.createElement(row, cell, p.getDtrDptId().toString());
			XmlHelper.createElement(row, cell, String.valueOf(p.getStartDate()));
			XmlHelper.createElement(row, cell, String.valueOf(p.getEndDate()));
			XmlHelper.createElement(row, cell, String.valueOf(p.getExpectedTime()));
			XmlHelper.createElement(row, cell, p.getDes());
			if(RegexUtil.isEmpty(p.getProductName())) {
				XmlHelper.createElement(row, cell, "");
				XmlHelper.createElement(row, cell, "");
			}else {
				XmlHelper.createElement(row, cell, p.getProductId().toString());
				XmlHelper.createElement(row, cell, p.getProductName());
			}
			if(parentId == 0) {
				XmlHelper.createElement(row, cell, "");
				XmlHelper.createElement(row, cell, "");
			}else {
				XmlHelper.createElement(row, cell, String.valueOf(parentId));
				XmlHelper.createElement(row, cell, p.getParentName());
			}
			
			XmlHelper.createElement(row, cell, String.valueOf(level));
			XmlHelper.createElement(row, cell, String.valueOf(parentId));
			XmlHelper.createElement(row, cell, String.valueOf(open));
			XmlHelper.createElement(row, cell, String.valueOf(false));
		    
			XmlHelper.addInfoToXML(rows, row);
		}
		
		return doc;
	}

	@Override
	public List<Project> getProjects(String pid) {
		String cr = " AND p.parent is null";
		if(RegexUtil.notEmpty(pid)) cr = " AND p.parent.id="+pid;
		
		return projectDao.getProjects(" ORDER BY p.id", cr);
	}
	
	@Override
	public List<Product> getProducts() {
		return productDao.getProducts();
	}
	
	@Override
	public JGridBase<Product> getProducts(JGridHelper<Product> grid) {
		String ord = " ORDER BY " + "p."+grid.getJq().getSidx() + " " + grid.getJq().getSord();
		List<Product> list = productDao.getProducts(ord, grid.getQ(), grid.getP());
		grid.getJq().setList(list);
		grid.getJq().setRecords(grid.getP().getTotalCount());
		grid.getJq().setTotal(grid.getP().getPageCount());
		return grid.getJq();
	}

	@Override
	public void removeProject(int id) {
		Project p = projectDao.query(id);
		projectDao.delete(p);
		
		Logs lf = new Logs();
		lf.setDated(new Date());
		lf.setLogger("删除项目");
		lf.setMessage("编号为 " + p.getProjectNo() + " 的  " + p.getType().getDes() + p.getProjectName() + " 已被删除成功。");
		log.debug(JsonUtils.toJson(lf));
	}

	@Override
	public void removeProduct(int id) {
		Product p = productDao.query(id);
		productDao.delete(p);
		
		Logs lf = new Logs();
		lf.setDated(new Date());
		lf.setLogger("删除产品");
		lf.setMessage(p.getProductType().getDes() +" 类产品 " + p.getProductName() + " 已被删除成功。");
		log.debug(JsonUtils.toJson(lf));
	}
}