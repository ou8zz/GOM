/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.Date;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;

import com.sqe.gom.BaseTest;
import com.sqe.gom.app.TrainingService;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.constant.TrainingType;
import com.sqe.gom.dao.TrainingDAO;
import com.sqe.gom.model.Training;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.TrainingController;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Mar 1, 2012
 * @version 3.0
 */
public class TrainingContrallerTest extends BaseTest {
	private TrainingService trainingService;
	private TrainingController trainingController;
	private MockHttpServletRequest request;
	private MockHttpServletResponse response;
	private TrainingDAO trainingDao;
	private Training training;
	
	@Autowired
	public void setTrainingDao(TrainingDAO trainingDao) {
		this.trainingDao = trainingDao;
	}
	
	@Autowired
	public void setTrainingService(TrainingService trainingService) {
		this.trainingService = trainingService;
	}
	
	@Before
	public void setUp() {
		trainingController = new TrainingController();
		trainingController.setTrainingService(trainingService);
		request =  new MockHttpServletRequest("GET","/training.htm");  
		response = new MockHttpServletResponse();
		
		training = new Training();
		training.setTprogram("传真机使用");
		training.setLecturer("sqe11");
		training.setTrainingType(TrainingType.EXTERNAL);
		training.setTrainingTime(12);
		training.setFee(12);
		training.setOtherFee(12);
		training.setStartDate(new Date());
		training.setEndDate(new Date());
		training.setQualification("23");
		training.setTcontent("计算机的保养和维护等等");
	}
	
	@After
	public void tearDown() {
		trainingDao.delete(training);
	}
	
	@Test
	public void saveTraining() throws Exception {
		UserGroup ug = new UserGroup();
		ug.setEname("sqse_ename");
		request.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug);
		BindingResult result = new BindException("", "test");
		trainingController.saveTraining(training, result, request, response);
		
		String str = response.getContentAsString();
		int s = str.indexOf("SUCCESS");
		String success = str.substring(s, s+7);
		assertEquals("SUCCESS", success);
	}
	
	@Test
	public void getTrainings() throws Exception {
		trainingDao.create(training);
		
		request.addParameter("page","1");   
		request.addParameter("rows","10"); 
		request.addParameter("sidx","id");   
		request.addParameter("sord","ASC"); 
		UserGroup ug = new UserGroup();
		ug.setEname("sqse_ename");
		request.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug);
		trainingController.getTrainings(request, response);
		String str = response.getContentAsString();
		assertNotNull(str);
	}
	
	@Test
	public void getExperiences() throws Exception {
		trainingDao.create(training);
		request.addParameter("pageId","1");  
		UserGroup ug = new UserGroup();
		ug.setEname("sqse_ename");
		request.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug);
		Model model = new ExtendedModelMap();
		String str = trainingController.getExperiences(request, response, model);
		
		assertEquals("app/list_experience", str);
	}
	
	@Test
	public void downloadGain() throws Exception {
		trainingDao.create(training);
		UserGroup ug = new UserGroup();
		ug.setEname("sqse_ename");
		request.getSession().setAttribute(SessionAttr.USER_TAKEN.name(), ug);
		
		trainingController.downloadGain("2011-01-01", new Date().toString(), request, response);
		
		assertEquals(200, response.getStatus());
	}
}
