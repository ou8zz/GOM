<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"  />
<style type="text/css">
#lf dd{width:320px;height:58px;float:left;margin-top:10px;}
#lf dd.dd_text{width:640px;height:88px;float:left;}
#lf dd label.label{font-size:1.1em;line-height:26px;height:26px;width:110px;float:left;text-align:right;color:#0E5080;margin-bottom:5px;}
#lf dd input.inp,#lf dd select.inp{float:right;border:1px solid #628EB1;height:22px;line-height:22px;margin-left:5px;width:200px;font-size:1em;}
#lf dd textarea.inp{float:right;border:1px solid #628EB1;height:68px;line-height:22px;margin-left:5px;width:520px;font-size:1em;}
.error{float: left;}
</style>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/app/mgr_responsibility.js" type="text/javascript"></script>

<title><fmt:message key="respon.page.title" /> -SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<table id="zgrid"></table>
<div id="zpager"></div>
</div>

<div id="content_main">
<form id="respForm" action="save_responsibility.htm" method="post">
<input type="hidden" id="id" name="id" />
<dl id="lf">
	<dd>
     <label class="label"><fmt:message key="respon.fcode" /></label>
     <input id="funcode" name="funcode" class="inp required"/>
   	</dd>
   	<dd>
     <label class="label"><fmt:message key="respon.name" /></label>
     <input id="name" name="name" class="inp required"/>
   	</dd>
   	<dd class="dd_text">
     <label class="label"><fmt:message key="respon.explain" /></label>
     <textarea id="explanation" name="explanation" class="inp required"></textarea>
   	</dd>
 </dl>
</form>
</div> <!-- end content_main -->
</div> <!-- end main -->
<%@include file="/common/footer.html" %>
</div> <!-- end container_24 -->

</body>
</html>
