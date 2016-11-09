<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<style type="text/css">
#lf dd {width:320px; height:78px; float:left;}
#lf dd label.lab{font-size:1.1em;line-height:26px;height:26px;color:#0E5080;margin-left:35px;}
#lf dd input.inp, #lf dd select.inp{float:right;border:1px solid #628EB1;height:22px;line-height:22px;margin-left:5px;width:200px;font-size:1.1em;margin-top:10px;}
#lf dd select.mininp{border:1px solid #628EB1;height:22px;line-height:22px;width:100px;font-size:1.1em;}
#lf dd textarea.area{float:right;border:1px solid #628EB1;margin-left:5px;width:200px;font-size:1em;}
#lf dd label.error{height:26px; float:right;}

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
#delayError{color:red;}

.process{position:relative; margin:0px 0;padding:1px 0;}
.process img.arrow{margin-left:12px;}
.process table{float:right; margin-top: 5px;}

.trace_tab th, .trace_tab td{color:#333;border-collapse:collapse;border:1px solid #aabcfe; padding:3px;}
.trace_tab th{background-color:#b9c9fe;text-align:center;vertical-align:middle;font-weight:bold;}

.tr_con:hover{border:1px solid #a6c9e2;background-color:#d0e5f5;text-decoration:none;}
.tr_con td{border:1px solid #a6c9e2;}

</style>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/uploadify-2.1.4.js" type="text/javascript"></script>
<script src="../scripts/common/md5.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../common/date/WdatePicker.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/utils.js" type="text/javascript"></script>
<script src="../scripts/app/my_task.js" type="text/javascript"></script>

<title><fmt:message key="task.my.page.title" /> -SQE SERVICE GOM</title>
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
<div id="gConsole">
<fmt:message key="task.delay" /><textarea id="delay" name="delay" rows="4" cols="20"></textarea>
<span id="delayError"></span>
</div>
<input type="hidden" id="id" name="id"/>
<input type="hidden" id="traceId" name="traceId"/>
<input type="hidden" id="nodeCode" name="nodeCode"/>
<input type="hidden" id="attachment" name="attachment"/>
<input type="hidden" id="actualHours" name="actualHours"/>
<input type="hidden" id="expectedEnd" name="expectedEnd"/>

<!-- 弹出窗口显示工作任务信息 -->
<div id="task"></div>
<div id="describe"></div>
<div id="staff" style="clear:both"></div>
<div id="date"></div>
	
<!-- 流程走向详细列表 -->
<table class="trace_tab" width="100%">
<thead><tr><th width="20%"><fmt:message key="process.process" /></th><th width="25%"><fmt:message key="process.deTime" /></th><th width="45%"><fmt:message key="process.opinion" /></th><th width="10%"><fmt:message key="general.attachment" /></th></tr></thead>
<tbody id="t_body"></tbody>
<!-- 工作流程图走向 -->
<tfoot><tr><td id="t_foot" colspan="4"></td></tr></tfoot>
</table>

<!-- 用户提交工作  -->
<dl id="lf">
   <dd><label class="lab"><fmt:message key="task.needHelp" /></label><input id="needHelp" name="needHelp" type="checkbox" class="inp"/></dd>
   <dd id="needState_dd"><label class="lab"><fmt:message key="task.needState" /></label><select id="needState" name="needState" class="inp"><option value="EXIGENCY"><fmt:message key="task.exigency" /></option><option value="GENERAL"><fmt:message key="task.general" /></option><option value="SECONDARY"><fmt:message key="task.secondary" /></option></select></dd>
    <dd id="backer_dd">
     <label class="lab"><fmt:message key="task.backer" /></label>
     <select id="executorDpt" name="executorDpt" class="mininp"></select>
     <select id="backer" name="backer" class="mininp required"></select>
   </dd>
   <dd><label class="lab"><fmt:message key="general.attachment" /></label><input id="attachments" name="attachments" type="file" class="inp"/></dd>
   <dd><label class="lab"><fmt:message key="general.note" /></label><textarea id="opinion" name="opinion" class="area"></textarea></dd>
</dl>

</div><!-- End content_main  -->

<div id="addTask">
<form id="taskForm" action="">
<dl id="lf">
   <dd>
     <label class="lab"><fmt:message key="task.assignor" /></label>
     <select id="assignorDpt" name="assignorDpt" class="mininp"></select>
     <select id="assignor" name="assignor" class="mininp required"></select>
   </dd>
   <dd>
     <label class="lab"><fmt:message key="task.title" /></label><input id="taskTitle" name="taskTitle" class="inp"/>
   </dd>
   <dd>
     <label class="lab"><fmt:message key="task.expectedHours" /></label><input id="expectedHours" name="expectedHours" class="inp"/>
   </dd>
   <dd>
     <label class="lab"><fmt:message key="general.expectedEnd" /></label><input id="expectedEnd" name="expectedEnd" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd H:mm'})" class="inp"/>
   </dd>
   <dd>
     <label class="lab"><fmt:message key="general.explain" /></label><textarea id="describe" name="describe" class="area" ></textarea>
   </dd>
</dl>
</form>
</div><!-- End addTask  -->

</div><!-- End content  -->
</div><!-- End grid_24  -->
<%@include file="/common/footer.html" %>
</div><!-- End container_24 -->
</body>
</html>