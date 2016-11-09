<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="添加联系人" />
<meta name="keywords" content="联系人" />
<link href="styles/reg.css" media="screen" rel="stylesheet" type="text/css"/>
<script src="scripts/common/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="scripts/common/validate.js" type="text/javascript"></script>
<script src="scripts/common/menu.js" type="text/javascript"></script>
<script type="text/javascript" src="scripts/common/maskedinput.js"></script>
<script src="scripts/reg_addr.js" type="text/javascript"></script>
<title><fmt:message key="user.addr.title" /> -SQE SERVICE GOM</title>
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
<h1>Step 3 of 3 </h1>
<form id="addrsForm" name="addrsForm" method="post" action="save_addr.htm">
<input id="addrs" name="addrs" type="hidden"/>
<input id="uid" name="uid" type="hidden" value="${TMP_USER_TAKEN.id}"/>
</form>
<form:form id="addrForm" method="post" modelAttribute="a" action="save_addr.htm">
<form:hidden path="id"/>
<c:choose><c:when test="${empty a.addrType}"><input id="addrType" name="addrType" type="hidden" value="PRESENT"/></c:when><c:otherwise><form:hidden path="addrType"/></c:otherwise></c:choose>
<fieldset class="fs_title">
  <legend class="leg_title"><fmt:message key="user.address" /></legend>
  <ul class="nav_title"><li>&gt;&gt; <a href="reg.htm"><fmt:message key="user.inbisic" /></a></li><li>&gt; <a href="next_edu.htm"><fmt:message key="user.inedu" /></a></li><li>&gt; <a href="next_addr.htm"><fmt:message key="user.inaddr" /></a></li></ul>
  <table width="100%" class="reg_tb">
      <caption><fmt:message key="user.ads" /></caption>
      <thead><tr><th width="15%"><fmt:message key="user.contact" /></th><th width="10%"><fmt:message key="user.relation" /></th><th width="15%"><fmt:message key="user.cell" /></th><th width="15%"><fmt:message key="user.zuoji" /></th><th width="23%"><fmt:message key="user.address" /></th><th width="12%"><fmt:message key="user.zipcode" /></th><th width="10%"><fmt:message key="user.operate" /></th></tr></thead>
      <tbody><c:choose><c:when test="${empty addrs}"></c:when><c:otherwise><c:forEach var="addr" items="${addrs}"><tr><td>${addr.contact}</td><td>${addr.relation}</td><td>${addr.cell}</td><td>${addr.phone}</td><td>${addr.address}</td><td>${addr.zipcode}</td><td><a href="del_address.htm?id=${addr.id}"><fmt:message key="general.del" /></a></td></tr></c:forEach></c:otherwise></c:choose></tbody>
    </table>
    <dl class="addr">
    <legend><fmt:message key="user.present" /></legend>
    <div class="error" style="display:none;">
      <img src="images/warning.gif" alt="Warning!" width="24" height="24" style="float:left;margin:-5px 10px 0px 0px; "/>
      <span></span>.<br clear="all"/>
    </div>
    <dd>
    <form:errors path="*" cssStyle="color:red"/>
    </dd>
    <dd></dd>
      <dd>
        <label class="lab"><fmt:message key="user.contact" /></label> <form:input path="contact" cssClass="inp required" tabindex="1" maxlength="10"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.relation" /></label> <form:input path="relation" cssClass="inp required" tabindex="2" maxlength="10"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.cell" /></label>
        <form:input path="cell" cssClass="inp required mobileCN" tabindex="3" maxlength="17"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.zuoji" /></label>
        <form:input path="phone" cssClass="inp required phoneCN" tabindex="4" maxlength="16"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.address" /></label> 
        <form:input path="address" cssClass="inp required" tabindex="5" maxlength="50"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.zipcode" /></label> 
        <form:input path="zipcode" cssClass="inp required" tabindex="6" maxlength="6"/>
      </dd>
  </dl>
  <div id="isame"><label for="addr_to_co"><fmt:message key="user.addr.to" /></label><input type="checkbox" id="addr_to_co" name="addr_to_co" class="toggleCheck" tabindex="7"/></div>
  <br clear="all"/>
  <dl class="family addr">
    <div class="subDiv">
    <legend><fmt:message key="user.family" /></legend>
      <input id="id2" name="id" type="hidden" value="0"/>
      <input id="addrType2" name="addrType" type="hidden" value="FAMILY"/>
      <dd><label class="lab"><fmt:message key="user.contact" /></label><input type="text" id="contact2" name="contact" class="inp familyRequired" tabindex="8" maxlength="10"/></dd>
      <dd><label class="lab"><fmt:message key="user.relation" /></label><input type="text" id="relation2" name="relation" class="inp familyRequired" tabindex="9" maxlength="10"/></dd>
      <dd><label class="lab"><fmt:message key="user.cell" /></label><input type="text" id="cell2" name="cell" class="inp mobileCN familyRequired" tabindex="10" maxlength="17"/></dd>
      <dd><label class="lab"><fmt:message key="user.zuoji" /></label><input type="text" id="phone2" name="phone" class="inp phoneCN familyRequired" tabindex="11" maxlength="16"/></dd>
      <dd><label class="lab"><fmt:message key="user.address" /></label><input type="text" id="address2" name="address" class="inp familyRequired" tabindex="12" maxlength="50"/></dd>
      <dd><label class="lab"><fmt:message key="user.zipcode" /></label><input type="text" id="zipcode2" name="zipcode" class="inp familyRequired" tabindex="13" maxlength="6"/></dd>
      </div>
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