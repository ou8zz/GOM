<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>

<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/common/md5.js" type="text/javascript"></script>
<script src="../scripts/common/maskedinput.js" type="text/javascript"></script>
<script src="../scripts/app/save_pwd.js" type="text/javascript"></script>
<style media="screen" type="text/css">
.juli th, .juli td{padding-top:15px;}
table th{line-height:26px;height:26px;color:#0E5080;text-align:right;}
input.inp{text-align:left;border:1px solid #628EB1;height:22px;line-height:22px;margin-left:5px;width:85%}
.validating{margin:0;padding:5px 0;}
</style>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<form id="pwdForm" name="pwdForm" method="post" action="">
<fieldset>
  <legend><fmt:message key="update.user.pwd.title" /></legend>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="juli">
    <th scope="row" width="15%"><fmt:message key="update.user.pwd" /></th>
    <td width="35%"><input type="password" name="pwd" id="pwd" class="inp required" tabindex="6" maxlength="19"/></td>
    <th width="15%"><fmt:message key="update.user.security" /></th>
    <td width="35%"><input type="text" name="security" id="security" class="inp required" /></td></tr>
  <tr>
    <th colspan="4" scope="row"><div class="submit_but validating"><input type="button" id="sendsecurity" value="<fmt:message key="update.user.sendsecurity" />" /></div></th>
    </tr>
  <tr>
    <th scope="row"><fmt:message key="update.user.pwd1" /></th>
    <td><input type="password" name="npwd" id="npwd" class="inp required" tabindex="6" maxlength="19"/></td>
    <th><fmt:message key="update.user.pwd2" /></th>
    <td><input type="password" name="rpwd" id="rpwd" class="inp required" tabindex="6" maxlength="19"/></td>
  </tr>
  <tr>
    <th colspan="4" scope="row"><div id="errors" class="error" style="color:#F00;text-align:left"></div></th>
    </tr>
  <tr>
    <th colspan="4" scope="row" style="text-align:center"><div class="submit_but"><input type="button" value="<fmt:message key="general.submit" />" id="sub" /></th>
    </tr>
</table>
</fieldset>
</form>
</div> <!-- end content -->
</div> <!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div> <!-- end container_24 -->
</body>
</html>