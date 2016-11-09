/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Random;
import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import com.sqe.gom.app.HolidaysService;
import com.sqe.gom.app.MailService;
import com.sqe.gom.app.SummaryService;
import com.sqe.gom.app.UserService;
import com.sqe.gom.constant.DateMarkType;
import com.sqe.gom.constant.DateRange;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.ItemType;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.dao.AbnormalDAO;
import com.sqe.gom.dao.AddressDAO;
import com.sqe.gom.dao.ConfigDAO;
import com.sqe.gom.dao.EducationDAO;
import com.sqe.gom.dao.GroupDAO;
import com.sqe.gom.dao.LoginDAO;
import com.sqe.gom.dao.SummaryDAO;
import com.sqe.gom.dao.SwotConfigDAO;
import com.sqe.gom.dao.UserDAO;
import com.sqe.gom.dao.ZtreeDAO;
import com.sqe.gom.exception.GomException;
import com.sqe.gom.model.Address;
import com.sqe.gom.model.Education;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Login;
import com.sqe.gom.model.Logs;
import com.sqe.gom.model.MailHeader;
import com.sqe.gom.model.Summary;
import com.sqe.gom.model.Ztree;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.Page;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.vo.UserGroup;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description detail information see interface please.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Sep 3, 2011, 4:00:13 PM
 * @version 3.0
 */
@Service("userService")
public class UserServiceImpl implements UserService {
	private Log log = LogFactory.getLog(UserServiceImpl.class);
	private GroupDAO groupDao;
	private UserDAO userDao;
	private ZtreeDAO ztreeDao;
	private AddressDAO addressDao;
	private EducationDAO eduDao;
	private AbnormalDAO abnormalDao;
	private LoginDAO loginDao;
	private ConfigDAO configDao;
	private MailService mailService;
	private SwotConfigDAO swotConfigDao;
	private SummaryDAO summaryDao;
	private SummaryService summaryService;
	private HolidaysService holidaysService;
	private HandlerState status = HandlerState.FAILED;
	
	@Resource(name="groupDao") public void setGroupDao(GroupDAO groupDao) {this.groupDao = groupDao;}
	@Resource(name="userDao") public void setUserDao(UserDAO userDao) {this.userDao = userDao;}
	@Resource(name="ztreeDao") public void setZtreeDao(ZtreeDAO ztreeDao) {this.ztreeDao = ztreeDao;}
	@Resource(name="addressDao") public void setAddressDao(AddressDAO addressDao) {this.addressDao = addressDao;}
	@Resource(name="educationDao") public void setEducationDao(EducationDAO eduDao) {this.eduDao = eduDao;}
	@Resource(name="loginDao") public void setLoginDao(LoginDAO loginDao) {this.loginDao = loginDao;}
	@Resource(name="abnormalDao") public void setAbnormalDao(AbnormalDAO abnormalDao) {this.abnormalDao = abnormalDao;}
	@Resource(name="configDao") public void setConfigDao(ConfigDAO configDao) {this.configDao = configDao;}
	@Resource(name="mailService") public void setMailService(MailService mailService) {this.mailService = mailService;}
	@Resource(name = "swotConfigDao") public void setSwotConfigDao(SwotConfigDAO swotConfigDao) {this.swotConfigDao = swotConfigDao;}
	@Resource(name = "summaryDao") public void setSummaryDao(SummaryDAO summaryDao) {this.summaryDao = summaryDao;}
	@Resource(name = "summaryService") public void setSummaryService(SummaryService summaryService) {this.summaryService = summaryService;}
	@Resource(name = "holidaysService") public void setHolidaysService(HolidaysService holidaysService) {this.holidaysService = holidaysService;}

	@Override
	public GomUser getUser(Integer userId) {
		return userDao.query(userId);
	}
	
	@Override
	public UserGroup getUser(String userName) {
		return userDao.getUser(userName);
	}

	@Override
	public GomUser saveUser(GomUser reg) {
		GomGroup position = groupDao.query(reg.getPstId());
		GomGroup department = groupDao.query(reg.getDptId());
		GomGroup role = groupDao.getGroup(new GomGroup(0, null, "User", GroupType.ROLE));
		reg.getGroups().add(position);
		reg.getGroups().add(department);
		reg.getGroups().add(role);
		
		if(RegexUtil.isEmpty(reg.getId()) || reg.getId() <= 0) {
			reg.setActive(false);
			reg.setLock(false);
			Integer maxJobNo = userDao.getMaxJobNo();
			String pre = configDao.getConfigValue("basis.jobNo.prefix") + String.valueOf(DateUtil.getField(Calendar.YEAR, null)).substring(2);
			if(RegexUtil.isEmpty(maxJobNo) || maxJobNo == 0) reg.setJobNo(pre + "001");
			else {
				maxJobNo++;
				if(maxJobNo < 10) pre += "00" + maxJobNo;
				else if(maxJobNo < 100) pre += "0" + maxJobNo;
				else pre += maxJobNo;
				reg.setJobNo(pre);
			}
		}
		
		userDao.create(reg);
		
		if(RegexUtil.notEmpty(reg.getId()) && reg.getId() > 0) {
			Logs lf = new Logs();
			lf.setLogger("用户资料创建成功");
			lf.setUserId(reg.getId());
			lf.setMessage(department.getCname() + "职务为" +position.getCname() + "的新入职员工"+reg.getCname()+"("+reg.getEname()+")");
			log.debug(JsonUtils.toJson(lf));
			return reg;
		}
		else {
			Logs lf = new Logs();
			lf.setLogger("用户资料创建失败");
			lf.setUserId(reg.getId());
			lf.setMessage(department.getCname() + "新入职用户 " + reg.getEname() + "入职资料创建失败");
			log.warn(JsonUtils.toJson(lf));
			return null;
		}
	}

	@Override
	public List<Address> getAddress(Integer uid, String ord) {
		return userDao.getAddress(uid, ord);
	}

	@Override
	public List<Education> getEducation(Integer uid, String ord) {
		return userDao.getEducation(uid, ord);
	}

	@Override
	public void saveEducation(int uid, List<Education> edus) {
		if(RegexUtil.notEmpty(uid) && uid > 0) {
			GomUser u = userDao.query(uid);
			for(Education edu : edus) {
				if(RegexUtil.isEmpty(edu.getId()) || edu.getId() == 0) {
					edu.setId(null);
					u.addEdu(edu);
				} else {
					edu.setUser(u);
					eduDao.update(edu);
				}
			}
			userDao.update(u);
		}
	}

	@Override
	public void updateEducation(Education edu) {
		eduDao.updateEdu(edu);
	}

	@Override
	public void saveAddress(Address a) {
		if(RegexUtil.notEmpty(a.getId()) && a.getId() > 0) {
			addressDao.updateAddr(a);
		} else {
			a.setId(null);
			GomUser u = userDao.query(a.getUid());
			u.addAddr(a);
			userDao.update(u);
		}
	}

	@Override
	public void saveAddress(List<Address> addrs, Integer userId) {
		if(RegexUtil.notEmpty(userId) && userId > 0) {
			GomUser u = userDao.query(userId);
			for(Address addr : addrs) {
				if(addr.getId() == 0){addr.setId(null);u.addAddr(addr);}
				else{addr.setUser(u); addressDao.update(addr);}
			}
			
			userDao.update(u);
		}
	}

	@Override
	public void updateUserAuthority(UserGroup u) {
		GomGroup gdpt = null;
		GomGroup gpst = null;
		GomGroup grole = null;
		GomUser user = userDao.query(u.getId());
		List<GomGroup> ls = groupDao.getGroups(u.getId());
		for(GomGroup gg : ls) {
			if(gg.getType().equals(GroupType.DEPARTMENT)) gdpt = gg;
			else if(gg.getType().equals(GroupType.POSITION)) gpst = gg;
			else if(gg.getType().equals(GroupType.ROLE)) grole = gg;
			
			if(RegexUtil.notEmpty(u.getDptId()) && gg.getType().equals(GroupType.DEPARTMENT) && !gg.getId().equals(u.getDptId())) {
				user.getGroups().remove(gg);
				GomGroup gd = groupDao.query(u.getDptId());
				user.getGroups().add(gd);
			}
			else if(RegexUtil.notEmpty(u.getPstId()) && gg.getType().equals(GroupType.POSITION) && !gg.getId().equals(u.getPstId())) {
				user.getGroups().remove(gg);
				GomGroup gp = groupDao.query(u.getPstId());
				user.getGroups().add(gp);
			}
			else if(RegexUtil.notEmpty(u.getRoleId()) && gg.getType().equals(GroupType.ROLE) && !gg.getId().equals(u.getRoleId())) {
				user.getGroups().remove(gg);
				GomGroup gr = groupDao.query(u.getRoleId());
				user.getGroups().add(gr);
			}
		}
		
		if(RegexUtil.isEmpty(gdpt) && RegexUtil.notEmpty(u.getDptId())) {
			GomGroup gd = groupDao.query(u.getDptId());
			user.getGroups().add(gd);
		}
		if(RegexUtil.isEmpty(gpst) && RegexUtil.notEmpty(u.getPstId())) {
			GomGroup gp = groupDao.query(u.getPstId());
			user.getGroups().add(gp);
		}
		if(RegexUtil.isEmpty(grole) && RegexUtil.notEmpty(u.getRoleId())) {
			GomGroup gr = groupDao.query(u.getRoleId());
			user.getGroups().add(gr);
		}
		userDao.update(user);
	}

	@Override
	public int updatePartUserInfor(GomUser user) {
		if(RegexUtil.notEmpty(user.isGeneric())) {
			//如果修改用户基础树菜单 ，在添加之前确保清空用户树里面所有基础树
			GomUser u = userDao.query(user.getId());
			List<Ztree> lzs = ztreeDao.getUserZtrees("", " AND u.id<>0 AND u.id=" + user.getId() + " AND z.id IN (SELECT z1.id FROM Ztree AS z1 LEFT JOIN z1.users AS u1 WHERE u1.id=0)");
			if(!lzs.isEmpty()) {
				u.getTrees().removeAll(lzs);
				userDao.update(u);
			}
		}
		return userDao.updateUser(user);
	}

	@Override
	public void delUser(int id) {
		userDao.delete(id);
	}

	@Override
	public UserGroup login(String name, String pwd) {
		return userDao.getLoginUser(name,pwd,true);
	}

	@Override
	public String[] chkLogLock(String name, String pwd) {
		String[] res = {"账户不存在，请核实后再登录", "0"};
		GomUser user = userDao.checkUser(name, null, false);
		if(RegexUtil.notEmpty(user)) {
			Login l = loginDao.getLog(user.getId(), 30);
			if(RegexUtil.notEmpty(l)) {
				userDao.updateUserLock(user.getId(), false);
				res[0] = "帐户已解锁，请再次登录";
			}else {
				//检查密码错误或帐户锁定
				GomUser gu = userDao.checkUser(name, pwd, false);
				if(RegexUtil.notEmpty(gu)) {res[0] = "帐户已锁定，或被注销，请联系管理员！"; res[1] = "5";}
				else res[0] = "帐户密码有误，请核实";
			}
		}
		
		return res;
	}

	@Override
	public void lockUser() {
		Login login = loginDao.getLog();
		if(RegexUtil.notEmpty(login)) {
			GomUser gu = login.getUser();
			if(!gu.isLock()) {
				gu.setLock(true);
				login.setUser(gu);
				login.setUnlockTime(DateUtil.forwardMin(30)); //后推半小时
				loginDao.update(login);
			}
		}
	}
	
	@Override
	public Boolean checkLoginAbnormal(Integer userId) {
		List<Integer> ids = loginDao.logAbnormal(userId);
		if(ids.isEmpty()) return true;
		
		Long i = abnormalDao.getAbnormal(userId, ProcessStatus.InProgress);
		if(i > 0) return true;
		return false;
	}
	
	@Override
	public HandlerState saveLogin(Login l) {
		Login login = loginDao.getLog(l.getUg().getId(), 0);
		if(RegexUtil.isEmpty(login)) {
			l.setUser(new GomUser(l.getUg().getId()));
			l.setLoginTime(new Date());
			if("admin".equals(l.getUg().getEname())) l.setReportMark(true);
			
			try {
				//检查是不是正常班或是补班
				boolean b = holidaysService.isHolidays(DateUtil.forMatDate());
				if(b) l.setDateMark(DateMarkType.MAKEUP);
				else l.setDateMark(DateMarkType.NORMAL);
			} catch (GomException e) {
				status = HandlerState.ERROR;
			}
			
			//每天的第一次登录发送good morning
			if(!l.getUg().getId().equals(3) && !l.getUg().getId().equals(1)) {	//不让James发早报，因为不知道邮箱密码，会发生登录不了  //不让管理员发送早报
				status = summaryService.sendMorningPaper(null, l.getUg());
			}
			loginDao.create(l);
			
			//记录迟到
			Calendar c = Calendar.getInstance();
			String[] lt = configDao.getConfigValue("basis.login.time").split(":");
			c.set(Calendar.HOUR_OF_DAY, Integer.parseInt(lt[0]));
			c.set(Calendar.MINUTE, Integer.parseInt(lt[1]));
			
			if(l.getLoginTime().after(c.getTime())) {
				Summary s = new Summary();
				s.setUser(new GomUser(l.getUg().getId()));
				s.setData(1f);
				s.setDated(new Date());
				s.setSwotConfig(swotConfigDao.getSwotConfig(ItemType.LATE, DateRange.DAY));
				summaryDao.create(s);
			}
		} else {
			String take = login.getLoginTake() + "," + l.getLoginTake();
			l.setLoginTake(take);
			l.setId(login.getId());
			l.setReportMark(login.getReportMark());
			if(login.getLoginIP().equals(l.getLoginIP())) l.setLoginIP(null);
			loginDao.save(l);
			status = HandlerState.SUCCESS;
		}
		return status;
	}

	@Override
	public void loginOut(UserGroup ug, String report) {
		StringBuilder logsb = new StringBuilder("");
		Login l = loginDao.getLog(ug.getId(), 0);
		if(RegexUtil.isEmpty(l)) return;
		
		//登出操作
		l.setLoginOut(new Date());
		loginDao.save(l);
		
		//发送报表登出
		if(RegexUtil.notEmpty(report) && !ug.getEname().equals("admin")) {
			//获得早退时间
			Calendar c = Calendar.getInstance();
			String[] lo = configDao.getConfigValue("basis.login.out").split(":");
			c.set(Calendar.HOUR_OF_DAY, Integer.parseInt(lo[0]));
			c.set(Calendar.MINUTE, Integer.parseInt(lo[1]));
			
			//如果退出时间正常消除异常
			if(new Date().after(c.getTime())) {
				l.setReportMark(true);
				logsb.append(" ，已经发送报表正常退出系统");
			} else logsb.append(" ，由于登出过早没有正常消除异常而被定为早退");
			loginDao.save(l);
			
			//记录早退
			if(new Date().before(c.getTime())) {
				Summary s = new Summary();
				s.setUser(new GomUser(ug.getId()));
				s.setData(1f);
				s.setDated(new Date());
				s.setSwotConfig(swotConfigDao.getSwotConfig(ItemType.EARLY, DateRange.DAY));
				summaryDao.create(s);
			}
			
			//发送报表
			summaryService.sendReport(ug);
		}
		
		//日志
		Logs lf = new Logs();
		lf.setDated(new Date());
		lf.setUserId(ug.getId());
		lf.setLogger("登出成功");
		lf.setMessage(ug.getEname() + " 于 " + DateUtil.forMatDate() + " 在IP： " + l.getLoginIP() +  " 登出 " + logsb.toString());
		log.debug(JsonUtils.toJson(lf));
	}
	
	
	@Override
	public boolean checkUser(String name) {
		GomUser user = userDao.checkUser(name, null, false);
		return (user == null || "".equals(user))? true:false;
	}

	@Override
	public boolean checkGroupIsNull(GomGroup g) {
		boolean tag;
		GomGroup gg = groupDao.getGroup(g);
		if(RegexUtil.notEmpty(gg)) {
			if(gg.getId().equals(g.getId()))tag = true;
			else tag = false;
		}
		else tag = true;
		return tag;
	}

	@Override
	public GomGroup loadGroup(Integer id) {
		return groupDao.query(id);
	}
	
	public GomGroup getGroup(GomGroup g) {
		return groupDao.getGroup(g);
	}

	@Override
	public List<GomGroup> getGroups(String order, String criteria, Page page, GroupType type) {
		return groupDao.getGroups(order, criteria, page, type);
	}
	
	@Override
	public List<UserGroup> getAgents(String groupName, GroupType type, String userName) {
		return userDao.getAgents(groupName,type, userName);
	}
	
	@Override
	public JGridBase<GomUser> getInactiveUser(String pre, boolean active, JGridHelper<GomUser> grid) {
		String od =" ORDER BY " + pre;
		if(RegexUtil.notEmpty(grid.getJq().getSidx())) od += grid.getJq().getSidx() + " " + grid.getJq().getSord();
		else od += "ename DESC";
		
		List<GomUser> ls = userDao.getInactiveUser(active, false, od, grid.getQ(), grid.getP());
		if(!ls.isEmpty()) {
			grid.getJq().setList(ls);
			grid.getJq().setRecords(grid.getP().getTotalCount());
			grid.getJq().setTotal(grid.getP().getPageCount());
		}
		
		return grid.getJq();
	}

	@Override
	public UserGroup getUserAndPosition(String position, String department) {
		return userDao.getUserByDepartAndPosit(position, department);
	}
	
	@Override
	public JGridBase<UserGroup> getUsers(boolean isRole, String dptId, String pstId, JGridHelper<UserGroup> grid) {
		List<UserGroup> list = Collections.emptyList();
		StringBuffer order = new StringBuffer(" ORDER BY d.cname");
		//order.append(grid.getJq().getSidx()).append(" ").append(grid.getJq().getSord());
		
		if(RegexUtil.notEmpty(dptId)) grid.setQ(" AND d.id = " + dptId);
		else if(RegexUtil.notEmpty(pstId)) grid.setQ(" AND p.id = " + pstId);
		
		if(isRole) list = userDao.getUsersConfig(order.toString(), grid.getQ(), grid.getP());
		else list = userDao.getUsers(order.toString(), false, grid.getQ(), grid.getP());
	
		grid.getJq().setList(list);
		grid.getJq().setRecords(grid.getP().getTotalCount());
		grid.getJq().setTotal(grid.getP().getPageCount());
		
		return grid.getJq();
	}
	
	@Override
	public List<UserGroup> getUsersByDpt(Integer dptId, Integer userId, GroupType groupType, boolean isMgr) {
		return userDao.getUsersByDpt(dptId, userId, groupType, isMgr);
	}

	@Override
	public List<GomGroup> getGroups(GroupType type, Page page) {
		return groupDao.getGroups(type, page);
	}

	@Override
	public boolean saveGroup(GomGroup g) {
		boolean b = false;
		if(checkGroupIsNull(g)) {
			if(RegexUtil.notEmpty(g.getId())) groupDao.update(g);
			else {groupDao.create(g); b = true;}
		}
		return b;
	}
	
	@Override
	public void removeGroup(Integer id) {
		groupDao.delete(id);
	}
	
	@Override
	public void sendValidateCode(String email, String text, HttpSession session) {
		StringBuilder code = new StringBuilder();
		Random r = new Random();
        for(int i = 0; i < 5; i++) {
        	int itmp = r.nextInt(26) + 65;
        	char ctmp = (char)itmp;
        	code.append(ctmp);
        }		

		MailHeader mh = new MailHeader();
		mh.setFrom(configDao.getConfigValue("basis.mail.user"));
		mh.setTo(new String[]{email});
		mh.setSubject(text);
		
		try {
			mailService.sendMail(null, mh, "  尊敬的用户，消息来自sqeservice GOM ！<br/>  您的验证码是：<strong>"+code+"</strong> <br/>  此验证码将在30分钟后失效;");
			session.setAttribute(SessionAttr.RANDCODE.name(), code.toString());
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void removeEdu(String[] id) {
		for(String i : id) {
			eduDao.delete(Integer.parseInt(i));
		}
	}
	
	@Override
	public void removeAddr(String[] id) {
		for(String i : id) {
			addressDao.delete(Integer.parseInt(i));
		}
	}
}