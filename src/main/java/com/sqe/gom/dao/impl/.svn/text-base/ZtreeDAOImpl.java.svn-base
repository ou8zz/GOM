/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sqe.gom.constant.MenuType;
import com.sqe.gom.dao.ZtreeDAO;
import com.sqe.gom.model.Ztree;
import com.sqe.gom.util.RegexUtil;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 20, 2012
 * @version 3.0
 */
@SuppressWarnings("unchecked")
@Repository("ztreeDao")
public class ZtreeDAOImpl extends GenericHibernateDAO<Ztree> implements ZtreeDAO {
	public ZtreeDAOImpl() {
		super(Ztree.class);
	}
	
	@Override//u.id<>0 and z.id in (select z1.id from Ztree AS z1 left join z1.user AS u1 where u1.id=0)
	public List<Ztree> getUserZtrees(String ord, String criteria) {
		String sql = "SELECT z FROM Ztree AS z LEFT JOIN z.users AS u WHERE 1=1";
		if(RegexUtil.notEmpty(criteria)) sql += criteria;
		if(RegexUtil.notEmpty(ord)) sql += ord;
		return (List<Ztree>) queryForList(sql, null);
	}
	
	@Override
	public List<Ztree> getBeanZtrees(String criteria) {
		String sql = "FROM Ztree AS z WHERE 1=1 ";
		if(RegexUtil.notEmpty(criteria)) sql += criteria;
		return (List<Ztree>) queryForList(sql += " GROUP BY z.id ORDER BY z.node", null);
	}
	
	@Override
	public List<Ztree> getZtrees(String ord, String criteria) {
		String sql = "SELECT new com.sqe.gom.model.Ztree(z.id, z.name, z.node, z.position, z.role, z.title, z.url, z.ico, z.parent.id) FROM Ztree AS z WHERE 1=1";
		if(RegexUtil.notEmpty(criteria)) sql += criteria;
		if(RegexUtil.notEmpty(ord)) sql += ord;
		return (List<Ztree>) queryForList(sql, null);
	}

	@Override
	public String getMaxNode(Integer id) {
		String sql = "SELECT MAX(p.node) FROM Ztree AS p WHERE ";
		if(RegexUtil.notEmpty(id)) {
			sql += "p.parent.id = " + id;
		} else {
			sql += "p.parent is null";
		}
		return (String) queryForObject(sql, null);
	}
		
	@Override
	public void updateZtree(Ztree z) {
		String sql = "UPDATE Ztree AS p SET p.name=?, p.title=?, p.url=?, p.ico=?, p.position=?, p.role=?, p.menuType=? WHERE p.id=?";
		executeUpdate(sql, new Object[]{z.getName(), z.getTitle(), z.getUrl(), z.getIco(), z.getPosition(), z.getRole(), z.getMenuType(), z.getId()});
	}
	
	@Override
	public void updateZtree(Integer zid, MenuType type) {
		String sql = "UPDATE Ztree AS p SET p.menuType=? WHERE p.id=?";
		executeUpdate(sql, new Object[]{type, zid});
	}
	
}
