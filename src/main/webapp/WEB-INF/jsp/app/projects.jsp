<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<style type="text/css">
dl dd{width:320px;float:left;margin-right:5px;}
dl dd.textarea{width:650px;}
dl dd label{width:115px;text-align:right;color:#0E5080;}
dl dd input,dl dd select{border:1px solid #628EB1;margin-left:5px;width:200px;}
dl dd input.inp{width:90px;}
dl dd select.minp{width:90px;margin-right:5px}
dl dd label.error{color:red;display:block;padding:0;margin:0px;text-align:left}
dl dd.error_msg{height:16px;}
</style>
<script src="../scripts/common/grid.js" type="text/javascript"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/app/project.js" type="text/javascript"></script>

<title><fmt:message key="project.page.title" /> -SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<table id="project_tb"></table>
<div id="project_pg"></div>
<div id="gConsole"><span style="color:red;"><fmt:message key="general.delete.msg" /></span></div>
<div id="content_main">
<form id="projectForm" name="projectForm">
<input type="hidden" id="id" name="id" />
<input type="hidden" id="parentId" name="parentId" />
<dl>
   <dd id="dd_type"><label><fmt:message key="project.type" /></label><select id="type" name="type"><option value="Project"><fmt:message key="project.proj" /></option><option value="Module"><fmt:message key="project.mode" /></option></select></dd>
   <dd class="project"><label><fmt:message key="project.product.name" /></label><select id="productId" name="productId"></select></dd>
   <dd class="module"><label><fmt:message key="project.project" /></label><select id="project" name="project"></select></dd>
   <dd><label id="lab_pNo"><fmt:message key="project.number" /></label><input id="projectNo" name="projectNo" maxlength="20"/></dd>
   <dd><label id="lab_pName"><fmt:message key="project.name" /></label><input id="projectName" name="projectName" maxlength="20"/></dd>
   <dd><label><fmt:message key="project.start" /></label><input id="startDate" name="startDate" maxlength="20" readonly="readonly"/></dd>
   <dd><label><fmt:message key="project.end" /></label><input id="endDate" name="endDate" maxlength="20" readonly="readonly"/></dd>
   <dd><label id="lab_dtr"><fmt:message key="project.dir" /></label><select id="dtrDptId" name="dtrDptId" class="minp"></select><select id="director" name="director" class="minp"></select></dd>
   <dd><label><fmt:message key="project.version" /></label><input id="version" name="version" maxlength="10" class="inp"/></dd>
   <dd><label><fmt:message key="project.hours" /></label><input id="expectedTime" name="expectedTime" maxlength="6" class="inp"/><span>PT</span></dd>
   <dd class="textarea"><label><fmt:message key="general.note" /></label><textarea id="des" name="des" rows="3" cols="60"></textarea></dd>
   <dd><span class="error_msg"></span></dd>
</dl>
</form>
</div> <!-- end content_main -->
</div> <!-- end content -->
</div> <!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div> <!-- end container_24 -->
</body>
</html>
