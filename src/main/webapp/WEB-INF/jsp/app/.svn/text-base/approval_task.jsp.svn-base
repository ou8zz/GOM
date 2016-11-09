<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>

<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="../styles/task.css" rel="stylesheet" type="text/css" media="screen" />

<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/uploadify-2.1.4.js" type="text/javascript"></script>
<script src="../scripts/common/md5.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/utils.js" type="text/javascript"></script>
<script src="../scripts/app/approval_task.js" type="text/javascript"></script>

<title><fmt:message key="task.approval.page.title" />  -SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<div id="g_mgr">
<table id="task_tb"></table>
<div id="task_pg"></div>
</div>
<div id="content_main">
<input type="hidden" id="id" name="id">
<input type="hidden" id="traceId" name="traceId">
<input type="hidden" id="nodeCode" name="nodeCode"/>
<input type="hidden" id="attachment" name="attachment">

<!-- 弹出窗口显示工作任务信息 -->
<div id="task"></div>
<div id="describe"></div>
<div id="staff" style="clear:both"></div>
<div id="date"></div>
	
<!-- 流程走向详细列表 -->
<table class="trace_tab" width="100%">
<thead><tr><th width="20%"><fmt:message key="process.process" /></th><th width="25%"><fmt:message key="process.deTime" /></th><th width="45%"><fmt:message key="process.opinion" /></th><th width="10%"><fmt:message key="general.attachment" /></th></tr></thead>
<tbody id="t_body"></tbody>
<!-- 工作流程图走向 -->
<tfoot><tr><td id="t_foot" colspan="4"></td></tr></tfoot>
</table>

<!-- 是否同意选择 -->
<dl id="lf">
   <dd class="tonggou"><h6><fmt:message key="process.tonggou" /></h6>
   	 <label><fmt:message key="process.revoke" /><input name="state" type="radio" value="REVOKE" tabindex="1"/></label>
   	 <label><fmt:message key="process.approval" /><input name="state" type="radio" value="APPROVAL" tabindex="2"/></label>
   	 <span class="error" id="error_state"></span>
   </dd>
   <dd><label class="lab"><fmt:message key="general.attachment" /></label><input id="attachments" name="attachments" type="file" class="inp"/></dd>
   <dd><label class="lab"><fmt:message key="general.note" /></label><textarea id="opinion" name="opinion" class="area"></textarea></dd>
</dl>

</div><!-- End content_main -->
</div><!-- End content -->
</div><!-- End grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- End container_24 -->
</body>
</html>