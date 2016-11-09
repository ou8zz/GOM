<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<style type="text/css">
.xian{position:relative;border-bottom:1px solid #36F;}
</style>

<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../common/kindeditor/kindeditor-min.js" type="text/javascript" charset="utf-8"></script>
<script src="../common/kindeditor/lang/zh_TW.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/app/howtodo.js" type="text/javascript"></script>

<title><fmt:message key="ht.page.title" /> -SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<div id="g_mgr">
<table id="how_tb"></table>
<div id="how_pg"></div>
</div>
<div id="content_main">
<form id="howForm">
<input type="hidden" id="id" name="id" />
<input type="hidden" id="resId" name="resId" />
<input type="hidden" id="howId" name="howId" />
<label id="title_label"><fmt:message key="ht.title" />
<select id="resource" name="resource" class="inp"></select></label>
<div>&nbsp;</div>
<textarea id="gain" name="gain" style="width:680px;height:380px;visibility:hidden;"></textarea>
</form> 

</div> <!-- end content_main -->
</div> <!-- end content -->
</div> <!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div> <!-- end container_24 -->
</body>
</html>
