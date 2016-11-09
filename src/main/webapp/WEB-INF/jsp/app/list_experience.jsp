<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<link href="../styles/global.css" media="screen" rel="stylesheet" type="text/css"/>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="../styles/experience.css" media="screen" rel="stylesheet" type="text/css"/>

<%@include file="/common/common_import.html" %>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/app/experience.js" type="text/javascript"></script>
<title><fmt:message key="experience.title" />-SQE SERVICE GOM</title>

</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
  <table id="ldlg" width="100%" border="0" cellspacing="0" cellpadding="0">
  <c:forEach items="${list}" var="train">
  <tbody>
    <tr>
      <td class="tbt bg" scope="col" width="20%"><fmt:message key="experience.tprogram" /></td>
      <td class="tbt bg" scope="col" width="20%"><fmt:message key="experience.lecturer" /></td>
      <td width="60%" rowspan="7" class="tbt bg" scope="col" style="border-bottom-color:#FFFFFF">
		<c:if test="${not empty train.gain}">
			<input type="hidden" id="isEmpty" value="${train.id }" />
			 <div>&nbsp;&nbsp;&nbsp;&nbsp;
			 	<span id="gainMsg${train.id}">${train.gain }</span>
			 	<div class="editdiv"><input type="button" class="editbutton" value="<fmt:message key="general.edit" />" onclick="editExper('${train.id}','${train.experienceId}')" /></div>
			 </div>
		</c:if>
		<c:if test="${empty train.gain}">
			<a href="#none" onclick="addExper(${train.id });"><fmt:message key="experience.chickadd" /></a>		
		</c:if>
	 </td>
    </tr>
    <tr>
      <td><span><a href="#none" onclick="showTraining('${train.tprogram}','${train.lecturer}','${train.startDate}','${train.endDate}','${train.trainingType.des}','${train.trainingTime}','${train.fee}','${train.otherFee}','${train.qualification}','${train.tcontent}')">${train.tprogram }</a></span></td>
      <td>${train.lecturer }</td>
    </tr>
    <tr>
      <td class="tbt bg" scope="col"><fmt:message key="general.startDate" /></td>
      <td class="tbt bg" scope="col"><fmt:message key="general.endDate" /></td>
    </tr>
    <tr>
      <td>${train.startDate }</td>
      <td> ${train.endDate }</td>
    </tr>
    <tr>
      <td class="tbt bg" scope="col"><fmt:message key="experience.trainingType" /></td>
      <td class="tbt bg" scope="col"><fmt:message key="experience.trainingTime" /></td>
    </tr>
    <tr>
      <td>${train.trainingType.des }</td>
      <td>${train.trainingTime }</td>
    </tr>
    <tr>
      <td class="nobo">&nbsp;&nbsp;&nbsp;</td>
      <td class="nobo">&nbsp;&nbsp;&nbsp;</td>
    </tr>
    </tbody>
   </c:forEach>
   <tfoot>
	   <tr>
	      <td colspan="3">
	      	<input type="button" id="download" class="down" value="<fmt:message key="general.download" />" /> ${page }
		  </td>
	   </tr>
   </tfoot>
</table>

<div id="training-form">
	<dl id="train">
	   <dd> <label class="label"><fmt:message key="experience.tprogram" /></label><span id="tprogram"></span> </dd>
	   <dd> <label class="label"><fmt:message key="experience.lecturer" /></label><span id="lecturer"></span> </dd>
	   <dd> <label class="label"><fmt:message key="general.startDate" /></label><span id="startDate"></span> </dd>
	   <dd> <label class="label"><fmt:message key="general.endDate" /></label><span id="endDate"></span> </dd>
	   <dd> <label class="label"><fmt:message key="experience.trainingType" /></label><span id="trainingType"></span> </dd>
	   <dd> <label class="label"><fmt:message key="experience.trainingTime" /></label><span id="trainingTime"></span> </dd>
	   <dd> <label class="label"><fmt:message key="experience.fee" /></label><span id="fee"></span> </dd>
	   <dd> <label class="label"><fmt:message key="experience.otherFee" /></label><span id="otherFee"></span> </dd>
	   <dd> <label class="label"><fmt:message key="experience.qualification" /></label><span id="qualification"></span> </dd>
	   <dd> <label class="label"><fmt:message key="experience.tcontent" /></label><span id="tcontent"></span> </dd>
   </dl>
</div>

<div id="exper-form">
	<input type="hidden" id="trainId" name="trainId"/>
	<input type="hidden" id="experId" name="experId"/>
	<textarea class="area" id="gain" name="gain" ></textarea>
</div>  

<div id="download-form">
	<form action="down_gain.htm" id="gainForm" method="post">
		<dl id="downTag">
		    <dd> <label class="label"><fmt:message key="general.startDate" /><input type="text" id="sDate" name="sDate" class="inp"/> </label></dd>
			<dd> <label class="label"><fmt:message key="general.endDate" /><input type="text" id="eDate" name="eDate" class="inp"/> </label></dd>
		</dl>	
	</form>
</div>  

</div><!-- end content -->
</div><!-- end grid 24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>