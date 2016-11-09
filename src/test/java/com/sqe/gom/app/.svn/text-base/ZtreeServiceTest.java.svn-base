/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.sqe.gom.BaseTest;
import com.sqe.gom.dao.ZtreeDAO;
import com.sqe.gom.model.Ztree;

/**
 * @description Ztree TEST
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 19, 2012
 * @version 3.0
 */
public class ZtreeServiceTest extends BaseTest {
	private Ztree zt;
	
	@Autowired
	private ZtreeDAO ztreeDao;
	
	@Autowired
	private ZtreeService ztreeService;
	
	
	@Before
	public void setUp() {
		zt = new Ztree();
		zt.setName("父节点1");
		zt.setTitle("this a parent node 1");
		zt.setUrl("www.google.com");
		zt.setIco("css/zTreeStyle/img/diy/2.png");
		zt.setNode("0");
	}
	
	@After
	public void tearDown() {
		ztreeDao.delete(zt);
	}
	
	@Test
	public void saveZtree() throws Exception {
		ztreeService.saveZtree(zt);
		assertNotNull(zt.getId());
	}
	
	@Test
	public void getZtrees() throws Exception {
		ztreeService.saveZtree(zt);
		
		List<Ztree> list = ztreeService.getZtrees(null);
		
		assertTrue(list.size()>0);
	}
	
	@Test
	public void getMaxNode() throws Exception {
		ztreeService.saveZtree(zt);
		
		String node = ztreeDao.getMaxNode(zt.getId());
	}
}
