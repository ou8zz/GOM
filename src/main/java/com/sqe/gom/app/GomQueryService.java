/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import java.util.Date;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.sqe.gom.constant.ApplyState;
import com.sqe.gom.constant.AssetState;
import com.sqe.gom.constant.AssetType;
import com.sqe.gom.constant.Attendance;
import com.sqe.gom.constant.DateRange;
import com.sqe.gom.constant.GroupType;
import com.sqe.gom.constant.LeaveType;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.ResourceType;
import com.sqe.gom.constant.TaskType;
import com.sqe.gom.constant.UnfinishedType;
import com.sqe.gom.constant.WorkingHoursType;
import com.sqe.gom.model.Asset;
import com.sqe.gom.model.Borrow;
import com.sqe.gom.model.Experience;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.Leave;
import com.sqe.gom.model.Login;
import com.sqe.gom.model.Meeting;
import com.sqe.gom.model.Project;
import com.sqe.gom.model.Responsibility;
import com.sqe.gom.model.Task;
import com.sqe.gom.model.Training;
import com.sqe.gom.util.Page;
import com.sqe.gom.vo.UserGroup;

/**
 * @description 报表数据接口
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Sep 7, 2012
 * @version 3.0
 */
@Transactional
public interface GomQueryService {
	
	/**
	 * 根据用户部门或职务查询多个用户团体
	 * @param type	DEPARTMENT("部门"), POSITION("职务")
	 * @param ename 如果type=DEPARTMENT为部门ename,type=POSITION为职务ename
	 * @return UserGroup {id,jobNo,ename,cname,email,cell,department or position(部门or职务),cdepartment or cposition(部门or职务)}
	 */
	List<UserGroup> getUsers(GroupType type, String ename);
	
	/**
	 * 用户入职/离职 和用户信息
	 * @param ename	用户英文名
	 * @return GomUser(id, ename(英文名), cname(中文名), jobNo(工作号), cdepartment(部门), entryDate(入职日期), exitDate(离职日期))
	 */
	GomUser getEntryAndDeptrueData(String ename);
	
	/**
	 * 用户当天登录日志
	 * @param uid 	用户ID
	 * @param mins 	当前日期提前分钟数
	 * @return Login (id,loginIP,loginTime,loginTake,loginOut,unlockTime,user)
	 */
	Login getLog(int uid, int mins);
	
	/**
	 * 获得当前用户登录日志 列表的开始日期和结束日期之间
	 * @param uid 		用户id
	 * @param startDate	开始日期 (如:2012-09-01)
	 * @param endDate	结束日期 (如:2012-09-02)
	 * @return List Login (id,loginIP,loginTime,loginTake,unlockTime,user)
	 */
	List<Login> getLogs(int uid, Date startDate, Date endDate);
	
	/**
	 * 工作查询：根据用户英文名查询用户工作，包括工作类型，状态，和固定工作
	 * 
	 * @param ename 	用户英文名(可以为空，为空表示所有)
	 * @param needHelp 	需要帮忙：如果为true表示类型为需要帮忙，如果为false表示正常工作任务
	 * @param type		工作类型： REGULAR("固定"), PLAN("计划"), TEMPORARY("临时");
	 * @param state 	工作状态：Ready(未分配), InProgress(正在进行), Completed(已经完成), Obsolete(已经废除) (可以为空，为空表示所有)
	 * @param frequency 周期(如果不为空表示查询固定工作) DAY("日"), WEEK("周"), MONTH("月"),QUARTER("季度"),YEAR("年");
	 * @param start		开始日期，如果end为空，则查询当前日期到当天的所有工作记录(可以为空，为空表示所有)
	 * @param end		结束日期，如果start为空，则查询当前日期之前的所有工作记录(可以为空，为空表示所有)
	 * @param page		分页
	 * @return List 	Task (id,taskTitle,state,taskType,expectedHours,actualHours,completedRate,occupyRate,executor,assignor,expectedStart,expectedEnd,actualStart,actualEnd,createDate,describe,delay)
	 */
	List<Task> getTasks(String ename, Boolean needHelp, TaskType type, ProcessStatus state, DateRange frequency, Date start, Date end, Page page);
	
	/**
	 * 项目列表和项目子模块
	 * @param isParent 	true只是父项目 false只是子模块
	 * @param parentId 	查询一个项目的子模块 parentId为项目父ID,(可以为空，为空表示所有)
	 * @param state		当前完成状态：InProgress(正在进行),Completed(已完成),(可以为空，为空表示所有)
	 * @param start 	查询项目添加日期比如从：2012-09-01 开始(为空则大于这个日期都查询到),(可以为空，为空表示所有)
	 * @param end 		项目添加日期比如到：2012-09-03 结束(为空则小于这个日期都查询到),(可以为空，为空表示所有)
	 * @return list 	porject(id,projectNo,projectName,version,type,director,startDate,endDate,actualEnd,expectedTime,actualTime,des,parent.id(父项目id),parent.projectName(父项目名),product.id(产品ID),product.productName(产品名)
	 */
	List<Project> getProjects(Boolean isParent, Integer parentId, ProcessStatus state, Date start, Date end);
		
	/**
	 * 培训列表
	 * @param start	开始时间
	 * @param end	结束时间 
	 * @return 		Training(id, tprogram(训练项目 ), lecturer(讲师), trainingType(培训类型), trainingTime(训练时数),fee(费用), otherFee(其它费用), startDate(开始时间), endDate(结束时间), qualification(讲师资质), tcontent(内容))
	 */
	List<Training> getTrainings(Date start, Date end);
	
	/**
	 * 资产列表
	 * @param type 	资产类型 COMPUTER("计算机"), CONSUMABLES ("办公耗材"), DAILY_OFFICE("办公日用品");
	 * @param state	资产状态 IN_SHELF_LIFE("保修期内"), OUT_SHELF_LIFE("过保修期"), AVAILABLE("可使用"), UNAVAILABLE("不可用"), DAMAGE("已损坏"), REPAIRCING("报修中")
	 * 				可以为空
	 * @param start	开始时间(可以为空)
	 * @param end	结束时间 (可以为空)
	 * @return Asset(a.id,a.assetName,a.assetType,a.ascription,a.des,a.buyNum,a.unit,a.assetState,a.admin,a.buyer,a.buyDate,a.warrantyDate,a.controlDate,a.scrapDate,a.attachment)
	 */
	List<Asset> getAssets(AssetType type, AssetState state, Date start, Date end);
	
	/**
	 * 借出资产物品
	 * @param ename 指定查询这个用户所借资产(可以为空)
	 * @param state 查询当状态为: TRIAL("待审"),AGREE("同意"), REJECT("拒绝"), CONFIRM("归还确认"), HOMING("归位"), USING("使用中"), DAMAGED("被损坏")
	 * 				为空表示所有
	 * @return list Borrow (id,asset.id(资产id),asset.assetName(资产名),funCode,applyState,receiveNum,receiver,receiveDate,returnDate,overStaff,remark)
	 */
	List<Borrow> getBorrows(String ename, ApplyState state);
	
	/** 
	 * 查询用户培训心得 或 如何做
	 * @param type 	类型 EXPERIENCE("心得"),HOW("如何做");
	 * @param user 	用户ename
	 * @param start 查询开始时间(格式：2012-09-01)
	 * @param end	查询结束时间(格式：2012-09-03)
	 * @return List Experience(id, student, createDate, gain, title(如何做标题), number(标准编号))
	 */
	List<Experience> getExperience(ResourceType type, String user, String start, String end);
	
	/**
	 * 用户管理责任(根据父子关系类型排序显示)
	 * @param userId 用户ID
	 * @return List Responsibility(id,funcode,name,explanation,ur.id<中间表ID>,ur.expected<中间表责任比重>,ur.node<中间表Node>,user.id<用户ID>,user.ename<用户名>)
	 */
	List<Responsibility> getResponsibility(Integer userId);

	/**
	 * 会议记录查询
	 * @param host	会议发起人(用户ename)	(为空表示所有)
	 * @param start	查询会议发起时从此日期 开始 	(为空表示所有)
	 * @param end	至此日期结束;		(为空表示所有)
	 * @return		Meeting{id,number,title,time,host,notes,locale,participants,isTrace,traceDate,endDate,content,explain}
	 */
	List<Meeting> getMeetings(String host, Date start, Date end);
	
	/**
	 * 迟到,早退 统计 根据type区分
	 * @param type 	ONDUTY("上班"),OFFDUTY("下班");
	 * @param time 	上班时间和下班时间,(如上班时间为：08:30)
	 * @param uid 	用户id
	 * @param field 统计天数条件 YEAR("年"), MONTH("月"), WEEK("周"), DAY("日");
	 * @param range	field条件范围，如field=DAY，range=2 天数推前2天(如当天是10号，则查询8号到10的数据内容)
	 * @return 		迟到,早退 天数
	 */
	int getAttendance(Attendance type, String time, int uid, DateRange field, int range);
	
	/**
	 * 请假统计
	 * @param uid 	用户id
	 * @param type 	类型 CASUAL("事假"), SICK("病假"),LEAVE_IN_LIEU("调休"),ANNUAL("年假"),MARRIAGE("婚假"),MATERNITY("产假"),BEREAVEMENT("丧假")
	 * 				为空表示所有类型
	 * @param field 统计天数条件 YEAR("年"), MONTH("月"), WEEK("周"), DAY("日");
	 * @param range	field条件范围，如field=DAY，range=2 天数推前2天(如当天是10号，则查询8号到10的数据内容)
	 * @return 		请假天数
	 */
	int getLeaveInof(int uid, LeaveType type, DateRange field, int range);
	
	/**
	 * 请假例表清单
	 * @param uid 	用户id
	 * @param type 	类型 CASUAL("事假"), SICK("病假"),LEAVE_IN_LIEU("调休"),ANNUAL("年假"),MARRIAGE("婚假"),MATERNITY("产假"),BEREAVEMENT("丧假")
	 * 				为空表示所有类型
	 * @param start 年度请假详细默认为当年 开始如：2011 则时间从2011-01-01 00:00:00开始
	 * @param end	从开始至一个年度，如：2012 则时间2012-01-01 00:00:00 如果为空则以当天时间为准
	 * @return List<Leave> 
	 */
	List<Leave> getYearLeave(int uid, LeaveType type, Integer start, Integer end);
	
	/**
	 * 计划\实际 工时统计
	 * @param type 	EXPECTED("预计"),ACTUAL("实际");
	 * @param ename 用户ename
	 * @param field 统计天数条件 YEAR("年"), MONTH("月"), WEEK("周"), DAY("日");
	 * @param range	field条件范围，如field=DAY，range=2 天数推前2天(如当天是10号，则查询8号到10的数据内容)
	 * @return 		计划工时天数
	 */
	int getWorkingHours(WorkingHoursType type, String ename, DateRange field, int range);
	
	/**
	 * 未完成工作或项目次数统计
	 * @param type	WORKTASK("工作任务"),PROJECT("项目");
	 * @param ename	用户ename
	 * @param field 统计天数条件 YEAR("年"), MONTH("月"), WEEK("周"), DAY("日");
	 * @param range	field条件范围，如field=DAY，range=2 天数推前2天(如当天是10号，则查询8号到10的数据内容)
	 * @return		未完成工作或项目次数
	 */
	int getWorkingUnfinished(UnfinishedType type, String ename, DateRange field, int range);
	
}
