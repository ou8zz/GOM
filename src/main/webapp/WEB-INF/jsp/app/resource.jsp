<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<link href="../styles/global.css" media="screen" rel="stylesheet" type="text/css"/>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<style type="text/css">
#content_main dl{position:relative;text-align:left;}
#content_main dl dd{width:320px;height:58px;line-height:58px;float:left;margin-right:5px;position:relative;}
#content_main dl dd.textarea{width:650px;}
#content_main dl dd label{line-height:26px;height:26px;width:115px;text-align:right;color:#0E5080;}
#content_main dl dd input,#content_main dl dd select.inp{border:1px solid #628EB1;height:22px;line-height:22px;margin-left:5px;width:200px;}
dl dd select.inps{width:100px;}

#resDate{height:30px;}
#resDate label{idth:220px;color:blue; margin-right:50px;}
#resVersion label{width:220px;color:blue; margin-right:50px;}

/* 分页 */
.pagination{text-align:right;float:right;padding-bottom:5px;}
.pagination a, .pagination a:link, .pagination a:visited{padding:2px 5px;margin:2px;border:1px solid #999;background-color:#ccc;text-decoration:none;color:#693;}
.pagination a:hover, .pagination a:active{border:1px solid #690;color:#fff;background-color:#693;text-decoration:none;}
.pagination span.current{padding:2px 5px;margin:2px -2px 2px 2px;border:1px solid #690;font-weight:bold;background-color:#693;color:#fff;}
.pagination span.disabled{padding:2px 5px;margin:2px;border:1px solid #eee;background-color:#fff;color:#ddd;}
.pagination b{padding:0 2px;color:#f00}

.tr_con:hover{border:1px solid #a6c9e2;background-color:#d0e5f5;text-decoration:none;}
.tr_type{backgroud-repeat:repeat-x;}
.tr_type th{ border:1px solid #a6c9e2;}
.tr_con td{border:1px solid #a6c9e2;}

#downTag dd input.inp,#downTag dd select.inp{float:right;border:1px solid #628EB1;height:22px;line-height:22px;margin-left:5px;width:100px;font-size:1em;}
#downTag dd label.label{font-size:1.1em;line-height:26px;height:26px;width:190px;float:left;text-align:left;color:#0E5080;margin-bottom:5px;}
.file_rid a{padding:2px 9.5px;margin:2px;backgroud-repeat:repeat-x;text-decoration:none;}
.file_rid a:hover{backgroud-repeat:repeat-x;text-decoration:none;color:black;}
#file_bot{width:793px;margin-top:-23px; background-color:#d0e5f5; border:1px solid #a6c9e2; height:21px;}
#div_type{backgroud-repeat:repeat-x;}

/* 播放器css */
#player{display:block;width:520px;height:330px}
</style>

<title><fmt:message key="resource.title" />-SQE SERVICE GOM</title>
<%@include file="/common/common_import.html" %>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/flowplayer-3.2.12.min.js" type="text/javascript"></script>
<script src="../scripts/common/uploadify-2.1.4.js" type="text/javascript"></script>
<script src="../scripts/app/resource.js" type="text/javascript"></script>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">

<!-- 视频播放弹出窗口 -->
<div id="play_video">
<a id="player" href=""></a>
</div>

<div id="g_mgr" style="border:1px solid #a6c9e2; width:793px;height:476px;">
 <div id="div_type">
 <input type="hidden" id="ftype" value="${ftype }"/>
    <label><fmt:message key="resource.filetype" /></label><select onmousedown="" name="filetype" id="filetype">
    		<option value=""><fmt:message key="general.select" /></option>
			<option value="MANUAL"><fmt:message key="resource.manual" /></option>
     		<option value="MATERIAL"><fmt:message key="resource.material" /></option>
     		<option value="TECHNICAL"><fmt:message key="resource.technical" /></option>
			<option value="EXPERIENCE"><fmt:message key="resource.experience" /></option>
			<option value="HOW"><fmt:message key="resource.how" /></option>
			<option value="VIDEO"><fmt:message key="resource.video" /></option>
	  	</select>	
	&nbsp;&nbsp;<fmt:message key="resource.filename" /> <input type="text" id="filename" name="filename" value="${fname }"/> 
	<input type="button" id="search" class="" value="<fmt:message key="resource.search" />" />
	<input type="button" id="reset" class="" value="<fmt:message key="resource.reset" />" />
  </div>
<table width="794" border="0" class="rtable">
  <thead><tr class="tr_type"><th></th><th><fmt:message key="resource.number" /></th><th><fmt:message key="resource.filetype" /></th><th><fmt:message key="resource.varsion" /></th><th><fmt:message key="resource.filetitle" /></th><th><fmt:message key="resource.createDate" /></th><th><fmt:message key="resource.uploadDate" /></th><th><fmt:message key="resource.updateDate" /></th><th><fmt:message key="resource.uploadName" /></th><th><fmt:message key="general.dpt" /></th><th><fmt:message key="general.download" /></th></tr></thead>
  <c:forEach items="${list}" var="res">
  <input type="hidden" id="path${res.id}" value="${res.path }" />
  <input type="hidden" id="isValid${res.id}" value="${res.isValid}" />
  <input type="hidden" id="resourceType${res.id}" value="${res.resourceType}" />
  <input type="hidden" id="downloadDate${res.id}" value="${res.downloadDate}" />
  <input type="hidden" id="attachment${res.id}" value="${res.attachment}" />
  <input type="hidden" id="responsibility${res.id}" value="${res.responsibility}" />
  <input type="hidden" id="score${res.id}" value="${res.score}" />
  <input type="hidden" id="swot${res.id}" value="${res.swot}" />
  <input type="hidden" id="des${res.id}" value="${res.des}" />
  <tbody class="tr_con">
	  <tr class="tr_con" onclick="select(${res.id })">
	    <td><input id="checkbox${res.id }" name="radios" type="radio" value="${res.id }" /></td>
		<td id="number${res.id }">${res.number }</td>
		<td>${res.resourceType.des }</td>
	    <td id="version${res.id }">${res.version }</td>
	    <td><c:choose><c:when test="${res.resourceType == 'VIDEO' }"><a href="javascript:playVideo('${res.attachment }');"><span id="title${res.id }">${res.title }</span></a></c:when><c:otherwise><span id="title${res.id }">${res.title }</span></c:otherwise></c:choose></td>
	    <td id="createDate${res.id }">${res.createDate }</td>
	    <td id="uploadDate${res.id }">${res.uploadDate }</td>
	    <td id="updateDate${res.id }">${res.updateDate }</td>
	    <td id="uploadEname${res.id }">${res.uploadEname }</td>
		<td id="maintainDpt${res.id }">${res.maintainDpt }</td>
	    <td><c:choose><c:when test="${not empty res.attachment }"><a href="javascript:downDlg('${res.id }');"><fmt:message key="general.download" /></a></c:when><c:otherwise><span><fmt:message key="resource.nodownload" /></span></c:otherwise></c:choose></td>
	  </tr>
  </tbody>
  </c:forEach>
</table>
</div>

<div id="content_main">

<form id="downForm" method="post" action="../download.htm"><input type="hidden" id="fileName" name="fileName" /></form>

<div id="down_how"><a id="original" href=""></a><br/><a id="howtodo" href=""></a></div>
<div id="main">
<div id="resDate"><b><fmt:message key="resource.createDate" /></b><label id="createDate"></label> <b><fmt:message key="resource.uploadDate" /></b><label id="uploadDate"></label> <b><fmt:message key="resource.updateDate" /></b><label id="updateDate"></label> </div>
<div id="resVersion"><b><fmt:message key="resource.varsion" /></b><label id="vers"></label> <b><fmt:message key="resource.filetype" /></b><label id="resType"></label> <b><fmt:message key="resource.number" /></b><label id="num"></label> </div>

<form id="resForm" >
<input type="hidden" id="token" name="token" value="${token }" />
<input type="hidden" id="id" name="id" />
<input type="hidden" id="version" name="version" />
<input type="hidden" id="isValid" name="isValid" value="true"/>
<input type="hidden" id="attachment" name="attachment" />
<dl id="lf">
	<dd>
     <label class="label"><fmt:message key="resource.path" /><select id="path" name="path" class="inp required"></select></label>
   </dd>
   <dd id="dd_resourceType">
     <label class="label"><fmt:message key="resource.filetype" /><select id="resourceType" name="resourceType" class="inp required">
     		<option value=""><fmt:message key="general.select" /></option>
			<option value="MANUAL"><fmt:message key="resource.manual" /></option>
     		<option value="MATERIAL"><fmt:message key="resource.material" /></option>
     		<option value="TECHNICAL"><fmt:message key="resource.technical" /></option>
			<option value="EXPERIENCE"><fmt:message key="resource.experience" /></option>
			<option value="HOW"><fmt:message key="resource.how" /></option>
			<option value="VIDEO"><fmt:message key="resource.video" /></option></select></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="resource.filetitle" /><input type="text" id="title" name="title" class="inp"/></label>
   </dd>
   <dd id="number_dd">
     <label class="label"><fmt:message key="resource.number" /><input type="text" id="number" name="number" class="inp"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="respon.page.title" /></label><select id="respar" class="inps"></select><select id="responsibility" name="responsibility" class="inps"></select>
   </dd>
<!--    <dd id="swot_dd"> -->
<!--      <label class="label">SWOT：<input type="text" id="swot" name="swot" class="inp"/></label> -->
<!--    </dd> -->
   <dd>
     <label class="label"><fmt:message key="general.explain" /><textarea rows="2" cols="29" id="des" name="des" class="inp area"></textarea></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="general.attachment" /><input type="file" id="atta" name="atta" maxlength="20" class="inp"/></label>
   </dd>
 </dl>
</form> 
</div><!-- end main -->
</div><!-- end content_main -->
<div id="file_bot"><span class="file_rid"><a href="javascript:addDlg();"> <fmt:message key="general.add" /></a><a href="javascript:editDlg();"><fmt:message key="general.edit" /></a></span>${page }</div>

</div><!-- end content -->
</div><!-- end grid 24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>