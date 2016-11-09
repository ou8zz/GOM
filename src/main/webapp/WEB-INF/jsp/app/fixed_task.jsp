<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<title><fmt:message key="fixed.task.title" /> - SQE SERVICE GOM</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"  />
<%@include file="/common/common_import.html" %>
<style type="text/css">
dl dd{width:320px;float:left;}
dl dd.textarea{width:640px;}
dl dd input.inps{width:100px;}
dl dd input.inpsmall{width:10px;}
dd.playStop{margin:15px 0;}
dd.playStop label.lab{width:20px;text-align:left;height:16px;line-height:16px}
dl dd span b{text-align:left;margin-right:135px;float:right;}
label.error{width:320px;color:#F00;line-height:28px;height:28px;margin-top:-8px;}
</style>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../common/date/WdatePicker.js" type="text/javascript" language="javascript"></script>
<script src="../scripts/app/fixed_task.js" type="text/javascript"></script>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<table id="zgrid"></table>
<div id="zpager"></div>

<div id="content_main">
<form id="fixedForm" name="fixedForm" action="" method="post">
<input type="hidden" id="id" name="id"/>
<dl>
   <dd><label><fmt:message key="fixed.task.frequency" /></label><select id="frequency" name="frequency" tabindex="1"><option value=""><fmt:message key="general.select" /></option><option value="DAY"><fmt:message key="fixed.task.frequency.day" /></option><option value="WEEK"><fmt:message key="fixed.task.frequency.week" /></option><option value="MONTH"><fmt:message key="fixed.task.frequency.month" /></option><option value="QUARTER"><fmt:message key="fixed.task.frequency.season" /></option><option value="YEAR"><fmt:message key="fixed.task.frequency.year" /></option></select></dd>
   <dd class="time"><label></label><select id="period" name="period" tabindex="2"></select></dd>
   <dd><label><fmt:message key="fixed.task.taskTitle" /></label><input id="taskTitle" name="taskTitle" maxlength="20" tabindex="3"/></dd>
   <dd><label><fmt:message key="fixed.task.hours" /></label><span><b>p.t.</b><input id="hours" name="hours" maxlength="5" tabindex="4" class="inps"/></span></dd>
   <dd><label><fmt:message key="fixed.task.expectedStart" /></label><input id="expectedStart" name="expectedStart" onfocus="WdatePicker({dateFmt:'H:mm'})" class="Wdate" readonly="readonly" tabindex="5"/></dd>
   <dd><label><fmt:message key="fixed.task.expectedEnd" /></label><input id="expectedEnd" name="expectedEnd" onfocus="WdatePicker({dateFmt:'H:mm'})" class="Wdate" readonly="readonly" tabindex="6"/></dd>
   <dd class="textarea"><label><fmt:message key="fixed.task.describe" /></label><textarea id="describe" name="describe" rows="3" cols="60" tabindex="7"></textarea></dd>
   <dd class="playStop"><label><fmt:message key="fixed.task.state" /></label>&nbsp;&nbsp;&nbsp;<input type="radio" name="state" maxlength="20" tabindex="8" value="Suspended" class="inpsmall"/><label class="lab"><fmt:message key="fixed.task.state.suspended" /></label><input type="radio" name="state" value="InProgress" class="inpsmall"/><label class="lab"><fmt:message key="fixed.task.state.inprogress" /></label></dd>
</dl>
</form>
</div><!-- End content_main -->

</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>
