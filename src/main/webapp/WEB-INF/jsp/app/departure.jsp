<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<title><fmt:message key="departure.page.title" /> -SQE SERVICE GOM</title>
<%@include file="/common/common_import.html" %>
<script src="../scripts/app/departure.js" type="text/javascript"></script>
<style type="text/css">
dl{height:280px;}
dd select{padding-left:5px;}
.receipt{color:#F00;font-weight:bold;margin:15px;}
</style>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="grid_20 omega">
<fieldset>
<legend><fmt:message key="departure.apply" /></legend>
<form:form id="departureForm" modelAttribute="dep" method="post" action="save_departure.htm">
<input type="hidden" name="token" value="${token }" />
<form:hidden path="id" />
<form:hidden path="userId" />
<form:hidden path="traceId" />
<form:hidden path="nodeCode" />
<form:hidden path="nodeOrder" />
<form:hidden path="ename" />
<form:hidden path="cname" />
<form:hidden path="opinion" />
<form:hidden path="userDpt" />
<form:hidden path="userPst" />
<form:hidden path="toMailAddr" />
<form:hidden path="dptId" />
<form:hidden path="recipientJobNo" />
<form:hidden path="recipientPst" />
<form:hidden path="handover" />
<form:hidden path="jobNo" />
<input type="hidden" id="entryDate" name="entryDate" value="1987-12-15">
<input type="hidden" id="salaryDate" name="salaryDate" value="1987-12-15">
<input type="hidden" id="approval" name="approval" value="APPROVAL">
<input type="hidden" id="pdays" value="${pdays}">
<input type="hidden" id="depart" value="${dtr.dptId}">
<dl>
  <div class="warn"><c:choose><c:when test="${empty msg}"><fmt:message key="departure.warn" /></c:when><c:otherwise>${msg}</c:otherwise></c:choose></div>
  <div id="err"><c:if test="${not empty error}">${error}</c:if></div>
  <dd><label><fmt:message key="departure.exitDate" /></label><form:input path="exitDate" cssClass="inp" tabindex="1" readonly="true"/></dd>
  <dd><label><fmt:message key="departure.recipient" /></label><form:select path="recipientDpt" tabindex="2"><form:option value=""><fmt:message key="general.select" /></form:option><form:options items="${departments}" itemValue="id" itemLabel="cname" /></form:select>
  <form:select path="recipient" tabindex="3"><form:option value="${dtr.ename}">${dtr.cname}</form:option></form:select></dd>
  <div class="textarea"><label><fmt:message key="departure.reason" /></label><form:textarea path="reason" rows="3" cols="55" tabindex="4"/></div>
  <div class="submit_but"><input type="submit" id="applySubmit" value="<fmt:message key="general.submit" />"/></div>
</dl>
</form:form>
</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>