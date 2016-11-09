<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<title><fmt:message key="leave.receipts.title" /> - SQE SERVICE GOM</title>
<%@include file="/common/common_import.html" %>
<link href="../styles/app.css" media="screen" rel="stylesheet" type="text/css"/>
<script src="../common/date/WdatePicker.js" type="text/javascript"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/common/jquery.blockUI.js" type="text/javascript"></script>
<script src="../scripts/app/get_receipt.js" type="text/javascript"></script>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="grid_20 omega">
<form:form id="leaveForm" modelAttribute="leave" method="post">
<form:hidden path="id" />
<form:hidden path="applyDate" />
<form:hidden path="comment" />
<fieldset>
<legend><fmt:message key="leave.receipts.legend" /></legend>
<c:choose>
<c:when test="${empty traces}">
<div class="receipt"><fmt:message key="leave.receipts.receipt.msg" /></div>
</c:when>
<c:otherwise>
 <div class="receipt grid_19">
   <div><img src="../images/leave/start.jpg" alt="start" align="middle"/><span><fmt:message key="leaves.taskStart" /></span></div>
   <c:forEach var="trace" items="${traces}">
      <img class="arrow" src="../images/leave/${trace.arrow}"/>
      <div class="opinion"><div><img src="../images/leave/${trace.icon}"/><span>${trace.node}</span></div>
      <table summary="${trace.node}"><thead><tr><th><fmt:message key="leaves.ename" /></th><th><fmt:message key="leaves.opinion" /></th><th><fmt:message key="leaves.subDate" /></th></tr></thead>
      <tbody><tr><td>${trace.actor}</td><td>${trace.opinion}</td><td><fmt:formatDate value="${trace.deliverTime}" type="both" pattern="yyyy-MM-dd HH:mm" /></td></tr></tbody>
      </table></div>
   </c:forEach>
 </div>
</c:otherwise>
</c:choose>
<c:if test="${!empty gs}">
 <h4 style="color:#F00;text-align:center"><fmt:message key="leave.receipts.alert" /></h4>
 <div style="border:1px solid #F00;">
 <dl id="lf">
   <dd>
     <label class="label"><fmt:message key="leaves.type" /><form:select path="type" cssClass="inp" tabindex="1">
       <form:option value="" label="<fmt:message key="leaves.type.null" />"/>
       <form:option value="CASUAL" label="<fmt:message key="leaves.type.casual" />"/>
       <form:option value="SICK" label="<fmt:message key="leaves.type.sick" />"/>
       <form:option value="LEAVE_IN_LIEU" label="<fmt:message key="leaves.type.leaveinlieu" />"/>
       <form:option value="MARRIAGE" label="<fmt:message key="leaves.type.marriage" />"/>
       <form:option value="ANNUAL" label="<fmt:message key="leaves.type.annual" />"/>
       <form:option value="MATERNITY" label="<fmt:message key="leaves.type.maternity" />"/>
       <form:option value="BEREAVEMENT" label="<fmt:message key="leaves.type.bereavement" />"/>
     </form:select>
     </label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="leaves.event" /><form:input path="event" cssClass="inp" tabindex="2" maxlength="150"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="leaves.startDate" /><form:input path="startDate" cssClass="inp Wdate" tabindex="3"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="leaves.endDate" /><form:input path="endDate" cssClass="inp Wdate" tabindex="4"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="leaves.days" /><form:input path="days" cssClass="inp" tabindex="5" maxlength="2"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="leaves.contact" /><form:input path="contact" cssClass="inp" tabindex="6" maxlength="30"/></label>
   </dd>
   <c:if test="${USER_TAKEN.position!='Manager' && USER_TAKEN.position!='Assistant'}">
   <dd>
     <label class="label"><fmt:message key="leaves.agent.dpt" /><form:select path="agentDepart" cssClass="inp" tabindex="7">
       <form:option value="" label="<fmt:message key="leaves.type.null" />"/>
       <form:options items="${gs}" itemValue="ename" itemLabel="cname" />
       </form:select>
      </label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="leaves.agent.name" /><form:select path="agent" cssClass="inp" tabindex="8">
     <form:option value="" label="<fmt:message key="leave.receipts.title" />"/>
     <c:if test="${!empty leave.agent}">
       <form:option value="${leave.agent}" label="${leave.agent}" cssClass="choice"/>
     </c:if>
     </form:select>
    </label>
   </dd>
   </c:if>
   <dd>
     <label class="area_label"><fmt:message key="leaves.handOver" /><form:textarea path="handOver" cssClass="area" rows="4" cols="30" /></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="leaves.des" /><form:input path="opinion" cssClass="inp" tabindex="10" maxlength="300"/></label>
   </dd>
 </dl> 
<div id="lfsub">
  <label class="lab_button"><input type="submit" value="<fmt:message key="leave.receipts.again.sub" />" id="leavesubmit" tabindex="9" class="button"/></label>
</div>
</div>
</c:if>
</fieldset>
</form:form>
</div>
</div>
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>