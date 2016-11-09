<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<style type="text/css">
dl dd{width:480px;float:left;margin-right:5px;}
dl dd.textarea{width:650px;}
dl dd label{width:115px;text-align:right;color:#0E5080;}
dl dd input,dl dd select{border:1px solid #628EB1;margin-left:5px;width:200px;}
dl dd input.inp{width:90px;}
dl dd label.error{color:red;display:block;padding:0;margin:0px;text-align:left}
dl dd.error_msg{height:16px;}

#mag{position:relative;border-bottom:1px solid #36F;}
#mag span, #md span{padding-left:10px;}
#mag p{padding:0;float:right;}
#mag p em{padding-left:20px;color:#F00;font-style:normal;}
</style>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/utils.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/app/handle_asset.js" type="text/javascript"></script>

<title><fmt:message key="asset.apply.handle" /> -SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<div id="g_mgr">
<table id="handle_tb"></table>
<div id="handle_pg"></div>
</div>
<div id="content_main">
<!-- 弹出窗口显示不能修改的信息 -->
<div id="mag"></div>
<div style="clear:both"></div>
<div id="md"></div>

<form id="borrowForm">
<input type="hidden" id="id" name="id" />
<input type="hidden" id="assetId" name="assetId" />
<dl id="lf">
   <dd><label class="label"><fmt:message key="borrow.applyState" /></label><select id="applyState" name="applyState" class="inp required"><option value="AGREE"><fmt:message key="borrow.agree" /></option><option value="REJECT"><fmt:message key="borrow.reject" /></option><option value="CONFIRM"><fmt:message key="borrow.confirm" /></option><option value="HOMING"><fmt:message key="borrow.homing" /></option><option value="USING"><fmt:message key="borrow.using" /></option><option value="DAMAGED"><fmt:message key="borrow.damaged" /></option></select></dd>
   <dd><label class="label"><fmt:message key="general.note" /></label><textarea id="remark" name="remark" class="area" cols="59" rows="3"></textarea></dd>
 </dl>
</form> 
</div> <!-- end content_main -->
</div> <!-- end content -->
</div> <!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div> <!-- end container_24 -->
</body>
</html>
