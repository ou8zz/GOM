<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="../styles/global.css" media="screen" rel="stylesheet" type="text/css"/>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"  />
<style type="text/css">
#lf dd{width:320px;height:58px;float:left;}
#lf dd label.label{font-size:1.1em;line-height:26px;height:26px;width:320px;float:right;text-align:right;color:#0E5080;margin-bottom:5px;}
#lf dd input.inp,#lf dd select.inp{float:right;border:1px solid #628EB1;height:22px;line-height:22px;margin-left:5px;width:200px;font-size:1em;}

#tree_tab th, #tree_tab td{color:#333;border-collapse:collapse;border:1px solid #aabcfe; padding:3px;}
#tree_tab th{background-color:#b9c9fe;text-align:center;vertical-align:middle;font-weight:bold;}
#tree_tab td.bg{background-color:#e8edff;text-align:center;}
#tree_tab td.trg{text-align:right;vertical-align:middle;background-color:#e8edff;}
#tree_tab td.nob_t_b{border-top:none;border-bottom:none;text-align:center;}
#tree_tab td.nob_l_r{border-left:none;border-right:none;}
#tree_tab td.nobo{border:none;text-align:center;}
#tree_tab td i{float:left;}
.tr_con:hover{border:1px solid #a6c9e2;background-color:#d0e5f5;text-decoration:none;}
.tr_con td{border:1px solid #a6c9e2;}
</style>

<title>左菜单通用配置  - SQE SERVICE GOM</title>
<%@include file="/common/common_import.html" %>

<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/admin/basic_tree.js" type="text/javascript"></script>
</head>
<body>
<%@include file="/common/admin_header.html" %>
<div id="content" class="grid_20 omega">
<table id="ztree_tb"></table>
<div id="ztree_pg"></div>

<div id="content_main">
	<input type="hidden" id="uid" name="uid" />
	<input type="hidden" id="zid" name="zid" />
	<table id="tree_tab" border="0" cellpadding="0" cellspacing="0" width="100%">
	    <thead><th width="5%"><input type='checkbox' id='allc' name='allc' value='allc' /></th><th width="15%">目录名</th><th width="25%">显示标题</th><th width="30%">路径</th><th width="15%">图标</th></thead>
		<tbody id="tree_body"></tbody>
	</table>
</div>

</div><!-- end content -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>
