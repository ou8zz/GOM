<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>

<style type="text/css">
.minp{font:left; border:1px solid #628EB1;height:22px;line-height:22px;width:95px;font-size:1.1em;}
#task{position:relative;border-bottom:1px solid #36F;}
#task span{padding-left:10px;}
#task p{padding:0;float:right;}
#task p em{padding-left:20px;color:#F00;font-style:normal;}
#describe,#staff{position:relative;}
#describe label{float:left;width:80px;}
#describe p{width:474px;float:left;}
#staff label{float:left;width:150px;}
#t_foot{position:relative;text-align:left;padding:5px;margin-top:10px;}
#t_foot span,#t_foot img.arrow{display:block;float:left;}
#t_foot img.arrow{padding-top:15px;}
</style>

<script src="../scripts/common/jquery.blockUI.js" type="text/javascript"></script>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/utils.js" type="text/javascript"></script>
<script src="../scripts/app/my_abnormal.js" type="text/javascript"></script>

<title><fmt:message key="abnormal.title" /> -SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<div id="g_mgr">
<table id="zgrid"></table>
<div id="zpager"></div>
</div>

<div id="show_process">
<!-- 弹出窗口显示工作任务信息 -->
<div id="task"></div>
<div id="describe"></div>
<div id="staff" style="clear:both"></div>
	
<!-- 流程走向详细列表 -->
<table class="gom_tb trace_tab" width="100%">
<thead><tr><th width="20%"><fmt:message key="process.process" /></th><th width="25%"><fmt:message key="process.deTime" /></th><th width="45%"><fmt:message key="process.opinion" /></th><th width="10%"><fmt:message key="general.attachment" /></th></tr></thead>
<tbody id="t_body"></tbody>
<!-- 异常流程图走向 -->
<tfoot><tr><td id="t_foot" colspan="4"></td></tr></tfoot>
</table>
</div>

<div id="content_main">
<input type="hidden" id="id" name="id" />
<input type="hidden" id="traceId" name="traceId" />
<!-- <input type="hidden" id="nodeName" name="nodeName" /> -->
<!-- <input type="hidden" id="nodeCode" name="nodeCode" /> -->
<input type="hidden" id="type" name="type" />
<input type="hidden" id="reporter" name="reporter" />

<dl id="lf">
<div id="abnormal_title"></div>
<div id="dd_indirect">
<dd><label class="lab"><fmt:message key="abnormal.indirect" /></label><select id="in_dpt" class="minp"></select><select id="indirect" name="indirect" class="minp"></select></dd>
<dd><textarea id="des" name="des" cols="38" rows="3"></textarea></dd>
</div>
</dl>

</div> <!-- end content_main -->
</div> <!-- end content -->
</div> <!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div> <!-- end container_24 -->
</body>
</html>