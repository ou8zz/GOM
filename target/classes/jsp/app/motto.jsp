<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<title><fmt:message key="motto.title" /> -SQE SERVICE GOM</title>
<%@include file="/common/common_import.html" %>
<script src="../common/kindeditor/kindeditor-min.js" type="text/javascript" charset="utf-8"></script>
<script src="../common/kindeditor/lang/zh_TW.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/utils.js" type="text/javascript"></script>
<script src="../scripts/app/motto.js" type="text/javascript"></script>
<style type="text/css">

</style>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="grid_20 omega">
<p><h3><fmt:message key="motto.title" /></h3></p>
<p><textarea id="motto_edit" name="motto_edit" style="width:700px;height:400px;visibility:hidden;"></textarea></p>

<form:form id="mottoForm" modelAttribute="motto" method="post">
<form:hidden path="id" />
<form:hidden path="mottoText" />
<div class="submit_but"><input type="button" id="motto_sub" value="<fmt:message key="general.submit" />"/></div>
</form:form>
</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>