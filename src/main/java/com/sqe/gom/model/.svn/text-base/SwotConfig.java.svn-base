/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.google.gson.annotations.Expose;
import com.sqe.gom.constant.DateRange;
import com.sqe.gom.constant.ItemType;
import com.sqe.gom.constant.StatisticalMethods;
import com.sqe.gom.constant.SwotModel;

/**
 * @description SWOT Config实体映射表
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Jan 9, 2012
 * @version 3.0
 */
@Table
@Entity
public class SwotConfig implements Serializable {
	private static final long serialVersionUID = -7109896314784402208L;

	@Expose
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id; 			// id号
	
	@Expose
	@Enumerated(EnumType.ORDINAL)
	@Column(name="date_range")
	private DateRange range;		//日期类别
	
	@Expose
	@Enumerated(EnumType.ORDINAL)
	private ItemType item;			//统计项目 {贡献，计划，实际，请假，调休，迟到，早退，延误}
	
	@Expose
	@Column(length = 6, nullable = false)
	private Float centerline; 		// 中心目标
	
	@Expose
	@Column(length = 6, nullable = false)
	private Float upper; 			// 上管线
	
	@Expose
	@Column(length = 6, nullable = false)
	private Float lower; 			// 下管线
	
	//Start property of improve mode
	@Expose
	private Float improveTarget; 	// 改善目标
	
	@Expose
	private Float tolerance; 		//标准差
	//end property of improve mode

	@Expose
	@Enumerated(EnumType.ORDINAL)
	private StatisticalMethods method; // 统计方式

	@Expose
	@Enumerated(EnumType.ORDINAL)
	private SwotModel model; 		// SWOT模式

	@Expose
	private Integer datum; 			// 统计基准值4-8

	//Start property of Stable
	@Expose
	private Float datumS; 			// 基准值 SWOT(Improve和StableAdvanced时不存在，即可为空)
	@Expose
	private Float datumW;
	@Expose
	private Float datumO;
	@Expose
	private Float datumT;
	//end property of Stable

	@Expose
	@Column(length = 6, nullable = false)
	private String colorS = "green"; // 颜色或图标URL SWOT

	@Expose
	@Column(length = 6, nullable = false)
	private String colorW = "red";

	@Expose
	@Column(length = 6, nullable = false)
	private String colorO = "blue";

	@Expose
	@Column(length = 6, nullable = false)
	private String colorT = "yellow";

	//Start property of advenced stable
	@Expose
	private Float distanceCenter; // 距离中心值 (仅StableAdvanced时存在，其他模式时均为空)
	@Expose
	private Boolean isDistanceCenter; // 启用距离中心值
	@Expose
	private Float continuousSameSide; // 连续同一侧
	@Expose
	private Boolean isContinuousSameSide; // 启用连续同一侧
	@Expose
	private Float continuousChange; // 连续变化
	@Expose
	private Boolean isContinuousChange; // 启用连续变化
	@Expose
	private Float continuousStaggered; // 连续交错
	@Expose
	private Boolean isContinuousStaggered; // 启用连续交错
	@Expose
	private Float distanceGtTwo; // 距中心2标准差
	@Expose
	private Boolean isDistanceGtTwo; // 启用距中心2标准差
	@Expose
	private Float distanceGtOne; // 距中心1标准差
	@Expose
	private Boolean isDistanceGtOne; // 启用距中心1标准差
	@Expose
	private Float continuousDistanceLtOne; // 连续距中心1标准差内
	@Expose
	private Boolean isContinuousDistanceLtOne; // 启用连续距中心1标准差内
	@Expose
	private Float continuousDistanceGtOne; // 连续距中心1标准差外
	@Expose
	private Boolean isContinuousDistanceGtOne; // 启用连续距中心1标准差外
	//End property of advenced stable
	
	@OneToMany(cascade=CascadeType.ALL,fetch=FetchType.LAZY, mappedBy ="swotConfig")
	private Set<Summary> summarys = new HashSet<Summary>();
	
	public SwotConfig() {}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public DateRange getRange() {
		return range;
	}

	public void setRange(DateRange range) {
		this.range = range;
	}

	public ItemType getItem() {
		return item;
	}

	public void setItem(ItemType item) {
		this.item = item;
	}

	public Float getCenterline() {
		return centerline;
	}

	public void setCenterline(Float centerline) {
		this.centerline = centerline;
	}

	public Float getImproveTarget() {
		return improveTarget;
	}

	public void setImproveTarget(Float improveTarget) {
		this.improveTarget = improveTarget;
	}

	public Float getTolerance() {
		return tolerance;
	}

	public void setTolerance(Float tolerance) {
		this.tolerance = tolerance;
	}

	public Float getUpper() {
		return upper;
	}

	public void setUpper(Float upper) {
		this.upper = upper;
	}

	public Float getLower() {
		return lower;
	}

	public void setLower(Float lower) {
		this.lower = lower;
	}

	public StatisticalMethods getMethod() {
		return method;
	}

	public void setMethod(StatisticalMethods method) {
		this.method = method;
	}

	public SwotModel getModel() {
		return model;
	}

	public void setModel(SwotModel model) {
		this.model = model;
	}

	public Integer getDatum() {
		return datum;
	}

	public void setDatum(Integer datum) {
		this.datum = datum;
	}

	public Float getDatumS() {
		return datumS;
	}

	public void setDatumS(Float datumS) {
		this.datumS = datumS;
	}

	public Float getDatumW() {
		return datumW;
	}

	public void setDatumW(Float datumW) {
		this.datumW = datumW;
	}

	public Float getDatumO() {
		return datumO;
	}

	public void setDatumO(Float datumO) {
		this.datumO = datumO;
	}

	public Float getDatumT() {
		return datumT;
	}

	public void setDatumT(Float datumT) {
		this.datumT = datumT;
	}

	public String getColorS() {
		return colorS;
	}

	public void setColorS(String colorS) {
		this.colorS = colorS;
	}

	public String getColorW() {
		return colorW;
	}

	public void setColorW(String colorW) {
		this.colorW = colorW;
	}

	public String getColorO() {
		return colorO;
	}

	public void setColorO(String colorO) {
		this.colorO = colorO;
	}

	public String getColorT() {
		return colorT;
	}

	public void setColorT(String colorT) {
		this.colorT = colorT;
	}

	public Float getDistanceCenter() {
		return distanceCenter;
	}

	public void setDistanceCenter(Float distanceCenter) {
		this.distanceCenter = distanceCenter;
	}

	public Boolean getIsDistanceCenter() {
		return isDistanceCenter;
	}

	public void setIsDistanceCenter(Boolean isDistanceCenter) {
		this.isDistanceCenter = isDistanceCenter;
	}

	public Float getContinuousSameSide() {
		return continuousSameSide;
	}

	public void setContinuousSameSide(Float continuousSameSide) {
		this.continuousSameSide = continuousSameSide;
	}

	public Boolean getIsContinuousSameSide() {
		return isContinuousSameSide;
	}

	public void setIsContinuousSameSide(Boolean isContinuousSameSide) {
		this.isContinuousSameSide = isContinuousSameSide;
	}

	public Float getContinuousChange() {
		return continuousChange;
	}

	public void setContinuousChange(Float continuousChange) {
		this.continuousChange = continuousChange;
	}

	public Boolean getIsContinuousChange() {
		return isContinuousChange;
	}

	public void setIsContinuousChange(Boolean isContinuousChange) {
		this.isContinuousChange = isContinuousChange;
	}

	public Float getContinuousStaggered() {
		return continuousStaggered;
	}

	public void setContinuousStaggered(Float continuousStaggered) {
		this.continuousStaggered = continuousStaggered;
	}

	public Boolean getIsContinuousStaggered() {
		return isContinuousStaggered;
	}

	public void setIsContinuousStaggered(Boolean isContinuousStaggered) {
		this.isContinuousStaggered = isContinuousStaggered;
	}

	public Float getDistanceGtTwo() {
		return distanceGtTwo;
	}

	public void setDistanceGtTwo(Float distanceGtTwo) {
		this.distanceGtTwo = distanceGtTwo;
	}

	public Boolean getIsDistanceGtTwo() {
		return isDistanceGtTwo;
	}

	public void setIsDistanceGtTwo(Boolean isDistanceGtTwo) {
		this.isDistanceGtTwo = isDistanceGtTwo;
	}

	public Float getDistanceGtOne() {
		return distanceGtOne;
	}

	public void setDistanceGtOne(Float distanceGtOne) {
		this.distanceGtOne = distanceGtOne;
	}

	public Boolean getIsDistanceGtOne() {
		return isDistanceGtOne;
	}

	public void setIsDistanceGtOne(Boolean isDistanceGtOne) {
		this.isDistanceGtOne = isDistanceGtOne;
	}

	public Float getContinuousDistanceLtOne() {
		return continuousDistanceLtOne;
	}

	public void setContinuousDistanceLtOne(Float continuousDistanceLtOne) {
		this.continuousDistanceLtOne = continuousDistanceLtOne;
	}

	public Boolean getIsContinuousDistanceLtOne() {
		return isContinuousDistanceLtOne;
	}

	public void setIsContinuousDistanceLtOne(Boolean isContinuousDistanceLtOne) {
		this.isContinuousDistanceLtOne = isContinuousDistanceLtOne;
	}

	public Float getContinuousDistanceGtOne() {
		return continuousDistanceGtOne;
	}

	public void setContinuousDistanceGtOne(Float continuousDistanceGtOne) {
		this.continuousDistanceGtOne = continuousDistanceGtOne;
	}

	public Boolean getIsContinuousDistanceGtOne() {
		return isContinuousDistanceGtOne;
	}

	public void setIsContinuousDistanceGtOne(Boolean isContinuousDistanceGtOne) {
		this.isContinuousDistanceGtOne = isContinuousDistanceGtOne;
	}

	public Set<Summary> getSummarys() {
		return summarys;
	}

	public void setSummarys(Set<Summary> summarys) {
		this.summarys = summarys;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).append(getCenterline()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof SwotConfig != true)
			return false;
		SwotConfig other = (SwotConfig) obj;
		return new EqualsBuilder().append(getId(), other.getId()).append(getCenterline(), other.getCenterline()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.id);
		sb.append(",").append(this.range);
		sb.append(",").append(this.centerline);
		sb.append(",").append(this.upper);
		sb.append(",").append(this.lower);
		sb.append(",").append(this.improveTarget);
		sb.append(",").append(this.model);
		sb.append(",").append(this.method);
		sb.append(",").append(this.datumS);
		sb.append(",").append(this.datumW);
		sb.append(",").append(this.datumO);
		sb.append(",").append(this.datumT);
		sb.append(",").append(this.colorS);
		sb.append(",").append(this.colorW);
		sb.append(",").append(this.colorO);
		sb.append(",").append(this.colorT);
		sb.append("}");
		return sb.toString();
	}
}
