/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import java.awt.Color;
import java.awt.geom.Rectangle2D;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hslf.model.Placeholder;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer;
import org.jfree.chart.renderer.xy.XYSplineRenderer;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DatasetChangeListener;
import org.jfree.data.general.DatasetGroup;
import org.jfree.data.xy.DefaultXYDataset;
import org.jfree.data.xy.XYBarDataset;
import org.jfree.data.xy.XYDataset;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;
import org.jfree.ui.RectangleInsets;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.Request;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import static org.junit.Assert.*;
import com.sqe.gom.BaseTest;
import com.sqe.gom.constant.StatisticalMethods;
import com.sqe.gom.constant.SwotModel;
import com.sqe.gom.model.SwotConfig;
import com.sqe.gom.model.SwotResult;

/**
 * @description
 * @see 在此描述依赖的其他接口或类
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Sep 19, 2012  9:38:04 PM
 * @version 3.0
 */
public class SwotTest {
	public static void main(String[] args) {
		
	}
	
	public JFreeChart createChart() {
		DefaultCategoryDataset dcd = new DefaultCategoryDataset();
		dcd.addValue(500, "java", "J2EE类");
		dcd.addValue(500, "java", "J2SE类");
		dcd.addValue(500, "java", "J2ME类");
		JFreeChart jfc = ChartFactory.createBarChart3D(
				"JAVA图书销量统计", 			//图标标题
				"JAVA图书", 					//横轴标题
				"销量(本)", 					//纵轴标题
				dcd,						//数据集
				PlotOrientation.HORIZONTAL, //图表方向
				false, 						//是否显示图例标识
				false, 						//是否显示tooltips
				false						//是否支持超链接
				);
		
		return jfc;
	}
	
	public void saveChartAsJPEG(HttpServletResponse response) {
		XYSplineRenderer renderer = new XYSplineRenderer();
		renderer.setBaseShapesVisible(false); 		//绘制的线条上不显示图例，如果显示的话，会使图片变得很丑陋
		renderer.setSeriesPaint(0, Color.GREEN); 	//设置0号数据的颜色。这是手工设置线条颜色的方法
		renderer.setPrecision(5); 					//设置精度，大概意思是在源数据两个点之间插入5个点以拟合出一条平滑曲线
		 
		//create plot
		NumberAxis xAxis = new NumberAxis("Time(ns)");
		xAxis.setAutoRangeIncludesZero(false);
		NumberAxis yAxis = new NumberAxis("Voltage(mv)");
		yAxis.setAutoRangeIncludesZero(false);
		 
		XYPlot plot = new XYPlot(createXYDataset(), xAxis, yAxis, renderer);
		plot.setBackgroundPaint(Color.black);
		plot.setDomainGridlinePaint(Color.white);
		plot.setRangeGridlinePaint(Color.white);
		plot.setAxisOffset(new RectangleInsets(4, 4, 4, 4)); //设置坐标轴与绘图区域的距离
		 
		JFreeChart chart = new JFreeChart("细胞电压图", //标题
						JFreeChart.DEFAULT_TITLE_FONT, //标题的字体，这样就可以解决中文乱码的问题
						plot,
						false //不在图片底部显示图例
						);
		 
		try {
			ChartUtilities.writeChartAsPNG(response.getOutputStream(), chart, 1024, 768, null);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private XYDataset createXYDataset() {  
        XYSeries xyseries1 = new XYSeries("One");  
        xyseries1.add(1987, 50);  
        xyseries1.add(1997, 20);  
        xyseries1.add(2007, 30);  
          
        XYSeries xyseries2 = new XYSeries("Two");  
        xyseries2.add(1987, 20);  
        xyseries2.add(1997, 10D);  
        xyseries2.add(2007, 40D);  
          
  
        XYSeries xyseries3 = new XYSeries("Three");  
        xyseries3.add(1987, 40);  
        xyseries3.add(1997, 30.0008);  
        xyseries3.add(2007, 38.24);  
          
  
        XYSeriesCollection xySeriesCollection = new XYSeriesCollection();  
  
        xySeriesCollection.addSeries(xyseries1);  
        xySeriesCollection.addSeries(xyseries2);  
        xySeriesCollection.addSeries(xyseries3);  
          
        return xySeriesCollection;  
	}
	
	private void dcd() {
		DefaultCategoryDataset dcd = new DefaultCategoryDataset();
		dcd.addValue(500, "java", "J2EE类");
		dcd.addValue(500, "java", "J2SE类");
		dcd.addValue(500, "java", "J2ME类");
		
		Rectangle2D legendShape = new Rectangle2D.Double(1.0, 2.0, 3.0, 4.0);
		System.out.println(legendShape.getFrame());
	}
}
