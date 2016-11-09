package com.sqe.gom.util;

import java.util.Date;
import java.util.List;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import com.google.gson.reflect.TypeToken;
import com.sqe.gom.BaseTest;
import com.sqe.gom.dao.UserDAO;
import com.sqe.gom.model.Education;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Logs;

public class JsonUtilsTest extends BaseTest {
	@Autowired
	protected UserDAO userDao;
	
	@Test
	public void arrayToList() {
		String str = "[{'startDate':'2011-09-01','endDate':'2011-09-02','school':'上海交大','major':'计算机应用','ed':'本科','idno':'S646446646464654','idScan':'b65e6e1c50854c7ab16586ddd38f2286.jpg','id':1},{'startDate':'2011-09-01','endDate':'2011-09-30','school':'上海交大','major':'计算机应用','ed':'本科','idno':'S646446646464654','id':2,'idScan':'b1c4403b190540fe9cacd4c0c71c8f08.jpg'},{'startDate':'2011-09-01','endDate':'2011-09-21','school':'同济大学','major':'计算机应用','ed':'本科','idno':'S646446646464654','idScan':'c7f71952104e47da8fac13bdc4ed21ae.jpg','id':3}]";
		//String s = "Roger: 驳回, 我给你讲一个你听都没有听过的因<br>null";
		List<Education> es = JsonUtils.fromJson(str, new TypeToken<List<Education>>(){}, "yyyy-MM-dd");
		if(es.size() > 0) {
		for(Education e: es) {
			System.out.println("开始时间:" + e.getStartDate() + " 结束时间:" + e.getEndDate() + " 毕业学校" + e.getSchool());
		}
		//System.out.println(s.replaceAll("null", ""));
		}
	}
	
	@Ignore
	public void getJson() {
		List<GomUser> ls = userDao.getInactiveUser(false, false, null, null, new Page(1));
		for(GomUser u :ls) {
			System.out.println(u.getBirthday());
		}
		System.out.println(JsonUtils.toJson(ls,new TypeToken<List<GomUser>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN,true));
	}
	
	@Test
	public void toJson() {
		StringBuilder sb = new StringBuilder("[");
        sb.append("{").append("dated:'").append(new Date()).append("',logger:'登录日志', message:'用户james已经于2012-11-12登录'").append("},");
        sb.append("{").append("dated:'").append(DateUtil.forMatDate()).append("',logger:'登录日志', message:'用户ole已经于2012-11-19登录'").append("},");
        
        String logStrs = sb.toString();
        logStrs = logStrs.substring(0, logStrs.length()-1);
        logStrs+="]";
        
        List<Logs> ls = JsonUtils.fromJson(logStrs, new TypeToken<List<Logs>>(){}, JsonUtils.SHORT_DATE_PATTERN);
        
        System.out.println(ls);
	}
}