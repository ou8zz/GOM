<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<title><fmt:message key="meeting.page.title" /> -SQE SERVICE GOM</title>
<%@include file="/common/common_import.html" %>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<script src="../scripts/common/grid.locale-tw.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../common/date/WdatePicker.js" type="text/javascript" charset="utf-8"></script>
<script src="../common/kindeditor/kindeditor-min.js" type="text/javascript" charset="utf-8"></script>
<script src="../common/kindeditor/lang/zh_TW.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/app/meeting.js" type="text/javascript"></script>
<style type="text/css">
#lf dd {width:320px; height:78px; float:left;}
#lf dd label.lab{font-size:1.1em;line-height:26px;height:26px;color:#0E5080;margin-left:35px;}
#lf dd input.inp, #lf dd select.inp{float:right;border:1px solid #628EB1;height:22px;line-height:22px;margin-left:5px;width:200px;font-size:1.1em;margin-top:10px;}
#lf dd select.mininp{border:1px solid #628EB1;height:22px;line-height:22px;width:100px;font-size:1.1em;}
#lf dd textarea.area{float:right;border:1px solid #628EB1;margin-left:5px;width:200px;font-size:1em;}
#lf dd label.error{height:26px; float:right;}

#dpt_dl label{color:blue;padding:10px 10px 6px;font-weight: bold;}
#user_dl label{padding:10px 10px 6px;}

#cont{position:relative;border-bottom:1px solid #36F;}
#cont span{padding-left:10px;}
#cont p{padding:0;float:right;}
#cont p em{padding-left:20px;color:orange;font-style:normal;}
#describe,#staff{position:relative;}
#describe label{float:left;width:80px;}
#describe p{width:474px;float:left;}
#staff label{float:left;width:150px;}

</style>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="grid_20 omega">
<div>
<table id="zgrid"></table>
<div id="zpager"></div>
</div>

<div id="add_main">
	<form id="meetingForm" action="meetingForm" method="post">
		<dl id="lf">
		   <dd><label class="lab"><fmt:message key="meeting.number" /></label><input id="number" name="number" class="inp"/></dd>
			<!-- <dd><label class="lab">SWOT：</label><input id="" name="" class="inp"/></dd> -->
		   <dd><label class="lab"><fmt:message key="meeting.title" /></label><input id="title" name="title" class="inp"/></dd>
		   <dd><label class="lab"><fmt:message key="meeting.locale" /></label><input id="locale" name="locale" class="inp"/></dd>
		   <dd><label class="lab"><fmt:message key="meeting.time" /></label><input id="time" name="time" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd H:mm:ss'})" class="inp"/></dd>
		   <dd><label class="lab"><fmt:message key="meeting.host" /></label><select id="hostDpt" name="userDpt" class="mininp"></select><select id="host" name="host" class="mininp required"></select></dd>
		   <dd><label class="lab"><fmt:message key="meeting.notes" /></label><select id="notesDpt" name="userDpt" class="mininp"></select><select id="notes" name="notes" class="mininp required"></select></dd>
		   <dd><label class="lab"><fmt:message key="meeting.participants" /></label><textarea id="participants" name="participants" onfocus="userDlg();" class="area"></textarea></dd>
		   <dd><label class="lab"><fmt:message key="meeting.explain" /></label><textarea id="explain" name="explain" class="area"></textarea></dd>
		</dl>
	</form>
</div><!-- End add_main  -->

<div id="edit_main">
	<!-- 弹出窗口显示信息 -->
	<div id="cont"></div>
	<div id="describe"></div>
	<div id="staff" style="clear:both"></div>
	
	<form id="editForm" action="editForm" method="post">
		<input type="hidden" id="id" name="id"/>
		<input type="hidden" id="host" name="host"/>
		<input type="hidden" id="title" name="title"/>
		<input type="hidden" id="time" name="time"/>
		<input type="hidden" id="participants" name="participants" />
		<dl id="lf">
		   <dd><label class="lab"><fmt:message key="meeting.isTrace" /></label><input id="isTrace" name="isTrace" type="checkbox"/></dd>
		   <dd id="traceDate_dd"><label class="lab"><fmt:message key="meeting.traceDate" /></label><input id="traceDate" name="traceDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd H:mm:ss'})" class="inp"/></dd>
		   <dd id="endDate_dd"><label class="lab"><fmt:message key="meeting.endDate" /></label><input id="endDate" name="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd H:mm:ss'})" class="inp"/></dd>
		   <dd><label class="lab"><fmt:message key="meeting.explain" /></label><textarea id="explain" name="explain" class="area"></textarea></dd>
		</dl>
		<br />
		<div style="clear:both;font-size:1.1em;color:#0E5080;"><fmt:message key="meeting.content" /></div>
		<textarea id="content" name="content" style="width:700px;height:200px;visibility:hidden;"></textarea>
	</form>
</div><!-- End edit_main  -->

<div id="user_main">
	<div id="dpt_dl"></div>
	<div id="user_dl"></div>
</div>

</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>