<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>

<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="../styles/app.css" media="screen" rel="stylesheet" type="text/css"/>

<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/maskedinput.js" type="text/javascript"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/app/address.js" type="text/javascript"></script>

<title><fmt:message key="user.address" /> -SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<table id="addr_tb"></table>
<div id="addr_pg"></div>
<div id="gConsole"><span style="color:red;"><fmt:message key="general.delete.msg" /></span></div>
<div id="content_main">
<form id="addrForm" method="post">
	<input type="hidden" name="id" id="id" />
	<div class="error" style="display:none;">
      <img src="../images/warning.gif" alt="Warning!" width="24" height="24" style="float:left;margin:-5px 10px 0px 0px; "/>
      <span></span>.<br clear="all"/>
    </div>
    <dl id="lf">
     <dd>
        <label class="label"><fmt:message key="user.addrtype" /><select id="addrType" name="addrType" class="inp required">
        	<option value="PRESENT"><fmt:message key="user.addrtype.present" /></option>
        	<option value="FAMILY"><fmt:message key="user.addrtype.family" /></option>
        	<option value="CENSUS"><fmt:message key="user.addrtype.census" /></option>
        	<option value="EMERGENCY"><fmt:message key="user.addrtype.emergency" /></option>
        </select></label> 
      </dd>
      <dd><label class="label"><fmt:message key="user.contact" /><input type="text" name="contact" id="contact" class="inp required" tabindex="1" maxlength="10"/></label> </dd>
      <dd><label class="label"><fmt:message key="user.relation" /><input type="text" name="relation" id="relation" class="inp required" tabindex="2" maxlength="10"/></label> </dd>
      <dd><label class="label"><fmt:message key="user.cell" /><input type="text" name="cell" id="cell" class="inp required mobileCN" tabindex="3" maxlength="17"/></label></dd>
      <dd><label class="label"><fmt:message key="user.zuoji" /><input type="text" name="phone" id="phone" class="inp required phoneCN" tabindex="4" maxlength="16"/></label></dd>
      <dd><label class="label"><fmt:message key="user.address" /><textarea id="address" name="address" class="area" cols="29" rows="2"></textarea></label></dd>
      <dd><label class="label"><fmt:message key="user.zipcode" /><input type="text" name="zipcode" id="zipcode" class="inp required" tabindex="6" maxlength="6"/></label> </dd>
    </dl>
</form>
</div> <!-- end content_main -->
</div> <!-- end content -->
</div> <!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div> <!-- end container_24 -->
</body>
</html>