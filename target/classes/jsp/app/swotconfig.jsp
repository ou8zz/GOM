<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>

<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>

<style type="text/css">
#lf dd {width:320px; height:78px; float:left;}
#lf dd input.inpc{border:1px solid #628EB1;height:22px;line-height:22px;margin-left:5px;width:140px;font-size:1em; }
#lf dd label span{width:60px; display:-moz-inline-box; display:inline-block; }
#lf dd input.inpd{border:1px solid #628EB1;height:22px;line-height:22px;margin-left:5px;width:180px;font-size:1em; }
.dat{width:20px; display:-moz-inline-box; display:inline-block; }

.trace_tab{width:50%;margin:auto;overflow:hidden;float:left;}
.trace_tab th, .trace_tab td{color:#333;border-collapse:collapse;border:1px solid #aabcfe; padding:3px;}
.trace_tab th{background-color:#b9c9fe;text-align:center;vertical-align:middle;font-weight:bold;}
.trace_tab td.bg{background-color:#e8edff;text-align:center;}
.trace_tab td.trg{text-align:right;vertical-align:middle;background-color:#e8edff;}
.trace_tab td.nob_t_b{border-top:none;border-bottom:none;text-align:center;}
.trace_tab td.nob_l_r{border-left:none;border-right:none;text-align:center;}
.trace_tab td.nobo{border:none;text-align:center;}

.submit_but{background-color:transparent;background-image:url(../scripts/common/images/aqua_but.png);background-repeat:no-repeat;width:86px;height:25px;background-position:0 0;border-width:0;}
.submit_but:hover{background-position:0 -25px;color:#5890D1;}
</style>

<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/utils.js" type="text/javascript"></script>
<script src="../scripts/app/swotconfig.js" type="text/javascript"></script>

<title><fmt:message key="swot.config.page.title" /> -SQE SERVICE GOM</title>

</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<div id="g_mgr">
<table id="sc_tb"></table>
<div id="sc_pg"></div>
</div>
<div id="gConsole"><span style="color:red;"><fmt:message key="general.delete.msg" /></span></div>
<div id="test_g"></div>
<div id="content_main">
<form id="swotcForm">
<input type="hidden" id="id" name="id" />
<input type="hidden" id="sid" name="sid" />
<dl id="lf" class="dl_swot">
	<dd>
     <label class="label"><fmt:message key="swot.dateRange" /></label>
     <select id="range" class="inp"> 
	     <option value="DAY"><fmt:message key="swot.date.day" /></option> 
	     <option value="WEEK"><fmt:message key="swot.date.week" /></option> 
	     <option value="MONTH"><fmt:message key="swot.date.month" /></option> 
	     <option value="YEAR"><fmt:message key="swot.date.year" /></option>
      </select>
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.item" /></label>
     <select id="item" class="inp"> 
	     <option value=""><fmt:message key="general.select" /></option> 
	     <option value="CONTRIBUTION"><fmt:message key="swot.item.contribution" /></option> 
	     <option value="PLAN"><fmt:message key="swot.item.plan" /></option> 
	     <option value="PRACTICAL"><fmt:message key="swot.item.practical" /></option>
	     <option value="LEAVE"><fmt:message key="swot.item.leave" /></option>
	     <option value="LIEU"><fmt:message key="swot.item.lieu" /></option>
	     <option value="LATE"><fmt:message key="swot.item.late" /></option>
	     <option value="EARLY"><fmt:message key="swot.item.early" /></option>
	     <option value="DELAY"><fmt:message key="swot.item.delay" /></option>
      </select>
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.model" /></label>
     	<select id="model" class="inp"> 
		     <option value=""><fmt:message key="general.select" /></option> 
		     <option value="STABLEA"><fmt:message key="swot.model.stablea" /></option> 
		     <option value="STABLEB"><fmt:message key="swot.model.stableb" /></option> 
		     <option value="STABLEADVANCED"><fmt:message key="swot.model.stableadvanced" /></option>
		     <option value="IMPROVE"><fmt:message key="swot.model.improve" /></option>
      	</select>
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.centerline" /></label><input id="centerline" name="centerline" maxlength="6" class="inp"/>
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.upper" /></label><input id="upper" name="upper" maxlength="6" class="inp"/>
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.lower" /></label><input id="lower" name="lower" maxlength="6" class="inp"/>
   </dd>
   <dd>
     <label class="label" id="l_datum"><fmt:message key="swot.datum" /></label><input id="datum" name="datum" maxlength="1" class="inp"/>
   </dd>
   <dd id="dd_improveTarger">
     <label class="label"><fmt:message key="swot.improveTarget" /></label><input id="improveTarget" name="improveTarget" maxlength="6" class="inp"/>
   </dd>
   <dd id="dd_method">
     <label class="label"><fmt:message key="swot.method" /></label>
     <select id="method" class="inp">
     	<option value="STDEV"><fmt:message key="swot.stdev" /></option>
	    <option value="PERCENTAGE"><fmt:message key="swot.percentage" /></option> 
	 </select>
   </dd>
   <dd>
     <label class="lab"><fmt:message key="swot.colors" /><input id="colorS" class="inpc" /><span id="scs">&nbsp;</span></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.colorw" /><input id="colorW" class="inpc" /><span id="scw">&nbsp;</span></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.coloro" /><input id="colorO" class="inpc" /><span id="sco">&nbsp;</span></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.colort" /><input id="colorT" class="inpc" /><span id="sct">&nbsp;</span></label>
   </dd>
</dl>
<dl id="lf" class="datum">
   <dd>
     <label class="label"><fmt:message key="swot.datums" /></label><input id="datumS" name="datumS" maxlength="6" class="inpd"/><span class="dat">&nbsp;%</span>
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.datumw" /></label><input id="datumW" name="datumW" maxlength="6" class="inpd"/><span class="dat">&nbsp;%</span>
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.datumo" /></label><input id="datumO" name="datumO" maxlength="6" class="inpd"/><span class="dat">&nbsp;%</span>
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.datumt" /></label><input id="datumT" name="datumT" maxlength="6" class="inpd"/><span class="dat">&nbsp;%</span>
   </dd>
</dl>   
<dl id="lf" class="values">
   <dd id="dd_dc">
     <label class="label"><fmt:message key="swot.distanceCenter" /></label><input id="distanceCenter" name="distanceCenter" maxlength="6" class="inpc"/>
   </dd>
   <dd id="dd_isdc">
     <label class="label"><fmt:message key="swot.isDistanceCenter" /></label><input id="isDistanceCenter" name="isDistanceCenter" type="checkbox" />
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.continuousSameSide" /></label><input id="continuousSameSide" name="continuousSameSide" maxlength="6" class="inpc"/>
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.isContinuousSameSide" /></label><input id="isContinuousSameSide" name="isContinuousSameSide" type="checkbox"  />
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.continuousChange" /></label><input id="continuousChange" name="continuousChange" maxlength="6" class="inpc"/>
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.isContinuousChange" /></label><input id="isContinuousChange" name="isContinuousChange" type="checkbox"  />
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.continuousStaggered" /></label><input id="continuousStaggered" name="continuousStaggered" maxlength="6" class="inpc"/>
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.isContinuousStaggered" /></label><input id="isContinuousStaggered" name="isContinuousStaggered" type="checkbox"  />
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.distanceGtOne" /></label><input id="distanceGtOne" name="distanceGtOne" maxlength="6" class="inpc"/>
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.isDistanceGtOne" /></label><input id="isDistanceGtOne" name="isDistanceGtOne" type="checkbox"  />
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.distanceGtTwo" /></label><input id="distanceGtTwo" name="distanceGtTwo" maxlength="6" class="inpc"/>
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.isDistanceGtTwo" /></label><input id="isDistanceGtTwo" name="isDistanceGtTwo" type="checkbox"  />
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.continuousDistanceLtOne" /></label><input id="continuousDistanceLtOne" name="continuousDistanceLtOne" maxlength="6" class="inpc"/>
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.isContinuousDistanceLtOne" /></label><input id="isContinuousDistanceLtOne" name="isContinuousDistanceLtOne" type="checkbox"  />
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.continuousDistanceGtOne" /></label><input id="continuousDistanceGtOne" name="continuousDistanceGtOne" maxlength="6" class="inpc"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="swot.isContinuousDistanceGtOne" /></label><input id="isContinuousDistanceGtOne" name="isContinuousDistanceGtOne" type="checkbox"  />  
   </dd>
 </dl>
</form> 
</div> <!-- end content_main -->
</div> <!-- end content -->
</div> <!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div> <!-- end container_24 -->
</body>
</html>
