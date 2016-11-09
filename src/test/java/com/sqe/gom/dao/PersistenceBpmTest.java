package com.sqe.gom.dao;

import static org.junit.Assert.*;
import javax.annotation.Resource;

import org.junit.Ignore;
import org.junit.Test;
import com.sqe.gom.BaseTest;
import com.sqe.gom.app.BpmService;
@Ignore
public class PersistenceBpmTest extends BaseTest{
	private static String s1 = "testUser", s2="testGroup";
	private BpmService pbpm;
	
	@Resource(name="bpmService")
	public void setPbpm(BpmService bpmService) {
		this.pbpm = bpmService;
	}
	
	@Test
	public void persistenceObject() {
		pbpm.saveObject("U", s1);
		pbpm.saveObject("G", s2);
		
		Object ut = pbpm.loadObject("U", s1);
		assertNotNull(ut);
		
		Object gt = pbpm.loadObject("G", s2);
		assertNotNull(gt);
	}
}
