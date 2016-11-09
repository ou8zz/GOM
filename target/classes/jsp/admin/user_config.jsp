<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<link href="../styles/global.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>

<title><fmt:message key="user.config.page.title" /> -SQE SERVICE GOM</title>
<%@include file="/common/common_import.html" %>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/admin/user_config.js" type="text/javascript"></script>

</head>
<body>
<%@include file="/common/admin_header.html" %>
<div id="content" class="alpha grid_20 omega">
<div id="g_mgr">
<table id="zgrid"></table>
<div id="zpager"></div>
</div>
<div id="content_main">
<form id="userForm">
<input type="hidden" id="id" />
<dl id="lf">
   <dd><label id="cname"></label>(<label id="ename"></label>)&nbsp;&nbsp;&nbsp;<label id="types"></label></dd>
   <dd>
     <label class="label"><fmt:message key="general.dpt" /><select id="department" class="inp required">
     	<c:forEach items="${departments}" var="d">
     		<option value="${d.id }">${d.cname }</option>
     	</c:forEach>
     </select></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="general.pst" /><select id="position" class="inp required">
     	<c:forEach items="${positions}" var="p">
     		<option value="${p.id }">${p.cname }</option>
     	</c:forEach>
     </select></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="general.role" /><select id="role" class="inp required">
     	<c:forEach items="${roles}" var="r">
     		<option value="${r.id }">${r.cname }</option>
     	</c:forEach>
     </select></label>
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