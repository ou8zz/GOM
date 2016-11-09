package com.sqe.gom;

import java.util.Date;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.SessionFactory;
import org.junit.Ignore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import com.sqe.gom.constant.CensusType;
import com.sqe.gom.constant.DocumentsType;
import com.sqe.gom.constant.GenderType;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.dao.GroupDAO;
import com.sqe.gom.dao.UserDAO;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.util.DateUtil;

@Ignore
@ContextConfiguration(locations={"classpath:gom-service-test.xml"})
public abstract class BaseTest extends AbstractTransactionalJUnit4SpringContextTests{
	protected static Log log = LogFactory.getLog(BaseTest.class);
	private SessionFactory sessionFactory;
	@Autowired
	private GroupDAO groupDao;
	
	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	public void commintAndBeginNew() {
		sessionFactory.getCurrentSession().flush();
		sessionFactory.openSession().beginTransaction();
	}
	
	public GomUser createUser(UserDAO userDao) {
		GomUser user = new GomUser();
		user.setActive(false);
		user.setLock(false);
		user.setCname("测试员");
		user.setEname("test");
		user.setPwd("1234556");
		user.setCell("13689748523");
		user.setEmail("test@sqeservice.com");
		user.setJobNo("SQE1201");
		user.setBirthday(DateUtil.parseDate("1987-08-16"));
		user.setCensusType(CensusType.COUNTRYSIDE);
		user.setEntryDate(new Date());
		user.setDocuments(DocumentsType.PASSPORT);
		user.setGender(GenderType.F);
		user.setIdcard("350821198703162587");
		user.setNation("汉");
		user.setAccountNo("6221662160161458895");
		user.setBank("上海兴业银行股份有限公司上海普陀支行");
		
		GomGroup dep = createDepGroup();
		GomGroup emp = createEmpGroup();
		user.getGroups().add(dep);
		user.getGroups().add(emp);
		
		userDao.create(user);
		
		return user;
	}
	
	public GomGroup createDepGroup() {
		GomGroup dep = new GomGroup();
		dep.setCname("开发部");
		dep.setEname("Develop");
		dep.setType(GroupType.DEPARTMENT);
		groupDao.create(dep);
		
		return dep;
	}
	
	public GomGroup createEmpGroup() {
		GomGroup emp = new GomGroup();
		emp.setCname("职员");
		emp.setEname("Employee");
		emp.setType(GroupType.POSITION);
		groupDao.create(emp);
		
		return emp;
	}
}
