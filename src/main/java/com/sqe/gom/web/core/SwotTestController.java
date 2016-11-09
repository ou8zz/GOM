/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.core;

import java.awt.Color;
import java.awt.geom.Ellipse2D;
import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jfree.chart.ChartPanel;
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
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;
import org.jfree.ui.ApplicationFrame;
import org.jfree.ui.RectangleAnchor;
import org.jfree.ui.RectangleInsets;
import org.jfree.ui.TextAnchor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sqe.gom.app.SummaryService;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.vo.UserGroup;

/**
 * @description		此类没有使用
 * @see SWOT测试报表图	
 * @author <a href="mailto:sqe_ole@126.com">OLE</a>
 * @date Sep 19, 2012  9:38:04 PM
 * @version 3.0
 */
@Controller
public class SwotTestController {
	private SummaryService summaryService;
	
	@Autowired
	public void setSummaryService(SummaryService summaryService) {
		this.summaryService = summaryService;
	}
	
	@RequestMapping(method=RequestMethod.GET, value="/app/chart.htm")
	public void saveChartAsJPEG(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("image/JPEG;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		
		summaryService.getSummarys(ug.getId());
//		try {
//			List<SwotResult> list = summaryService.getSummary(ug.getId(), 25, DateRange.DAY);
//			summaryService.saveReportImg(DateRange.DAY, ug.getId(), list, "工时统计", null, res.getOutputStream());
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
	}
	
	
	private static XYDataset createXYDataset() {  
        XYSeries xyseries = new XYSeries("数据");

        //xyseries.setNotify(false);
        xyseries.add(1, 12);
        xyseries.add(2, 17);
        xyseries.add(3, 11);
        xyseries.add(4, 17);
        xyseries.add(5, 9);
        xyseries.add(6, 8);
        xyseries.add(7, 11);
        xyseries.add(8, 20);
        xyseries.add(9, 15);
        xyseries.add(10, 12);
        xyseries.add(11, 17);
        xyseries.add(12, 11);
        xyseries.add(13, 11);
        xyseries.add(15, 20);
        xyseries.add(14, 15);
        
        TimeSeries ts = new TimeSeries("数据", Day.class);
        ts.add(new Day(DateUtil.previous(20*30)), 1);
        ts.add(new Day(DateUtil.previous(4)), 5);
        ts.add(new Day(DateUtil.previous(3)), 2);
        ts.add(new Day(DateUtil.previous(2)), 2);
        ts.add(new Day(DateUtil.previous(1)), 2);
        ts.add(new Day(DateUtil.previous(0)), 2);
        
          
        XYSeries hours = new XYSeries("数据二", false, false); 
//        hours.setNotify(true);
        hours.add(1, 13);
        hours.add(8, 12);
        hours.add(7, 9);
        hours.add(6, 14);
        hours.add(9, 7);
        hours.add(4, 9);
        hours.add(3, 6);
        hours.add(2, 11);
       
        
        
        XYSeries xyS = new XYSeries("S");  
        for(int i=25; i>=0; i--) {
        	xyS.add(i, i);  
        }
        XYSeries xyW = new XYSeries("W");  
        for(int i=25; i>=0; i--) {
        	xyW.add(i, 70);  
        }
        XYSeries xyO = new XYSeries("O");  
        for(int i=25; i>=0; i--) {
        	xyO.add(i, 50);  
        }
        XYSeries xyT = new XYSeries("T");  
        for(int i=25; i>=0; i--) {
        	xyT.add(i, 30);  
        }
        
        XYSeriesCollection xySeriesCollection = new XYSeriesCollection();  
        xySeriesCollection.addSeries(xyseries);  
        
        TimeSeriesCollection timeSeriesCollection = new TimeSeriesCollection();
        timeSeriesCollection.addSeries(ts);
        //xySeriesCollection.addSeries(hours);
//        xySeriesCollection.addhttp://localhost:88/gom/app/chart.htmSeries(xyS);
//        xySeriesCollection.addSeries(xyO);
//        xySeriesCollection.addSeries(xyT);
          
        return timeSeriesCollection;  
	}
	
	public static void main(String[] arg) {
		ApplicationFrame af = new ApplicationFrame("SWOT");
		
		XYSplineRenderer renderer = new XYSplineRenderer();
		renderer.setSeriesShapesFilled(1, true);
		renderer.setBaseShapesVisible(true); 		//绘制的线条上不显示图例，如果显示的话，会使图片变得很丑陋
		renderer.setPrecision(1); 					//设置精度，大概意思是在源数据两个点之间插入10个点以拟合出一条平滑曲线
		renderer.setSeriesPaint(0, Color.CYAN); 	//设置0号数据的颜色。这是手工设置线条颜色的方法
		renderer.setSeriesPaint(1, Color.GREEN);
		renderer.setSeriesPaint(2, Color.BLUE);
		renderer.setSeriesPaint(3, Color.YELLOW);
		renderer.setSeriesPaint(4, Color.RED);
		renderer.setSeriesShape(0, new Ellipse2D.Double(-3.0, -3.0, 6.0, 6.0));
        renderer.setSeriesShape(1, new Ellipse2D.Double(-3.0, -3.0, 6.0, 6.0));
        
		//create plot
        DateAxis xAxis = new DateAxis("日期");
        //xAxis.setAutoTickUnitSelection(false);
        xAxis.setTickMarksVisible(false);
        xAxis.setAutoRange(false);
		xAxis.setMinimumDate(DateUtil.previous(20*31));
        xAxis.setMaximumDate(DateUtil.previous(0));
        DateFormat chartFormatter = new SimpleDateFormat("yy-MM");
        xAxis.setDateFormatOverride(chartFormatter);
        StandardXYToolTipGenerator ttg = new StandardXYToolTipGenerator(StandardXYToolTipGenerator.DEFAULT_TOOL_TIP_FORMAT, chartFormatter, NumberFormat.getInstance());
        renderer.setBaseToolTipGenerator(ttg);
        
//        NumberAxis xAxis1 = new NumberAxis("日期");
//        xAxis1.setAutoRangeIncludesZero(false);
//        xAxis1.setRangeType(RangeType.FULL);
        
		NumberAxis yAxis = new NumberAxis("数据");
		yAxis.setAutoRangeIncludesZero(false);
		yAxis.setRange(0, 19);
		 
		XYPlot plot = new XYPlot(createXYDataset(), xAxis, yAxis, renderer);
//		plot.setBackgroundPaint(Color.gray);
//		plot.setDomainGridlinePaint(Color.white);
//		plot.setRangeGridlinePaint(Color.white);
		plot.setAxisOffset(new RectangleInsets(5D, 5D, 5D, 5D)); //设置坐标轴与绘图区域的距离
//		ValueMarker valuemarker = new ValueMarker(200D);
//		plot.addRangeMarker(valuemarker);
//		plot.setDomainCrosshairVisible(true);
//		plot.setRangeCrosshairVisible(true);
//		plot.setWeight(10);
		 
		// add a labelled marker for the bid start price...
        final Marker up = new ValueMarker(9.0);
        up.setLabel("上管线");
        up.setPaint(Color.green);
        up.setLabelAnchor(RectangleAnchor.BOTTOM_RIGHT);
        up.setLabelTextAnchor(TextAnchor.TOP_RIGHT);
        plot.addRangeMarker(up);
        
        // add a labelled marker for the bid start price...
        final Marker start = new ValueMarker(3.0);
        start.setLabel("中心线");
        start.setPaint(Color.blue);
        start.setLabelAnchor(RectangleAnchor.BOTTOM_RIGHT);
        start.setLabelTextAnchor(TextAnchor.TOP_RIGHT);
        plot.addRangeMarker(start);
        
        // add a labelled marker for the bid start price...
        final Marker down = new ValueMarker(1.0);
        down.setLabel("下管线");
        down.setPaint(Color.red);
        down.setLabelAnchor(RectangleAnchor.BOTTOM_RIGHT);
        down.setLabelTextAnchor(TextAnchor.TOP_RIGHT);
        plot.addRangeMarker(down);
        
		JFreeChart chart = new JFreeChart("SWOT统计", 	//标题
						JFreeChart.DEFAULT_TITLE_FONT, 	//标题的字体，这样就可以解决中文乱码的问题
						plot,
						true //图片底部显示图例
						);
		
		ChartPanel chartpanel = new ChartPanel(chart);
		af.add(chartpanel);
		
		//将内存中的图片写到本地硬盘
        try {
			ChartUtilities.saveChartAsJPEG(new File("d:/pie.jpg"), chart, 400, 200);
		} catch (IOException e) {
			e.printStackTrace();
		}
        
		af.pack();
		af.setVisible(true);
	}
}
