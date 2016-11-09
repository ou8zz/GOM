<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>

<link href="../styles/app.css" media="screen" rel="stylesheet" type="text/css"/>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/utils.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/app/borrow.js" type="text/javascript"></script>

<title><fmt:message key="borrow.page.title" /> -SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<div id="g_mgr">
<table id="borrow_tb"></table>
<div id="borrow_pg"></div>
</div>
<div id="gConsole"><span style="color:red;"><fmt:message key="general.delete.msg" /></span></div>
<div id="content_main">
<form id="borrowForm">
<input type="hidden" id="id" name="id" />
<input type="hidden" id="assetId" name="assetId" />
<dl id="lf">
<!--    <dd> -->
<%--      <label class="label"><fmt:message key="respon.fcode" /><input id="funCode" name="funCode" maxlength="20" class="inp"/></label> --%>
<!--    </dd> -->
   <dd>
     <label class="label"><fmt:message key="borrow.applyState" /><select id="applyState" name="applyState" class="inp required"><option value="AGREE"><fmt:message key="borrow.agree" /></option><option value="REJECT"><fmt:message key="borrow.reject" /></option><option value="CONFIRM"><fmt:message key="borrow.confirm" /></option><option value="HOMING"><fmt:message key="borrow.homing" /></option><option value="USING"><fmt:message key="borrow.using" /></option><option value="DAMAGED"><fmt:message key="borrow.damaged" /></option></select></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="borrow.num" /><input id="receiveNum" name="receiveNum" maxlength="20" class="inp"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="borrow.receiver" /><input id="receiver" name="receiver" maxlength="20" class="inp"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="asset.apply.date" /><input id="receiveDate" name="receiveDate" maxlength="20" class="inp"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="asset.return.date" /><input id="returnDate" name="returnDate" maxlength="20" class="inp"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="borrow.overStaff" /><input id="overStaff" name="overStaff" maxlength="20" class="inp"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="general.note" /><textarea id="remark" name="remark" class="area" cols="29" rows="2"></textarea></label>
   </dd>
 </dl>
</form> 
</div> <!-- end content_main -->
</div> <!-- end content -->
</div> <!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div> <!-- end container_24 -->
</body>
</html>
