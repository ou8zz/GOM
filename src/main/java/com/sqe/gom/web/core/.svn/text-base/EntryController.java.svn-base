/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.ProcessService;
import com.sqe.gom.app.UserService;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.model.Address;
import com.sqe.gom.model.Education;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Logs;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;
import com.sqe.gom.web.validation.AddressValidator;
import com.sqe.gom.web.validation.EducationValidator;

/**
 * @description user entry report to submit information.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Feb 1, 2012  8:56:13 PM
 * @version 3.0
 */
@Controller
public class EntryController{
	private Log log = LogFactory.getLog(EntryController.class);
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	private HandlerState str = HandlerState.FAILED;
	private UserService userService;
	private ProcessService processService;
	
	@Resource(name="userService")
	public void setUserService(UserService userSerivce) {
		this.userService = userSerivce;
	}
	
	@Resource(name="processService")
	public void setProcessService(ProcessService processService) {
		this.processService = processService;
	}
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(df,false));
	}
	
	//入职审核页面
	@RequestMapping(method=RequestMethod.GET, value="/app/check_entrant.htm")
	public String entrantsPage(Model model) {
		model.addAttribute("entrant",new GomUser());
		return "app/entrants"; 
	}
	
	/**
	 * 进入管理员开通新员工账号页面
	 * @param model
	 * @return
	 */
	@PreAuthorize("hasRole('Technology') and hasRole('Manager') or hasRole('Director')")
	@RequestMapping(method=RequestMethod.GET, value="/app/set_mail.htm")
	public String setupAddMailForAdmin(Model model, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		model.addAttribute("entrant",new GomUser());
		return "app/entrant_mail";
	}
	
	/**
	 * 进入入职资料审核页面
	 * @param model
	 * @return
	 */
	@PreAuthorize("hasRole('User') and hasRole('Manager') or hasRole('Director') or hasRole('Assistant')")
	@RequestMapping(method=RequestMethod.GET, value="/app/entrants.htm")
	public String setupEntrant(Model model, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		model.addAttribute("entrant",new GomUser());
		model.addAttribute("departments", userService.getGroups(GroupType.DEPARTMENT, null));
		return "app/entrants";
	}
	
	/**
	 * 新职员职责分配
	 * @param model
	 * @return
	 */
	@PreAuthorize("hasRole('User') and hasRole('Manager') or hasRole('Director')")
	@RequestMapping(method=RequestMethod.GET, value="/app/assigned_respons.htm")
	public String entrantResponsibilities(Model model, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		model.addAttribute("entrant",new GomUser());
		return "app/responsibilities";
	}
	
	/**
	 * get list of inactive users
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/app/get_users.htm")
	public void getEntryUsers(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		JGridHelper<GomUser> grid = new JGridHelper<GomUser>();
		String pre = "u.";
		grid.jgridHandler(req, res, pre);
		UserGroup user = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());

		try {
			out = res.getWriter();
			
			if(RegexUtil.notEmpty(user)) {
				out.write(JsonUtils.toJson(processService.getEntrants(user.getEname(), grid), new TypeToken<JGridBase<GomUser>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN, true));
				out.flush();
				out.close();
			}
		} catch (Exception e) {
			log.error("get inactive users list have a error!", e);
		} finally {
			if(out != null){out.flush();out.close();}
			grid = null;
		}
	}
	
	/**
	 * get education or address list of user
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/app/get_user_edu.htm")
	public void getEduOrAddr(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		
		String uid = req.getParameter("id");
		String sidx = req.getParameter("sidx");
		String sord = req.getParameter("sord");
		String type = req.getParameter("t");
		String isgrid = req.getParameter("isgrid");
		
		boolean isjq;
		if(RegexUtil.notEmpty(isgrid)) isjq = Boolean.valueOf(isgrid);
		else isjq = false;
		
		if(RegexUtil.notEmpty(type)) {
			JGridBase<Education> edu = null;
			JGridBase<Address> adr = null;
			
			try {
				out = res.getWriter();
				String od =" ORDER BY p.";
				
				if(type.equals("EDU")) {
					edu = new JGridBase<Education>();
					if(RegexUtil.notEmpty(sidx)) {
						od += sidx + " " + sord;
						edu.setSidx(sidx);
						edu.setSord(sord);
					}else od += "startDate";
					
					if(RegexUtil.notEmpty(uid) && !uid.equals("undefined")){
						List<Education> ls = userService.getEducation(Integer.parseInt(uid), od);
						if(isjq) {
							edu.setList(ls);
							edu.setRecords(ls.size());
							edu.setTotal(1);
							edu.setRows(10);
							edu.setPage(1);
							out.write(JsonUtils.toJson(edu, new TypeToken<JGridBase<Education>>(){}.getType(),JsonUtils.SHORT_DATE_PATTERN,true));
						}else out.write(JsonUtils.toJson(ls, new TypeToken<List<Education>>(){}.getType(),JsonUtils.SHORT_DATE_PATTERN,true));
						
						out.flush();
						out.close();
					}
					
				}
				else if(type.equals("ADR")) {
					adr = new JGridBase<Address>();
					if(RegexUtil.notEmpty(sidx)) {
						od += sidx + " " + sord;
						adr.setSidx(sidx);
						adr.setSord(sord);
					}else od += "contact";
					
					if(RegexUtil.notEmpty(uid)){
						List<Address> ls = userService.getAddress(Integer.parseInt(uid), od);
						if(isjq) {
							adr.setList(ls);
							adr.setRecords(ls.size());
							adr.setTotal(1);
							adr.setRows(10);
							adr.setPage(1);
							out.write(JsonUtils.toJson(adr, new TypeToken<JGridBase<Address>>(){}.getType(),JsonUtils.SHORT_DATE_PATTERN,true));
						}else out.write(JsonUtils.toJson(ls, new TypeToken<List<Address>>(){}.getType(),JsonUtils.SHORT_DATE_PATTERN,true));
						
						out.flush();
						out.close();
					}
				}
			} catch (Exception e) {
				log.error("get education or address list of user have a error occurred!", e);
			} finally {
				if(out != null) {
					out.flush();
					out.close();
				}
			}
		}
	}
	
	/**
	 * get address list of user
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/get_user_addr.htm")
	public void saveUserAddress(@ModelAttribute("addr") Address addr, BindingResult result, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");

		Object[] str = new Object[2];
		try {
			out = res.getWriter();
			new AddressValidator().validate(addr, result);
			if(result.hasErrors()) {
				System.out.println(result.getAllErrors().toString());
				
				str[0] = false;
				str[1] = "所有字段均不能为空";
			}else {
				if(RegexUtil.notEmpty(addr.getUid())) {
					addr.setUser(new GomUser(addr.getUid()));
					userService.saveAddress(addr);
					str[0] = true;
					str[1] = "更新成功";
					
					Logs lf = new Logs();
					lf.setLogger("新增地址");
					lf.setDated(new Date());
					lf.setUserId(addr.getUid());
					lf.setMessage(addr.getAddrType().getDes()+":" + addr.getAddress()+",联系人："+addr.getContact()+",联系电话：" + addr.getCell());
					log.debug(JsonUtils.toJson(lf));
				}
			}
			out.write(str[0] +  "," + str[1]);
		}catch(Exception e) {
			log.error("get address list of user have a error occurred!", e);
			str[0] = false;
			str[1] = "更新时发生错误";
			out.write(str[0] +  "," + str[1]);
		} finally {
			str = null;
			if(out != null) {out.flush();out.close();}
		}
	}
	
	/**
	 * save user education information
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/save_user_edu.htm")
	public void saveUserEducate(@ModelAttribute("edu") Education edu, BindingResult result, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		Logs lf = new Logs();
		lf.setDated(new Date());
		
		try {
			out = res.getWriter();
			m.clear();
			
			new EducationValidator().validate(edu, result);
			if(result.hasErrors()) {
				m.put("result", HandlerState.PARAM_EMPTY);
			}else {
				if(RegexUtil.notEmpty(edu.getUid())) {
					if(RegexUtil.isEmpty(edu.getId())) {
						List<Education> edus = new ArrayList<Education>();
						edus.add(edu);
						userService.saveEducation(edu.getUid(), edus);
						m.put("result", HandlerState.SUCCESS);
						
						lf.setUserId(edu.getUid());
						lf.setLogger("新增教育经历");
						lf.setMessage("学历 " + edu.getEd() + " 于 " + DateUtil.formatDate(edu.getStartDate()) + "至" +DateUtil.formatDate(edu.getEndDate()) + " 就读于 " + edu.getSchool() + edu.getMajor() + " 专业 ");
						log.debug(JsonUtils.toJson(lf));
					}else {
						edu.setUser(new GomUser(edu.getUid()));
						userService.updateEducation(edu);
						m.put("result", HandlerState.SUCCESS);
						
						lf.setUserId(edu.getUid());
						lf.setLogger("编辑教育经历");
						lf.setMessage("您于 "+ DateUtil.forMatDate() + " 编辑学历 " + edu.getEd() + edu.getSchool() + edu.getMajor() + " 专业 ");
						log.debug(JsonUtils.toJson(lf));
					}
				}else m.put("result", HandlerState.PARAM_EMPTY);
			}
			
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String, Object>>(){}.getType()));
		}catch(Exception e) {
			log.error("get address list of user have a error occurred!", e);
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String, Object>>(){}.getType()));
		} finally {
			m.clear();
			if(out != null) {out.flush();out.close();}
		}
	}
	
	/**
	 * 入职流程审核
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/app/edit_entrant.htm")
	public void updateEntrant(@ModelAttribute("user") GomUser user, BindingResult result,HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		Logs lf = new Logs();
		lf.setDated(new Date());
		try {
			out = res.getWriter();
			UserGroup loginUser = (UserGroup)req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
			
			if(RegexUtil.isEmpty(user.getNodeCode()) || RegexUtil.isEmpty(user.getNodeOrder()) || RegexUtil.isEmpty(user.getId()) || RegexUtil.isEmpty(user.getTraceId()) || RegexUtil.isEmpty(user.getApproval()) || RegexUtil.isEmpty(loginUser)) {
				str = HandlerState.PARAM_EMPTY;
			}else {
				if(user.getNodeCode().equals("Personnel")) {
					if(RegexUtil.isEmpty(user.getEntryDate()) || RegexUtil.isEmpty(user.getFullDate()) || RegexUtil.isEmpty(user.getType()) || RegexUtil.isEmpty(user.getBank()) || RegexUtil.isEmpty(user.getAccountNo())|| RegexUtil.isEmpty(user.getCensusType()) || RegexUtil.isEmpty(user.getIdcard())) m.put("result", HandlerState.PARAM_EMPTY);
					else str = processService.updateEntrant(user, loginUser);
					
					//日志
					lf.setUserId(loginUser.getId());
					lf.setLogger("人事审核");
					if(HandlerState.SUCCESS.equals(str)) {
						lf.setMessage("人事管理员已为新用户 (" + user.getEname() + ") 分配正式入职日期"+ DateUtil.formatDate(user.getEntryDate()) +" 被分配为 "+user.getType().getDes()+"，请等待下一流程审核。");
						log.debug(JsonUtils.toJson(lf));
					} else {
						lf.setMessage("用户 (" + user.getEname() + ")的入职人事审核流程出错已经中止 ");
						log.warn(JsonUtils.toJson(lf));
					}
					
				}
				else if(user.getNodeCode().equals("Technology")){
					if(RegexUtil.isEmpty(user.getTelExt())|| RegexUtil.isEmpty(user.getEmail())|| RegexUtil.isEmpty(user.getEmailPwd())|| !user.isActive() || !user.isLock()) m.put("result", HandlerState.PARAM_EMPTY);
					else str = processService.updateEntrant(user, loginUser);	
				
					//日志
					lf.setUserId(loginUser.getId());
					lf.setLogger("开通账号");
					if(HandlerState.SUCCESS.equals(str)) {
						lf.setMessage("IT管理员已经开通 (" + user.getEname() + ") 账号，分配新的公司邮箱 " + user.getEmail() + "，请等待下一流程审核。");
						log.debug(JsonUtils.toJson(lf));
					} else {
						lf.setMessage("用户 (" + user.getEname() + ")的入职开通账号流程出错已经中止 ");
						log.warn(JsonUtils.toJson(lf));
					}
					
				}
				else {
					str = processService.updateEntrant(user, loginUser);
					
					//日志
					lf.setUserId(loginUser.getId());
					lf.setLogger("入职审核");
					if(HandlerState.SUCCESS.equals(str)) {
						lf.setMessage("用户 (" + user.getEname() + ")于 " + DateUtil.formatDate(user.getEntryDate()) + " 入职工号 " + user.getJobNo() + " 分配就续 ,流程已进行下一节点");
						log.debug(JsonUtils.toJson(lf));
					} else {
						lf.setMessage("用户 (" + user.getEname() + ")的入职流程出错已经中止 ");
						log.warn(JsonUtils.toJson(lf));
					}
				}
			}
			
			
		} catch (IOException ex) {
			log.error("HR approval entry user occurred get write error", ex);
			str = HandlerState.ERROR;
		}finally {
			m.put("result", str);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			m.clear();
			if(out != null) {out.flush();out.close();}
		}
	}
}
