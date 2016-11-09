<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<title><fmt:message key="leaves.title" /> - SQE SERVICE GOM</title>
<link rel="stylesheet" type="text/css" media="screen" href="../styles/ui.jqgrid.css" />
<%@include file="/common/common_import.html" %>
<script src="../scripts/common/grid.js" type="text/javascript"></script>
<script src="../scripts/common/uploadify-2.1.4.js" type="text/javascript"></script>
<script src="../scripts/common/jquery.blockUI.js" type="text/javascript"></script>
<script src="../common/date/WdatePicker.js" type="text/javascript"></script>
<script src="../scripts/app/leaves.js" type="text/javascript"></script>
<style type="text/css">
.gom_tb,.trace{border-collapse:collapse;border-left:#A6C9E2 solid 1px;border-top:#A6C9E2 solid 1px;text-align:left;}
.gom_tb td,.gom_tb th{border-right:#A6C9E2 solid 1px;border-bottom:#A6C9E2 solid 1px;padding:10px 10px 6px;}
.gom_tb th{font-weight:bold;}
.gom_tb th,.gom_tb .tb_bg{background-color:#A6C9E2;text-align:center;vertical-align:middle;}
.gom_tb .tmp td{margin:0;padding:0;clear:both;}
input.inpw{width:100%}
input.inp{margin-right:15px;}
.trace thead th{background-color:#693;text-align:center;vertical-align:middle;font-weight:bold;color:#fff;}
.trace tfoot{position:relative;text-align:left;}
.trace tfoot span,.trace tfoot img.arrow{display:block;float:left;}
.trace tfoot span{margin:0 5px;}.trace tfoot span h6{text-align:right;}
.trace tfoot img.arrow{padding:15px 10px 0 10px;}
.elr_boder{ margin:0 15px;}
</style>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="grid_20 omega">
<table id="zgrid"></table>
<div id="zpager"></div>
<div id="content_main">
<form id="leaveForm" method="post">
<input type="hidden" name="id" id="id"/>
<input type="hidden" name="traceId" id="traceId"/>
<input type="hidden" name="nodeCode" id="nodeCode"/>
<input type="hidden" name="nodeOrder" id="nodeOrder"/>
<input type="hidden" name="relationAddr" id="relationAddr"/>
<input type="hidden" name="agent" id="agent"/>
<input type="hidden" name="agentDpt" id="agentDpt"/>
<input type="hidden" name="agentJobNo" id="agentJobNo"/>
<input type="hidden" name="agentPst" id="agentPst"/>
<input type="hidden" name="agentCname" id="agentCname"/>
<input type="hidden" name="recipient" id="recipient"/>
<input type="hidden" name="ename" id="ename"/>
<input type="hidden" name="cname" id="cname"/>
<input type="hidden" name="jobNo" id="jobNo"/>
<input type="hidden" name="cdepartment" id="cdepartment"/>
<input type="hidden" name="cposition" id="cposition"/>
<input type="hidden" name="startDate" id="startDate"/>
<input type="hidden" name="endDate" id="endDate"/>
<input type="hidden" name="days" id="days"/>
<input type="hidden" name="handOver" id="handOver"/>
<input type="hidden" name="contact" id="contact"/>
<input type="hidden" name="event" id="event"/>
<input type="hidden" name="type" id="type"/>
<input type="hidden" name="orOpinion" id="orOpinion"/>
<input type="hidden" name="applyDate" id="applyDate"/>
<input type="hidden" name="tmp_user" id="tmp_user" value="${USER_TAKEN.ename}"/>
<table class="gom_tb" width="100%" border="0" cellspacing="0" cellpadding="0"></table>
</form>
</div><!-- end content_main -->
</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>