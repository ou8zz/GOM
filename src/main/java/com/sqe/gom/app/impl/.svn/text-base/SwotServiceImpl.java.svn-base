/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sqe.gom.app.SwotService;
import com.sqe.gom.constant.DateRange;
import com.sqe.gom.constant.ItemType;
import com.sqe.gom.constant.StatisticalMethods;
import com.sqe.gom.dao.SwotConfigDAO;
import com.sqe.gom.model.SwotConfig;
import com.sqe.gom.model.SwotResult;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.JGridBase;
import com.sqe.gom.web.core.expand.JGridHelper;

/**
 * @description SwotService 接口实现类
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 19, 2012
 * @version 3.0
 */
@Service("swotService")
public class SwotServiceImpl implements SwotService {
	private SwotConfigDAO swotConfigDao;
	
	@Autowired
	public void setSwotConfigDao(SwotConfigDAO swotConfigDao) {
		this.swotConfigDao = swotConfigDao;
	}
	
	@Override
	public List<String> stable(SwotConfig sc, List<Float> data) {
		return stableAlgorithm(sc, rebuildList(sc, data));
	}

	@Override
	public List<String> improve(SwotConfig sc, List<Float> data) {
		return improveAlgorithm(sc, rebuildList(sc, data));
	}
	
	@Override
	public List<String> advanced(SwotConfig sc, List<Float> data) {
		return advancedAlgorithm(sc, rebuildList(sc,data));
	}
	
	@Override
	public void saveSwotConfig(SwotConfig sc) {
		if(RegexUtil.notEmpty(sc.getId())) {
			swotConfigDao.update(sc);
		} 
		else swotConfigDao.create(sc);
	}
	
	@Override
	public SwotConfig getSwotConfig(ItemType item, DateRange range) {
		return swotConfigDao.getSwotConfig(item, range);
	}
	
	@Override
	public JGridBase<SwotConfig> getSwotConfigs(JGridHelper<SwotConfig> grid) {
		String ord = " ORDER BY p.";
		if(RegexUtil.notEmpty(grid.getJq().getSidx())) ord += grid.getJq().getSidx() + " " + grid.getJq().getSord();
		else ord += "id asc";
		grid.getJq().setList(swotConfigDao.getSwotConfigs(ord, grid.getQ(), grid.getP()));
		grid.getJq().setRecords(grid.getP().getTotalCount());
		grid.getJq().setTotal(grid.getP().getPageCount());
		return grid.getJq();
	}

	@Override
	public void removeSwotConfig(Integer id) {
		swotConfigDao.delete(id);
	}
	
	/**
	 * 改善统计
	 * 
	 * SWOT改善 判定规则(4≤x≤8)：
	 * Strength  ①. X均值大于等于目标值；
	 * Opportunity  ①. 均值未达标，但有x-1点连续≥目标植；
	 * Threat  ①.不论均值是否达标，只要x-1连续向下，则判为T
	 * Weak  ①.连续x点向下； 
	 * T 四项条件均不满足，则为T
	 * 
	 * u 二次修正  Opportunity 之前为绿（S），而下一点 < 前一点（相减值为负）
	 */
	private List<String> improveAlgorithm(SwotConfig sc, List<SwotResult> list){
		List<String> average = Collections.emptyList();
		
		if(sc.getDatum() > 0 && sc.getDatum() < list.size()) {
			average = new ArrayList<String>();
			//不需要上下管线 Float[] datum = getLimit(sc.getImproveTarget(), sc.getTolerance(), sc.getMethod());
			//计算均值
			for(int i=sc.getDatum(),j=0; i < list.size(); i++, j++) {
				Float avg = (float) 0.0;
				int k=0;
				int trendQ=0,trendR=0;
				while(k < sc.getDatum()) {
					avg =avg+list.get(j+k).getData();
					if(list.get(j+k).getData() >= sc.getImproveTarget()){trendQ++;trendR=0;}
					else{trendR--;trendQ=0;}
					k++;
				}
				
				avg = avg/sc.getDatum();
				
				if(avg >= sc.getImproveTarget()) average.add(sc.getColorS());
				else if(avg<sc.getImproveTarget() && trendQ == sc.getDatum()-1) average.add(sc.getColorO());
				else if(sc.getDatum()+trendR==1) average.add(sc.getColorT());
				else if(sc.getDatum()+trendR==0) average.add(sc.getColorW());
				else average.add(sc.getColorT());
			}
		}
		
		return average;
	}
	
	/**
	 * 稳定B/C 统计模式
	 * 
	 * 若model为百分比 , 则上、下管线＝(±允差% * 中心值)/2 + 中心值
	 * 若model为公差，则上、下管线 = 中心值 ± 公差/2
	 * 
	 * 上管线 = 中心值 + (1% * 中心值)/2
	 * 下管线 = 中心值 - (1% * 中心值)/2
	 * 
	 * @param sc   需要传入所选择的SWOT统计模式
	 * @param list 仅传入SwotResult(id, data)两个字段即可
	 * @return 返回SwotResult封装的列表清单
	 */
	private List<String> stableAlgorithm(SwotConfig sc, List<SwotResult> list) {
		//默认公差
		List<String> res = Collections.emptyList();
		
		//如果为百分比
		if(sc.getMethod().equals(StatisticalMethods.PERCENTAGE)) {
			sc.setDatumS(sc.getDatumS()/100);
			sc.setDatumW(sc.getDatumW()/100);
			sc.setDatumO(sc.getDatumO()/100);
			sc.setDatumT(sc.getDatumT()/100);
		}

		Float[] datumS = getLimit(sc.getCenterline(), sc.getDatumS(), sc.getMethod());
		Float[] datumW = getLimit(sc.getCenterline(), sc.getDatumW(), sc.getMethod());
		Float[] datumO = getLimit(sc.getCenterline(), sc.getDatumO(), sc.getMethod());
		Float[] datumT = getLimit(sc.getCenterline(), sc.getDatumT(), sc.getMethod());
		
		if(list.size() >= sc.getDatum()) {
			res = new ArrayList<String>();
			int i = 0;
			for(SwotResult d : list) {
				String swot = null;
				//case: S
				if(d.getData() > datumS[0] && d.getData() < datumS[1]) {
					swot = sc.getColorS();
				}
				//case: O
				else if(d.getData() >= datumO[0] && d.getData() < datumO[1]) {
					swot = sc.getColorO();
				}
				//case: T
				else if(d.getData() >= datumT[0] && d.getData() < datumT[1]) {
					swot = sc.getColorT();
				}
				//case: W
				else if(d.getData() > datumW[1] || d.getData() < datumW[0]) {
					swot = sc.getColorW();
				} 
				else swot = sc.getColorW();
				
				if(i >= sc.getDatum()) {
					res.add(swot);
				}
				i++;
			}
		}
		
		return res;
	}
	
	/**
	 * 进阶模式
	 * 
	 * 在以下條件下是查出黃(T)
	 *   1. 1各点，距离中心点大于K个标准差
	 *   2. 连续K点在中心线同一侧
	 *   3. 连续K个点，全部递增或全部递减
	 *   4. 连续K个点，上下交错
	 *   5. K+1个点中有K个点，距离中心线(同侧)大于2个标准差
	 *   6. K+1个点中有K个点，距离中心线(同侧)大于1个标准差
	 *   7. 连续 K个点，距离中心线（任一侧）1个标准差以内
	 *   8. 连续 K个点，距离中心线（任一侧）大于1个标准差
	 * 
	 * 在+/-1S下, 且上下波動，不被黃檢出是查出綠(S)
	 * 在超出+/-3S是紅(W)
	 * 在以上條件，且都在=/-3內，是蓝。
	 * 
	 * @param sc   需要传入所选择的SWOT统计模式
	 * @param list 仅传入SwotResult(id, data)两个字段即可
	 * @return 返回SwotResult封装的列表清单
	 */
	public List<String> advancedAlgorithm(SwotConfig sc, List<SwotResult> list) {
		List<String> average = Collections.emptyList();
		
		if(list.size() >= 25) {
			if(sc.getDatum() > 0 && sc.getDatum() < list.size()) {
				average = new ArrayList<String>();
				//计算均值
				for(int i=sc.getDatum()-1,j=0; i < list.size(); i++, j++) {
					Float avg = (float) 0.0;
					int k=0;
					int p=0,n=0;//positive简称p 正数       Negative 简称n 负数
					int c=0,d=0; //c增加, d减少
					int jc=0; //交错
					int b1=0,b2=0,lb1=0,gb1=0;//标准差
					
					while(k < sc.getDatum()) {
						avg =avg+list.get(j+k).getData();
						int bc = (int) (list.get(j+k).getData() - sc.getCenterline());
						//判断与中心值的标准差
						if(bc >= 0){p++;n=0;}
						else{p--;n=0;}
						
						//判断趋势(同侧）
						if((list.get(j+k).getData()-list.get(j+k-1).getData()) > 0) {
							c++;d=0;
							
							//同侧大于标准差
							if(Math.abs(bc) >= 2){b2++;b1=0;}
							else if(Math.abs(bc) >= 1){b1++;b2=0;}
							
							//判断交错
							if((list.get(j+k+1).getData()-list.get(j+k).getData()) < 0) jc++;
						}else {
							d++;c=0;
							//同侧大于标准差
							if(Math.abs(bc) >= 2){b2++;b1=0;}
							else if(Math.abs(bc) >= 1){b1++;b2=0;}
						}
						
						//任一侧1个标准差
						if(Math.abs(bc) >= 1){gb1++;lb1=0;}
						else{lb1++;gb1=0;}
						
						k++;
						//k+1个同侧标差
						if((list.get(j+k).getData()-list.get(j+k-1).getData()) > 0) {
							//同侧大于标准差
							if(Math.abs(bc) >= 2){b2++;b1=0;}
							else if(Math.abs(bc) >= 1){b1++;b2=0;}
						}else {
							//同侧大于标准差
							if(Math.abs(bc) >= 2){b2++;b1=0;}
							else if(Math.abs(bc) >= 1){b1++;b2=0;}
						}
					}
					
					avg = avg/sc.getDatum();
					
					//在以下条件下是查出黄(T)
					if(sc.getIsDistanceCenter() && Math.abs(sc.getCenterline()-avg) > sc.getDistanceCenter()) average.add(sc.getColorT());
					else if(sc.getIsContinuousSameSide() && (p == sc.getContinuousSameSide()|| n == sc.getContinuousSameSide())) average.add(sc.getColorT());
					else if(sc.getIsContinuousChange() && (sc.getContinuousChange()==c || sc.getContinuousChange()==d)) average.add(sc.getColorT());
					else if(sc.getIsContinuousStaggered() && sc.getContinuousStaggered() == jc) average.add(sc.getColorT());
					else if(sc.getIsDistanceGtTwo() && sc.getDistanceGtTwo() == b2) average.add(sc.getColorT());
					else if(sc.getIsDistanceGtOne() && sc.getDistanceGtOne() == b1) average.add(sc.getColorT());
					else if(sc.getIsContinuousDistanceLtOne() && sc.getContinuousDistanceGtOne()==lb1) average.add(sc.getColorT());
					else if(sc.getIsContinuousDistanceGtOne() && sc.getContinuousDistanceGtOne()==gb1) average.add(sc.getColorT());
					else if(Math.abs(sc.getCenterline()-avg) < 1) average.add(sc.getColorS());
					else if(Math.abs(sc.getCenterline()-avg) > 3) average.add(sc.getColorW());
					else average.add(sc.getColorO());
				}
			}
		}
		
		return average;
	}
	
	//Calculation of the upper and lower limits
	private Float[] getLimit(Float centerline, Float swotDatum, StatisticalMethods method) {
		Float datum;
		if(StatisticalMethods.PERCENTAGE.equals(method))datum = (swotDatum * centerline)/2;
		else datum = swotDatum/2;
		return new Float[]{centerline-datum,centerline+datum};
	}
	
	//对data重新封装
	private List<SwotResult> rebuildList(SwotConfig sc, List<Float> data) {
		List<SwotResult> sr = new ArrayList<SwotResult>();
		
		for(Float f : data) {
			sr.add(new SwotResult(sc.getModel(),f));
		}
		
		return sr;
	}
}
