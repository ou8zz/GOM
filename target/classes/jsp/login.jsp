<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<title>Login -SQE SERVICE GOM</title>
<link href="styles/reg.css" media="screen" rel="stylesheet" type="text/css"/>
<link href="styles/jquery-ui-1.8.20.css" media="screen" rel="stylesheet" type="text/css"/>
<style type="text/css">
.user{line-height:10px; margin-left: 30px; margin-top: 30px;}
</style>

<%@include file="/common/header.html" %>
<script src="scripts/common/jquery-ui-1.8.20.js" type="text/javascript"></script>
<script src="scripts/common/jcrop.js" type="text/javascript"></script>
<script src="scripts/common/validate.js" type="text/javascript"></script>
<script type="text/javascript" src="scripts/common/maskedinput.js"></script>
<script src="scripts/common/md5.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$("#gom_login_form").submit(function() {
		$("#j_password").val($.md5($("#j_password").val()));
	});
});
</script>

</head>
<body>
<!-- Security login -->
<div class="grid_24" align="left">
<div class="user"><h1 style="color:blue">GOM登录</h1></div>
<form id="gom_login_form" action="gom_login.htm" method="post">
<div class="user">UserName:<input id="j_username" name="j_username" value="sqe_ole" /></div>
<div class="user">Password:<input id="j_password" name="j_password" value="sqe111" /></div>
<div class="user">
<input type="submit" value="login" />
<input type="button" value="out" onclick="location='gom_logout.htm'" />
</div>
</form>
<div class="user">
<c:if test="${not empty param.error}">  
<font color="red">登录失败<br />
原因: <c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}" /></font>  
</c:if>  
</div>
</div>

<%@include file="/common/footer.html" %>
</body>
</html>