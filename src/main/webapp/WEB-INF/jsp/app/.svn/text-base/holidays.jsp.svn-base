<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>

<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>

<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/app/holidays.js" type="text/javascript"></script>
<style type="text/css">
dl dd{width:320px; height:68px;line-height:38px;position:relative;}
#lf dd,#lf dd label.lab_button{width:320px;height:58px;float:left;}
#lf dd label.label{font-size:1em;line-height:26px;height:26px;width:320px;float:right;text-align:right;color:#0E5080;margin-bottom:5px;}
#lf dd input.inp,#lf dd select.inp{float:right;border:1px solid #628EB1;height:22px;line-height:22px;margin-left:5px;width:200px;font-size:1em;}
dl dd label.error{height:26px;color:red;position:relative;display:block;padding:0px;margin:0px;text-align:left;width:300px;}
dl dd.error_msg{height:16px;}
</style>

<title><fmt:message key="holidays.title" /> - SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<div>
<table id="zgrid"></table>
<div id="zpager"></div>
</div>

<div id="content_main">
<form:form id="holidaysForm" name="holidaysForm" modelAttribute="holidays">
<input type="hidden" id="id" name="id" />
<dl id="lf">
   <dd><label class="lab"><fmt:message key="holidays.name" /></label><form:input path="name" maxlength="20" tabindex="1" /></dd>
   <dd><label class="lab"><fmt:message key="holidays.days" /></label><form:input path="days" maxlength="10" tabindex="4" /></dd>
   <dd><label class="lab"><fmt:message key="general.startDate" /></label><form:input path="startDate" maxlength="20" tabindex="2" /></dd>
   <dd><label class="lab"><fmt:message key="general.endDate" /></label><form:input path="endDate" maxlength="20" tabindex="3" /></dd>
	<dd><span class="error_msg"></span></dd>
</dl>
</form:form> 
</div><!-- end content_main -->
</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>
