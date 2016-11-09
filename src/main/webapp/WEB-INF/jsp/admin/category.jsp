<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<link href="../styles/global.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>

<%@include file="/common/common_import.html" %>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/admin/category.js" type="text/javascript"></script>

<title>文件分类管理 -SQE SERVICE GOM</title>
</head>
<body>
<%@include file="/common/admin_header.html" %>
<div id="content" class="alpha grid_20 omega">
<div id="g_mgr">
<table id="cate_tb"></table>
<div id="cate_pg"></div>
</div>

<div id="gConsole"><span style="color:red;">确定要删除所选记录吗？</span></div>

<div id="content_main">
<form id="cateForm">
<input type="hidden" id="id" name="id" />
<dl id="lf">
	<dd id="dd_path">
     <label class="label">目 录：</label><select id="path" name="path" class="inp required"></select>
   </dd>
   <dd>
     <label class="label">分类名：</label><input id="name" name="name" class="inp"/>
   </dd>
 </dl>
</form> 
</div><!-- end content_main -->
</div><!-- end content -->
</div><!-- end grid 24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->

</body>
</html>
