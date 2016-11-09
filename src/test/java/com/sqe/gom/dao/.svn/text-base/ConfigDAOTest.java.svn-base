/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import static org.junit.Assert.*;
import com.sqe.gom.BaseTest;
import com.sqe.gom.model.Config;

/**
 * @description
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jun 6, 2012  9:44:25 PM
 * @version 3.0
 */
public class ConfigDAOTest extends BaseTest {
	@Autowired
	private ConfigDAO configDao;
	String key = "fileUpload";
	
	@Test
	public void testQueryByKey() {
		Config c = new Config();
		c.setKey(key);
		c.setName("文件上传参数组");
		configDao.create(c);
		
		Config config = configDao.getConfig(key);
		assertNotNull(config.getKey());
		assertEquals(config.getKey(), key);
	}
}
