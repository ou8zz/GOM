/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.sqe.gom.dao.ProjectDAO;
import com.sqe.gom.model.Project;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 5, 2012
 * @version 3.0
 */
@SuppressWarnings("unchecked")
@Repository("projectDao")
public class ProjectDAOImpl extends GenericHibernateDAO<Project> implements ProjectDAO {
	public ProjectDAOImpl() {
		super(Project.class);
	}

	@Override
	public List<Project> getProjects(String ord, String criteria) {
		String sql = "SELECT new com.sqe.gom.model.Project(p.id,p.projectNo,p.projectName,p.version,p.type,p.director,p.startDate,p.endDate,p.actualEnd,p.expectedTime,p.actualTime,p.des,f.id,f.projectName,c.id,c.productName) FROM Project AS p LEFT JOIN p.parent as f LEFT JOIN p.product AS c WHERE 1=1 ";
		if(RegexUtil.notEmpty(criteria)) {sql += criteria; }
		if(RegexUtil.notEmpty(ord)) sql += ord; 
		return (List<Project>) queryForList(sql, null);
	}
	
	@Override
	public List<Project> getProjects(String criteria) {
		String sql = "SELECT new com.sqe.gom.model.Project(p.id,p.projectNo,p.projectName,p.version,p.director,p.startDate,p.endDate,p.updateDate,p.actualEnd,p.expectedTime,p.actualTime,p.des) FROM Project AS p WHERE 1=1 ";
		if(RegexUtil.notEmpty(criteria)) {sql += criteria; }
		return (List<Project>) queryForList(sql, null);
	}
	
	@Override
	public Project getProject(Project pro) {
		String sql = "FROM Project AS p WHERE p.projectNo=? OR p.projectName=?";
		Project p = (Project) queryForObject(sql, new Object[]{pro.getProjectNo(), pro.getProjectName()});
		return p;
	}

	@Override
	public int updateProject(Project p) {
		List<Object> obj = new ArrayList<Object>();
		StringBuffer sql= new StringBuffer("UPDATE Project SET ");
		
		if(RegexUtil.notEmpty(p.getUpdateDate())) {
			sql.append("updateDate=?");
			obj.add(p.getUpdateDate());
		}
		
		if(RegexUtil.notEmpty(p.getDirector())) {
			sql.append(", director=?");
			obj.add(p.getDirector());
		}
		
		if(RegexUtil.notEmpty(p.getProjectNo())) {
			sql.append(", projectNo=?");
			obj.add(p.getProjectNo());
		}
		
		if(RegexUtil.notEmpty(p.getProjectName())) {
			sql.append(", projectName=?");
			obj.add(p.getProjectName());
		}
		
		if(RegexUtil.notEmpty(p.getVersion())) {
			sql.append(", version=?");
			obj.add(p.getVersion());
		}
		
		if(RegexUtil.notEmpty(p.getStartDate())) {
			sql.append(", startDate=?");
			obj.add(p.getStartDate());
		}
		
		if(RegexUtil.notEmpty(p.getEndDate())) {
			sql.append(", endDate=?");
			obj.add(p.getEndDate());
		}
		
		if(RegexUtil.notEmpty(p.getActualEnd())) {
			sql.append(", actualEnd=?");
			obj.add(p.getActualEnd());
		}
		
		if(RegexUtil.notEmpty(p.getExpectedTime())) {
			sql.append(", expectedTime=?");
			obj.add(p.getExpectedTime());
		}
		
		if(RegexUtil.notEmpty(p.getActualTime())) {
			sql.append(", actualTime=?");
			obj.add(p.getActualTime());
		}
		
		if(RegexUtil.notEmpty(p.getDes())) {
			sql.append(", des=?");
			obj.add(p.getDes());
		}
		
		if(RegexUtil.notEmpty(p.getId())) {
			if(obj.isEmpty()) return 0;
			else {
				sql.append(" WHERE id=?");
				obj.add(p.getId());
				return executeUpdate(sql.toString(), obj.toArray());
			}
		}else return 0;
	}
}