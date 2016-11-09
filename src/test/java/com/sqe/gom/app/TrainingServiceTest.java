/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.Date;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.ResourceType;
import com.sqe.gom.constant.TrainingType;
import com.sqe.gom.dao.CategoryDAO;
import com.sqe.gom.dao.ExperienceDAO;
import com.sqe.gom.model.Experience;
import com.sqe.gom.model.Resource;
import com.sqe.gom.model.Training;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.UserGroup;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 25, 2012
 * @version 3.0
 */
@Ignore
public class TrainingServiceTest extends BaseTest {
	private TrainingService trainingService;
	private ResourceService resourceService;
	private ExperienceDAO experienceDao;
	private CategoryDAO categoryDao;
	private static Training tr;
	
	@Autowired
	public void setCategoryDao(CategoryDAO categoryDao) {
		this.categoryDao = categoryDao;
	}
	
	@Autowired
	public void setExperienceDao(ExperienceDAO experienceDao) {
		this.experienceDao = experienceDao;
	}
	
	@Autowired
	public void setTrainingService(TrainingService trainingService) {
		this.trainingService = trainingService;
	}
	
	@Autowired
	public void setResourceService(ResourceService resourceService) {
		this.resourceService = resourceService;
	}
	
	@Before
	public void onSetUpTestDataWithinTransaction() throws Exception {
		tr = new Training();
		tr.setTprogram("传真机使用");
		tr.setLecturer("sqe11");
		tr.setTrainingType(TrainingType.EXTERNAL);
		tr.setTrainingTime(12);
		tr.setFee(12);
		tr.setOtherFee(12);
		tr.setStartDate(new Date());
		tr.setEndDate(new Date());
		tr.setQualification("23");
		tr.setTcontent("计算机的保养和维护等等");
		
	}
	
	@After
	public void cleaningTestDate() throws Exception {
		if(RegexUtil.notEmpty(tr.getId()))
			trainingService.removeTraining(tr.getId());
	}
	
	@Test
	public void saveTraining() throws Exception {
		trainingService.saveTraining(tr);
		assertNotNull(tr.getId());
	}
	
	@Test
	public void getTrainings() {
		trainingService.saveTraining(tr);
		List<Training> list = trainingService.getTrainingAndExperience("sqe11", new Page(1,5));
		assertTrue(list.size() > 0);		
	}
	
	@Test
	public void getGain() {
		trainingService.saveTraining(tr);
		Experience experience = new Experience();
		experience.setStudent("sqe11");
		experience.setCreateDate(new Date());
		experience.setGain("sqe11我的心得内容添加");
		experience.setTraining(tr);
				
		Resource resource = new Resource();
		resource.setTitle("教育");
		resource.setVersion("V-1.0");
		resource.setCreateDate(new Date());
		resource.setUpdateDate(new Date());
		resource.setDes("教育详细信息");
		resource.setResourceType(ResourceType.EXPERIENCE);
		resource.setAttachment("aa");
		resource.setIsValid(true);
		resource.setUploadEname("sqe11");
		resource.setMaintainDpt("人事部");
		resource.setUploadDate(new Date());
		resource.setResponsibility(1);
		resource.setScore(12);
		resource.setSwot("12");
		resource.setCategory(categoryDao.query(2));	//添加分组
		resource.setPath(2);
		UserGroup ug = new UserGroup();
		ug.setEname("sqe11");
		ug.setCdepartment("人事部");
		ug.setComment("aa");
		resourceService.saveResource(resource, ug);
		
		experience.setResource(resource);
		experienceDao.create(experience);
		
		List<Experience> list = trainingService.getGain(tr.getLecturer(), "2011-01-01", DateUtil.formatDate(new Date()));
		assertTrue(list.size() > 0);
	}
	
	@Test
	public void getTrainingAndExperience() {
		trainingService.saveTraining(tr);
		List<Training> list = trainingService.getTrainingAndExperience(tr.getLecturer(), new Page(1,5));
		assertTrue(list.size() > 0);
	}
	
	@Test
	public void saveHowAndToResource() {
		Resource resource = new Resource();
		resource.setTitle("教育");
		resource.setVersion("V-1.0");
		resource.setCreateDate(new Date());
		resource.setUpdateDate(new Date());
		resource.setDes("教育详细信息");
		resource.setResourceType(ResourceType.EXPERIENCE);
		resource.setAttachment("aa");
		resource.setIsValid(true);
		resource.setUploadEname("sqe11");
		resource.setMaintainDpt("人事部");
		resource.setUploadDate(new Date());
		resource.setResponsibility(1);
		resource.setScore(12);
		resource.setSwot("12");
		resource.setCategory(categoryDao.query(2));	//添加分组
		resource.setPath(2);
		UserGroup ug = new UserGroup();
		ug.setEname("sqe11");
		ug.setCdepartment("人事部");
		ug.setComment("aa");
		resourceService.saveResource(resource, ug);
		
		Experience ex = new Experience();
		ex.setStudent("sqe11");
		ex.setCreateDate(new Date());
		ex.setGain("我的心得内容添加");
		ex.setResourceId(resource.getId());
		trainingService.saveHowAndToResource(ex);
		assertNotNull(ex.getId());
	}
	
	@Test
	public void saveExperienceAndToResource() {
		trainingService.saveTraining(tr);
		Experience e = new Experience();
		e.setStudent("sqe11");
		e.setCreateDate(new Date());
		e.setGain("我的心得内容添加");
		e.setTrainingId(tr.getId());
		
		trainingService.saveExperienceAndToResource(e, "E:\\workspace\\gom\\src\\main\\webapp\\images\\accept.png", "e://");
		assertNotNull(e.getId());
	}
}
