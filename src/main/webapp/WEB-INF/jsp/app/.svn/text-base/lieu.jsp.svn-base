<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>

<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>

<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/app/lieu.js" type="text/javascript"></script>
<style type="text/css">
dl dd{width:320px; height:68px;line-height:38px;position:relative;}
#lf dd,#lf dd label.lab_button{width:320px;height:58px;float:left;}
#lf dd label.label{font-size:1em;line-height:26px;height:26px;width:320px;float:right;text-align:right;color:#0E5080;margin-bottom:5px;}
#lf dd input.inp,#lf dd select.inp{float:right;border:1px solid #628EB1;height:22px;line-height:22px;margin-left:5px;width:200px;font-size:1em;}
dl dd label.error{height:26px;color:red;position:relative;display:block;padding:0px;margin:0px;text-align:left;width:300px;}
dl dd.error_msg{height:16px;}
#explan{border:1px #628EB1 solid; display:block; height:36px; width:260px;}
</style>

<title><fmt:message key="lieu.title" /> - SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<table id="zgrid"></table>
<div id="zpager"></div>
<div id="content_main">
<form id="lieuForm" name="lieuForm">
<input type="hidden" id="id" name="id" />
<input type="hidden" id="explanation" name="explanation" />
<dl id="lf">
   	<dd><label class="lab"><fmt:message key="lieu.type" /></label><select id="type" name="type"><option value="COMMON"><fmt:message key="lieu.type.common" /></option><option value="USER"><fmt:message key="lieu.type.user" /></option></select></dd>
   	<dd id="dd_holidays"><label class="lab"><fmt:message key="lieu.holidays" /></label><select id="holidaysId" name="holidaysId"></select><label class="error" generated="true" id="err_holidays"></label></dd>
   	<dd><label class="lab"><fmt:message key="lieu.dayoff" /></label><input id="dayoff" name="dayoff" maxlength="20" tabindex="2" /></dd>
   	<dd><label class="lab"><fmt:message key="lieu.workedon" /></label><input id="workedon" name="workedon" maxlength="20" tabindex="3" /></dd>
	<dd><span id="explan">&nbsp;</span></dd>
	<dd><span class="error_msg"></span></dd>
</dl>
</form> 
</div><!-- end content_main -->
</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>
