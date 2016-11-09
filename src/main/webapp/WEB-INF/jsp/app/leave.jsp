<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<title><fmt:message key="leave.receipt.title"></fmt:message> - SQE SERVICE GOM</title>
<%@include file="/common/common_import.html" %>
<script type="text/javascript">
$(function(){$.fn.zTree.init($("#menu"), setting);});
</script>
<style type="text/css">
table th, table td{border-collapse:collapse;border:1px solid #A6C9E2;padding:3px;text-align:center;}
table .tb_bg{background-color:#A6C9E2;}
table th{background-color:#A6C9E2;text-align:center;vertical-align:middle;font-weight:bold;}
table.trace th{background-color:#ACE;text-align:center;vertical-align:middle;font-weight:bold;}
table.trace{position:relative;text-align:left;}
table.trace span,table.trace img.arrow{display:block;float:left;}
table.trace img.arrow{padding-top:15px;}
table caption{font-weight:bold;font-size:1.1em;margin:0 auto;text-align:center;margin:10px 0;}
.receipt{color:#F00;font-weight:bold;margin:20px;}
</style>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="grid_20 omega">
<form:form id="leaveForm" modelAttribute="leave" method="post">
<c:choose>
<c:when test="${empty traces}">
<div class="receipt"><fmt:message key="leave.receipt.error.msg" /></div>
</c:when>
<c:otherwise>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
<caption><fmt:message key="leave.receipt.page" /></caption>
  <tr class="tb_bg">
    <th rowspan="2" scope="col" width="15%"><fmt:message key="leaves.applicant" /></th>
    <td scope="col" width="25%"><fmt:message key="leaves.dpt" /></td>
    <td scope="col" width="25%"><fmt:message key="leaves.ename" /></td>
    <td scope="col" width="13%"><fmt:message key="leaves.jobNo" /></td>
    <td scope="col" width="22%"><fmt:message key="leaves.pst" /></td>
  </tr>
  <tr>
    <td>${leave.cdepartment}</td>
    <td>${leave.ename}(${leave.cname})</td>
    <td>${leave.jobNo}</td>
    <td>${leave.cposition}</td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr class="tb_bg">
    <th rowspan="2"><fmt:message key="leaves.leaveTime" /></th>
    <td><fmt:message key="leaves.startDate" /></td>
    <td><fmt:message key="leaves.endDate" /></td>
    <td><fmt:message key="leaves.days" /></td>
    <td><fmt:message key="leaves.subDate" /></td>
  </tr>
  <tr>
     <td>${leave.startDate}</td>
     <td>${leave.endDate}</td>
     <td>${leave.days}</td>
     <td>${leave.applyDate}</td>
   </tr>
   <tr>
    <td colspan="5">&nbsp;</td>
  </tr
  ><tr>
    <th><fmt:message key="leaves.event" /></th>
    <td colspan="2" style="text-align:left">${leave.event}</td>
    <td class="tb_bg"><fmt:message key="leaves.contact" /></td>
    <td>${leave.contact}</td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
   <tr class="tb_bg">
     <th rowspan="2"><fmt:message key="leaves.agent" /></th>
     <td><fmt:message key="leaves.dpt" /></td>
     <td><fmt:message key="leaves.ename" /></td>
     <td><fmt:message key="leaves.jobNo" /></td>
     <td><fmt:message key="leaves.pst" /></td>
   </tr>
   <tr>
     <td>${leave.agentDpt}</td>
     <td>${leave.agent}(${leave.agentCname})</td>
     <td>${leave.agentJobNo}</td>
     <td>${leave.agentPst}</td>
   </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
     <th><fmt:message key="leaves.handOver" /></th>
     <td colspan="4" style="text-align:left">${leave.handOver}</td>
     </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <th colspan="5"><fmt:message key="leaves.state" /></th>
  </tr>
  <tr>
    <td colspan="5">
    <table width="100%" class="trace"><thead><tr><th width="20%"><fmt:message key="leaves.process" /></th><th width="25%"><fmt:message key="leaves.deTime" /></th><th width="45%"><fmt:message key="leaves.opinion" /></th><th width="10%"><fmt:message key="leaves.att" /></th></tr></thead><tbody><c:forEach var="trace" items="${traces}">
    <tr><td>${trace.nodeName}(${trace.actor})</td><td><fmt:formatDate value="${trace.deliverTime}" type="both" pattern="yyyy-MM-dd HH:mm" /></td><td >${trace.opinion}</td><td><c:if test="${!empty trace.attachment}"><a href="download.htm?file=${trace.attachment}&name=${trace.actor}的交接文档"><fmt:message key="leaves.download" /></a></c:if></td></tr></c:forEach></tbody><tfoot><tr><td colspan="4"><span><img alt="Start" src="../images/trace/start.png"><h6><fmt:message key="leaves.taskStart" /></h6></span>
    <c:forEach var="trace" items="${traces}"><img src="../images/trace/${trace.arrow}" class="arrow"><span><img src="../images/trace/${trace.icon}"><h6>${trace.nodeName}(${trace.actor})</h6></span></c:forEach></td></tr></tfoot>
</table>
    </td>
  </tr>
</table>
</c:otherwise>
</c:choose>
</form:form>
</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>