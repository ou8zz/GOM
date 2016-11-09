/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.awt.Color;
import java.awt.geom.Ellipse2D;
import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.servlet.ServletOutputStream;

import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.DateAxis;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.labels.StandardXYToolTipGenerator;
import org.jfree.chart.plot.Marker;
import org.jfree.chart.plot.ValueMarker;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.xy.XYSplineRenderer;
import org.jfree.data.time.Day;
import org.jfree.data.time.TimeSeries;
import org.jfree.data.time.TimeSeriesCollection;
import org.jfree.data.xy.XYDataset;
import org.jfree.ui.RectangleAnchor;
import org.jfree.ui.RectangleInsets;
import org.jfree.ui.TextAnchor;
import org.springframework.mail.MailAuthenticationException;
import org.springframework.stereotype.Service;

import com.sqe.gom.app.GomQueryService;
import com.sqe.gom.app.MailService;
import com.sqe.gom.app.SummaryService;
import com.sqe.gom.app.SwotService;
import com.sqe.gom.constant.DateRange;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.constant.ItemType;
import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.constant.ResourceType;
import com.sqe.gom.constant.SwotModel;
import com.sqe.gom.dao.ConfigDAO;
import com.sqe.gom.dao.MottoDAO;
import com.sqe.gom.dao.ReportConfigDAO;
import com.sqe.gom.dao.ReportDAO;
import com.sqe.gom.dao.SummaryDAO;
import com.sqe.gom.model.GomUser;
import com.sqe.gom.model.MailHeader;
import com.sqe.gom.model.Report;
import com.sqe.gom.model.ReportConfig;
import com.sqe.gom.model.Statistics;
import com.sqe.gom.model.SwotConfig;
import com.sqe.gom.model.SwotResult;
import com.sqe.gom.model.Task;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.PDFHelper;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.Attendance;
import com.sqe.gom.vo.UserGroup;

/**
 * @description
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Service("summaryService")
public class SummaryServiceImpl implements SummaryService {
	private SummaryDAO summaryDao;
	private ReportDAO reportDao;
	private SwotService swotService;
	private ReportConfigDAO reportConfigDao;
	private MottoDAO mottoDao;
	private Map<Integer, SwotConfig> configs;
	private GomQueryService queryService;
	private MailService mailService;
	private ConfigDAO configDao;
	private String path;
	private HandlerState status = HandlerState.FAILED;
	
	@Resource(name="summaryDao") public void setSummaryDao(SummaryDAO summaryDao) { this.summaryDao = summaryDao; }
	@Resource(name="reportDao") public void setReportDao(ReportDAO reportDao) { this.reportDao = reportDao; }
	@Resource(name="swotService") public void setSwotService(SwotService swotService) { this.swotService = swotService; }
	@Resource(name="gomQueryService") public void setQueryService(GomQueryService queryService) {this.queryService = queryService; }
	@Resource(name="mailService") public void setMailService(MailService mailService) {this.mailService = mailService;}
	@Resource(name="reportConfigDao") public void setReportConfigDao(ReportConfigDAO reportConfigDao) {this.reportConfigDao = reportConfigDao;}
	@Resource(name="mottoDao") public void setMottoDao(MottoDAO mottoDao) {this.mottoDao = mottoDao;}
	@Resource(name="configDao") public void setConfigDao(ConfigDAO configDao) {this.configDao = configDao;path = configDao.getConfig("fileUpload.rootPath").getValue();}
	
	
	@Override
	public HandlerState sendMorningPaper(ReportConfig rc, UserGroup ug) {
		if(RegexUtil.isEmpty(rc)) rc = reportConfigDao.getReportConfig(DateRange.MORNING, ug.getId());
		if(RegexUtil.isEmpty(rc)) return status;  //如果为空表示用户没有进行报表的配置
		
		Map<String, Object> params = new HashMap<String, Object>();
		MailHeader mh = new MailHeader();
		
		GomUser guser = rc.getUser();
		if(RegexUtil.isEmpty(guser)) guser = queryService.getEntryAndDeptrueData(ug.getEname());
		try {
			mh.setFrom(ug.getEmail());
			mh.setTo(rc.getReceiver().split(","));
			mh.setSubject("Good Morning - " + ug.getEname() + "(" + ug.getCname() + ")");
			if(RegexUtil.notEmpty(rc.getCc())) mh.setCc(rc.getCc().split(","));
			params.put("doing", queryService.getTasks(ug.getEname(), false, null, ProcessStatus.InProgress, null, DateUtil.previous(7), DateUtil.previous(-1), null));
			params.put("motto", mottoDao.getMotto().getMottoText());
			
			//Log图片附件
			Map<String,File> m = new HashMap<String, File>();
			m.put("sqe_logo", new File(configDao.getConfig("fileUpload.rootPath").getValue() + "/logo/sqe_logo.png"));
			mh.setInline(m);
					
			//如果用户有自定义签名直接加载，否则加载系统默认签名
			String text = null;
			if(RegexUtil.notEmpty(guser.getSignature().getStext())) {
				text = guser.getSignature().getStext();
			} else {
				Map<String, Object> signature = new HashMap<String, Object>();
				signature.put("user", guser);
				signature.put("version", configDao.getConfigValue("basis.version"));
				signature.put("web", configDao.getConfigValue("basis.web"));
				signature.put("tel", configDao.getConfigValue("basis.tel"));
				signature.put("fax", configDao.getConfigValue("basis.fax"));
				signature.put("company_cn", configDao.getConfigValue("basis.company.cn"));
				signature.put("company_en", configDao.getConfigValue("basis.company.en"));
				text = mailService.getHtmlBody("signature.ftl", signature);
			}
			params.put("signature", text.replaceFirst("img src=", "img src='cid:sqe_logo' alt="));
			mailService.sendMail(guser, mh, mailService.getHtmlBody("morning.ftl", params));
			status = HandlerState.SUCCESS;
		} catch (MessagingException e) {
			status = HandlerState.ERROR;
		} catch (MailAuthenticationException e) {
			status = HandlerState.ERROR;
		} catch (NullPointerException e) {
			status = HandlerState.ERROR;
		}
		return status;
	}
	
	@Override
	public void sendReport(UserGroup ug) {
		Calendar cal = Calendar.getInstance();
		List<ReportConfig> rcs = reportConfigDao.getReportConfigs(ug.getId());
		for (ReportConfig rc : rcs) {
			//日报
			if (DateRange.DAY.equals(rc.getType()) && rc.getSend()) {
				sendReport(rc, ug, 1);
			} 
			//周报
			else if (DateRange.WEEK.equals(rc.getType()) && rc.getSend()) {
				if (rc.getSendTime().equals(String.valueOf(DateUtil.getField(Calendar.DAY_OF_WEEK, null)))) {
					sendReport(rc, ug, 7);
				}
			} 
			//月报
			else if (DateRange.MONTH.equals(rc.getType()) && rc.getSend()) {
				if (rc.getSendTime().equals(String.valueOf(DateUtil.getField(Calendar.DAY_OF_MONTH, null)))) {
					sendReport(rc, ug, 30);
				}
			} 
			//季报
			else if (DateRange.QUARTER.equals(rc.getType()) && rc.getSend()) {
				cal = Calendar.getInstance();
				Integer month = cal.get(Calendar.MONTH) + 1;
				Integer day = cal.get(Calendar.DAY_OF_MONTH);
				if ((month.equals(3) && day.equals(31)) || (month.equals(6) && day.equals(30)) || (month.equals(9) && day.equals(30)) ||(month.equals(12) && day.equals(31)) ) 
					sendReport(rc, ug, 90);
			} 
			//年报
			else if (DateRange.YEAR.equals(rc.getType()) && rc.getSend()) {
				cal = Calendar.getInstance();
				Integer month = cal.get(Calendar.MONTH) + 1;
				Integer day = cal.get(Calendar.DAY_OF_MONTH);
				if (month.equals(1) && day.equals(1))
					sendReport(rc, ug, 365);
			}
		}
	}
	
	@Override
	public void sendReport(ReportConfig rc, UserGroup ug, Integer date_count) {
		String path = configDao.getConfig("fileUpload.rootPath").getValue();
		Map<String, Object> params = new HashMap<String, Object>();
		MailHeader mh = new MailHeader();
		if(RegexUtil.notEmpty(rc.getReceiver())) {
			try {
				GomUser user = queryService.getEntryAndDeptrueData(ug.getEname());
				params.put("user", user);
				
				mh.setFrom(ug.getEmail());
				mh.setSubject(ug.getEname() + "(" + ug.getCname() + ")" + rc.getType().getDes() + "报");
				mh.setTo(rc.getReceiver().split(","));
				if(RegexUtil.notEmpty(rc.getCc())) mh.setCc(rc.getCc().split(","));
				
				if(rc.getDevote()) params.put("devote", testTask(queryService.getTasks(ug.getEname(), false, null, ProcessStatus.Completed, null, DateUtil.previous(date_count), DateUtil.previous(-1), null)));
				if(rc.getWeekDevote()) params.put("weekDevote", testTask(queryService.getTasks(ug.getEname(), false, null, ProcessStatus.Completed, null, DateUtil.previous(date_count+7), DateUtil.previous(-1), null)));
				if(rc.getTask()) params.put("tasks", testTask(queryService.getTasks(ug.getEname(), false, null, ProcessStatus.Ready, null, DateUtil.previous(date_count+7), DateUtil.previous(-1), null)));
				if(rc.getDoing()) params.put("doing", testTask(queryService.getTasks(ug.getEname(), false, null, ProcessStatus.InProgress, null, DateUtil.previous(date_count+7), DateUtil.previous(-1), null)));
				if(rc.getHelp()) params.put("help", testTask(queryService.getTasks(ug.getEname(), true, null, null, null, DateUtil.previous(date_count), DateUtil.previous(-1), null)));
				if(rc.getHow()) params.put("hows", queryService.getExperience(ResourceType.HOW, ug.getEname(), DateUtil.formatDate(DateUtil.previous(date_count+7)), DateUtil.formatDate(DateUtil.previous(-1))));
				if(rc.getLogin()) params.put("logins", queryService.getLogs(ug.getId(), DateUtil.previous(date_count), DateUtil.previous(-1)));
				if(rc.getLogin()) params.put("login", queryService.getLog(ug.getId(), 0));
				if(rc.getRepos()) params.put("resp", queryService.getResponsibility(ug.getId()));
				if(rc.getAssets()) params.put("borrows", queryService.getBorrows(ug.getEname(), null));
				params.put("meeting", queryService.getMeetings(null, DateUtil.previous(30), DateUtil.previous(-1)));
				
				//Log图片附件 
				Map<String, File> imgs = new HashMap<String, File>();
				imgs.put("sqe_logo", new File(path + "/logo/sqe_logo.png"));
				params.put("imgs", imgs);		
				
				//如果用户有自定义签名直接加载，否则加载系统默认签名
				String text = null;
				if(RegexUtil.notEmpty(user.getSignature().getStext())) {
					text = user.getSignature().getStext();
				} else {
					Map<String, Object> signature = new HashMap<String, Object>();
					signature.put("user", user);
					signature.put("version", configDao.getConfigValue("basis.version"));
					signature.put("web", configDao.getConfigValue("basis.web"));
					signature.put("tel", configDao.getConfigValue("basis.tel"));
					signature.put("fax", configDao.getConfigValue("basis.fax"));
					signature.put("company_cn", configDao.getConfigValue("basis.company.cn"));
					signature.put("company_en", configDao.getConfigValue("basis.company.en"));
					text = mailService.getHtmlBody("signature.ftl", signature);
				}
				params.put("signature", text.replaceFirst("img src=", "img src='cid:sqe_logo' alt="));
				
				File email_attachment = null;
				if (rc.getSummary() && DateRange.DAY.equals(rc.getType())) {
					params.put("daily", getSummarys(ug.getId()));
				}
				if (rc.getSummary() && DateRange.WEEK.equals(rc.getType())) {
					//周曲线图数据
					List<SwotResult> results = getSummary(ug.getId(), 20, rc.getType());
					params.putAll(saveReportImg(results, ug.getId(), path));
					email_attachment = PDFHelper.getPDF(path + "/pdf/("+user.getEname()+")weekly.pdf", params);
					params.put("weekly", getSummary(ug.getId(), 12, DateRange.WEEK));
				}
				if (rc.getSummary() && DateRange.MONTH.equals(rc.getType())) {
					//月曲线图数据
					List<SwotResult> results = getSummary(ug.getId(), 20, rc.getType());
					params.putAll(saveReportImg(results, ug.getId(), path));
					email_attachment = PDFHelper.getPDF(path + "/pdf/("+user.getEname()+")monthly.pdf", params);
					params.put("monthly", getSummary(ug.getId(), 12, DateRange.MONTH));
				}
				if (rc.getSummary() && DateRange.QUARTER.equals(rc.getType())) {
					params.put("quarterly", getSummary(ug.getId(), 12, DateRange.QUARTER));
				}
				if (rc.getSummary() && DateRange.YEAR.equals(rc.getType())) {
					//年曲线图数据
					List<SwotResult> results = getSummary(ug.getId(), 20, rc.getType());
					params.putAll(saveReportImg(results, ug.getId(), path));
					email_attachment = PDFHelper.getPDF(path + "/pdf/("+user.getEname()+")yearly.pdf", params);
					params.put("yearly", getSummary(ug.getId(), 12, DateRange.YEAR));
				}
				mh.setInline(imgs);
				if(RegexUtil.notEmpty(email_attachment)) mh.setAttachment(new String[]{email_attachment.getPath()});
				
				mailService.sendMail(user, mh, mailService.getHtmlBody("report.ftl", params));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	@Override
	public List<SwotResult> getSummary(Integer uid, Integer count, DateRange range) {
		List<SwotResult> list = new ArrayList<SwotResult>();

		//预先存入swot配置
		configs = getSwotConfigs(range);
		
		List<Statistics> ls = summaryDao.getSummary(uid, count, range);
		
		list.addAll(getCount(ls, ItemType.CONTRIBUTION, range));
		list.addAll(getCount(ls, ItemType.PLAN, range));
		list.addAll(getCount(ls, ItemType.PRACTICAL, range));
		list.addAll(getCount(ls, ItemType.LEAVE, range));
		list.addAll(getCount(ls, ItemType.LIEU, range));
		list.addAll(getCount(ls, ItemType.LATE, range));
		list.addAll(getCount(ls, ItemType.EARLY, range));
		list.addAll(getCount(ls, ItemType.DELAY, range));

		return list;
	}
	
	@Override
	public List<SwotResult> getSummarys(Integer uid) {
		//#CONTRIBUTION("贡献"), PLAN("计划"), PRACTICAL("实际"), LEAVE("请假"), LIEU("调休"), LATE("迟到"), EARLY("早退"), DELAY("延误");
		List<SwotResult> list = new ArrayList<SwotResult>();
		
		//预先存入swot配置
		configs = getSwotConfigs(DateRange.DAY);
		
		List<Statistics> daym = summaryDao.getSummary(uid, 4, DateRange.DAY);
		List<Statistics> weekm = summaryDao.getSummary(uid, 4, DateRange.WEEK);
		List<Statistics> monthm = summaryDao.getSummary(uid, 4, DateRange.MONTH);
		List<Statistics> yearm = summaryDao.getSummary(uid, 2, DateRange.YEAR);

		list.addAll(getCount(daym, ItemType.CONTRIBUTION, DateRange.DAY));
		list.addAll(getCount(weekm, ItemType.CONTRIBUTION, DateRange.WEEK));
		list.addAll(getCount(monthm, ItemType.CONTRIBUTION, DateRange.MONTH));
		list.addAll(getCount(yearm, ItemType.CONTRIBUTION, DateRange.YEAR));
			
		list.addAll(getCount(daym, ItemType.PLAN, DateRange.DAY));
		list.addAll(getCount(weekm, ItemType.PLAN, DateRange.MONTH));
		list.addAll(getCount(monthm, ItemType.PLAN, DateRange.MONTH));
		list.addAll(getCount(yearm, ItemType.PLAN, DateRange.YEAR));
		
		list.addAll(getCount(daym, ItemType.PRACTICAL, DateRange.DAY));
		list.addAll(getCount(weekm, ItemType.PRACTICAL, DateRange.WEEK));
		list.addAll(getCount(monthm, ItemType.PRACTICAL, DateRange.MONTH));
		list.addAll(getCount(yearm, ItemType.PRACTICAL, DateRange.YEAR));
		
		list.addAll(getCount(daym, ItemType.LEAVE, DateRange.DAY));
		list.addAll(getCount(weekm, ItemType.LEAVE, DateRange.WEEK));
		list.addAll(getCount(monthm, ItemType.LEAVE, DateRange.MONTH));
		list.addAll(getCount(yearm, ItemType.LEAVE, DateRange.YEAR));
		
		list.addAll(getCount(daym, ItemType.LIEU, DateRange.DAY));
		list.addAll(getCount(weekm, ItemType.LIEU, DateRange.WEEK));
		list.addAll(getCount(monthm, ItemType.LIEU, DateRange.MONTH));
		list.addAll(getCount(yearm, ItemType.LIEU, DateRange.YEAR));
		
		list.addAll(getCount(daym, ItemType.LATE, DateRange.DAY));
		list.addAll(getCount(weekm, ItemType.LATE, DateRange.WEEK));
		list.addAll(getCount(monthm, ItemType.LATE, DateRange.MONTH));
		list.addAll(getCount(yearm, ItemType.LATE, DateRange.YEAR));
		
		list.addAll(getCount(daym, ItemType.EARLY, DateRange.DAY));
		list.addAll(getCount(weekm, ItemType.EARLY, DateRange.WEEK));
		list.addAll(getCount(monthm, ItemType.EARLY, DateRange.MONTH));
		list.addAll(getCount(yearm, ItemType.EARLY, DateRange.YEAR));
		
		list.addAll(getCount(daym, ItemType.DELAY, DateRange.DAY));
		list.addAll(getCount(weekm, ItemType.DELAY, DateRange.WEEK));
		list.addAll(getCount(monthm, ItemType.DELAY, DateRange.MONTH));
		list.addAll(getCount(yearm, ItemType.DELAY, DateRange.YEAR));
		
		return list;
	}
	
	@Override
	public List<Attendance> getAttendance(String[] uids) {
		List<Attendance> list = new ArrayList<Attendance>();
		for(String uid : uids) {
			if(RegexUtil.notEmpty(uid)) 
			list.addAll(summaryDao.getAttendance(Integer.parseInt(uid)));
		}
		return list;
	}
	
	@Override
	public Map<String, String> getReportImg(Integer uid, DateRange range) {
		// TODO
		Map<String, String> m = new HashMap<String, String>();
		int i = reportDao.getReport(range, uid, DateUtil.parseDate("2013-03-07"));
		
		//本月最后一天
		Calendar cal=Calendar.getInstance();//获取当前日期
		int lastday = cal.getMaximum(Calendar.MONTH);
		cal.set(Calendar.DATE,lastday);
		
		//if(DateUtil.previousDate(days, date))
		
		if (i == 0) {
			List<SwotResult> list = getSummary(uid, 20, range);
			for(SwotResult sr : list) {
				Report r = new Report();
				r.setData(sr.getData());
				r.setDated(sr.getDated());
				r.setItem(sr.getItem());
				r.setType(range);
				//reportDao.create(r);
				//System.out.println("+++++++" + r);
			}
			
			Map<String, List<SwotResult>> res = getMapResult(list);
			
			long millis = System.currentTimeMillis();
			
			File contribution = saveReportImg(ItemType.CONTRIBUTION, uid, res.get(ItemType.CONTRIBUTION.name()), "", path + "/temp/contribution_" + millis + uid + ".jpg" , null);
			File plan = saveReportImg(ItemType.PLAN, uid, res.get(ItemType.PLAN.name()), "", path + "/temp/plan_" + millis + uid + ".jpg" , null);
			File practical = saveReportImg(ItemType.PRACTICAL, uid, res.get(ItemType.PRACTICAL.name()), "", path + "/temp/practical_" + millis + uid + ".jpg" , null);
			File leave = saveReportImg(ItemType.LEAVE, uid, res.get(ItemType.LEAVE.name()), "", path + "/temp/leave_" + millis + uid + ".jpg" , null);
			File lieu = saveReportImg(ItemType.LIEU, uid, res.get(ItemType.LIEU.name()), "", path + "/temp/lieu_" + millis + uid + ".jpg" , null);
			File late = saveReportImg(ItemType.LATE, uid, res.get(ItemType.LATE.name()), "", path + "/temp/late_" + millis + uid + ".jpg" , null);
			File early = saveReportImg(ItemType.EARLY, uid, res.get(ItemType.EARLY.name()), "", path + "/temp/early_" + millis + uid + ".jpg" , null);
			File delay = saveReportImg(ItemType.DELAY, uid, res.get(ItemType.DELAY.name()), "", path + "/temp/delay_" + millis + uid + ".jpg" , null);
			
			m.put("contribution_img", contribution.getPath().replace("\\", "/").substring(contribution.getPath().lastIndexOf("uploads")));
			m.put("plan_img", plan.getPath().replace("\\", "/").substring(plan.getPath().lastIndexOf("uploads")));
			m.put("practical_img", practical.getPath().replace("\\", "/").substring(practical.getPath().lastIndexOf("uploads")));
			m.put("leave_img", leave.getPath().replace("\\", "/").substring(leave.getPath().lastIndexOf("uploads")));
			m.put("lieu_img", lieu.getPath().replace("\\", "/").substring(lieu.getPath().lastIndexOf("uploads")));
			m.put("late_img", late.getPath().replace("\\", "/").substring(late.getPath().lastIndexOf("uploads")));
			m.put("early_img", early.getPath().replace("\\", "/").substring(early.getPath().lastIndexOf("uploads")));
			m.put("delay_img", delay.getPath().replace("\\", "/").substring(delay.getPath().lastIndexOf("uploads")));
			
		}
		return m;
	}
	
	@Override
	public File saveReportImg(ItemType item, Integer uid, List<SwotResult> list, String title, String path, ServletOutputStream stream) {
		XYSplineRenderer renderer = new XYSplineRenderer();
		renderer.setBaseShapesVisible(true); 		//绘制的线条上不显示图例，如果显示的话，会使图片变得很丑陋
		renderer.setPrecision(1); 					//设置精度，大概意思是在源数据两个点之间插入10个点以拟合出一条平滑曲线
		renderer.setSeriesPaint(0, Color.cyan); 	//设置0号数据的颜色。这是手工设置线条颜色的方法
		renderer.setSeriesShape(0, new Ellipse2D.Double(-3.0, -3.0, 6.0, 6.0));
		
		SwotConfig config = configs.get(item.ordinal());
		if(RegexUtil.isEmpty(config)) return null;
		
        String dar = "yy-w";
        int pre = 20;
        if(DateRange.DAY.equals(config.getRange())) {
        	dar = "dd";
        	pre = 30 * 1;
        }
        else if(DateRange.WEEK.equals(config.getRange())) {
        	dar = "yy-w";
        	pre = 19 * 7;
        }
        else if(DateRange.MONTH.equals(config.getRange())) {
        	dar = "yy-MM";
        	pre = 20 * 30;
        }
        else if(DateRange.YEAR.equals(config.getRange())) {
        	dar = "yyyy";
        	pre = 20 * 366;
        }
        DateFormat chartFormatter = new SimpleDateFormat(dar);
        Date start = DateUtil.previous(pre);
        Date end = DateUtil.previous(0);
        
        //create plot
        DateAxis xAxis = new DateAxis("统计自 " + DateUtil.formatDate(start) + " 至 " + DateUtil.formatDate(end));
        xAxis.setTickMarksVisible(false);
        xAxis.setAutoRange(false);
        xAxis.setMinimumDate(start);
        xAxis.setMaximumDate(end);
        xAxis.setDateFormatOverride(chartFormatter);
        renderer.setBaseToolTipGenerator(new StandardXYToolTipGenerator(StandardXYToolTipGenerator.DEFAULT_TOOL_TIP_FORMAT, chartFormatter, NumberFormat.getInstance()));
		
		NumberAxis yAxis = new NumberAxis();
		yAxis.setAutoRangeIncludesZero(false);
		yAxis.setRange(config.getLower()-6, config.getUpper()+6);
		 
		XYPlot plot = new XYPlot(createXYDataset(uid, list), xAxis, yAxis, renderer);
		plot.setAxisOffset(new RectangleInsets(5D, 5D, 5D, 5D)); //设置坐标轴与绘图区域的距离
		 
		//添加三条中心线
        final Marker up = new ValueMarker(config.getUpper());
        up.setLabel("上管线");
        up.setPaint(Color.blue);
        up.setLabelAnchor(RectangleAnchor.BOTTOM_RIGHT);
        up.setLabelTextAnchor(TextAnchor.TOP_RIGHT);
        plot.addRangeMarker(up);
        
        final Marker centre = new ValueMarker(config.getCenterline());
        centre.setLabel("中心线");
        centre.setPaint(Color.green);
        centre.setLabelAnchor(RectangleAnchor.BOTTOM_RIGHT);
        centre.setLabelTextAnchor(TextAnchor.TOP_RIGHT);
        plot.addRangeMarker(centre);
        
        final Marker down = new ValueMarker(config.getLower());
        down.setLabel("下管线");
        down.setPaint(Color.red);
        down.setLabelAnchor(RectangleAnchor.BOTTOM_RIGHT);
        down.setLabelTextAnchor(TextAnchor.TOP_RIGHT);
        plot.addRangeMarker(down);
        
		JFreeChart chart = new JFreeChart(title, 		//标题
						JFreeChart.DEFAULT_TITLE_FONT, 	//标题的字体，这样就可以解决中文乱码的问题
						plot,
						false //不在图片底部显示图例
						);
		try {
			//WEB流图片
			if(RegexUtil.notEmpty(stream)) {
				ChartUtilities.writeChartAsJPEG(stream, chart, 750, 380, null);
			}
			//将图片写到硬盘指定目录
			else if(RegexUtil.notEmpty(path)) {
				File img = new File(path);
				ChartUtilities.saveChartAsJPEG(img, chart, 750, 200);
				return img;
			}
		} catch (IOException e) {
			return null;
		}
		return null;
	}
	
	/**
	 * 生成用户报表图表在指定目录中
	 * @param results	数据源
	 * @param userId	用户ID
	 * @param path		保存的目录
	 * @return params	返回保存的图片名和数据结果以Map形式
	 */
	private Map<String, Object> saveReportImg(List<SwotResult> results, Integer userId, String path) {
		Map<String, Object> params = new HashMap<String, Object>();
		Map<String, List<SwotResult>> maps = getMapResult(results);
		
		//生成图片文件
		List<SwotResult> contributions = maps.get(ItemType.CONTRIBUTION.name());
		File contribution = saveReportImg(ItemType.CONTRIBUTION, userId, contributions, "", path + "/temp/contribution_" + userId + ".jpg" , null);
		params.put(ItemType.CONTRIBUTION.name()+"img", contribution);
		params.put(ItemType.CONTRIBUTION.name(), contributions);
		
		List<SwotResult> plans = maps.get(ItemType.PLAN.name());
		File plan = saveReportImg(ItemType.PLAN, userId, plans, "", path + "/temp/plan_" + userId + ".jpg" , null);
		params.put(ItemType.PLAN.name()+"img", plan);
		params.put(ItemType.PLAN.name(), plans);
		
		List<SwotResult> practicals = maps.get(ItemType.PRACTICAL.name());
		File practical = saveReportImg(ItemType.PRACTICAL, userId, practicals, "", path + "/temp/practical_" + userId + ".jpg" , null);
		params.put(ItemType.PRACTICAL.name()+"img", practical);
		params.put(ItemType.PRACTICAL.name(), practicals);
		
		List<SwotResult> delays = maps.get(ItemType.DELAY.name());
		File delay = saveReportImg(ItemType.DELAY, userId, delays, "", path + "/temp/delay_" + userId + ".jpg" , null);
		params.put(ItemType.DELAY.name()+"img", delay);
		params.put(ItemType.DELAY.name(), delays);
		
		List<SwotResult> leaves = maps.get(ItemType.LEAVE.name());
		File leave = saveReportImg(ItemType.LEAVE, userId, leaves, "", path + "/temp/leave_" + userId + ".jpg" , null);
		params.put(ItemType.LEAVE.name()+"img", leave);
		params.put(ItemType.LEAVE.name(), leaves);
		
		List<SwotResult> lieus = maps.get(ItemType.LIEU.name());
		File lieu = saveReportImg(ItemType.LIEU, userId, lieus, "", path + "/temp/lieu_" + userId + ".jpg" , null);
		params.put(ItemType.LIEU.name()+"img", lieu);
		params.put(ItemType.LIEU.name(), lieus);
		
		List<SwotResult> lates = maps.get(ItemType.LATE.name());
		File late = saveReportImg(ItemType.LATE, userId, lates, "", path + "/temp/late_" + userId + ".jpg" , null);
		params.put(ItemType.LATE.name()+"img", late);
		params.put(ItemType.LATE.name(), lates);
		
		List<SwotResult> earlys = maps.get(ItemType.EARLY.name());
		File early = saveReportImg(ItemType.EARLY, userId, earlys, "", path + "/temp/early_" + userId + ".jpg" , null);
		params.put(ItemType.EARLY.name()+"img", early);
		params.put(ItemType.EARLY.name(), earlys);
		
		return params;
	}
	
	private Map<String, List<SwotResult>> getMapResult(List<SwotResult> results) {
		Map<String, List<SwotResult>> params = new HashMap<String, List<SwotResult>>();
		List<SwotResult> contributions = new ArrayList<SwotResult>();
		List<SwotResult> plans = new ArrayList<SwotResult>();
		List<SwotResult> practicals = new ArrayList<SwotResult>();
		List<SwotResult> delays = new ArrayList<SwotResult>();
		List<SwotResult> leaves = new ArrayList<SwotResult>();
		List<SwotResult> lieus = new ArrayList<SwotResult>();
		List<SwotResult> lates = new ArrayList<SwotResult>();
		List<SwotResult> earlys = new ArrayList<SwotResult>();
		for(SwotResult s : results) {
			if(s.getTitle().equals(ItemType.CONTRIBUTION.getDes())) contributions.add(s);
			else if(s.getTitle().equals(ItemType.PLAN.getDes())) plans.add(s);
			else if(s.getTitle().equals(ItemType.PRACTICAL.getDes())) practicals.add(s);
			else if(s.getTitle().equals(ItemType.DELAY.getDes())) delays.add(s);
			else if(s.getTitle().equals(ItemType.LEAVE.getDes())) leaves.add(s);
			else if(s.getTitle().equals(ItemType.LIEU.getDes())) lieus.add(s);
			else if(s.getTitle().equals(ItemType.LATE.getDes())) lates.add(s);
			else if(s.getTitle().equals(ItemType.EARLY.getDes())) earlys.add(s);
		}
		params.put(ItemType.CONTRIBUTION.name(), contributions);
		params.put(ItemType.PLAN.name(), plans);
		params.put(ItemType.PRACTICAL.name(), practicals);
		params.put(ItemType.DELAY.name(), delays);
		params.put(ItemType.LEAVE.name(), leaves);
		params.put(ItemType.LIEU.name(), lieus);
		params.put(ItemType.LATE.name(), lates);
		params.put(ItemType.EARLY.name(), earlys);
		return params;
	}
	
	/**
	 * 用户统计数据集
	 * @param uid
	 * @return
	 */
	private XYDataset createXYDataset(Integer uid, List<SwotResult> list) { 
		TimeSeries timeSeries = null;
		TimeSeriesCollection timeSeriesCollection = new TimeSeriesCollection();
		int i = 1;
		for(SwotResult sr : list) {
			if(i==1) {
				timeSeries = new TimeSeries(sr.getTitle(), Day.class);
			} 
			timeSeries.add(new Day(sr.getDated()), sr.getData());
			if(i%20 == 0) {
				i = 0;
				timeSeriesCollection.addSeries(timeSeries);
			}
			i++;
		}
	    return timeSeriesCollection;  
	}
	
	/**
	 * SWOT工作测试
	 * @param list
	 * @return
	 */
	private List<Task> testTask(List<Task> list) {
		if(list.isEmpty()) return null;
		List<String> result = null;
		List<Float> lf = new ArrayList<Float>();
		for(Task t : list) {
			if(ProcessStatus.Completed.equals(t.getState())) {
				lf.add(t.getActualHours());
			} else if(ProcessStatus.InProgress.equals(t.getState())) {
				lf.add(t.getExpectedHours());
			} else {
				
			}
		}
		
		ItemType item = ItemType.PRACTICAL;
		if(ProcessStatus.Completed.equals(list.get(0).getState())) {
			item = ItemType.CONTRIBUTION;
		}
		
		//统计SWOT
		configs = getSwotConfigs(DateRange.DAY);
		SwotConfig config = configs.get(item.ordinal());
		if (config.getModel().equals(SwotModel.STABLEA) || config.getMethod().equals(SwotModel.STABLEB)) {
			result = swotService.stable(config, lf);
		} else if (config.getMethod().equals(SwotModel.STABLEADVANCED)) {
			result = swotService.advanced(config, lf);
		} else {
			result = swotService.improve(config, lf);
		}
		
		for(int i=0; i<result.size(); i++) {
			String sr = result.get(i);
			Task t = list.get(i);
			t.setSwot(sr);
		}
		return list;
	}
	
	
	/**
	 * 将所有项目的集合通过key得到后进行swot统计，然后再对List集合进行日期和标题的封装
	 * @param dm		所有的项目Map集合
	 * @param key		项目标题
	 * @param range		日期类型（日，周，月，年）
	 * @return	List<SwotResult>
	 */
	private List<SwotResult> getCount(List<Statistics> ls, ItemType item, DateRange range) {
		List<SwotResult> list = new ArrayList<SwotResult>();
		List<String> result = null;
		List<Float> lf = new ArrayList<Float>();
		List<Date> dd = new ArrayList<Date>();
		if(!ls.isEmpty()) {
			for(Statistics s : ls) {
				if(s.getItem().equals(item)) {
					lf.add(s.getData());
					dd.add(s.getDated());
				}
			}
			
			//统计SWOT
			SwotConfig config = configs.get(item.ordinal());
			if (config.getModel().equals(SwotModel.STABLEA) || config.getMethod().equals(SwotModel.STABLEB)) {
				result = swotService.stable(config, lf);
			} else if (config.getMethod().equals(SwotModel.STABLEADVANCED)) {
				result = swotService.advanced(config, lf);
			} else {
				result = swotService.improve(config, lf);
			}
			
			//封装时间字段和标题
			int q = config.getDatum();
			String str = "";
			for(String sr : result) {
				SwotResult res = new SwotResult();
				res.setTitle(config.getItem().getDes());
				res.setItem(config.getItem());
				res.setData(lf.get(q));
				res.setDated(dd.get(q));
				res.setSwot(sr);
				if(DateRange.DAY.equals(range)) str = String.valueOf("D" + DateUtil.getField(Calendar.DAY_OF_MONTH, res.getDated()));
				else if(DateRange.WEEK.equals(range)) str = String.valueOf("W" + DateUtil.getField(Calendar.WEEK_OF_YEAR, res.getDated()));
				else if(DateRange.MONTH.equals(range)) str = String.valueOf("M" + DateUtil.getField(Calendar.MONTH, res.getDated()));
				else if(DateRange.QUARTER.equals(range)) str = String.valueOf("Q" + DateUtil.getQuarter(res.getDated()));
				else str = String.valueOf(DateUtil.getField(Calendar.YEAR, res.getDated()));
				res.setDay(str);
				list.add(res);
				q++;
			}
		}
		return list;
	}
	
	
	/**
	 * swot配置列表
	 * @return
	 */
	private Map<Integer, SwotConfig> getSwotConfigs(DateRange range) {
		configs = new HashMap<Integer, SwotConfig>();
		configs.put(ItemType.CONTRIBUTION.ordinal(), swotService.getSwotConfig(ItemType.CONTRIBUTION, range));
		configs.put(ItemType.PLAN.ordinal(), swotService.getSwotConfig(ItemType.PLAN, range));
		configs.put(ItemType.PRACTICAL.ordinal(), swotService.getSwotConfig(ItemType.PRACTICAL, range));
		configs.put(ItemType.LEAVE.ordinal(), swotService.getSwotConfig(ItemType.LEAVE, range));
		configs.put(ItemType.LIEU.ordinal(), swotService.getSwotConfig(ItemType.LIEU, range));
		configs.put(ItemType.LATE.ordinal(), swotService.getSwotConfig(ItemType.LATE, range));
		configs.put(ItemType.EARLY.ordinal(), swotService.getSwotConfig(ItemType.EARLY, range));
		configs.put(ItemType.DELAY.ordinal(), swotService.getSwotConfig(ItemType.DELAY, range));
		return configs;
	}
	
}
