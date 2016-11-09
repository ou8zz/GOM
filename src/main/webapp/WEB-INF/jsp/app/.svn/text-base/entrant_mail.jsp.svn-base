<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<title><fmt:message key="entrant.mail.title" /> - SQE SERVICE GOM</title>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen" />
<%@include file="/common/common_import.html" %>
<script src="../scripts/common/grid.js" type="text/javascript"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/common/jquery.blockUI.js" type="text/javascript"></script>
<script src="../scripts/app/entrant_mail.js" type="text/javascript"></script>
<style type="text/css">
.gom_tb,.resp{width:600px;border-collapse:collapse;border-left:#A6C9E2 solid 1px;border-top:#A6C9E2 solid 1px;text-align:left;}
.gom_tb td,.gom_tb th,.resp td,.resp th{border-right:#A6C9E2 solid 1px;border-bottom:#A6C9E2 solid 1px;padding:10px 10px 6px;}
.gom_tb tbody th,.resp thead th{background-color:#C5DBEC;font-weight:normal;text-align:center;}
.gom_tb tbody b{font-size:1.1em;}
.gom_tb thead th{padding:10px 5px;font-weight:bold;}
.gom_tb tbody td ul{list-style:none;position:relative;margin:0;margin:-10px 0 0;}
.gom_tb tbody td ul li{float:left;height:20;line-height:20px;margin:0 0 20px;padding:0 10px;border-right:1px #333 solid;}.gom_tb tbody td ul li.last{border:none;}
table.resp caption{font-weight:bold;font-size:1.1em;}
table.resp tbody th{text-align:right;}
table.resp tbody input.inpw{width:70%;}
label.error{color:#F00;text-align:left;margin:0;display:inline;}
</style>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="grid_20 omega">
<table id="zgrid"></table>
<div id="zpager"></div>
<div id="content_main">
<form id="entryForm" method="post">
<input type="hidden" id="id" name="id" />
<input type="hidden" id="traceId" name="traceId" />
<input type="hidden" id="nodeCode" name="nodeCode" />
<input type="hidden" id="nodeOrder" name="nodeOrder" />
<input type="hidden" id="ename" name="ename" />
<input type="hidden" id="cname" name="cname" />
<input type="hidden" id="jobNo" name="jobNo" />
<input type="hidden" id="entryDate" name="entryDate" />
<input type="hidden" id="fullDate" name="fullDate" />
<input type="hidden" id="gender" name="gender" />
<input type="hidden" id="birthday" name="birthday" />
<input type="hidden" id="marriage" name="marriage" />
<input type="hidden" id="nation" name="nation" />
<input type="hidden" id="depId" name="depId" />
<input type="hidden" id="cdepartment" name="cdepartment" />
<input type="hidden" id="cposition" name="cposition" />
<input type="hidden" id="cell" name="cell" />
<input type="hidden" id="portrait" name="portrait" />
<input type="hidden" id="approval" name="approval" value="APPROVAL">
<table cellspacing="0" cellpadding="0" class="gom_tb" summary="新员工职责分配"></table>

<table width="100%" class="resp"><caption><fmt:message key="entrant.mail.caption" /></caption><tbody>
<tr><th width="30%"><fmt:message key="user.telExt" /></th><td width="70%"><input id="telExt" name="telExt" tabindex="1" type="text" maxlength="8"/></td></tr>
<tr><th><fmt:message key="user.email" /></th><td><input id="email" name="email" tabindex="2" type="text" maxlength="35" class="inpw"/></td></tr>
<tr><th><fmt:message key="user.emailPwd" /></th><td><input id="emailPwd" name="emailPwd" tabindex="3" type="text" maxlength="20" class="inpw"/></td></tr>
<tr><th><fmt:message key="entrant.mail.active" /></th><td><input type="checkbox" name="active" id="active" tabindex="4"/></td></tr>
<tr><th></th><td><input type="checkbox" name="lock" id="lock" tabindex="5"/><span style="color:red;"><fmt:message key="entrant.mail.msg" /></span></td></tr>
<tfoot><tr><td colspan="2"><span class="error_msg"></span></td></tr></tfoot>
</tbody></table>
</form>
</div><!-- end content_main -->
</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>