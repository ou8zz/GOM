package com.sqe.gom.app;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.ApplyState;
import com.sqe.gom.constant.ApprovalStatus;
import com.sqe.gom.constant.AssetState;
import com.sqe.gom.constant.AssetType;
import com.sqe.gom.constant.Attendance;
import com.sqe.gom.constant.CensusType;
import com.sqe.gom.constant.DocumentsType;
import com.sqe.gom.constant.DateRange;
import com.sqe.gom.constant.GenderType;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.constant.LeaveType;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.ProjectType;
import com.sqe.gom.constant.ResourceType;
import com.sqe.gom.constant.TaskType;
import com.sqe.gom.constant.TrainingType;
import com.sqe.gom.constant.UnfinishedType;
import com.sqe.gom.constant.WorkingHoursType;
import com.sqe.gom.dao.AssetDAO;
import com.sqe.gom.dao.BorrowDAO;
import com.sqe.gom.dao.ExperienceDAO;
import com.sqe.gom.dao.FixedTaskDAO;
import com.sqe.gom.dao.LeaveDAO;
import com.sqe.gom.dao.LoginDAO;
import com.sqe.gom.dao.MeetingDAO;
import com.sqe.gom.dao.ProjectDAO;
import com.sqe.gom.dao.ResourceDAO;
import com.sqe.gom.dao.ResponsibilityDAO;
import com.sqe.gom.dao.TaskDAO;
import com.sqe.gom.dao.TrainingDAO;
import com.sqe.gom.dao.UserDAO;
import com.sqe.gom.dao.UserRespDAO;
import com.sqe.gom.model.Asset;
import com.sqe.gom.model.Borrow;
import com.sqe.gom.model.Config;
import com.sqe.gom.model.Experience;
import com.sqe.gom.model.FixedTask;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Leave;
import com.sqe.gom.model.Login;
import com.sqe.gom.model.Meeting;
import com.sqe.gom.model.Project;
import com.sqe.gom.model.Responsibility;
import com.sqe.gom.model.Task;
import com.sqe.gom.model.Training;
import com.sqe.gom.model.UserResp;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.vo.UserGroup;

@Ignore
public class GomQueryServiceTest extends BaseTest {
	protected static Log log = LogFactory.getLog(GomQueryServiceTest.class);
	private GomQueryService gomQueryService;
	
	@Resource(name="gomQueryService")
	public void setReportService(GomQueryService gomQueryService) {
		this.gomQueryService = gomQueryService;
	}
	
	@Autowired
	private UserDAO userDao;
	@Autowired
	private ProjectDAO projectDao;
	@Autowired
	private TaskDAO taskDao;
	@Autowired
	private FixedTaskDAO fixedTaskDao;
	@Autowired
	private LoginDAO loginDao;
	@Autowired
	private ResponsibilityDAO responDao;
	@Autowired
	private UserRespDAO urDao;
	@Autowired
	private AssetDAO assetDao;
	@Autowired
	private BorrowDAO borrowDao;
	@Autowired
	private TrainingDAO trainingDao;
	@Autowired
	private ResourceDAO resourceDao;
	@Autowired
	private ExperienceDAO experienceDao;
	@Autowired
	private LeaveDAO leaveDao;
	@Autowired
	private MeetingDAO meetingDao;
	
	private GomUser james, ole;
	private Project p, p1, p2, p3, p4;
	private Responsibility r;
	private UserResp ru;
	private Task task, task2;
	private FixedTask fixedTask;
	private Login login, login1, login2;
	private Asset asset;
	private Borrow borrow;
	private Training training;
	private com.sqe.gom.model.Resource resource, resource2;
	private Experience experience, how;
	private Leave leave, leave1;
	private Config config;
	private Meeting meeting;
	
	@Before
	public void insertData() {
		//User
		james = new GomUser();
		james.setActive(false);
		james.setLock(false);
		james.setCname("张老师");
		james.setEname("james");
		james.setPwd("905dcb52b6585ac391ffcf8162cd6c99");
		james.setCell("13689748523");
		james.setEmail("sqe_james@sqeservice.com");
		james.setJobNo("SQE1201");
		james.setBirthday(DateUtil.parseDate("1987-08-16"));
		james.setCensusType(CensusType.COUNTRYSIDE);
		james.setEntryDate(new Date());
		james.setGender(GenderType.F);
		james.setNation("汉");
		james.setDocuments(DocumentsType.PIDCard);
		james.setIdcard("350821198703162587");
		james.setAccountNo("6221662160161458895");
		james.setBank("上海兴业银行股份有限公司上海普陀支行");
		
		GomGroup dep = createDepGroup();
		GomGroup emp = createEmpGroup();
		james.getGroups().add(dep);
		james.getGroups().add(emp);
		
		ole = new GomUser();
		ole.setActive(false);
		ole.setLock(false);
		ole.setCname("小明");
		ole.setEname("ole");
		ole.setPwd("905dcb52b6585ac391ffcf8162cd6c99");
		ole.setCell("13689343525");
		ole.setEmail("sqe_ole@sqeservice.com");
		ole.setJobNo("SQE1202");
		ole.setBirthday(DateUtil.parseDate("1987-10-16"));
		ole.setCensusType(CensusType.COUNTRYSIDE);
		ole.setEntryDate(DateUtil.parseDate("2012-10-11"));
		ole.setExitDate(DateUtil.parseDate("1987-10-30"));
		ole.setGender(GenderType.F);
		ole.setDocuments(DocumentsType.PIDCard);
		ole.setIdcard("350821198703162587");
		ole.setNation("汉");
		ole.setAccountNo("6221662160161458895");
		ole.setBank("上海兴业银行股份有限公司上海普陀支行");
		ole.getGroups().add(dep);
		ole.getGroups().add(emp);
		
		
		//Project
		p = new Project();
		p.setProjectName("GOM系统");
		p.setProjectNo("0001");
		p.setVersion("V1.0");
		p.setType(ProjectType.Project);
		p.setDirector("james");
		p.setStartDate(DateUtil.parseDate("2012-09-01"));
		p.setState(ProcessStatus.InProgress);
		p.setExpectedTime("290");
		p.setEndDate(DateUtil.parseDate("2012-09-30"));
		
		p1 = new Project();
		p1.setProjectName("GOM登录模块");
		p1.setProjectNo("0011");
		p1.setVersion("V1.0");
		p1.setType(ProjectType.Module);
		p1.setDirector("james");
		p1.setStartDate(DateUtil.parseDate("2012-09-01"));
		p1.setState(ProcessStatus.Completed);
		p1.setExpectedTime("45");
		p1.setEndDate(DateUtil.parseDate("2012-09-04"));
		p1.setParent(p);
		
		p2 = new Project();
		p2.setProjectName("GOM请假模块");
		p2.setProjectNo("0012");
		p2.setVersion("V1.0");
		p2.setType(ProjectType.Module);
		p2.setDirector("james");
		p2.setStartDate(DateUtil.parseDate("2012-09-05"));
		p2.setState(ProcessStatus.InProgress);
		p2.setExpectedTime("34");
		p2.setEndDate(DateUtil.parseDate("2012-09-07"));
		p2.setParent(p);
		
		p3 = new Project();
		p3.setProjectName("GOM工作安排模块");
		p3.setProjectNo("0013");
		p3.setVersion("V1.0");
		p3.setType(ProjectType.Module);
		p3.setDirector("james");
		p3.setStartDate(DateUtil.parseDate("2012-09-08"));
		p3.setState(ProcessStatus.InProgress);
		p3.setExpectedTime("90");
		p3.setEndDate(DateUtil.parseDate("2012-09-13"));
		p3.setParent(p);
		
		p4 = new Project();
		p4.setProjectName("GOM离职模块");
		p4.setProjectNo("0014");
		p4.setVersion("V1.0");
		p4.setType(ProjectType.Module);
		p4.setDirector("james");
		p4.setStartDate(DateUtil.parseDate("2012-09-14"));
		p4.setState(ProcessStatus.InProgress);
		p4.setExpectedTime("43");
		p4.setEndDate(DateUtil.parseDate("2012-09-18"));
		p4.setParent(p);
		
		
		//Responsibility
		r = new Responsibility();
		r.setName("编码开发");
		r.setFuncode("F1_0");
		r.setExplanation("功能的代码编写实现");
		
		//Responsibility 关联 user
		ru = new UserResp();
		ru.setUser(ole);
		ru.setExpected(20);
		ru.setNode("1");
		ru.setRespon(r);
		
		//FixedTask
		fixedTask = new FixedTask();
		fixedTask.setCreateDate(DateUtil.previous(7));
		fixedTask.setFrequency(DateRange.DAY);
		fixedTask.setPeriod((short)1);
		fixedTask.setState(ProcessStatus.InProgress);
		fixedTask.setHours(1F);
		fixedTask.setExpectedStart(DateUtil.previous(7));
		fixedTask.setExpectedEnd(DateUtil.previous(5));
		fixedTask.setTaskTitle("每日要打扫公司");
		fixedTask.setDescribe("打扫公司干净！");
		
		//Task
		task = new Task();
		task.setCreateDate(DateUtil.previous(7));
		task.setAssignor(james.getEname());
		task.setExecutor(ole.getEname());
		task.setState(ProcessStatus.InProgress);
		task.setExpectedStart(DateUtil.previous(7));
		task.setExpectedEnd(DateUtil.previous(5));
		task.setExpectedHours(24f);
		task.setActualStart(DateUtil.previous(6));
		task.setActualEnd(DateUtil.previous(4));
		task.setActualHours(25f);
		task.setTaskTitle("Gom登录");
		task.setDescribe("Gom登录工作");
		task.setDelay("延误工作原因");
		task.setTaskType(TaskType.PLAN);
		task.setProject(p);
		task.setResponsibility(r);
		
		//Task2
		task2 = new Task();
		task2.setCreateDate(DateUtil.previous(7));
		task2.setAssignor(james.getEname());
		task2.setExecutor(ole.getEname());
		task2.setState(ProcessStatus.InProgress);
		task2.setExpectedStart(DateUtil.previous(7));
		task2.setExpectedEnd(DateUtil.previous(5));
		task2.setExpectedHours(1f);
		task2.setActualStart(DateUtil.previous(8));
		task2.setActualEnd(DateUtil.previous(6));
		task2.setActualHours(1f);
		task2.setTaskTitle("固定打扫");
		task2.setDescribe("打扫公司干净");
		task2.setDelay("延误工作原因2");
		task2.setTaskType(TaskType.REGULAR);
		task2.setResponsibility(r);
		task2.setFixed(fixedTask);
		
		//Login
		login = new Login();
		login.setLoginIP("127.0.0.0");
		login.setLoginTake("08:26,09:20,13:56");
		Calendar c = Calendar.getInstance();
		c.set(Calendar.MINUTE, 27);
		login.setLoginTime(c.getTime());
		c.set(Calendar.HOUR_OF_DAY, 17);
		c.set(Calendar.MINUTE, 32);
		login.setLoginOut(c.getTime());
		login.setUser(ole);
		
		login1 = new Login();
		login1.setLoginIP("127.0.0.0");
		login1.setLoginTake("08:31,09:50,14:56");
		c.set(Calendar.DAY_OF_MONTH, c.get(Calendar.DAY_OF_MONTH)-1);
		c.set(Calendar.HOUR_OF_DAY, 8);
		c.set(Calendar.MINUTE, 31);
		login1.setLoginTime(c.getTime());
		c.set(Calendar.HOUR_OF_DAY, 17);
		c.set(Calendar.MINUTE, 34);
		login1.setLoginOut(c.getTime());
		login1.setUser(ole);
		
		login2 = new Login();
		login2.setLoginIP("127.0.0.0");
		login2.setLoginTake("08:24,08:59,16:56");
		c.set(Calendar.DAY_OF_MONTH, c.get(Calendar.DAY_OF_MONTH)-1);
		c.set(Calendar.HOUR_OF_DAY, 8);
		c.set(Calendar.MINUTE, 24);
		login2.setLoginTime(c.getTime());
		c.set(Calendar.HOUR_OF_DAY, 17);
		c.set(Calendar.MINUTE, 20);
		login2.setLoginOut(c.getTime());
		login2.setUser(ole);
		
		//Asset
		asset = new Asset();
		asset.setAdmin("Roger");
		asset.setAssetName("hp笔记本");
		asset.setAscription("IT部");
		asset.setAssetState(AssetState.AVAILABLE);
		asset.setAssetType(AssetType.COMPUTER);
		asset.setBuyDate(DateUtil.parseDate("2012-01-05"));
		asset.setBuyer("Roger");
		asset.setBuyNum(1);
		asset.setControlDate(DateUtil.parseDate("2012-01-05"));
		asset.setDes("hp笔记本，可以使用");
		asset.setUnit("台");
		asset.setWarrantyDate(DateUtil.parseDate("2015-01-05"));
		
		//Borrow
		borrow = new Borrow();
		borrow.setFunCode("FCode_15");
		borrow.setApplyState(ApplyState.AGREE);
		borrow.setAsset(asset);
		borrow.setReceiveNum(1);
		borrow.setReceiver(ole.getEname());
		borrow.setReceiveDate(DateUtil.parseDate("2012-09-30"));
		borrow.setReturnDate(DateUtil.parseDate("2012-10-30"));
		borrow.setRemark("ole借用30天");
		borrow.setOverStaff(james.getEname());
		
		//Training
		training = new Training();
		training.setLecturer("Roger");
		training.setQualification("高级");
		training.setTprogram("gom功能讲解");
		training.setStartDate(DateUtil.previous(5));
		training.setEndDate(DateUtil.previous(4));
		training.setTcontent("gom使用和功能介绍");
		training.setFee(11.5);
		training.setOtherFee(10.0);
		training.setTrainingTime(12.5f);
		training.setTrainingType(TrainingType.SELF_TRAINING);
		
		//Resource
		resource = new com.sqe.gom.model.Resource();
		resource.setCreateDate(new Date());
		resource.setNumber("v-001");
		resource.setVersion("v1.0");
		resource.setResourceType(ResourceType.EXPERIENCE);
		resource.setIsValid(true);
		resource.setTitle("工作文件");
		resource.setAttachment("attachment");
		resource.setUploadEname(ole.getEname());
		resource.setMaintainDpt("IT部门");
		resource.setDes("文件");
		
		resource2 = new com.sqe.gom.model.Resource();
		resource2.setCreateDate(new Date());
		resource2.setResourceType(ResourceType.HOW);
		resource2.setNumber("v-002");
		resource2.setVersion("v1.0");
		resource2.setIsValid(true);
		resource2.setTitle("工作文件");
		resource2.setAttachment("attachment");
		resource2.setUploadEname(ole.getEname());
		resource2.setMaintainDpt("IT部门");
		resource2.setDes("文件");
		
		//Experience
		experience = new Experience();
		experience.setCreateDate(DateUtil.parseDate("2012-10-05"));
		experience.setTraining(training);
		experience.setResource(resource2);
		experience.setStudent(ole.getEname());
		experience.setGain("我的培训心得：合理的使用gom，每天登录gom");
		
		//How
		how = new Experience();
		how.setCreateDate(DateUtil.parseDate("2012-10-05"));
		how.setResource(resource);
		experience.setResource(resource2);
		how.setStudent(ole.getEname());
		how.setGain("工作如何做：登录gom时需要发送邮件到邮箱收到验证码，然后根据邮箱收到的验证码登录！");
		
		//Leave
		leave = new Leave();
		leave.setId(1);
		leave.setAgent("Sherry");
		leave.setAgentDpt("IT部门");
		leave.setAgentJobNo("SQE1125");
		leave.setAgentPst("职员");
		leave.setApproval(ApprovalStatus.AGREE);
		leave.setAgentCname("肖小霞");
		leave.setRecipient("wendy");
		leave.setApplyDate(DateUtil.previous(1));
		leave.setDays((short)3);
		leave.setStartDate(DateUtil.previous(1));
		leave.setEndDate(DateUtil.previous(-1));
		leave.setEvent("因为什么事情");
		leave.setHandOver("所要交接的工作如下");
		leave.setType(LeaveType.CASUAL);
		leave.setContact("假期联系方式 021-56238596");
		leave.setState(ProcessStatus.Reserved);
		leave.setUser(ole);
		
		//Leave1
		leave1 = new Leave();
		leave1.setId(1);
		leave1.setAgent("Wendy");
		leave1.setAgentDpt("财物部门");
		leave1.setAgentJobNo("SQE1125");
		leave1.setAgentPst("职员");
		leave1.setApproval(ApprovalStatus.AGREE);
		leave1.setAgentCname("李先生");
		leave1.setRecipient("wendy");
		leave1.setApplyDate(DateUtil.previous(1));
		leave1.setDays((short)1);
		leave1.setStartDate(DateUtil.previous(1));
		leave1.setEndDate(DateUtil.previous(0));
		leave1.setEvent("我上次工作调休");
		leave1.setHandOver("所要交接的工作如下");
		leave1.setType(LeaveType.LEAVE_IN_LIEU);
		leave1.setContact("假期联系方式 021-56238596");
		leave1.setState(ProcessStatus.Reserved);
		leave1.setUser(ole);
		
		config = new Config();
		config.setGroup("basis");
		config.setKey("version");
		config.setValue("3.0");
		config.setName("系统版本");
		
		meeting = new Meeting();
		meeting.setNumber("No-001");
		meeting.setTitle("会议主题");
		meeting.setTime(DateUtil.previous(1));
		meeting.setHost("sherry");
		meeting.setNotes("sherry");
		meeting.setLocale("办公室");
		meeting.setContent("内容");
		meeting.setExplain("说明");
		meeting.setParticipants("james, sqe_ole, sherry");
		meeting.setIsTrace(false);
	}
	
	//根据用户部门或职务查询多个用户团体
	@Test
	public void testUsers() {
		userDao.create(ole);
		
		List<UserGroup> list = gomQueryService.getUsers(GroupType.DEPARTMENT, "Develop");
		assertEquals(list.size(), 1);
		assertEquals(list.get(0).getDepartment(), "Develop");
	}
	
	//所有2012-01-01至今 ole所有工作
	@Test
	public void testTasks() {
		projectDao.create(p);
		responDao.create(r);
		taskDao.create(task);
		
		fixedTaskDao.create(fixedTask);
		taskDao.create(task2);
		
		List<Task> list = gomQueryService.getTasks(ole.getEname(), false, null, null, null, DateUtil.parseDate("2012-01-01"), new Date(), null);
		assertEquals(list.size(), 2);
		assertNotNull(list.get(0).getTaskTitle());
		assertEquals(list.get(0).getTaskTitle(), "Gom登录");
		assertEquals(list.get(0).getDelay(), "延误工作原因");
	}
	
	//查询 2012-01-01至今 ole固定工作（每日要做内容）
	@Test
	public void testFixedTask() {
		fixedTaskDao.create(fixedTask);
		projectDao.create(p);
		responDao.create(r);
		taskDao.create(task);
		taskDao.create(task2);
		
		List<Task> list = gomQueryService.getTasks(ole.getEname(), false, null, null, DateRange.DAY, DateUtil.parseDate("2012-01-01"), new Date(), null);
		assertEquals(list.size(), 1);
		assertNotNull(list.get(0).getTaskTitle());
		assertEquals(list.get(0).getTaskTitle(), "固定打扫");
	}
	
	//项目和子模块
	@Test
	public void testProjects() {
		projectDao.create(p);
		projectDao.create(p1);
		projectDao.create(p2);
		projectDao.create(p3);
		projectDao.create(p4);
		
		//所有项目和子模块数
		List<Project> list = gomQueryService.getProjects(false, null, null, null, null);
		assertEquals(list.size(), 5);
		assertNotNull(list.get(0).getProjectName());
		assertNotNull(list.get(1).getProjectName());
		assertNotNull(list.get(2).getProjectName());
		assertNotNull(list.get(3).getProjectName());
		assertNotNull(list.get(4).getProjectName());
		
		//所有正在进行的模块
		List<Project> list1 = gomQueryService.getProjects(false, null, ProcessStatus.InProgress, null, null);
		assertEquals(list1.size(), 4);
		assertNotNull(list1.get(0).getProjectName());
		assertNotNull(list1.get(1).getProjectName());
		assertNotNull(list1.get(2).getProjectName());
		assertNotNull(list1.get(3).getProjectName());
		
		//所有完成的模块数
		List<Project> list2 = gomQueryService.getProjects(false, null, ProcessStatus.Completed, null, null);
		assertEquals(list2.size(), 1);
		assertNotNull(list2.get(0).getProjectName());
		
		//父项目“GOM”子模块数
		List<Project> list3 = gomQueryService.getProjects(false, p.getId(), null, null, null);
		assertEquals(list3.size(), 4);
		assertNotNull(list3.get(0).getProjectName());
		assertNotNull(list3.get(1).getProjectName());
		assertNotNull(list3.get(2).getProjectName());
		assertNotNull(list3.get(3).getProjectName());
		
		//所有3个月前的模块数
		List<Project> list4 = gomQueryService.getProjects(false, null, null, DateUtil.parseDate("2012-09-01"), DateUtil.parseDate("2012-09-30"));
		assertEquals(list4.size(), 5);
		assertNotNull(list4.get(0).getProjectName());
		assertNotNull(list4.get(1).getProjectName());
		assertNotNull(list4.get(2).getProjectName());
		assertNotNull(list4.get(3).getProjectName());
		assertNotNull(list4.get(4).getProjectName());
	}
	
	//培训列表
	@Test
	public void testTrainings() {
		trainingDao.create(training);
		
		List<Training> list = gomQueryService.getTrainings(DateUtil.previous(7), new Date());
		assertEquals(1, list.size());
		Training training = list.get(0);
		assertNotNull(training);
		assertEquals("Roger", training.getLecturer());
	}
	
	//资产列表
	@Test
	public void testAssets() {
		assetDao.create(asset);
		
		List<Asset> list = gomQueryService.getAssets(AssetType.COMPUTER, AssetState.AVAILABLE, DateUtil.parseDate("2012-01-01"), DateUtil.parseDate("2012-01-30"));
		assertEquals(list.size(), 1);
		assertNotNull(list.get(0).getAssetName());
		assertEquals(list.get(0).getAssetName(), "hp笔记本");
	}
	
	//所有ole用户所借资产
	@Test
	public void testBorrow() {
		assetDao.create(asset);
		borrowDao.create(borrow);
		
		List<Borrow> list = gomQueryService.getBorrows(ole.getEname(), null);
		assertEquals(list.size(), 1);
		assertNotNull(list.get(0).getReceiver());
	}
	
	//所有ole用户心得/如何做
	@Test
	public void testExperience() {
		trainingDao.create(training);
		resourceDao.create(resource2);
		experienceDao.create(experience);
		
		resourceDao.create(resource);
		experienceDao.create(how);
		
		//心得
		List<Experience> les = gomQueryService.getExperience(ResourceType.EXPERIENCE, ole.getEname(), null, null);
		assertEquals(les.size(), 1);
		assertNotNull(les.get(0).getStudent());
		assertEquals(ole.getEname(), les.get(0).getStudent());
		
		//如何做
		List<Experience> hows = gomQueryService.getExperience(ResourceType.HOW, ole.getEname(), null, null);
		assertEquals(hows.size(), 1);
		assertNotNull(hows.get(0).getStudent());
		assertEquals(ole.getEname(), hows.get(0).getStudent());
	}
	
	//ole用户责任管理
	@Test
	public void testResponsibility() {
		responDao.create(r);
		userDao.create(ole);
		urDao.create(ru);
		
		List<Responsibility> list = gomQueryService.getResponsibility(ole.getId());
		assertEquals(list.size(), 1);
		assertNotNull(list.get(0).getFuncode());
		assertEquals(list.get(0).getFuncode(), "F1_0");
	}
	
	//用户信息，包括部门 ，入职，离职日期
	@Test
	public void testEntryAndDepartureData() {
		userDao.create(james);
		userDao.create(ole);
		
		GomUser user = gomQueryService.getEntryAndDeptrueData(ole.getEname());
		assertNotNull(user);
		assertNotNull(ole.getCdepartment());
		assertEquals("ole", user.getEname());
		assertNotNull(user.getEntryDate());
		assertNotNull(user.getExitDate());
	}
	
	//ole登录时间
	@Test
	public void testLog() {
		userDao.create(ole);
		loginDao.create(login);
		
		Login l = gomQueryService.getLog(ole.getId(), 0);
		assertNotNull(l);
		assertNotNull(l.getLoginTime());
	}
	
	//ole近30天内登录次数统计
	@Test
	public void testLogs() {
		userDao.create(ole);
		loginDao.create(login);
		loginDao.create(login1);
		loginDao.create(login2);
		
		List<Login> list = gomQueryService.getLogs(ole.getId(), DateUtil.previous(30), new Date());
		assertFalse(list.isEmpty());
		assertNotNull(list.get(0).getLoginTime());
	}
	
	//ole两个月内迟到  / 早退 次数统计
	@Test
	public void testAttendance() {
		userDao.create(ole);
		loginDao.create(login);
		loginDao.create(login1);
		loginDao.create(login2);
		
		//迟到
		int i = gomQueryService.getAttendance(Attendance.ONDUTY, "8:30", ole.getId(), DateRange.MONTH, 2);
		assertEquals(i, 1);
		
		// 早退
		int j = gomQueryService.getAttendance(Attendance.OFFDUTY, "17:30", ole.getId(), DateRange.MONTH, 2);
		assertEquals(j, 1);
	}
		
	//ole近30天内请假天数
	@Test
	public void testLeaveInof() {
		userDao.create(ole);
		leaveDao.create(leave);
		
		int i = gomQueryService.getLeaveInof(ole.getId(), null, DateRange.DAY, 30);
		assertEquals(i, 3);
	}
	
	//ole近30天内补假天数
	@Test
	public void testLeaveLieu() {
		userDao.create(ole);
		leaveDao.create(leave1);
		
		int i = gomQueryService.getLeaveInof(ole.getId(), LeaveType.LEAVE_IN_LIEU, DateRange.DAY, 30);
		assertEquals(i, 1);
	}
	
	//ole在2012年内请假次数
	@Test
	public void testYearLeave() {
		userDao.create(ole);
		leaveDao.create(leave);
		
		List<Leave> list = gomQueryService.getYearLeave(ole.getId(), null, 2012, 2013);
		assertFalse(list.isEmpty());
		assertNotNull(list.get(0).getAgent());
	}
	
	//ole用户在7天内的工时
	@Test
	public void testWorkingHours() {
		userDao.create(ole);
		projectDao.create(p);
		responDao.create(r);
		fixedTaskDao.create(fixedTask);
		taskDao.create(task);
		taskDao.create(task2);
		
		//预计工时25小时
		int i = gomQueryService.getWorkingHours(WorkingHoursType.EXPECTED, ole.getEname(), DateRange.DAY, 7);
		assertEquals(i, 25);
		
		//实际工时25小时
		int j = gomQueryService.getWorkingHours(WorkingHoursType.ACTUAL, ole.getEname(), DateRange.DAY, 7);
		assertEquals(j, 25);
	}
	
	//工作或项目 未完成次数
	@Test
	public void testWorkingUnfinished() {
		userDao.create(ole);
		projectDao.create(p);
		projectDao.create(p1);
		responDao.create(r);
		fixedTaskDao.create(fixedTask);
		taskDao.create(task);
		taskDao.create(task2);
		
		//工作未完成次数
		int i = gomQueryService.getWorkingUnfinished(UnfinishedType.WORKTASK, ole.getEname(), DateRange.DAY, 7);
		assertEquals(i, 1);
		
		//项目未完成次数
		int j = gomQueryService.getWorkingUnfinished(UnfinishedType.PROJECT, james.getEname(), DateRange.YEAR, 2);
		assertEquals(j, 2);
	}
	
	//会议记录
	@Test
	public void testMeeting() {
		meetingDao.create(meeting);
		List<Meeting> list = gomQueryService.getMeetings(meeting.getHost(), DateUtil.previous(3), new Date());
		
		assertNotNull(list);
		assertEquals(list.size(), 1);
		assertEquals("办公室", list.get(0).getLocale());
	}
}