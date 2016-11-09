<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>

<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="../styles/uploadify.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="../styles/jcrop.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="../styles/app.css" media="screen" rel="stylesheet" type="text/css"/>

<script src="../scripts/common/uploadify-2.1.4.js" type="text/javascript"></script>
<script src="../scripts/common/jcrop.js" type="text/javascript"></script>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/jquery.blockUI.js" type="text/javascript"></script>
<script src="../scripts/common/utils.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/app/education.js" type="text/javascript"></script>

<title><fmt:message key="user.edu" /> -SQE SERVICE GOM</title>
<style type="text/css">
#thumbnail {}
</style>

</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<table id="edu_tb"></table>
<div id="edu_pg"></div>
<div id="gConsole"><span style="color:red;"><fmt:message key="general.delete.msg" /></span></div>
<div id="content_main">
<input type="hidden" id="zw" name="zw" />
<input type="hidden" id="zh" name="zh" />
<input type="hidden" id="x" name="x" />
<input type="hidden" id="y" name="y" />
<input type="hidden" id="edus" name="edus"  value=""/>

<form id="eduForm" method="post" action="update_education.htm">
<input type="hidden" name="id" id="id" />
<input type="hidden" name="idScan" id="idScan" />
<fieldset class="fs_title">
    <dl id="lf">
      <dd><label class="label"><fmt:message key="user.school" /><input type="text" name="school" id="school" class="inp required" tabindex="3" maxlength="30"/></label> </dd>
      <dd><label class="label"><fmt:message key="user.ed" /><input type="text" name="ed" id="ed" class="inp required" tabindex="4" maxlength="16"/></label> </dd>
      <dd><label class="label"><fmt:message key="general.startDate" /><input type="text" name="startDate" id="startDate" class="inp required" tabindex="1" maxlength="10"/></label> </dd>
      <dd><label class="label"><fmt:message key="general.endDate" /><input type="text" name="endDate" id="endDate" class="inp required" tabindex="2" maxlength="10"/></label> </dd>
      <dd><label class="label"><fmt:message key="user.major" /><input type="text" name="major" id="major" class="inp required" tabindex="5" maxlength="20"/></label></dd>
      <dd><label class="label"><fmt:message key="user.idno" /><input type="text" name="idno" id="idno" class="inp required" tabindex="6" maxlength="30"/></label></dd>
      <dd class="idscanimg">
		   <label class="label"><fmt:message key="user.idScanImg" /><input type="file" name="idScanImg" id="idScanImg"/>
		      <img src="" id="idscan" width="450" height="270" alt=""/>
		   </label>    
		   <label class="label"><fmt:message key="user.cut" /><input type="button" value="<fmt:message key="user.crop_submit" />" id="crop_submit" tabindex="9" class="aqua_but"/></label>
      </dd>
      <dd>
      	<div id="thumbnail">
		  <img id="tmp_img" src="" alt=""/>
		  <div id="tmp_preview"><img id="preview" src="" alt="Preview" /></div>
		</div>
      </dd>
  </dl>
</fieldset>
</form>
</div> <!-- end content_main -->
</div> <!-- end content -->
</div> <!-- end main -->
<%@include file="/common/footer.html" %>
</div> <!-- end container_24 -->
</body>
</html>