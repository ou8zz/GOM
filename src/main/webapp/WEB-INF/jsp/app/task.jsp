<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<style type="text/css">
dl dd{width:320px;float:left;}
dl dd span b{text-align:left;margin-right:120px;float:right;}
dl dd input.inp{width:220px;}
dl dd input.inps{width:100px;}
.textarea{clear:both;}
label.error{padding:15px 0;display:block;color:#F00;width:300px;}
</style>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/uploadify-2.1.4.js" type="text/javascript"></script>
<script src="../scripts/common/md5.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/common/utils.js" type="text/javascript"></script>
<script src="../scripts/app/task.js" type="text/javascript"></script>

<title><fmt:message key="task.page.title" /> - SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<table id="task_tb"></table>
<div id="task_pg"></div>
<div id="content_main">
<form id="taskForm" name="taskForm" action="">
<input type="hidden" id="id" name="id">
<input type="hidden" id="traceId" name="traceId">
<input type="hidden" id="state" name="state">
<input type="hidden" id="completedRate" name="completedRate"/>
<dl>
   <dd class="project"><label><fmt:message key="task.project" /></label><select id="project" name="project" tabindex="1"></select></dd>
   <dd><label><fmt:message key="task.title" /></label><input id="taskTitle" name="taskTitle" maxlength="20" tabindex="2" class="inp"/></dd>
   <!-- 子项目展示 -->
   <table class="gom_tb project" cellpadding="0" cellspacing="0">
    <thead><th width="8%"><fmt:message key="general.select" /></th><th width="17%"><fmt:message key="task.module.name" /></th><th width="17%"><fmt:message key="task.module.number" /></th><th width="18%"><fmt:message key="task.expectedHours" /></th><th width="20%"><fmt:message key="general.expectedStart" /></th><th width="20%"><fmt:message key="general.expectedEnd" /></th></thead>
	<tbody id="module"></tbody>
   </table>
   <dd><label><fmt:message key="task.expectedHours" /></label><span><b>p.t.</b><input id="expectedHours" name="expectedHours" maxlength="20" tabindex="3" class="inps"/></span></dd>
   <dd><span class="error_msg"></span></dd>
   <div class="textarea"><label><fmt:message key="general.explain" /></label><textarea id="describe" name="describe" tabindex="4" rows="3" cols="60"></textarea></div>
 </dl>
</form>
</div><!-- end content_main -->
</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div></div><!-- end container_24 -->
</body>
</html>