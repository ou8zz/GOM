<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link href="../styles/app.css" media="screen" rel="stylesheet" type="text/css"/>
<link href="../styles/uploadify.css" media="screen" rel="stylesheet" type="text/css"/>
<link href="../styles/jcrop.css" media="screen" rel="stylesheet" type="text/css"/>
<script src="../scripts/common/uploadify-2.1.4.js" type="text/javascript"></script>
<script src="../scripts/common/jcrop.js" type="text/javascript"></script>
<script src="../scripts/common/maskedinput.js" type="text/javascript" ></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/app/edit_user.js" type="text/javascript"></script>
<style type="text/css">
#content img{border:none;}
.introduction{border:1px solid #36C;margin:10px 0;}
#lf{margin:0;padding:0;}
dd label.lab span{float:left;color:#0E5080;}
dd label.lab{font-size:1em;line-height:26px;height:26px;width:125px;float:left;text-align:right;color:#0E5080;}
#lf dd input.readInp,#lf dd select.readInp{float:right;border:1px solid #ccc;height:22px;line-height:22px;margin-left:5px;width:200px;font-size:1em;}
.about{padding-bottom:10px;}
.about h2{display:inline-block;margin:0 5px 5px 0;}
.about i{float:right;}
.about ul{list-style:none;border-top:1px solid #333;}
.about ul li{display:inline-block;padding:2px 5px;margin:0;}
.about ul li.first{margin-left:100px;}
.colum_content{height:26px;line-height:26px;font-size:1em;float:left;position:relative;width:330px;}
.colum_content label{width:120px;float:left;text-align:right;color:#0E5080;}
#thumbnail{clear:both;position:relative;max-width:670px;}
.idScan_preview{width:450px;height:270px;overflow:hidden;}
.portrait_preview{width:80px;height:100px;overflow:hidden;}
#sfz{margin:15px 0;}
</style>

<title><fmt:message key="edit.user.title" /> -SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="grid_20 omega">
<form:form id="userForm" modelAttribute="user" method="post">
<form:hidden path="id" />
<form:hidden path="idScan" />
<form:hidden path="portrait" />
<input type="hidden" id="zw" name="zw" />
<input type="hidden" id="zh" name="zh" />
<input type="hidden" id="x" name="x" />
<input type="hidden" id="y" name="y" />
<div class="introduction grid_20 omega">
<div class="about grid_17 alpha"><span><h2>${user.cname}</h2>${user.ename}</span><i><fmt:message key="edit.user.entryDate" /> ${user.entryDate}</i><ul><li class="first"></li><li>${user.gender.des}</li>|<li>${user.birthday}</li>|<li>${user.nation}</li>|<li>${user.marriage.des}</li>|<li>${user.height}cm</li></ul>
<div class="colum_content"><label><fmt:message key="general.dpt" /></label>${user.cdepartment}</div>
<div class="colum_content"><label><fmt:message key="general.pst" /></label>${user.cposition}</div>
<div class="colum_content"><label><fmt:message key="user.census" /></label>${user.censusType.des}</div>
<div class="colum_content"><label><fmt:message key="user.documents1" /></label>${user.idcard}</div>
<div class="colum_content"><label><fmt:message key="user.email" /></label>${user.email}</div>
<div class="colum_content"><label><fmt:message key="user.jobNo" /></label>${user.jobNo}</div>
</div>
<div id="touxian"><img src="../uploads/images/${user.portrait}" class="grid_3 omega" alt="${user.ename}portrait" title="${user.ename}portrait"/></div>
</div>
<div id="sfz"><img src="../uploads/images/${user.idScan}" alt="<fmt:message key="user.idScanImage" />" title="<fmt:message key="user.idScanImage" />"/></div>
<dl id="lf">
<div class="error" style="display:none;"><img src="../images/warning.gif" alt="Warning!" width="24" height="24" style="float:left; margin: -5px 10px 0px 0px; " /><span></span>.<br clear="all"/><br/></div>
   <dd><label class="label"><fmt:message key="user.privateCell" /><form:input path="cell" cssClass="inp mobileCN" tabindex="1" maxlength="17"/></label> </dd>
   <dd><label class="label"><fmt:message key="user.privatePhon" /><form:input path="phone" cssClass="inp phoneCN" tabindex="2" maxlength="16"/></label> </dd>
   <dd><label class="label"><fmt:message key="user.privateMail" /><form:input path="privateMail" cssClass="inp" tabindex="3" maxlength="35"/></label> </dd>
   <dd><label class="label"><fmt:message key="user.telExt" /><form:input path="telExt" cssClass="inp" tabindex="4"/></label> </dd>
   <dd><label class="label"><fmt:message key="user.bank" /><form:input path="bank" cssClass="inp" tabindex="5" maxlength="45"/></label> </dd>
   <dd><label class="label"><fmt:message key="user.accountNo" /><form:input path="accountNo" cssClass="inp" tabindex="6" maxlength="19"/></label> </dd>
   <dd><label class="label"><fmt:message key="user.idScanImage" /><input type="file" name="idScanImage" id="idScanImage" tabindex="7"/></label></dd>
   <dd><label class="label"><fmt:message key="user.cut" /><input type="button" name="crop_idScan" value="<fmt:message key="user.crop_submit" />" id="crop_idScan" tabindex="8" class="aqua_but"/></label></dd>
   <dd><label class="label"><fmt:message key="user.uploadPortrait" /><input type="file" name="portraitImage" id="portraitImage" tabindex="9"/></label></dd>
 </dl>
<div id="thumbnail">
  <img id="tmp_portrait" src="" alt="<fmt:message key="user.image.alt" />"/>
  <div id="preview"><img id="idScan_tmp" src="" alt="idScan_tmp"/></div>
</div>
 <div id="lfsub">
  <label class="lab_button"><input type="submit" value="<fmt:message key="edit.user.submit" />" id="leavesubmit" tabindex="10" class="button"/></label>
 </div>
</form:form>
</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>