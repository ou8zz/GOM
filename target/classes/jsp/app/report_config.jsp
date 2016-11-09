<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link rel="stylesheet" type="text/css" media="screen" href="../styles/ui.jqgrid.css" />
<style type="text/css">
input.rcc{border:1px solid #ccc;height:22px;line-height:22px;margin-left:5px;width:240px;font-size:1em;font:left;}

.tr_con:hover{border:1px solid #a6c9e2;background-color:#d0e5f5;text-decoration:none;}
.tr_con td{border:1px solid #a6c9e2;}

.submit_but{ text-align: center; }

.gom_tb tr td{text-align:center;}
.ct{ width:30px; text-align:center; }
.cte{ width:125px; background-color: #D9D9FF; }

/* 签名CSS */
.signiture h3,.signiture p{padding:0;margin:0;}
.signiture table b{color:#03F}
.signiture table{border-bottom:1px solid #000;}
</style>

<script src="../common/date/WdatePicker.js" type="text/javascript"></script>
<script src="../common/kindeditor/kindeditor-min.js" type="text/javascript" charset="utf-8"></script>
<script src="../common/kindeditor/lang/zh_TW.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/jquery.blockUI.js" type="text/javascript"></script>
<script src="../scripts/app/report_config.js" type="text/javascript"></script>

<title><fmt:message key="rc.page.title" /> -SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">

<!-- 人员选择弹出框 -->
<div id="user_main">
	<div id="dpt_dl"></div>
	<div id="user_dl"></div>
</div>

<div id="content_main">
<form:form id="reportForm" modelAttribute="rc" method="post">
<form:hidden path="id" />
<form:hidden path="receiver" />
<form:hidden path="cc" />
<form:hidden path="stext" />
	<!--<dl id="lf">
 	//summary, devote, weekDevote, repos, task, doing,help,daily, weekly, perMonth, quarterly,how, assets，login 
	//概述、对公司贡献，一周贡献，管理责任，工作命令，需要做，需要帮忙，每日做，每周做，每月做，每季做，如何做，资产管理，登录或登出日志 
		<dd><label class="lab"><fmt:message key="rc.summary" /></label><form:checkbox path="summary" cssClass="inp" /></dd>
		<dd><label class="lab"><fmt:message key="rc.devote" /></label><form:checkbox path="devote" cssClass="inp" /></dd>
		<dd><label class="lab"><fmt:message key="rc.weekDevote" /></label><form:checkbox path="weekDevote" cssClass="inp" /></dd>
		<dd><label class="lab"><fmt:message key="rc.repos" /></label><form:checkbox path="repos" cssClass="inp" /></dd>
		<dd><label class="lab"><fmt:message key="rc.task" /></label><form:checkbox path="task" cssClass="inp" /></dd>
		<dd><label class="lab"><fmt:message key="rc.doing" /></label><form:checkbox path="doing" cssClass="inp" /></dd>
		<dd><label class="lab"><fmt:message key="rc.help" /><form:checkbox path="help" cssClass="inp" /></dd>
		<dd><label class="lab"><fmt:message key="rc.daily" /></label><form:checkbox path="daily" cssClass="inp" /></dd>
		<dd><label class="lab"><fmt:message key="rc.weekly" /></label><form:checkbox path="weekly" cssClass="inp" /></dd>
		<dd><label class="lab"><fmt:message key="rc.perMonth" /></label><form:checkbox path="perMonth" cssClass="inp" /></dd>
		<dd><label class="lab"><fmt:message key="rc.quarterly" /></label><form:checkbox path="quarterly" cssClass="inp" /></dd>
		<dd><label class="lab"><fmt:message key="rc.how" /></label><form:checkbox path="how" cssClass="inp" /></dd>
		<dd><label class="lab"><fmt:message key="rc.assets" /></label><form:checkbox path="assets" cssClass="inp" /></dd>
		<dd><label class="lab"><fmt:message key="rc.login" /></label><form:checkbox path="login" cssClass="inp" /></dd>
	</dl>
	-->
	<table class="gom_tb">
		<thead><tr><th><form:select path="type"><form:option value="MORNING"><fmt:message key="rc.type.morning" /></form:option><form:option value="DAY"><fmt:message key="rc.type.day" /></form:option><form:option value="WEEK"><fmt:message key="rc.type.week" /></form:option><form:option value="MONTH"><fmt:message key="rc.type.month" /></form:option><form:option value="QUARTER"><fmt:message key="rc.type.quarter" /></form:option><form:option value="YEAR"><fmt:message key="rc.type.year" /></form:option></form:select></th><th colspan="5"><fmt:message key="rc.page.title" /></th><th colspan="2"><input type="button" id="sendTest" value="发送测试邮件" /></th></tr></thead>
		<tbody id="scen">
			<tr>
				<td class="cte"><fmt:message key="rc.daily" /></td><td><form:checkbox path="daily" cssClass="inp" /></td>
				<td class="cte"><fmt:message key="rc.devote" /></td><td><form:checkbox path="devote" cssClass="inp" /></td>
				<td class="cte"><fmt:message key="rc.task" /></td><td><form:checkbox path="task" cssClass="inp" /></td>
				<td class="cte"><fmt:message key="rc.login" /></td><td><form:checkbox path="login" cssClass="inp" /></td>
			</tr>
			<tr>
				<td class="cte"><fmt:message key="rc.weekly" /></td><td><form:checkbox path="weekly" cssClass="inp" /></td>
				<td class="cte"><fmt:message key="rc.weekDevote" /></td><td><form:checkbox path="weekDevote" cssClass="inp" /></td>
				<td class="cte"><fmt:message key="rc.help" /></td><td><form:checkbox path="help" cssClass="inp" /></td>
				<td class="cte"><fmt:message key="rc.summary" /></td><td><form:checkbox path="summary" cssClass="inp" /></td>
			</tr>
			<tr>
				<td class="cte"><fmt:message key="rc.perMonth" /></td><td><form:checkbox path="perMonth" cssClass="inp" /></td>
				<td class="cte"><fmt:message key="rc.repos" /></td><td><form:checkbox path="repos" cssClass="inp" /></td>
				<td class="cte"><fmt:message key="rc.how" /></td><td><form:checkbox path="how" cssClass="inp" /></td>
				<td class="cte">&nbsp;</td><td>&nbsp;</td>
			</tr>
			<tr>
				<td class="cte"><fmt:message key="rc.quarterly" /></td><td><form:checkbox path="quarterly" cssClass="inp" /></td>
				<td class="cte"><fmt:message key="rc.assets" /></td><td><form:checkbox path="assets" cssClass="inp" /></td>
				<td class="cte"><fmt:message key="rc.doing" /></td><td><form:checkbox path="doing" cssClass="inp" /></td>
				<td class="cte">&nbsp;</td><td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="8">&nbsp;</td>
			</tr>
			</tbody>
			<tbody>
			<tr>
				<td class="cte"><fmt:message key="rc.send" /></td><td colspan="3" class="cte"><form:checkbox path="send" cssClass="inp" /></td>
				<td class="cte"><fmt:message key="rc.sendTime" /></td><td colspan="3" class="cte" id="cst">&nbsp;</td>
			</tr>
			<tr>
			  <td class="cte"><fmt:message key="rc.ename" /></td><td colspan="3" class="cte"><form:input path="ename" onfocus="userDlg();" cssClass="rcc"/></td>
			  <td class="cte"><fmt:message key="rc.ccename" /></td><td colspan="3" class="cte"><form:input path="ccename" onfocus="userDlg('cc');" cssClass="rcc"/></td>
		    </tr>
			<tr>
			  <td colspan="1" class="cte"><fmt:message key="rc.stext" /></td>
			  <td colspan="7" class="cte"><textarea id="content" name="content" style="width:650px;height:280px;visibility:hidden;"></textarea></td>
		    </tr>
		</tbody>
		<tfoot>
			<tr><td colspan="8" class="submit_but"><input type="button" value="<fmt:message key="general.submit" />" id="report_sub" /></td></tr>
		</tfoot>
	</table>
</form:form>

</div> <!-- end content_main -->
</div> <!-- end content -->
</div> <!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div> <!-- end container_24 -->
</body>
</html>