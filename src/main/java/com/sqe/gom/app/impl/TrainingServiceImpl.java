/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sqe.gom.app.TrainingService;
import com.sqe.gom.constant.ResourceType;
import com.sqe.gom.dao.ExperienceDAO;
import com.sqe.gom.dao.ResourceDAO;
import com.sqe.gom.dao.TrainingDAO;
import com.sqe.gom.model.Experience;
import com.sqe.gom.model.Logs;
import com.sqe.gom.model.Resource;
import com.sqe.gom.model.Training;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.ManagerWord;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 10, 2012
 * @version 3.0
 */
@Service("trainingService")
public class TrainingServiceImpl implements TrainingService {
	private Log log = LogFactory.getLog(getClass());
	private TrainingDAO trainingDao;
	private ExperienceDAO experienceDao;
	private ResourceDAO resourceDao;
	
	@Autowired
	public void setTrainingDao(TrainingDAO trainingDao) {
		this.trainingDao = trainingDao;
	}
	
	@Autowired
	public void setExperienceDao(ExperienceDAO experienceDao) {
		this.experienceDao = experienceDao;
	}
	
	@Autowired
	public void setResourceDao(ResourceDAO resourceDao) {
		this.resourceDao = resourceDao;
	}
		
	@Override
	public JGridBase<Training> getTrainings(JGridHelper<Training> grid) {
		
		String ord = " ORDER BY " + "t."+grid.getJq().getSidx() + " " + grid.getJq().getSord();
		
		grid.getJq().setList(trainingDao.getTrainings(ord, grid.getQ(), grid.getP()));
		grid.getJq().setRecords(grid.getP().getTotalCount());
		grid.getJq().setTotal(grid.getP().getPageCount());
		return grid.getJq();
	}

	@Override
	public List<Training> getTrainingAndExperience(String ename, Page page) {
		List<Training> listTrain = new ArrayList<Training>();
		String ord = " ORDER BY t.startDate ASC";
		List<Training> list = trainingDao.getTrainingAndExperience(ord, null, page);
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
			if(RegexUtil.notEmpty(t.getExperience())) {
				for(Experience ex : t.getExperience()) {
					if(RegexUtil.notEmpty(ename) && ename.equals(ex.getStudent())) {
						tv.setExperienceId(ex.getId());
						tv.setGain(ex.getGain());
					}
				}
			}
			listTrain.add(tv);
		}
		return listTrain;
	}
		
	@Override
	public List<Experience> getGain(String user, String start, String end) {
		StringBuilder criteria = new StringBuilder();
		
		if(RegexUtil.notEmpty(start)) criteria.append(" AND e.createDate>='").append(start).append("'");
		if(RegexUtil.notEmpty(end)) criteria.append(" AND e.createDate<='").append(end).append("'");
		
		return experienceDao.getExperiences(" ORDER BY e.createDate", criteria.toString(), null);
	}

	@Override
	public void saveTraining(Training training) {
		Logs lf = new Logs();
		lf.setDated(new Date());
		
		if(RegexUtil.notEmpty(training.getId())) {
			trainingDao.update(training);
			
			lf.setLogger("编辑培训课程");
			lf.setMessage("您于 " + DateUtil.forMatDate() + " 编辑 " + training.getTrainingType().getDes() + " 课程 " + training.getTprogram());
			log.debug(JsonUtils.toJson(lf));
		} else {
			trainingDao.create(training);
			
			lf.setLogger("新增培训课程");
			lf.setMessage("您于 " + DateUtil.forMatDate() + " 新增 " + training.getTrainingType().getDes() + " 课程 " + training.getTprogram() + " 为时 " + training.getTrainingTime() + " 小时， 由" + training.getQualification() + " 讲师 " + training.getLecturer() + " 老师为大家授课！ ");
			log.debug(JsonUtils.toJson(lf));
		}
	}

	@Override
	public void saveHowAndToResource(Experience experience) {
		//常规修改和添加Experience
		if(RegexUtil.notEmpty(experience.getId())) {
			experienceDao.updateExperience(experience);
		} else {
			//添加到如何做
			experience.setCreateDate(new Date());
			experience.setResource(resourceDao.query(experience.getResourceId()));
			experienceDao.create(experience);
		}
	}
	
	@Override
	public void saveExperienceAndToResource(Experience experience, String image, String path) {
		//常规修改和添加Experience
		if(RegexUtil.notEmpty(experience.getId())) {
			experienceDao.updateExperience(experience);
		} else {
			//添加心得
			experience.setCreateDate(new Date());
			experience.setTraining(trainingDao.query(experience.getTrainingId()));
			experienceDao.create(experience);
		}
		
		//添加到Experience后。如果有在Resource表中添加过心得，则找到word文件做只修改操作，否则创建新的word
		Resource res = resourceDao.getResource(experience.getStudent());
		if(RegexUtil.notEmpty(res)) {
			List<Experience> listExper = experienceDao.getExperiences(ResourceType.HOW, experience.getStudent(), null, null);
 			StringBuilder gain = new StringBuilder();
			for(Experience exper : listExper) {
				gain.append(exper.getGain()).append("\n\n");
			}
			//删除原有文件
			ManagerWord.deleteWord(path+res.getAttachment());
			res.setIsValid(true);
			res.setDes(experience.getStudent()+"心得最近添加于"+DateUtil.formatDate(new Date()));
			String ver = RegexUtil.formatDecimal(Float.parseFloat(res.getVersion().substring(2)), "#.##");
			res.setVersion("V-"+RegexUtil.formatDecimal(Float.parseFloat(ver)+0.1f, "#.##"));		//更新自动升级版本0.1
			res.setUpdateDate(new Date());
			res.setUploadEname(experience.getStudent());
			String text = ManagerWord.formatText(image, res.getTitle(), gain.toString(), res.getVersion(), res.getCreateDate(), res.getUpdateDate(), "");
			ManagerWord.writerWord(path+"/"+res.getAttachment(), text);
			res.setAttachment(res.getAttachment());
			resourceDao.update(res);
		} else {
			//添加 或 编辑心得后再往文件表中插入一条Resource
			Resource resource = new Resource();
			resource.setIsValid(true);
			resource.setCreateDate(new Date());
			resource.setMaintainDpt("");
			resource.setResourceType(ResourceType.EXPERIENCE);
			resource.setTitle(experience.getStudent()+"最近心得");
			resource.setDes(experience.getStudent()+"心得最近添加于"+DateUtil.formatDate(new Date()));
			resource.setVersion("V-1.0");
			resource.setUploadDate(new Date());
			resource.setUploadEname(experience.getStudent());
			String text = ManagerWord.formatText(image, resource.getTitle(), experience.getGain(), resource.getVersion(), resource.getCreateDate(), new Date(), "");
			String fileName = UUID.randomUUID().toString().replaceAll("-", "")+ ".doc";
			ManagerWord.writerWord(path+"/"+fileName, text);
			resource.setAttachment(fileName);
			resourceDao.create(resource);
		}
	}

	@Override
	public void removeTraining(int id) {
		trainingDao.delete(id);
	}

	@Override
	public void removeExperience(int id) {
		experienceDao.delete(id);
	}
	

}
