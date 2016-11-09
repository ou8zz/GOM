/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import static org.junit.Assert.*;
import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.util.Page;
import com.sqe.gom.vo.UserGroup;

/**
 * @description
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Sep 6, 2011  9:30:02 PM
 * @version 3.0
 */
public class GroupTest extends BaseTest {
	@Autowired
	private GroupDAO groupDao;
	@Autowired
	private UserDAO userDao;
	
	@Ignore
	public void createGroup() {
		GomGroup g = new GomGroup();
		g.setCname("超级用户");
		g.setEname("Supervisors");
		g.setType(GroupType.ROLE);
		groupDao.create(g);
		assertNotNull(g.getId());
		GomGroup group = groupDao.query(g.getId());
		assertEquals(g.getId(), group.getId());
		Page p = new Page(1);
		List<GomGroup> gs = groupDao.getGroups(" order by g.ename", null, p, g.getType());
		assertEquals(gs.size(),1);
		for(GomGroup gg : gs) {
			System.out.println(gg.getCname() + " ename=" + gg.getEname());
		}
	}
	
	@Test
	public void getUserAndPosition() {
		createUser(userDao);
		
		UserGroup ug = userDao.getUserByDepartAndPosit("Employee", "Develop");
		assertNotNull(ug.getId());
		System.out.println(ug.getCname() + " " + ug.getPosition());
	}
}
