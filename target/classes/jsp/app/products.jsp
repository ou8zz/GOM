<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>

<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>

<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/app/product.js" type="text/javascript"></script>
<style type="text/css">
dl dd{width:320px;float:left;margin-right:5px;}
dl dd.textarea{width:650px;}
dl dd label{width:115px;text-align:right;color:#0E5080;}
dl dd input,dl dd select{border:1px solid #628EB1;margin-left:5px;width:200px;}
dl dd input.inp{width:90px;}
dl dd select.minp{width:90px;margin-right:5px}
dl dd label.error{color:red;display:block;padding:0;margin:0;text-align:left;width:300px;}
dl dd.error_msg{height:16px;}
</style>

<title><fmt:message key="product.page.title" /> - SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<table id="product_tb"></table>
<div id="product_pg"></div>
<div id="gConsole"><span style="color:red;"><fmt:message key="general.delete.msg" /></span></div>
<div id="content_main">
<form id="productForm" name="productForm">
<input type="hidden" id="id" name="id" />
<dl>
   <dd><label><fmt:message key="product.name" /></label><input id="productName" name="productName" maxlength="20" tabindex="1"/></dd>
   <dd><label><fmt:message key="product.type" /></label><select id="productType" name="productType" tabindex="2"><option value=""><fmt:message key="general.select" /></option><option value="SOFTWARE"><fmt:message key="product.soft" /></option><option value="CONSULTING"><fmt:message key="product.consulting" /></option><option value="TRAINNING"><fmt:message key="product.trainning" /></option></select></dd>
   <dd><label><fmt:message key="product.num" /></label><input id="num" name="num" maxlength="20" tabindex="4"/></dd>
   <dd><label><fmt:message key="product.unit" /></label><select id="unit" name="unit" tabindex="5"><option value=""><fmt:message key="general.select" /></option><option><fmt:message key="product.tao" /></option><option><fmt:message key="product.gei" /></option><option><fmt:message key="product.jian" /></option><option><fmt:message key="product.tai" /></option><option><fmt:message key="product.ba" /></option><option><fmt:message key="product.ci" /></option><option><fmt:message key="product.other" /></option></select></dd>
   <dd><label><fmt:message key="product.output" /></label><input id="outputDate" name="outputDate" maxlength="20" tabindex="6" readonly="readonly"/></dd>
   <dd><label><fmt:message key="project.version" /></label><input id="version" name="version" maxlength="20" tabindex="3"/></dd>
   <dd class="textarea"><label><fmt:message key="general.explain" /></label><textarea id="explains" name="explains" tabindex="7" rows="3" cols="60"></textarea></dd>
   <dd><span class="error_msg"></span></dd>
 </dl>
</form> 
</div><!-- end content_main -->
</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>
