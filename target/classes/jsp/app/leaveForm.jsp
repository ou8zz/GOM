<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<title><fmt:message key="leave.apply.title" /> -SQE SERVICE GOM</title>
<%@include file="/common/common_import.html" %>
<script src="../common/date/WdatePicker.js" type="text/javascript"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/common/jquery.blockUI.js" type="text/javascript"></script>
<script src="../scripts/common/uploadify-2.1.4.js" type="text/javascript"></script>
<script src="../scripts/common/utils.js" type="text/javascript"></script>
<script src="../scripts/app/leaveForm.js" type="text/javascript"></script>
<style type="text/css">
table.gom_tb{border-collapse:collapse;border-left:#A6C9E2 solid 1px;border-top:#A6C9E2 solid 1px;text-align:left;}
table.gom_tb td,.gom_tb th{border-right:#A6C9E2 solid 1px;border-bottom:#A6C9E2 solid 1px;padding:10px 10px 6px;}
table.gom_tb td select.empty_left{margin-left:10px;}
table.gom_tb tbody th{font-weight:normal;text-align:right;background-color:#A6C9E2;padding:10px 5px;}
table.gom_tb caption{font-weight:bold;font-size:1.2em;text-align:center; margin:10px 0;}
#event{width:100%;}
label.error{display:block;margin:0;padding:0;}
.submit_but{margin:0 auto;text-align:center;}
</style>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="grid_20 omega">
<form:form id="leaveForm" modelAttribute="leave" method="post">
<input type="hidden" name="token" value="${token }">
<form:hidden path="id" />
<form:hidden path="applyDate" />
<form:hidden path="attachment" />
<input type="hidden" name="traceId" id="traceId" value="${trace.id}"/>
<input type="hidden" name="nodeCode" id="nodeCode" value="${trace.nodeCode}"/>
<input type="hidden" name="nodeOrder" id="nodeOrder" value="${trace.nodeOrder}"/>
<input type="hidden" name="approval" id="approval" value="APPROVAL"/>
<table cellspacing="0" cellpadding="0" class="gom_tb" summary="请假单" width="100%">
<caption><c:choose><c:when test="${empty leave.event}"><fmt:message key="leave.apply.application" /></c:when><c:otherwise><fmt:message key="leave.apply.application.error" /></c:otherwise></c:choose></caption>
<tbody>
<tr>
  <th width="15%"><fmt:message key="leave.apply.recipient" /></th>
  <td width="30%"><form:select path="recipientDpt" tabindex="1"><form:option value=""><fmt:message key="general.select" /></form:option><form:options items="${departments}" itemValue="id" itemLabel="cname" /></form:select><form:select path="recipient" tabindex="2" cssClass="empty_left"><form:option value=""><fmt:message key="general.select" /></form:option></form:select></td>
  <td width="10%" rowspan="4">&nbsp;</td>
  <th width="15%"><fmt:message key="leave.apply.agent" /></th>
  <td width="30%"><form:select path="agentDpt" tabindex="3"><form:option value=""><fmt:message key="general.select" /></form:option><form:options items="${departments}" itemValue="id" itemLabel="cname" /></form:select><form:select path="agent" tabindex="4" cssClass="empty_left"><form:option value=""><fmt:message key="general.select" /></form:option></form:select></td>
 </tr>
  <tr>
    <th><fmt:message key="general.startDate" /></th>
    <td><form:input path="startDate" tabindex="5" readonly="true" cssClass="Wdate"/></td>
    <th><fmt:message key="general.endDate" /></th>
    <td><form:input path="endDate" tabindex="6" readonly="true" cssClass="Wdate"/></td>
  </tr>
  <tr>
    <th><fmt:message key="leave.apply.type" /></th>
    <td><form:select path="type" tabindex="7"><form:option value=""><fmt:message key="general.select" /></form:option>
	    <form:option value="CASUAL"><fmt:message key="leave.apply.type1" /></form:option>
	    <form:option value="SICK"><fmt:message key="leave.apply.type2" /></form:option>
	    <form:option value="LEAVE_IN_LIEU"><fmt:message key="leave.apply.type3" /></form:option>
	    <form:option value="BEREAVEMENT"><fmt:message key="leave.apply.type4" /></form:option>
	    <form:option value="MARRIAGE"><fmt:message key="leave.apply.type5" /></form:option>
	    <form:option value="ANNUAL"><fmt:message key="leave.apply.type6" /></form:option>
	    <form:option value="MATERNITY"><fmt:message key="leave.apply.type7" /></form:option>
    </form:select></td>
    <th><fmt:message key="leave.apply.days" /></th>
    <td><form:input path="days" tabindex="8" maxlength="2"/></td>
  </tr>
  <tr>
    <th><fmt:message key="leave.apply.event" /></th>
    <td><form:input path="event" tabindex="9" maxlength="150"/></td>
    <th><fmt:message key="leave.apply.contact" /></th>
    <td><form:input path="contact" tabindex="10" maxlength="30"/></td>
  </tr>
  <tr>
    <th><fmt:message key="leave.apply.tmp_user" /></th>
    <td colspan="4"><input type="file" name="tmp_user" id="tmp_user" tabindex="12"/></td>
    </tr>
  <tr>
  <tr>
    <th><fmt:message key="leave.apply.handOver" /></th>
    <td colspan="4"><form:textarea path="handOver" rows="3" cols="60" tabindex="12"/></td>
    </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="5"><div class="submit_but"><input type="submit" id="leavesubmit" value="<fmt:message key="leave.apply.leavesubmit" />"/></div></td>
  </tr>
</tbody>
</table>
</form:form>
</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>