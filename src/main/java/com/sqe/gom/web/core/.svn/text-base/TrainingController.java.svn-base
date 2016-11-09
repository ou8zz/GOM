/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.TrainingService;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.model.Experience;
import com.sqe.gom.model.Training;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.ManagerWord;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.PageTag;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;
import com.sqe.gom.web.validation.TrainingValidator;

/**
 * @description Training entry report to submit information.
 * @author <a href="mailto:sqe_ole@126.com">OLE</a>
 * @date Aug 7, 2011  11:04:25 PM
 * @version 3.0
 */
@Controller
public class TrainingController {
	private Log log = LogFactory.getLog(TrainingController.class);
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private HandlerState str = HandlerState.FAILED;
	private TrainingService trainingService;
		
	@Autowired
	public void setTrainingService(TrainingService trainingService) {
		this.trainingService = trainingService;
	}
		
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(df,false));
	}	
		
	//培训主页面
	@RequestMapping(method = RequestMethod.GET, value = "/app/training.htm")
	public String trainingPage() { return "app/training"; }
	
	/**
	 * 前台培训展现方法
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/app/get_trainings.htm")
	public void getTrainings(HttpServletRequest req, HttpServletResponse res) {
		JGridHelper<Training> grid = new JGridHelper<Training>();
		grid.jgridHandler(req, res, "t.");
		try {
			out = res.getWriter();
			out.write(JsonUtils.toJson(trainingService.getTrainings(grid), new TypeToken<JGridBase<Training>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN,true));
		} catch (Exception e) {
			log.error("/app/get_trainings.htm have a error!", e);
		} finally {
			if (out != null) {out.flush();out.close();}
			grid = null;
		}
	}
			
	/**
	 * 心得体会汇总<分页显示>
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/app/harvest.htm")
	public String getExperiences(HttpServletRequest req, HttpServletResponse res, Model model) {
		Integer pageId = 1;
		String pid = req.getParameter("pageId");
		UserGroup ug = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		if(!RegexUtil.notEmpty(ug)) return "app/list_experience";
		if(RegexUtil.notEmpty(pid)) pageId = Integer.parseInt(pid);
		Page page = new Page(pageId,5);
		model.addAttribute("list", trainingService.getTrainingAndExperience(ug.getEname(), page));
		model.addAttribute("page", PageTag.getPageTag(page, pageId, req.getRequestURL()+"?pageId="));
		return "app/list_experience";
	}
	
	/**
	 * 下载心得成word格式文件
	 * @param startDate
	 * @param endDate
	 * @param req
	 * @param res
	 * @throws IOException
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/down_gain.htm")
	public void downloadGain(@RequestParam("sDate")String startDate,@RequestParam("eDate")String endDate,HttpServletRequest req, HttpServletResponse res) {
		UserGroup ug = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		String path = req.getSession().getServletContext().getRealPath("/uploads/doc/");
		try {
			List<Experience> list = trainingService.getGain(ug.getEname(), startDate, endDate);
			if(list.size() > 0) {
				String str = "";
				for(Experience ex : list) { str += ex.getGain()+"\n\n"; }
				if(RegexUtil.notEmpty(str)) {
					res.setContentType("application/msword");
					res.setHeader("Content-Disposition","attachment;filename = " + ug.getEname()+"心得.doc");
					String text = ManagerWord.formatText(req.getSession().getServletContext().getRealPath("/images/browse.jpg"), ug.getEname()+"心得", str, "V-1.0", new Date(), new Date(), ug.getEmail());
					String fileName = "/"+UUID.randomUUID().toString().replaceAll("-", "")+ ".doc";
					//先把数据写成一个word存起来
					ManagerWord.writerWord(path+fileName, text);
					//下载
					ManagerWord.downloadWrod(req, res, fileName);
			        //下载后删除在/doc的临时文件
			        ManagerWord.deleteWord(path+fileName);
				} else {
					res.setContentType("text/html;charset=UTF-8");
					res.setHeader("Cache-Control", "no-cache");
				}
			}
		} catch (Exception e) {
			log.error("down_gain.htm have a error!", e);
		} 
	}
	
	/**
	 * 前台培训<添加，编辑>
	 * @param training
	 * @param result
	 * @param req
	 * @param res
	 * @param model
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/save_training.htm")
	public void saveTraining(@ModelAttribute("training") Training training, BindingResult result, HttpServletRequest req, HttpServletResponse res){
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		UserGroup ug = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		try {
			out = res.getWriter();
			if(RegexUtil.isEmpty(training.getId())) {
				training.setLecturer(ug.getEname());
			}
			new TrainingValidator().validate(training, result);
			if(result.hasErrors()) {
				str = HandlerState.PARAM_EMPTY;
			} else {
				trainingService.saveTraining(training);
				str = HandlerState.SUCCESS;
				m.put("training", training);
			}
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));	
		} catch (IOException e) {
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			log.error("save_training.htm have a error!", e);
		}finally {
			m.clear();
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
	/**
	 * 心得<添加，编辑>
	 * @param training
	 * @param result
	 * @param req
	 * @param res
	 * @param model
	 */
	@RequestMapping(method=RequestMethod.POST, value="/app/save_experience.htm")
	public void saveExperince(@ModelAttribute("experience") Experience experience, BindingResult result, 
			HttpServletRequest req, HttpServletResponse res){
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		UserGroup ug = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		try {
			out = res.getWriter();
			experience.setStudent(ug.getEname());
			trainingService.saveExperienceAndToResource(experience, req.getSession().getServletContext().getRealPath("/images/browse.jpg"), req.getSession().getServletContext().getRealPath("/uploads/doc//"));
			m.put("g", experience.getGain());
			m.put("result", HandlerState.SUCCESS);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));	
		} catch (Exception e) {
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			log.error("save_experience.htm is error!", e);
			log.warn("心得:" + experience.getStudent() + " 的心得提交失败！", e);
		}finally {
			m.clear();
			if (out != null) {out.flush();out.close();}
		}
	}
		
	/**
	 * 删除培训记录
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/del_training.htm")
	public void delTrainings(@RequestParam("id")Integer id, HttpServletResponse res) {
		try {
			out = res.getWriter();
			trainingService.removeTraining(id);
			m.put("result", HandlerState.SUCCESS);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			log.debug("删除培训记录:培训记录号" + id + "删除成功！");
		} catch (Exception e) {
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			log.warn("删除培训记录:删除ID号为：" + id + "的操作失败了！", e);
		} finally {
			if (out != null) {out.flush();out.close();}
		}	
	}
	
}
