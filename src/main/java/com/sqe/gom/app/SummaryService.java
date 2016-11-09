/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;

import com.sqe.gom.constant.DateRange;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.ItemType;
import com.sqe.gom.model.ReportConfig;
import com.sqe.gom.model.SwotResult;
import com.sqe.gom.vo.Attendance;
import com.sqe.gom.vo.UserGroup;

/**
 * @description 
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Transactional
public interface SummaryService {
	
	
	/**
	 * 根据用户ID项目统计8个项目按每个进行统计DAY*4  WEEK*4  MONTH*4  YEAR*2
	 * @param uid
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	List<SwotResult> getSummarys(Integer uid);
	
	/**
	 * 按日期DateRange类型和count数对用户进行统计
	 * @param uid
	 * @param count
	 * @param range
	 * @return
	 */
	@PreAuthorize("hasRole('User')")
	List<SwotResult> getSummary(Integer uid, Integer count, DateRange range);
	
	/**
	 * 发送早报
	 * @param rc
	 * @param ug
	 */
	HandlerState sendMorningPaper(ReportConfig rc, UserGroup ug);
	 
	/**
	 * 发送用户报表
	 * @param ug
	 */
	@PreAuthorize("hasRole('User')")
	void sendReport(UserGroup ug);
	
	/**
	 * 发送报表方法
	 * @param rc			报表配置
	 * @param ug			用户
	 * @param date_count	需要统计数据向前多少天 如：一个月30天
	 */
	@PreAuthorize("hasRole('User')")
	void sendReport(ReportConfig rc, UserGroup ug, Integer date_count);
	
	
	/**
	 * 出勤记录
	 * @param uids
	 * @return	
	 */
	@PreAuthorize("hasRole('User')")
	List<Attendance> getAttendance(String[] uids);
	
	
	/**
	 * 生成report表数据
	 * @param uid
	 * @param range
	 */
	@PreAuthorize("hasRole('User')")
	Map<String, String> getReportImg(Integer uid, DateRange range);
	
	/**
	 * 报表曲线图
	 * @param item 	项目类别
	 * @param uid	用户Id
	 * @param path	文件保存路径
	 * @return 		图片文件
	 */
	@PreAuthorize("hasRole('User')")
	File saveReportImg(ItemType item, Integer uid, List<SwotResult> list, String title, String path, ServletOutputStream stream);
}
