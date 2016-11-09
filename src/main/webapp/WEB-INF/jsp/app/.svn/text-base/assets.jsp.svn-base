<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link href="../styles/global.css" media="screen" rel="stylesheet" type="text/css"/>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<style type="text/css">
#content_main dl{position:relative;text-align:left;}
#content_main dl dd{width:320px;height:68px;line-height:58px;float:left;margin-right:5px;position:relative;}
#content_main dl dd.textarea{width:650px;}
#content_main dl dd label{line-height:26px;height:26px;width:115px;text-align:right;color:#0E5080;}
#content_main dl dd input,#content_main dl dd select{border:1px solid #628EB1;height:22px;line-height:22px;margin-left:5px;width:200px;}
#content_main dl dd input.minp{width:90px;}
#content_main dl dd select.minp{width:90px;margin-right:5px}
#content_main dl dd label.error{color:red;height:10px;width:200px;float:left;margin-top:-10px;}
</style>

<script src="../scripts/common/utils.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/uploadify-2.1.4.js" type="text/javascript"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/app/asset.js" type="text/javascript"></script>

<title><fmt:message key="asset.page.title" /> -SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<div id="g_mgr">
<table id="asset_tb"></table>
<div id="asset_pg"></div>
</div>

<div id="content_main">
<form id="assetForm">
<input type="hidden" id="id" name="id" />
<input type="hidden" id="attachment" name="attachment" />
<dl id="lf">
   <dd><label class="lab"><fmt:message key="asset.name" /></label><input id="assetName" name="assetName" maxlength="20" class="inp"/></dd>
   <dd>
     <label class="lab"><fmt:message key="asset.type" /></label>
     <select id="assetType" name="assetType" class="inp required">
     	<option value="COMPUTER"><fmt:message key="asset.type.computer" /></option>
     	<option value="CONSUMABLES"><fmt:message key="asset.type.consumables" /></option>
     	<option value="DAILY_OFFICE"><fmt:message key="asset.type.daily" /></option>
    </select>
   </dd>
   <dd>
     <label class="lab"><fmt:message key="asset.ascription" /></label>
     	<select id="ascription" name="ascription" class="inp required">
			<c:forEach var="va" items="${departments}">
   				<option value="${va.cname}">${va.cname }</option>
   			</c:forEach>
        </select>
   </dd>
   <dd>
     <label class="lab"><fmt:message key="asset.state" /></label>
     <select id="assetState" name="assetState" class="inp required">
     	<option value="IN_SHELF_LIFE"><fmt:message key="asset.state.in" /></option>
     	<option value="OUT_SHELF_LIFE"><fmt:message key="asset.state.out" /></option>
     	<option value="AVAILABLE"><fmt:message key="asset.state.available" /></option>
     	<option value="UNAVAILABLE"><fmt:message key="asset.state.unavailable" /></option>
     	<option value="DAMAGE"><fmt:message key="asset.state.damage" /></option>
     	<option value="REPAIRCING"><fmt:message key="asset.state.repaircing" /></option>
    </select>
   </dd>
   <dd>
     <label class="lab"><fmt:message key="asset.buyNum" /></label>
     <input id="buyNum" name="buyNum" maxlength="10" class="minp"/>
     <select id="unit" name="unit" class="minp">
     	<option><fmt:message key="asset.util.gei" /></option>
     	<option><fmt:message key="asset.util.zhi" /></option>
     	<option><fmt:message key="asset.util.jian" /></option>
     	<option><fmt:message key="asset.util.xiang" /></option>
     </select>
     <label class="error" generated="true" for="buyNum"></label>
   </dd>
   <dd id="admin_id"><label class="lab"><fmt:message key="asset.admin" /></label><input id="admin" name="admin" maxlength="20" class="inp" readonly="readonly"/></dd>
   <dd><label class="lab"><fmt:message key="asset.buyer" /></label>
   		<select id="buyDpt" class="minp">
   			<option value=""><fmt:message key="general.select" /></option>
   			<c:forEach var="va" items="${departments}">
   				<option value="${va.id}">${va.cname }</option>
   			</c:forEach>
        </select>
        <select id="buyer" name="buyer" class="minp"></select>
        </dd>
   <dd><label class="lab"><fmt:message key="asset.buyDate" /></label><input id="buyDate" name="buyDate" maxlength="20" class="inp required" readonly="readonly"/></dd>
   <dd><label class="lab"><fmt:message key="asset.warrantyDate" /></label><input id="warrantyDate" name="warrantyDate" maxlength="20" class="inp required" readonly="readonly"/></dd>
   <dd><label class="lab"><fmt:message key="asset.controlDate" /></label><input id="controlDate" name="controlDate" maxlength="20" class="inp required" readonly="readonly"/></dd>
   <dd><label class="lab"><fmt:message key="asset.scrapDate" /></label><input id="scrapDate" name="scrapDate" maxlength="20" class="inp required" readonly="readonly"/></dd>
   <dd><label class="lab"><fmt:message key="general.explain" /></label><textarea id="des" name="des" class="area" cols="29" rows="2"></textarea></dd>
   <dd><label class="lab"><fmt:message key="general.attachment" /></label><input type="file" id="att" name="att" /></dd>
 </dl>
</form> 
</div><!-- end content_main -->
</div><!-- end content -->
</div><!-- end grid 24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->

</body>
</html>
