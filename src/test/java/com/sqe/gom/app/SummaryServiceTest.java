/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;

import com.sqe.gom.constant.DateRange;
import com.sqe.gom.dao.SummaryDAO;
import com.sqe.gom.model.Summary;
import com.sqe.gom.model.SwotResult;

/**
 * @description
 * @author Administrator
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 25, 2012
 * @version 3.0
 */
@Ignore
@ContextConfiguration(locations={"classpath:config/gom-service.xml"})
public class SummaryServiceTest extends AbstractTransactionalJUnit4SpringContextTests {
	private MockHttpServletRequest request;
	private MockHttpServletResponse response;
	private SummaryService summaryService;
	private SwotService swotService;
	private Summary summary;
	
	@Autowired
	private SummaryDAO summaryDao;
	
	@Autowired
	public void setSummaryService(SummaryService summaryService) {
		this.summaryService = summaryService;
	}
	@Autowired
	public void setSwotService(SwotService swotService) {
		this.swotService = swotService;
	}
		
	@Test
	public void getSummarys() {
		List<SwotResult> list = summaryService.getSummary(4, 4, DateRange.DAY);
		
		
		for(SwotResult s : list) {
			System.out.println(s.getSwot() + " " + s.getData() + " " + s.getSwot());
		}
	}
	
	
	@Test
	public void getSummaryYear() {
		
	}
}
