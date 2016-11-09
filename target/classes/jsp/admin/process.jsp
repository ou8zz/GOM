<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link rel="stylesheet" type="text/css" media="screen" href="../styles/ui.jqgrid.css" />
<style type="text/css">
#header{height:100px;background-color:#8F9E28}
#header h2{text-indent:-9999px;}
#footer{text-align:center;margin:20px 0;}
#footer li{display:inline;}
#choiceProcess{font-size:1em;margin:10px 0;}
#choiceProcess button{margin-left:15px;}
#choiceProcess select,.prop select{margin-left:5px;width:150px;height:20px;line-height:20px;}
#gf dd{width:400px;height:38px;line-height:38px;position:relative;}
#gf dd label{width:80px;float:left;text-align:right;display:block;color:#0E5080;height:20px;line-height:20px;margin-right:5px;}
#gf dd label.lab{width:40px;float:left;}
#gf dd input.inps{border:1px solid #628EB1;margin:2px;width:250px;height:20px;line-height:20px;}
#gf dd.selt{position:relative;height:68px;line-height:29px;}
#gf dd.selt div, .selt label{float:left;}
#gf dd.selt select{width:90px;}
.executor,.posting{margin-left:5px;}
.executors{margin-left:85px;}
.tbiao{clear:both;margin:10px;}
.trace{position:relative;}
.trace .nav_img{float:left;margin:0 5px;}
.trace .nav_img h6{text-align:right}
.trace img.arrow{padding:0 10px;}
</style>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/uploadify-2.1.4.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/admin/process.js" type="text/javascript"></script>

<title>流程管理 -SQE SERVICE GOM</title>
</head>
<body>
<%@include file="/common/admin_header.html" %>
<div id="content" class="grid_20 omega">

<div id="choiceProcess">流程选择<select id="process" name="process" tabindex="1"><option value="DEPARTURE">离职流程</option><option value="ENTRY">入职流程</option><option value="LEAVE">请假流程</option><option value="TASK">工作安排</option><option value="ABNORMAL">异常流程</option></select><button>预览流程</button></div>
<table id="zgrid"></table>
<div id="zpager"></div>

<form:form id="processForm" method="post" modelAttribute="process">
<div id="content_main">
<form:hidden path="icon" />
<form:hidden path="id" />
<form:hidden path="nodeOrder" />
 <dl id="gf">
   <dd><label>节点代码</label><form:input path="nodeCode" tabindex="2" maxlength="45"/></dd>
   <dd><label>节点名称</label><input id="node_name" name="node_name" tabindex="3" maxlength="20" /></dd>
   <dd class="prop"><label>执行者类型</label><form:select path="assignType" tabindex="4"><option value="">-请选择-</option><option value="PERSON">个人</option><option value="PEOPLE">多人</option><option value="POSITION">职务</option><option value="DYNAMIC">动态</option><option value="PARAMETER">参数</option></form:select></dd>
   <dd class="selt"><label>执行者</label><div>所属部门<form:select path="dptOper"><option value="">-请选择-</option><form:options items="${dpts}" itemValue="id" itemLabel="cname"/></form:select></div>
    <div class="executor">执行人<select id="actor" name="actor" tabindex="5"><option value="">-请选择-</option></select></div>
    <div class="posting">执行者职务<form:select path="excPst" tabindex="6"><form:options items="${ptns}" itemValue="ename" itemLabel="cname"/></form:select></div>
    <div class="executors">执行人<input id="exexutors" name="exexutors" class="inps" /></div>
   </dd>
   <dd class="parameter"><label>参数</label><input id="template" name="template"/></dd>
   <dd><label>节点图标</label><input type="file" name="file_img" id="file_img" tabindex="6" class="inp"/></dd>
   <div class="tbiao"><img alt="图标" width="48" height="48" border="0"/></div>
 </dl>
</div><!-- end content_main -->
</form:form>

<div id="process_preview"><div class="trace"></div></div>

</div><!-- end content -->
</div><!-- end main -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>