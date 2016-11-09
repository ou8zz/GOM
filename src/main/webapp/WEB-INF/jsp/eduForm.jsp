<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<title><fmt:message key="user.edu.title" /> -SQE SERVICE GOM</title>
<meta name="description" content="Amazine,Balanced Trace Mineral,Greens&Reds" />
<meta name="keywords" content="Amazine Balanced Trace Mineral Greens&Reds" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="styles/reg.css" media="screen" rel="stylesheet" type="text/css"/>
<link href="styles/jquery-ui-1.8.20.css" media="screen" rel="stylesheet" type="text/css"/>
<script src="scripts/common/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="scripts/common/jquery-ui-1.8.20.js" type="text/javascript"></script>
<script src="scripts/common/uploadify-2.1.4.js" type="text/javascript"></script>
<script src="scripts/common/validate.js" type="text/javascript"></script>
<script type="text/javascript" src="scripts/common/maskedinput.js"></script>
<script type="text/javascript" src="scripts/common/json-2.3.min.js"></script>
<script src="scripts/common/menu.js" type="text/javascript"></script>
<script type="text/javascript" src="scripts/reg_edu.js"></script>
</head>
<body>
<div id="container">
<div id="header"></div>
<div id="content">
<div id="left_side">
<h1><fmt:message key="user.ent" /></h1>
<div id="proceede">
<h2><fmt:message key="user.reported" /></h2>
<a class="step step1"><fmt:message key="user.mesgs" /></a>
<a class="step step2"><fmt:message key="user.hrcheck" /></a>
<a class="step step3"><fmt:message key="user.itsendmail" /></a>
</div>
</div>
<div id="right_side">
<h1>Step 2 of 3 </h1>
<form:form id="eduForm" method="post" modelAttribute="edu" action="save_edu.htm">
<input id="uid" name="uid" type="hidden" value="${TMP_USER_TAKEN.id}"/>
<input id="edus" name="edus" type="hidden"/>
<form:hidden path="id" />
<form:hidden path="idScan" />
<fieldset class="fs_title">
  <legend class="leg_title"><fmt:message key="user.edu" /></legend>
  <ul class="nav_title"><li>&gt;&gt; <a href="reg.htm"><fmt:message key="user.inbisic" /></a></li><li>&gt; <a href="next_edu.htm"><fmt:message key="user.inedu" /></a></li><c:if test="${!empty TMP_USER_TAKEN.id}"><li>&gt; <a href="next_addr.htm"><fmt:message key="user.inaddr" /></a></li></c:if></ul>
    <table class="reg_tb">
      <caption><fmt:message key="user.edus" /></caption>
      <thead><tr><th><fmt:message key="user.number" /></th><th><fmt:message key="general.startDate" /></th><th><fmt:message key="general.endDate" /></th><th><fmt:message key="user.school" /></th><th><fmt:message key="user.major" /></th><th><fmt:message key="user.ed" /></th><th><fmt:message key="user.operate" /></th></tr></thead>
      <tbody><c:choose><c:when test="${empty edus}"></c:when><c:otherwise><c:forEach var="edu" items="${edus}" varStatus="status"><tr><td>${status.count}</td><td>${edu.startDate}</td><td>${edu.endDate}</td><td>${edu.school}</td><td>${edu.major}</td><td>${edu.ed}</td><td><a href="del_education.htm?id=${edu.id}"><fmt:message key="general.del" /></a></td></tr></c:forEach></c:otherwise></c:choose></tbody>
    </table>
    <dl>
    <div class="error" style="display:none;">
      <img src="images/warning.gif" alt="Warning!" width="24" height="24" style="float:left;margin:-5px 10px 0px 0px; "/>
      <span></span>.<br clear="all"/>
    </div>
    <dd>
    <form:errors path="*" cssStyle="color:red"/>
    </dd>
    <dd></dd>
      <dd>
        <label class="lab"><fmt:message key="general.startDate" /></label> <form:input path="startDate" id="startDate" cssClass="inp required" tabindex="1" maxlength="10"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="general.endDate" /></label> <form:input path="endDate" id="endDate" cssClass="inp required" tabindex="2" maxlength="10"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.school" /></label> 
        <form:input id="school" path="school" cssClass="inp required" tabindex="3" maxlength="30"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.ed" /></label> 
        <form:input id="ed" path="ed" cssClass="inp required" tabindex="4" maxlength="16"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.major" /></label>
        <form:input id="major" path="major" cssClass="inp required" tabindex="5" maxlength="20"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.idno" /></label>
        <form:input id="idno" path="idno" cssClass="inp required" tabindex="6" maxlength="30"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.idScanImg" /></label>
        <input type="file" name="idScanImg" id="idScanImg" tabindex="7"/>
      </dd>
      <dd><input type="submit" value="<fmt:message key="user.again.add" />" id="next_item" class="aqua_but"></dd>
  </dl>
</fieldset>
<div class="buttonSubmit" id="butSubmit">
  <span></span>
  <input type="submit" name="userSubmit" value="<fmt:message key="general.submit" />" id="userSubmit" tabindex="20"/>
</div>
</form:form>
</div>
</div>
<%@include file="/common/footer.html" %>
</div>
</body>
</html>