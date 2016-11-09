<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<script src="../scripts/app/departure.js" type="text/javascript"></script>
<style type="text/css">
h5{text-align:center;padding:10px 0;}
table th, table td{border-collapse:collapse;border:1px solid #aabcfe;padding:3px;}
table td.head_bg{background-color:#bcf;}
table th{background-color:#bce;text-align:center;vertical-align:middle;font-weight:bold;}
table.trace thead th{background-color:#693;text-align:center;vertical-align:middle;font-weight:bold;color:#fff;}
table.trace{position:relative;text-align:left;}
table.trace span,table.trace img.arrow{display:block;float:left;}
table.trace img.arrow{padding-top:15px;}
.receipt{color:#F00;font-weight:bold;margin:20px;}
</style>
<title><fmt:message key="departure.page.title" /> -SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="grid_20 omega">
<div id="err"><c:if test="${not empty error}">${error}</c:if></div>
<c:choose>
<c:when test="${empty dep}">
<div class="receipt"><fmt:message key="departure.receipt.alert" /></div>
</c:when>
<c:otherwise>
<h5>${dep.userDpt}(${dep.ename}) -<fmt:message key="departure.apply" /></h5>
<table border="0" cellspacing="0" cellpadding="0" width="790">
  <tr>
    <th rowspan="2" scope="col"><fmt:message key="departure.applyUser" /></th>
    <td class="head_bg" scope="col"><fmt:message key="general.dpt" /></td>
    <td class="head_bg" scope="col"><fmt:message key="user.ename" /></td>
    <td class="head_bg" scope="col"><fmt:message key="user.cname" /></td>
    <td class="head_bg" scope="col"><fmt:message key="general.pst" /></td>
  </tr>
  <tr>
    <td>${dep.userDpt}</td>
    <td>${dep.ename}</td>
    <td>${dep.cname}</td>
    <td>${dep.userPst}</td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
     <th><fmt:message key="departure.onDate" /></th>
     <td class="head_bg"><fmt:message key="departure.enDate" /></td>
     <td>${dep.entryDate}</td>
     <td class="head_bg"><fmt:message key="departure.exitDate" /></td>
     <td>${dep.exitDate}</td>
   </tr>
   <tr>
    <td colspan="5">&nbsp;</td>
  </tr><tr>
    <th><fmt:message key="departure.reason" /></th>
    <td colspan="4" style="text-align:left;width:662px">${dep.reason}</td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
   <tr>
     <th><fmt:message key="departure.recipient" /></th>
     <td class="head_bg"><fmt:message key="general.dpt" /></td>
     <td>${dep.recipientDpt}</td>
     <td class="head_bg"><fmt:message key="user.ename" /></td>
     <td>${dep.recipient}</td>
   </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
     <th><fmt:message key="departure.salary" /></th>
     <td class="head_bg"><fmt:message key="departure.salaryDate" /></td>
     <td>${dep.salaryDate}</td>
     <td class="head_bg"><fmt:message key="departure.accountNo" /></td>
     <td>${dep.accountNo}</td>
   </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <th colspan="5"><fmt:message key="process.state" /></th>
  </tr>
  <tr>
    <td colspan="5">
    <table width="100%" class="trace"><thead><tr><th width="20%"><fmt:message key="process.process" /></th><th width="25%"><fmt:message key="process.deTime" /></th><th width="45%"><fmt:message key="process.opinion" /></th><th width="10%"><fmt:message key="general.attachment" /></th></tr></thead><tbody><c:forEach var="trace" items="${traces}">
    <tr><td>${trace.nodeName}(${trace.actor})</td><td><fmt:formatDate value="${trace.deliverTime}" type="both" pattern="yyyy-MM-dd HH:mm" /></td><td>${trace.opinion}</td><td><c:if test="${!empty trace.attachment}"><a href="download.htm?file=${trace.attachment}&name=${trace.actor}的离职交接文档"><fmt:message key="general.download" /></a></c:if></td></tr></c:forEach></tbody><tfoot><tr><td colspan="4"><span><img alt="Start" src="../images/trace/start.png"><h6><fmt:message key="process.taskStart" /></h6></span>
    <c:forEach var="trace" items="${traces}"><img src="../images/trace/${trace.arrow}" class="arrow"><span><img src="../images/trace/${trace.icon}"><h6>${trace.nodeName}(${trace.actor})</h6></span></c:forEach></td></tr></tfoot>
</table>
    </td>
  </tr>
</table>
</c:otherwise>
</c:choose>
</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>