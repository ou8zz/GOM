<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link href="../styles/global.css" media="screen" rel="stylesheet" type="text/css"/>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/admin/group.js" type="text/javascript"></script>
<style type="text/css">
#gf dd label{font-size:1.2em;line-height:26px;width:80px;float:left;text-align:right;display:block;color:#0E5080;}
#gf dd input.inp{float:left;border:1px solid #628EB1;height:20px;padding:2px;width:100px;font-size:1em;}
.inp_warning{background:#F0FDE2;border:1px dotted #8FBCDD;border-left:0;border-right:0;float:left; height: 24px;}
.inp_warning s{background-image:url(../images/tip.png);float:left;width:16px;height:16px;margin-top:2px;}
.inp_error{background:#FCF2F0;border:1px dotted #FA8385;border-left:0;border-right:0;float:left;}
.inp_error s{background-image:url(../images/error.png); float:left;width:16px;height:16px;margin-top:2px;}
.inp_warning i, .inp_error i{padding:0 3px;}
</style>

<title><fmt:message key="group.page.title" /> -SQE SERVICE GOM</title>
</head>
<body>
<%@include file="/common/admin_header.html" %>
<div id="content" class="grid_20 omega">
<table id="zgrid"></table>
<div id="zpager"></div>

<div id="gConsole"><span style="color:red;"><fmt:message key="asset.delete.msg" /></span></div>

<div id="content_main">
<form:form modelAttribute="g">
 <form:hidden path="id" />
 <dl id="gf">
   <dd id="dd_ename">
     <label><fmt:message key="user.ename" /></label><form:input path="ename" size="15" maxlength="15" cssClass="inp"/>
     <span id="e_title"></span>
   </dd>
   <dd>
     <label><fmt:message key="user.cname" /></label><form:input path="cname" size="10" maxlength="10" cssClass="inp"/>
     <span id="c_title"></span>
   </dd>
 </dl> 
</form:form>
</div><!-- end content_main -->
</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>