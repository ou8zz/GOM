<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="../styles/global.css" media="screen" rel="stylesheet" type="text/css"/>
<link href="../styles/jquery-ui-1.8.20.css" rel="stylesheet" type="text/css" media="screen"  />
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"  />
<style type="text/css">
#edit_tb,#tree_tb{width:100%;border-collapse:collapse;border-left:#A6C9E2 solid 1px;border-top:#A6C9E2 solid 1px;text-align:left;}
#edit_tb td,#edit_tb th,#tree_tb td,#tree_tb th{border-right:#A6C9E2 solid 1px;border-bottom:#A6C9E2 solid 1px;padding:5px 2px 3px;}
#edit_tb select{width:100px;}
#edit_tb tbody input{width:80px;}
#tree_tb th, #edit_tb th{background-color:#b9c9fe;text-align:center;vertical-align:middle;font-weight:bold;}
#tree_tb td i, #edit_tb td i{float:left;}
.tr_con:hover{border:1px solid #a6c9e2;background-color:#d0e5f5;text-decoration:none;}
.tr_con td{border:1px solid #a6c9e2;}
.bluelab{color:blue; font-weight:bold;}
</style>
<%@include file="/common/common_import.html" %>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/maskedinput.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/json-2.3.min.js" type="text/javascript"></script>
<script src="../scripts/app/respon_config.js" type="text/javascript"></script>

<title><fmt:message key="respon.config.title" /> -SQE SERVICE GOM</title>
</head>

<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<table id="zgrid"></table>
<div id="zpager"></div>
<div id="content_main">
<input type="hidden" id="uid" name="uid" />
<table id="tree_tb" border="0" cellpadding="0" cellspacing="0" width="100%">
<thead><tr><td colspan="5"><b style="color:blue"><fmt:message key="respon.config.userResp" /></b></td></tr><th width="15%"><fmt:message key="respon.fcode" /></th><th width="25%"><fmt:message key="respon.name" /></th><th width="10%"><fmt:message key="respon.exp" /></th><th width="10%"><fmt:message key="respon.actual" /></th><th width="40%"><fmt:message key="respon.explain" /></th></thead>
<tbody></tbody></table>
<form id="responForm" name="responForm" method="post">
<table id="edit_tb" border="0" cellpadding="0" cellspacing="0" width="100%">
<thead><tr><td colspan="2"><label class="bluelab"><fmt:message key="respon.config.add" /></label><select id="resNoUser"></select></td><td colspan="2"><label class="bluelab"><fmt:message key="respon.config.userMainResp" /><input type="checkbox" id="ups"></input></label>&nbsp;&nbsp;<label class="bluelab"><fmt:message key="respon.config.userRespEdit" /></label><select id="resUser"></select></td></tr><th><fmt:message key="respon.fcode" /></th><th><fmt:message key="respon.name" /></th><th><fmt:message key="respon.exp" /></th><th><fmt:message key="respon.explain" /></th></thead><tbody></tbody><tfoot></tfoot>
</table>
<div class="submit_msg"><input type="button" id="userSubmit" value="<fmt:message key="respon.config.assign" />" tabindex="18"></div>
</form>
</div><!-- end content_main -->

</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>
