/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.Date;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.TrainingType;
import com.sqe.gom.model.Experience;
import com.sqe.gom.model.Training;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.Page;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 28, 2012
 * @version 3.0
 */
public class ExperienceDaoTest extends BaseTest{
	private ExperienceDAO experienceDao;
	private TrainingDAO trainingDao;
	private Experience experience;
	private Training training;
	
	@Autowired
	public void setTrainingDao(TrainingDAO trainingDao) {
		this.trainingDao = trainingDao;
	}
	
	@Autowired
	public void setExperienceDao(ExperienceDAO experienceDao) {
		this.experienceDao = experienceDao;
	}
		
	@Before
	public void setUp() {
		experience = new Experience();
		experience.setStudent("sqe11");
		experience.setCreateDate(DateUtil.parseDate("2012-10-01"));
		experience.setGain("我的心得内容添加");
		
		training = new Training();
		training.setId(1);
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
		experienceDao.delete(experience);
	}
	
	@Test
	public void saveExperience() {
		trainingDao.create(training);
		experience.setTraining(training);
		experienceDao.create(experience);
		
		assertNotNull(experience.getId());
	}
	
	@Test
	public void getGain() {
		trainingDao.create(training);
		experience.setTraining(training);
		experienceDao.create(experience);
		
		List<Experience> list = experienceDao.getExperiences(null, null, new Page(1, 5));
		assertTrue(list.size()>0);
		assertEquals(1, list.size());
		assertEquals("sqe11", list.get(0).getStudent());
	}
	
	@Test
	public void updateExperience() {
		trainingDao.create(training);
		experience.setTraining(training);
		experienceDao.create(experience);
		
		experienceDao.create(experience);
		Experience exper = new Experience();
		exper.setId(experience.getId());
		exper.setStudent("sqe22");
		exper.setCreateDate(new Date());
		exper.setGain("我的心得修改内容");
		exper.setTraining(training);
		int i = experienceDao.updateExperience(exper);
		assertEquals(1, i);
	}
}