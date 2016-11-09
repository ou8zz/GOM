/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import static org.junit.Assert.assertEquals;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.StatisticalMethods;
import com.sqe.gom.constant.SwotModel;
import com.sqe.gom.model.SwotConfig;

/**
 * @description
 * @see 在此描述依赖的其他接口或类
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Sep 19, 2012  9:38:04 PM
 * @version 3.0
 */
@Ignore
public class SwotServiceTest extends BaseTest {
	private SwotConfig sc;
	private List<Float> data;
	
	private SwotService swotService;

	@Resource(name="swotService")
	public void setSwotService(SwotService swotService) {
		this.swotService = swotService;
	}

	@Before
	public void onSetUpTestData() throws Exception {
		sc = new SwotConfig();
		sc.setDatum(5);
		sc.setId(1);
		
		data = new ArrayList<Float>();
		data.add((float) 60.15);
		data.add((float) 60.00);
		data.add((float) 60.12);
		data.add((float) 60.13);
		data.add((float) 60.12);
		data.add((float) 60.22);
		data.add((float) 60.11);
		data.add((float) 60.10);
		data.add((float) 60.01);
		data.add((float) 59.05);
		data.add((float) 59.06);
		data.add((float) 60.00);
		data.add((float) 61.55);
		data.add((float) 62.00);
		data.add((float) 59.95);
		data.add((float) 60.00);
		data.add((float) 60.00);
		data.add((float) 65.00);
		data.add((float) 64.00);
		data.add((float) 64.35);
		data.add((float) 65.34);
	}
	
	//稳定A
	@Test
	public void testStableA() throws Exception {
		sc.setMethod(StatisticalMethods.PERCENTAGE);
		sc.setModel(SwotModel.STABLEA);
		sc.setCenterline((float) 60.00);
		sc.setDatumS((float)1);
		sc.setDatumO((float)5);
		sc.setDatumT((float)35);
		sc.setDatumW((float)35);
		
		List<String> list = swotService.stable(sc, data);
		assertEquals(21,list.size());
		for(String ss : list) {
			System.out.println(" = " + ss);
//			if(ss.getData() == 60.15) assertEquals("green", ss);
//			else if(ss.getData() == 59.05) assertEquals("blue", ss);
//			else if(ss.getData() == 61.55) assertEquals("yellow", ss);
		}
	}
	
	//稳定B
	@Test
	public void testStableB() throws Exception {
		sc.setMethod(StatisticalMethods.STDEV);
		sc.setModel(SwotModel.STABLEB);
		sc.setCenterline((float) 60.00);
		sc.setDatumS((float)0.30);
		sc.setDatumO((float)1.50);
		sc.setDatumT((float)10.5);
		sc.setDatumW((float)10.5);
		
		List<String> list = swotService.stable(sc, data);
		assertEquals(21,list.size());
		for(String ss : list) {
			System.out.println(" = " + ss);
//			if(ss.getData() == 60.15) assertEquals("green", ss.getSwot());
//			else if(ss.getData() == 59.05) assertEquals("blue", ss.getSwot());
//			else if(ss.getData() == 61.55) assertEquals("yellow", ss.getSwot());
		}
	}
	
	//改善
	@Test
	public void testImprove() throws Exception {
		data.add((float) 59.05);
		data.add((float) 59.06);
		data.add((float) 60.00);
		data.add((float) 61.55);
		data.add((float) 62.00);
		data.add((float) 61.40);
		data.add((float) 60.05);
		data.add((float) 60.00);
		data.add((float) 59.98);
		data.add((float) 59.95);
		data.add((float) 59.90);
		data.add((float) 59.00);
		data.add((float) 58.15);
		data.add((float) 59.00);
		data.add((float) 59.05);
		data.add((float) 58.06);
		data.add((float) 58.05);
		data.add((float) 58.04);
		data.add((float) 58.00);
		data.add((float) 58.00);
		data.add((float) 57.95);
		data.add((float) 57.99);
		data.add((float) 57.90);

		sc.setMethod(StatisticalMethods.PERCENTAGE);
		sc.setImproveTarget((float) 58.00);
		sc.setModel(SwotModel.IMPROVE);
		
		List<String> list = swotService.improve(sc, data);
		assertEquals(40,list.size());
		for(String ss : list) {
			System.out.println(" = " + ss);
			/**if(ss.getData() == 60.15) assertEquals("green", ss.getSwot());
			else if(ss.getData() == 59.05) assertEquals("blue", ss.getSwot());
			else if(ss.getData() == 61.55) assertEquals("yellow", ss.getSwot());*/
		}
	}
}
