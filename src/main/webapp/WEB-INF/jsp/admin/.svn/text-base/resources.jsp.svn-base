<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"  />
<script src="../scripts/common/swfobject.js" type="text/javascript"></script>
<script src="../scripts/common/uploadify-2.1.4.js" type="text/javascript"></script>
<script src="../scripts/common/grid.locale-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/menu.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/admin/resources.js" type="text/javascript"></script>
<style type="text/css">
#lf dd{width:320px;height:58px;float:left;}
#lf dd label.label{font-size:1.1em;line-height:26px;height:26px;width:320px;float:right;text-align:right;color:#0E5080;margin-bottom:5px;}
#lf dd input.inp,#lf dd select.inp{float:right;border:1px solid #628EB1;height:22px;line-height:22px;margin-left:5px;width:200px;font-size:1em;}

</style>

<title><fmt:message key="resources.title" />-SQE SERVICE GOM</title>
</head>
<body>
<%@include file="/common/admin_header.html" %>
<div id="content" class="alpha grid_20 omega">
<div id="g_mgr">
<table id="res_tb"></table>
<div id="res_pg"></div>
</div>
<div id="gConsole"><span style="color:red;"><fmt:message key="general.delete.msg" /></span></div>
<div id="content_main">
<form id="resForm" >
<input type="hidden" id="id" name="id" />
<input type="hidden" id="attachment" name="attachment" />
<dl id="lf">
   <dd><label class="label"><fmt:message key="resource.path" /><select id="path" name="path" class="inp required"></select></label></dd>
   <dd><label class="label"><fmt:message key="resource.filetype" /><select id="resourceType" name="resourceType" class="inp required"><option value="MANUAL"><fmt:message key="resource.manual" /></option><option value="MATERIAL"><fmt:message key="resource.material" /></option><option value="TECHNICAL"><fmt:message key="resource.technical" /></option><option value="HOW"><fmt:message key="resource.how" /></option><option value="EXPERIENCE"><fmt:message key="resource.experience" /></option><option value="VIDEO"><fmt:message key="resource.video" /></option></select></label></dd>
   <dd><label class="label"><fmt:message key="resource.number" /><input type="text" id="number" name="number" class="inp"/></label></dd>
   <dd><label class="label"><fmt:message key="resource.isValid" /><select id="isValid" name="isValid" class="inp required"><option value="true"><fmt:message key="resource.istrue" /></option><option value="false"><fmt:message key="resource.isfalse" /></option></select></label></dd>
   <dd id="dd_createDate"><label class="label"><fmt:message key="resource.createDate" /><input type="text" id="createDate" name="createDate" class="inp_readonly" onfocus="this.blur()"/></label></dd>
   <dd id="dd_updateDate"><label class="label"><fmt:message key="resource.updateDate" /><input type="text" id="updateDate" name="updateDate" class="inp_readonly" onfocus="this.blur()"/></label></dd>
   <dd id="dd_uploadDate"><label class="label"><fmt:message key="resource.uploadDate" /><input type="text" id="uploadDate" name="uploadDate" maxlength="20" class="inp" readonly="readonly"/></label></dd>
   <dd><label class="label"><fmt:message key="resource.varsion" /><input type="text" id="version" name="version" maxlength="20" class="inp"/></label></dd>
   <dd><label class="label"><fmt:message key="resource.filetitle" /><input type="text" id="title" name="title" maxlength="20" class="inp"/></label></dd>
   <dd><label class="label"><fmt:message key="general.explain" /><textarea rows="2" cols="28" id="des" name="des" class="inp area"></textarea></label></dd>
   <dd><label class="label"><fmt:message key="general.attachment" /><input type="file" id="att" name="att" maxlength="20" class="inp"/></label></dd>
 </dl>
</form> 
</div><!-- end content_main -->
</div><!-- end content -->
</div><!-- end main -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>