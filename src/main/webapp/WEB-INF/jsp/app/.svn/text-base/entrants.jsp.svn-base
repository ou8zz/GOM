<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen" />
<script src="../scripts/common/grid.js" type="text/javascript"></script>
<script src="../scripts/common/uploadify-2.1.4.js" type="text/javascript"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/common/jcrop.js" type="text/javascript"></script>
<script src="../scripts/common/jquery.blockUI.js" type="text/javascript"></script>
<script src="../scripts/common/utils.js" type="text/javascript"></script>
<script src="../scripts/app/entrants.js" type="text/javascript"></script>
<style type="text/css">
#content_main{width:380px;position:relative;}
#content_main span h2{display:inline}
#content_main span span{float:right;}
#header_line{border-top:1px dashed #3399FF;text-align:right;color:#06F;}
#content_main .side{position:relative;width:405px;}
#content_main .left_side{width:120px;float:left;margin-top:-15px;}
#touxian{margin-left:20px;margin-bottom:30px;}
#content_main table{float:left;width:285px;margin-left:20px;}
#content_main td{padding:8px;border-bottom:1px solid #fff;color:#333;border-top:1px solid #fff;background:#e8edff url('../images/gradback.png') repeat-x;}
#content_main input{height:18px;line-height:18px;margin-left:10px;}
#content_main input.inp{width:200px;}
#edu_tb td{padding:5px 0;}
#edu_tb label{width:90px;text-align:right;}
#edu_tb input{width:145px;height:18px;line-height:18px;margin:0;padding:0;text-align:left;margin-left:5px;}
label.error{display:block;color:red;font-style:italic;font-weight:normal;}
input[type="text"].error, select.error{width:200px;}
input.error, select.error{border:2px solid red;background-color:#FFFFD5;margin:0px;color:red;}
tr.error{color:red;background:url('../images/warning.gif') no-repeat top left;}
tr.error a{color:#336699;font-size:.95em;text-decoration:underline}
#content_main .add_mail{position:relative;width:350px;}
#portrait,#entryForm{float:left;}
#portrait{margin-right:15px;}
.director select{margin-left:15px;}
</style>
<title><fmt:message key="entrants.page.title" /> - SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="grid_20 omega">
<table id="zgrid"></table>
<div id="zpager"></div>
<br/>
<table id="agrid"></table>
<div id="apager"></div>
<br/>
<table id="egrid"></table>
<div id="epager"></div>
<div id="content_main">
<form:form id="entryForm" modelAttribute="entrant" method="post">
<form:hidden path="id" />
<form:hidden path="jobNo" />
<form:hidden path="traceId" />
<form:hidden path="nodeCode" />
<form:hidden path="nodeOrder" />
<form:hidden path="portrait" />
<form:hidden path="ename" />
<form:hidden path="pwd" />

<span id="name"></span>
<div id="header_line"></div>
<div class="left_side">
<img id="touxian" src="../images/touxian.gif" border="0"/>
<br/>
<span><fmt:message key="entrants.span" /></span>
<br/>
<input type="file" name="idScanImage" id="idScanImage" tabindex="8"/>
</div>
<table border="0" cellpadding="0" cellspacing="7">
  <tr>
    <td><label id="department"><fmt:message key="general.dpt" /></label><span id="cdepartment"></span></td>
    <td>&nbsp;</td>
    <td><label id="position"><fmt:message key="general.pst" /></label><span id="cposition"></span></td>
  </tr>
  <tr class="error">
    <span></span>
  </tr>
  <tr>
    <td colspan="3"><label><fmt:message key="edit.user.entryDate" /></label><input id="entryDate" name="entryDate" tabindex="1" type="text" readonly="readonly"/></td>
  </tr>
  <tr>
    <td colspan="3"><label><fmt:message key="user.type" /></label>
<span><input name="type" tabindex="2" type="radio" value="FIELDWORK"/><label><fmt:message key="user.type1" /></label></span><span><input name="type" tabindex="3" type="radio" value="TRAINING_PERIOD"/><label><fmt:message key="user.type2" /></label></span><span><input name="type" tabindex="4" type="radio" value="QUALIFIED"/><label><fmt:message key="user.type3" /></label></span></td>
    </tr>
  <tr>
    <td colspan="3"><label><fmt:message key="user.fullDate" /></label><input id="fullDate" name="fullDate" tabindex="5" type="text" readonly="readonly"/></td>
  </tr>
  <tr>
    <td colspan="3"><label><fmt:message key="user.bank" /></label><input id="bank" name="bank" tabindex="6" type="text" maxlength="50" class="inp"/></td>
  </tr>
  <tr>
    <td colspan="3"><label><fmt:message key="user.accountNo" /></label><input id="accountNo" name="accountNo" tabindex="7" type="text" maxlength="19" class="inp"/></td>
    </tr>
  <tr>
    <td colspan="3"><label><fmt:message key="user.census" /></label>
		<span><form:radiobutton path="censusType" value="COUNTRYSIDE" cssClass="required"/><label for="censusType1"><fmt:message key="user.census.countryside" /></label></span><span><form:radiobutton path="censusType" value="TOWN" cssClass="required"/><label for="censusType2"><fmt:message key="user.census.town" /></label></span><span><form:radiobutton path="censusType" value="GANGAOTAIBAO" cssClass="required"/><label for="censusType3"><fmt:message key="user.census.gangao" /></label></span><span><form:radiobutton path="censusType" value="FOREIGNER" cssClass="required"/><label for="censusType4"><fmt:message key="user.census.foreigner" /></label></span>
      </tr>
  <tr><td colspan="3"><label><fmt:message key="user.idcard" /></label><input id="idcard" name="idcard" tabindex="11" type="text" maxlength="18" class="inp"/></td></tr>
  <tr><td colspan="3" class="director"><label><fmt:message key="leave.apply.recipient" /></label><form:select path="email" tabindex="12"><form:option value=""><fmt:message key="general.select" /></form:option><form:options items="${departments}" itemValue="id" itemLabel="cname" /></form:select><form:select path="emailPwd" tabindex="13"></form:select></td></tr>
</table>
<div style="position:relative"><img id="idScan" src="" border="0" width="250" height="150" style="float:left;"/>
<div style="float:left;width:160px;margin-left:10px"><input type="checkbox" name="approval" id="approval" tabindex="1" value="APPROVAL"><fmt:message key="entrants.approval1" /><span style="color:red">（如果地址和教育信息未填写或检查，请勿确认，先填写或核对好，最后再这里提交通过）<fmt:message key="entrants.approval2" /></span></div></div>
</form:form>
</div>

<div id="content_edu">
<table id="edu_tb">
  <tr>
    <td><label><fmt:message key="user.school" /></label><input id="school" name="school" tabindex="13" type="text" maxlength="30"/></td>
    <td>&nbsp;</td>
    <td><label><fmt:message key="user.major" /></label><input id="major" name="major" tabindex="14" type="text" maxlength="30"/></td>
  </tr>
  <tr>
    <td><label>&nbsp;<fmt:message key="general.startDate" /></label><input id="startDate" name="startDate" tabindex="15" type="text"/></td>
    <td>&nbsp;</td>
    <td><label>&nbsp;<fmt:message key="general.endDate" /></label><input id="endDate" name="endDate" tabindex="16" type="text"/></td>
  </tr>
  <tr>
    <td><label><fmt:message key="user.ed" /></label><input id="ed" name="ed" tabindex="17" type="text" maxlength="20"/></td>
    <td>&nbsp;</td>
    <td><label>&nbsp;<fmt:message key="user.idno" /></label><input id="idno" name="idno" tabindex="18" type="text" maxlength="35"/></td>
  </tr>
  <tr>
    <td colspan="3"><label><fmt:message key="user.idScanImg" /></label><input type="file" name="zjScanImage" id="zjScanImage" tabindex="19"/></td>
  </tr>
</table>
<div><img id="zjScan" name="zjScan" border="0" width="400" height="250"/></div>
</div>

</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>