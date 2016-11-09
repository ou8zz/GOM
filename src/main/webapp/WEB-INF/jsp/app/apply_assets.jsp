<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>

<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<style type="text/css">
#content_main dl{position:relative;text-align:left;}
#content_main dl dd{width:320px;height:68px;line-height:58px;float:left;margin-right:5px;position:relative;}
#content_main dl dd.textarea{width:650px;}
#content_main dl dd label{line-height:26px;height:26px;width:115px;text-align:right;color:#0E5080;}
#content_main dl dd input,#content_main dl dd select{border:1px solid #628EB1;height:22px;line-height:22px;margin-left:5px;width:200px;}
#content_main dl dd label.error{color:red;height:10px;width:200px;float:left;margin-top:-10px;}

#show_title{position:relative;border-bottom:1px solid #36F;}
#show_title span{padding-left:10px;}
#show_title p{padding:0;float:right;}
#show_title p em{padding-left:20px;color:blue;font-style:normal;}
#describe,#staff{position:relative;}
#describe label{float:left;width:80px;}
#describe p{width:474px;float:left;}
#staff label{float:left;width:150px;}
</style>
<script src="../scripts/common/utils.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/app/apply_asset.js" type="text/javascript"></script>

<title><fmt:message key="asset.apply.title" /> -SQE SERVICE GOM</title>
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
<!-- 弹出窗口显示工作任务信息 -->
<div id="show_title"></div>
<div id="describe"></div>
<div id="staff" style="clear:both"></div>

<form id="borrowForm">
<input type="hidden" id="id" name="id" />
<input type="hidden" id="assetId" name="assetId" />
<input type="hidden" id="assetName" name="assetName" />
<input type="hidden" id="buyNum" name="buyNum" />
<input type="hidden" id="applyState" name="applyState" value="TRIAL" />
<dl id="lf">
<!--    <dd> -->
<%--      <label class="label"><fmt:message key="respon.fcode" /></label><input id="funCode" name="funCode" maxlength="20" class="inp"/> --%>
<!--    </dd> -->
   <dd>
     <label class="label"><fmt:message key="asset.apply.num" /></label><input id="receiveNum" name="receiveNum" maxlength="20" class="inp"/>
   </dd>
   <dd>
     <label class="label"><fmt:message key="asset.apply.date" /></label><input id="receiveDate" name="receiveDate" maxlength="20" class="inp"/>
   </dd>
   <dd>
     <label class="label"><fmt:message key="asset.return.date" /></label><input id="returnDate" name="returnDate" maxlength="20" class="inp"/>
   </dd>
   <dd>
     <label class="label"><fmt:message key="general.note" /></label><textarea id="remark" name="remark" class="area" cols="29" rows="2"></textarea>
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
