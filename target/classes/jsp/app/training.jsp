<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<style type="text/css">

dl dd{width:320px; height:70px; float:left;margin-right:5px;}
dl dd.textarea{width:650px;}
dl dd label{width:115px;text-align:right;color:#0E5080;}
dl dd input,dl dd select{border:1px solid #628EB1;margin-left:5px;width:200px;}
dl dd input.inp{width:90px;}
dl dd select.minp{width:90px;margin-right:5px}
dl dd span b{text-align:left;margin-right:135px;float:right;}
dl dd label.error{color:red;display:block;padding:0;margin:0px;text-align:left}
dl dd.error_msg{height:16px;}
.textarea{clear:both;}
.textarea label.error{padding:15px 0;display:block;color:#F00;width:300px;}
</style>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/common/utils.js" type="text/javascript"></script>
<script src="../scripts/app/training.js" type="text/javascript"></script>

<title><fmt:message key="training.page.title" /> -SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<table id="training_tb"></table>
<div id="training_pg"></div>
<div id="gConsole"><span style="color:red;"><fmt:message key="general.delete.msg" /></span></div>
<div id="content_main">
<form id="trainingForm" method="post">
<input type="hidden" id="id" name="id" />
<input type="hidden" id="lecturer" name="lecturer" />
    <dl id="lf">
     <dd><label class="label"><fmt:message key="training.tprogram" /></label><input id="tprogram" name="tprogram" /></dd>
      <dd><label class="label"><fmt:message key="training.pt" /></label><span><b>p.t.</b><input id="trainingTime" name="trainingTime" class="inp" /></span></dd>
      <dd><label class="label"><fmt:message key="training.type" /></label><select id="trainingType" name="trainingType" class="required"><option value="INTERNAL"><fmt:message key="training.internal" /></option><option value="EXTERNAL"><fmt:message key="training.external" /></option><option value="SELF_TRAINING"><fmt:message key="training.self" /></option></select></dd>
      <dd><label class="label"><fmt:message key="training.fee" /></label><span><b>&#65509;.</b><input id="fee" name="fee" class="inp" /></span></dd>
      <dd><label class="label"><fmt:message key="training.qualification" /></label><input id="qualification" name="qualification" /></dd>
      <dd><label class="label"><fmt:message key="training.otherfee" /></label><span><b>&#65509;.</b><input id="otherFee" name="otherFee" class="inp" value="0" /></span></dd>
      <dd><label class="label"><fmt:message key="general.startDate" /></label><input id="startDate" name="startDate" readonly="readonly" /></dd>
      <dd><label class="label"><fmt:message key="general.endDate" /></label><input id="endDate" name="endDate" readonly="readonly" /></dd>
      <div class="textarea">
        <label class="label"><fmt:message key="training.tcontent" /></label><textarea id="tcontent" name="tcontent" tabindex="4" rows="3" cols="60"></textarea>
      </div>
      <dd><span class="error_msg"></span></dd>
  </dl>
</form>
</div> <!-- end content_main -->
</div> <!-- end content -->
</div> <!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div> <!-- end container_24 -->
</body>
</html>