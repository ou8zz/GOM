/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import javax.annotation.Resource;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import com.sqe.gom.BaseTest;
import com.sqe.gom.dao.ConfigDAO;
import com.sqe.gom.model.Config;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 19, 2012
 * @version 3.0
 */
public class ConfigServiceTest extends BaseTest {
	private MockHttpServletRequest request;
	private MockHttpServletResponse response;
	private GomService gomService;
	private ConfigDAO configDao;
	private Config config;

	@Resource(name = "gomService")
	public void setGomService(GomService gomService) {
		this.gomService = gomService;
	}

	@Autowired
	public void setConfigDao(ConfigDAO configDao) {
		this.configDao = configDao;
	}

	@Before
	public void setUp() {
		request =  new MockHttpServletRequest("GET","/config.htm");  
		response = new MockHttpServletResponse();
		
		config = new Config();
		config.setGroup("basis");
		config.setKey("basis.adminIT");
		config.setName("IT管理员");
		config.setValue("james");
		
	}
	

	@After
	public void tearDown() {
		configDao.delete(config);
	}
	
	@Test
	public void saveSysConfigs() throws Exception {
		configDao.create(config);
		
		JGridHelper<Config> grid = new JGridHelper<Config>();
		grid.jgridHandler(request, response, "c.");
		grid.getJq().setSidx("id");
		grid.getJq().setSord("ASC");
		grid.getJq().setPage(1);
		grid.getJq().setRows(10);
		
		JGridBase<Config> jgb = gomService.getConfigByGroup(config.getGroup(), "c.", grid);
		assertNotNull(jgb);
		assertEquals(1, jgb.getList().size());
	}
    
	@Test
	public void getSysConfigs() throws Exception {
		configDao.create(config);
		
		Config c = configDao.getConfig("basis.adminIT");
		assertNotNull(c);
		assertEquals("james", c.getValue());
	}
}
