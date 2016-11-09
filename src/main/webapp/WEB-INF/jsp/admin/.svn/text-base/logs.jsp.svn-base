<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link href="../styles/app.css" media="screen" rel="stylesheet" type="text/css"/>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>

<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../common/kindeditor/kindeditor-min.js" type="text/javascript" charset="utf-8"></script>
<script src="../common/kindeditor/lang/zh_TW.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/utils.js" type="text/javascript"></script>
<script src="../scripts/admin/logs.js" type="text/javascript"></script>
<style type="text/css">
#lf dd {width:320px; height:78px; float:left;}
#lf dd label.lab{font-size:1.1em;line-height:26px;height:26px;color:#0E5080;margin-left:35px;}
#lf dd input.inp, #lf dd select.inp{float:right;border:1px solid #628EB1;height:22px;line-height:22px;margin-left:5px;width:200px;font-size:1.1em;margin-top:10px;}
#lf dd select.mininp{border:1px solid #628EB1;height:22px;line-height:22px;width:100px;font-size:1.1em;}
#lf dd textarea.area{float:right;border:1px solid #628EB1;margin-left:5px;width:200px;font-size:1em;}
#lf dd label.error{height:26px; float:right;}
</style>
<title><fmt:message key="log.page.title" /> -SQE SERVICE GOM</title>
</head>
<body>
<%@include file="/common/admin_header.html" %>
<div id="content" class="grid_20 omega">
<table id="zgrid"></table>
<div id="zpager"></div>

<div id="content_main">
	<form id="logForm" action="" method="post">
		<input type="hidden" id="id" name="id"/>
		<dl id="lf">
		   <dd><label class="lab"><fmt:message key="log.type" /></label><select id="type" name="type"><option value="SYSTEM"><fmt:message key="log.type1" /></option><option value="NEW"><fmt:message key="log.type2" /></option><option value="UPDATE"><fmt:message key="log.type3" /></option><option value="DEBUG"><fmt:message key="log.type4" /></option></select></dd>
		   <dd><label class="lab"><fmt:message key="log.logger" /></label><input id="logger" name="logger" class="inp"/></dd>
		   <dd><label class="lab"><fmt:message key="log.level" /></label><input id="level" name="level" class="inp"/></dd>
		</dl>
		<br />
		<div style="clear:both;font-size:1.1em;color:#0E5080;"><fmt:message key="log.message" /></div>
		<textarea id="message" name="message" style="width:700px;height:200px;visibility:hidden;"></textarea>
	</form>
</div><!-- End content_main  -->
</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>