<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<style type="text/css">
#lf dd {width:320px; height:68px; float:left;}
#lf dd label.lab{font-size:1.1em;line-height:26px;height:26px;color:#0E5080;margin-left:30px;}
#lf dd input.inp, #lf dd select.inp{border:1px solid #628EB1;height:22px;line-height:22px;margin-left:5px;width:200px;font-size:1.1em;margin-top:10px;}
#lf dd input.minp,#lf dd select.minp{font:left; border:1px solid #628EB1;height:22px;line-height:22px;width:95px;font-size:1.1em;}
#task{position:relative;border-bottom:1px solid #36F;}
#task span{padding-left:10px;}
#task p{padding:0;float:right;}
#task p em{padding-left:20px;color:#F00;font-style:normal;}
#describe,#staff{position:relative;}
#describe label{float:left;width:80px;}
#describe p{width:474px;float:left;}
#staff label{float:left;width:150px;}
#t_foot{position:relative;text-align:left;padding:5px;margin-top:10px;}
#t_foot span,#t_foot img.arrow{display:block;float:left;}
#t_foot img.arrow{padding-top:15px;}

.project_tab{margin-left: 40px; float:left;}
.project_tab th, .project_tab td{color:#333;border-collapse:collapse;border:1px solid #aabcfe; padding:3px;}
.project_tab th{background-color:#b9c9fe;text-align:center;vertical-align:middle;font-weight:bold;}

.process{position:relative; margin:0px 0;padding:1px 0;}
.process img.arrow{margin-left:12px;}
.process table{float:right; margin-top: 5px;}

.tr_con:hover{border:1px solid #a6c9e2;background-color:#d0e5f5;text-decoration:none;}
.tr_con td{border:1px solid #a6c9e2;}

.error{width:300px; margin-bottom:15px; margin-right:10px;}
</style>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/uploadify-2.1.4.js" type="text/javascript"></script>
<script src="../scripts/common/md5.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../common/date/WdatePicker.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/utils.js" type="text/javascript"></script>
<script src="../scripts/app/order_task.js" type="text/javascript"></script>

<title><fmt:message key="task.order.page.title" /> -SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<div id="g_mgr">
<table id="task_tb"></table>
<div id="task_pg"></div>
</div>

<div id="content_main">
<!-- 弹出窗口显示工作任务信息 -->
<div id="task"></div>
<div id="date"></div>
<div id="describe"></div>
<div id="staff" style="clear:both"></div>
	
<!-- 流程走向详细列表 -->
<table class="gom_tb trace_tab" width="100%">
<thead><tr><th width="20%"><fmt:message key="process.process" /></th><th width="25%"><fmt:message key="process.deTime" /></th><th width="45%"><fmt:message key="process.opinion" /></th><th width="10%"><fmt:message key="general.attachment" /></th></tr></thead>
<tbody id="t_body"></tbody>
<!-- 工作流程图走向 -->
<tfoot><tr><td id="t_foot" colspan="4"></td></tr></tfoot>
</table>

<fieldset class="fenpei"><legend><fmt:message key="task.fenpei" /></legend>
<dl id="lf">
<form id="taskForm" action="">
<input type="hidden" id="id" name="id" />
<input type="hidden" id="uid" name="uid" />
<input type="hidden" id="traceId" name="traceId" />
<input type="hidden" id="attachment" name="attachment" />
<input type="hidden" id="completedRate" name="completedRate" />
   <dd>
     <label class="lab"><fmt:message key="task.assignor" /></label>
     <select id="assignorDpt" name="assignorDpt" class="minp"></select>
     <select id="assignor" name="assignor" class="minp required"></select>
   </dd>
   <dd>
     <label class="lab"><fmt:message key="task.executor" /></label>
     <select id="executorDpt" name="executorDpt" class="minp"></select>
     <select id="executor" name="executor" class="minp required"></select>
   </dd>
   <dd>
     <label class="lab"><fmt:message key="respon.page.title" /></label><select id="responsibility" name="responsibility" class="inp"></select>
   </dd>
   
   <table id="res_tab" class="gom_tb" cellpadding="0" cellspacing="0">
    <thead><th><fmt:message key="general.select" /></th><th><fmt:message key="respon.name" /></th><th><fmt:message key="respon.fcode" /></th><th><fmt:message key="respon.exp" /></th></thead>
	<tbody id="res_body"></tbody>
   </table>

   <dd>
     <label class="lab"><fmt:message key="general.expectedStart" /></label><input id="expectedStart" name="expectedStart" class="inp"/>
   </dd>
   <dd>
     <label class="lab"><fmt:message key="general.expectedEnd" /></label><input id="expectedEnd" name="expectedEnd" class="inp"/>
   </dd>
   <dd>
     <label class="lab"><fmt:message key="general.attachment" /></label><input id="attachments" name="attachments" type="file" class="inp"/>
   </dd>
   </form>
 </dl>
</fieldset>
</div> <!-- end content_main -->
</div> <!-- end content -->
</div> <!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div> <!-- end container_24 -->
</body>
</html>