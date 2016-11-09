<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<title>系统参数配置管理 -SQE SERVICE GOM</title>
<%@include file="/common/common_import.html" %>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/utils.js" type="text/javascript"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../common/date/WdatePicker.js" type="text/javascript"></script>
<script src="../scripts/admin/config.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" media="screen" href="../styles/ui.jqgrid.css" />
<link href="../styles/admin.css" media="screen" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@include file="/common/admin_header.html" %>
<div id="content" class="grid_20 omega">
<form:form id="configForm" method="post" modelAttribute="def">
<input id="is_sub" type="hidden" value="true" />
<div id="choiceGroup">参数组<form:select path="group"><form:options items="${configs}" itemValue="key" itemLabel="name"/></form:select></div>
<table id="zgrid"></table>
<div id="zpager"></div>
<div id="content_main">
 <dl id="gf">
   <dd><label>KEY值</label><form:input path="key" tabindex="1" maxlength="45"/></dd>
   <dd><label>名称</label><form:input path="name" tabindex="2" maxlength="20"/></dd>
   <dd class="prop"><label>配置类型</label><form:select path="type" tabindex="3"><option value="">请选择</option><option value="GROUP">配置组</option><option value="DEF">配置项</option></form:select></dd>
   <dd class="defProp"><label>设定值</label><span id="setValue"><form:input path="value" tabindex="4" maxlength="150"/></span></dd>
   <dd class="defProp prop"><label>参数组</label><form:select path="pkey" tabindex="5"><option value="">请选择</option><form:options items="${configs}" itemValue="key" itemLabel="name"/></form:select></dd>
 </dl>
</div><!-- end content_main -->
</form:form>
</div><!-- end content -->
</div><!-- end main -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>