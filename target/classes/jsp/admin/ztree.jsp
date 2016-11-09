<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<link href="../styles/global.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>

<style type="text/css">
#lf dd{width:320px;height:58px;float:left;}
#lf dd label.label{font-size:1.1em;line-height:26px;height:26px;width:320px;float:right;text-align:right;color:#0E5080;margin-bottom:5px;}
#lf dd input.inp,#lf dd select.inp{float:right;border:1px solid #628EB1;height:22px;line-height:22px;margin-left:5px;width:200px;font-size:1em;}
</style>

<%@include file="/common/common_import.html" %>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/uploadify-2.1.4.js" type="text/javascript"></script>
<script src="../scripts/admin/ztree.js" type="text/javascript"></script>

<title>菜单管理 -SQE SERVICE GOM</title>

</head>
<body>
<%@include file="/common/admin_header.html" %>
<div id="content" class="alpha grid_20 omega">
<table id="ztree_tb"></table>
<div id="ztree_pg"></div>

<div id="content_main">
<form id="ztreeForm">
<input type="hidden" id="id" name="id" />
<input type="hidden" id="pid" name="pid" />
<input type="hidden" id="ico" name="ico" />
<input type="hidden" id="node" name="node" />
<dl id="lf">
   <dd>
     <label class="label">名称：<input id="name" name="name" maxlength="30" class="inp"/></label>
   </dd>
   <dd>
     <label class="label">标题：<input id="title" name="title" maxlength="30" class="inp"/></label>
   </dd>
   <dd>
     <label class="label">连接路径：<input id="url" name="url" maxlength="50" class="inp"/></label>
   </dd>
   <dd>
     <label class="label">图标：<input id="icon" name="icon" type="file" class="inp"/></label>
   </dd>
   <dd>
     <label class="label">职位：<input id="position" name="position" maxlength="30" class="inp"/></label>
   </dd>
   <dd>
     <label class="label">角色：<input id="role" name="role" maxlength="30" class="inp"/></label>
   </dd>
   <dd>
     <label class="label">菜单类型：<select id="menuType" name="menuType" class="inp"><option value="General">通用</option><option value="Custom">自定义</option></select></label>
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
