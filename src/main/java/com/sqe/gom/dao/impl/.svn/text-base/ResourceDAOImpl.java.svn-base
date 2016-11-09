/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.constant.ResourceType;
import com.sqe.gom.dao.ResourceDAO;
import com.sqe.gom.model.Resource;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;

/**
 * @description  ResourceDAO implements entity class.
 * @see com.sqe.gom.dao.GenericDAO
 * @description category
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 9, 2011
 * @version 3.0
 */
@Repository("resourceDao")
@SuppressWarnings("unchecked")
public class ResourceDAOImpl extends GenericHibernateDAO<Resource> implements ResourceDAO {
	public ResourceDAOImpl() {
		super(Resource.class);
	}
	
	@Override
	public List<Resource> getResources(String ord, String criteria, Page page) {
		String num = "SELECT COUNT(*) FROM Resource AS r WHERE 1=1";
		String sql = "SELECT new com.sqe.gom.model.Resource(r.id,c.id,r.resourceType,r.number,r.version,r.title,r.des,r.attachment,r.createDate,r.updateDate,r.isValid,r.uploadDate,r.uploadEname,r.maintainDpt,r.downloadDate,r.responsibility,r.score,r.swot) FROM Resource AS r LEFT JOIN r.category AS c WHERE 1=1";
		if(RegexUtil.notEmpty(criteria)) {num += criteria;sql += criteria;}
		if(RegexUtil.notEmpty(ord)) sql += ord;
		if(RegexUtil.isEmpty(page)) return (List<Resource>) queryForList(sql, null);
		return (List<Resource>) queryForList(num, sql, null, page);
	}
	
	@Override
	public List<Resource> getResourceAndHow(String ord, String criteria, Page page) {
		String num = "SELECT COUNT(*) FROM Resource AS r WHERE r.resourceType=? ";
		String sql = "FROM Resource AS r WHERE r.resourceType=? ";
		if(RegexUtil.notEmpty(criteria)) {
			num += criteria;
			sql += criteria;
		}
		if(RegexUtil.notEmpty(ord)) sql += ord;
		if(RegexUtil.isEmpty(page)) queryForList(sql, new Object[]{ResourceType.HOW});
		return (List<Resource>) queryForList(num, sql, new Object[]{ResourceType.HOW}, page);
	}

	@Override
	public void updateResource(Resource r) {
		List<Object> list = new ArrayList<Object>();
		StringBuffer sql= new StringBuffer("UPDATE Resource AS r SET r.updateDate=?");
		list.add(new Date());
		
		if(RegexUtil.notEmpty(r.getTitle())) {
			sql.append(", r.title=?");
			list.add(r.getTitle());
		}
		if(RegexUtil.notEmpty(r.getVersion())) {
			sql.append(", r.version=?");
			list.add(r.getVersion());
		}
		if(RegexUtil.notEmpty(r.getDes())) {
			sql.append(", r.des=?");
			list.add(r.getDes());
		}
		if(RegexUtil.notEmpty(r.getAttachment())) {
			sql.append(", r.attachment=?");
			list.add(r.getAttachment());
		}
		if(RegexUtil.notEmpty(r.getIsValid())) {
			sql.append(", r.isValid=?");
			list.add(r.getIsValid());
		}
		if(RegexUtil.notEmpty(r.getUploadDate())) {
			sql.append(", r.uploadDate=?");
			list.add(r.getUploadDate());
		}
		if(RegexUtil.notEmpty(r.getUploadEname())) {
			sql.append(", r.uploadEname=?");
			list.add(r.getUploadEname());
		}
		if(RegexUtil.notEmpty(r.getMaintainDpt())) {
			sql.append(", r.maintainDpt=?");
			list.add(r.getMaintainDpt());
		}
		if(RegexUtil.notEmpty(r.getId())) {
			sql.append(" WHERE r.id=?");
			list.add(r.getId());
			executeUpdate(sql.toString(), list.toArray());
		}
		executeUpdate(sql.toString(), list.toArray());
	}
	
	@Override
	public Resource getResource(String uploadEname) {
		return (Resource) queryForObject("FROM Resource AS r WHERE r.resourceType=? AND r.uploadEname=?", new Object[]{ResourceType.EXPERIENCE, uploadEname});
	}

	@Override
	public void updateDowonloadDate(int id, Date downloadDate) {
		String sql = "UPDATE Resource AS r SET r.downloadDate=? WHERE r.id=?";
		executeUpdate(sql, new Object[]{downloadDate, id});
	}
	
}