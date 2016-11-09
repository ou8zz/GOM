/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.TrainingType;
import com.sqe.gom.model.Training;
import com.sqe.gom.util.Page;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Feb 28, 2012
 * @version 3.0
 */
public class TrainingDaoTest extends BaseTest{
	private TrainingDAO trainingDao;
	private Training tr;
	
	@Autowired
	public void setTrainingDao(TrainingDAO trainingDao) {
		this.trainingDao = trainingDao;
	}
		
	@Before
	public void initDate() {
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
	public void cleaningDate() {
		trainingDao.delete(tr);
	}
	
	@Test
	public void saveTraining() {
		trainingDao.create(tr);
	}
	
	@Test
	public void getTrainings() {
		trainingDao.create(tr);
		
		List<Training> listTrain = new ArrayList<Training>();
		String ord = " ORDER BY t.id ASC";
		List<Training> list = trainingDao.getTrainingAndExperience(ord, null, new Page(1,5));
		for(Training t : list) {
			Training tv = new Training();
			tv.setId(t.getId());
			tv.setTprogram(t.getTprogram());
			tv.setLecturer(t.getLecturer());
			tv.setTrainingType(t.getTrainingType());
			tv.setTrainingTime(t.getTrainingTime());
			tv.setFee(t.getFee());
			tv.setOtherFee(t.getOtherFee());
			tv.setStartDate(t.getStartDate());
			tv.setEndDate(t.getEndDate());
			tv.setQualification(t.getQualification());
			tv.setTcontent(t.getTcontent());
			listTrain.add(tv);
		}
		assertTrue(listTrain.size() > 0);	
	}
	
	@Test
	public void getTraining() {
		trainingDao.create(tr);
		List<Training> training = trainingDao.getTrainingAndExperience(" ORDER BY t.id ASC", null, new Page(1,5));
		assertTrue(training.size() > 0);
	}
	
	@Test
	public void updateTraining() {
		trainingDao.create(tr);
		
		tr.setTprogram("打印机使用");
		tr.setLecturer("sqe112");
		tr.setTrainingType(TrainingType.EXTERNAL);
		tr.setTrainingTime(12);
		
		trainingDao.update(tr);
		assertEquals("sqe112", tr.getLecturer());
		assertEquals("打印机使用", tr.getTprogram());
		
	}
}