<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Good Morning -SQE SERVICE GOM</title>
<style type="text/css">
body{font:0.8em/100% Arial,sans-serif,simsung,Verdana,Tahoma,Helvetica;}
.gom_tb{border-collapse:collapse;border-left:#A6C9E2 solid 1px;border-top:#A6C9E2 solid 1px;text-align:left;width:750px;}
.gom_tb td,.gom_tb th{border-right:#A6C9E2 solid 1px;border-bottom:#A6C9E2 solid 1px;padding:3px 3px 2px;}
.gom_tb th{font-weight:bold;}
.gom_tb th,.gom_tb .tb_bg{background-color:#A6C9E2;text-align:center;vertical-align:middle;}
.gom_tb .tmp td{margin:0;padding:0;clear:both;}
.gom_tb caption{font-weight:bold;font-size:1.1em;}
.sht{width:20px;}
.bts{padding-top:30px;color:blue;}

/* 签名CSS */
.signiture h3,.signiture p{padding:0;margin:0;}
.signiture table b{color:#03F}
.signiture table{border-bottom:1px solid #000;}
.signiture p{margin-top:5px;}
</style>
</head>
<body>
<div><b>Dear All:</b></div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;Good Morning!</div>
<hr />
<#if doing?exists>
<br />
<b class="bts">今日需要做</b>
<table class="gom_tb">
<thead><tr><th class="sht">SWOT</th><th>任务标题</th><th>工作类型</th><th>预计工时</th><th>开始时间 </th><th>结束时间</th></tr></thead>
<tbody>
<#list doing as d>
	<tr><td style='background-color:green'></td><td>${d.taskTitle }</td><td>${d.taskType.des }</td><td>${d.expectedHours }</td><td>${(d.expectedStart?date)?string("yyyy-MM-dd HH:mm")}</td><td><#if d.expectedEnd?exists>${(d.expectedEnd?date)?string("yyyy-MM-dd HH:mm")}</#if></td></tr>
</#list>
</table>
</#if>

<hr />
<br />
<div><#if motto?exists>${motto}</#if></div>

<br />
<div><#if signature?exists>${signature}</#if></div>
</body>
</html>