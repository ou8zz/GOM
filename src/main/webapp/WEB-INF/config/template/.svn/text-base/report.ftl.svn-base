<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${user.ename } - 日报 -SQE SERVICE GOM</title>
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
#umsg #lmsg{position:relative;border-bottom:1px solid #36F;}
#umsg span #lmsg span{padding-left:10px;}
.limited{width:300px; white-space:nowrap; text-overflow:ellipsis; -o-text-overflow:ellipsis; overflow: hidden;}
.gom_tb .login_time{word-break:break-all;}
/* 签名CSS */
.signiture h3,.signiture p{padding:0;margin:0;}
.signiture table b{color:#03F}
.signiture table{border-bottom:1px solid #000;}
.signiture p{margin-top:5px;}
</style>
</head>
<body>

<div id="umsg"><span><b>工号</b> ${user.jobNo }</span> &nbsp; <span><b>用户名</b> ${user.ename } &nbsp;(${user.cname }) </span> &nbsp; <span><b>所属部门</b>  ${user.cdepartment }</span> </div>
<#if login?exists>
<div id="lmsg"><span><b>上班时间</b> ${(login.loginTime?date)?string("HH:mm") }</span> &nbsp; <span><b>下班时间 </b><#if login.loginOut?exists>${(login.loginOut?date)?string("HH:mm")}</#if></span> &nbsp; <span> <b>入职日期</b> ${user.entryDate } </span></div>
<#else>
登录数据不存在
</#if>

<#if daily?exists>
<table class="gom_tb">
<!-- 头部 -->
<thead>
<tr><th>SWOT</th>
<#assign sIndex=1/>
<#list daily as s>
    <#if sIndex <= 14><th>${s.day}</th></#if>
    <#assign sIndex=sIndex+1/>
</#list>
</tr>
</thead>
<!-- 主要内容 -->
<tbody>
<#assign sIndex=1/>
<#list daily as s>
    <#if sIndex%14 == 1><tr class='tr_con'><td>${s.title }</td></#if>
    <td style="background-color:${s.swot }">${s.data }</td>
    <#if sIndex%14 == 0></tr></#if>
    <#assign sIndex=sIndex+1/>
</#list>
</tbody>
</table>
</#if>

<#if weekly?exists> 
<br />
<b class="bts">周趋势</b>
<table class="gom_tb">
<thead><tr><th>SWOT</th>
<#assign sIndex=1/>
<#list weekly as w>
    <#if sIndex <= 12><th>${w.day }</th></#if>
    <#assign sIndex=sIndex+1/>
</#list>
</tr>
</thead>
<tbody>
<#assign sIndex=1/>
<#list weekly as s>
    <#if sIndex%12 == 1><tr class='tr_con'><td>${s.title }</td></#if>
    <td style="background-color:${s.swot }">${s.data }</td>
    <#if sIndex%12 == 0></tr></#if>
    <#assign sIndex=sIndex+1/>
</#list>
</tbody>
</table>
</#if>

<#if monthly?exists> 
<br />
<b class="bts">月趋势</b>
<table class="gom_tb">
<thead><tr><th>SWOT</th>
<#assign sIndex=1/>
<#list monthly as m>
    <#if sIndex <= 12><th>${m.day }</th></#if>
    <#assign sIndex=sIndex+1/>
</#list>
</tr>
</thead>
<tbody>
<#assign sIndex=1/>
<#list monthly as m>
    <#if sIndex%12 == 1><tr class='tr_con'><td>${m.title }</td></#if>
    <td style="background-color:${m.swot }">${m.data }</td>
    <#if sIndex%12 == 0></tr></#if>
    <#assign sIndex=sIndex+1/>
</#list>
</tbody>
</table>
</#if>

<#if quarterly?exists> 
<br />
<b class="bts">季趋势</b>
<table class="gom_tb">
<thead><tr><th>SWOT</th>
<#assign sIndex=1/>
<#list quarterly as q>
    <#if sIndex <= 12><th>${q.day }</th></#if>
    <#assign sIndex=sIndex+1/>
</#list>
</tr>
</thead>
<tbody>
<#assign sIndex=1/>
<#list quarterly as q>
    <#if sIndex%12 == 1><tr class='tr_con'><td>${q.title }</td></#if>
    <td style="background-color:${q.swot }">${q.data }</td>
    <#if sIndex%12 == 0></tr></#if>
    <#assign sIndex=sIndex+1/>
</#list>
</tbody>
</table>
</#if>

<#if yearly?exists> 
<br />
<b class="bts">年趋势</b>
<table class="gom_tb">
<thead><tr><th>SWOT</th>
<#assign sIndex=1/>
<#list yearly as y>
    <#if sIndex <= 12><th>${y.day }</th></#if>
    <#assign sIndex=sIndex+1/>
</#list>
</tr>
</thead>
<tbody>
<#assign sIndex=1/>
<#list yearly as y>
    <#if sIndex%12 == 1><tr class='tr_con'><td>${y.title }</td></#if>
    <td style="background-color:${y.swot }">${y.data }</td>
    <#if sIndex%12 == 0></tr></#if>
    <#assign sIndex=sIndex+1/>
</#list>
</tbody>
</table>
</#if>

<#if devote?exists>
<br />
<b class="bts">对公司的贡献</b>
<table class="gom_tb">
<thead><tr><th class="sht">SWOT</th><th>任务标题</th><th>工作类型</th><th>预计工时</th><th>实际工时</th><th>完成比例(%)</th><th>开始时间 </th><th>结束时间</th></tr></thead>
<tbody>
<#assign sIndex=0/>
<#list devote as d>
    <tr><td style='background-color:${d.swot }'></td><td>${d.taskTitle }</td><td>${d.taskType.des }</td><td>${d.expectedHours }</td><td><#if d.actualHours?exists>${d.actualHours }</#if></td><td><#if d.completedRate?exists>${d.completedRate }</#if></td><td><#if d.actualStart?exists>${(d.actualStart?date)?string("yyyy-MM-dd HH:mm") }</#if></td><td><#if d.actualEnd?exists>${(d.actualEnd?date)?string("yyyy-MM-dd HH:mm")}</#if></td></tr>
	<#assign sIndex=sIndex+1/>
</#list>
</tbody>
<tfoot><tr><td>统计</td><td colspan="7">${sIndex}</td></tr></tfoot>
</table>
</#if>

<#if weekDevote?exists>
<br />
<b class="bts">一周贡献记录</b>
<table class="gom_tb">
<thead><tr><th class="sht">SWOT</th><th>任务标题</th><th>工作类型</th><th>预计工时</th><th>实际工时</th><th>完成比例(%)</th><th>开始时间 </th><th>结束时间</th></tr></thead>
<tbody>
<#assign sIndex=0/>
<#list weekDevote as d>
    <tr><td style='background-color:${d.swot }'></td><td>${d.taskTitle }</td><td>${d.taskType.des }</td><td>${d.expectedHours }</td><td><#if d.actualHours?exists>${d.actualHours }</#if></td><td><#if d.completedRate?exists>${d.completedRate }</#if></td><td><#if d.actualStart?exists>${(d.actualStart?date)?string("yyyy-MM-dd HH:mm")}</#if></td><td><#if d.actualEnd?exists>${(d.actualEnd?date)?string("yyyy-MM-dd HH:mm") }</#if></td></tr>
	<#assign sIndex=sIndex+1/>
</#list>
</tbody>
<tfoot><tr><td>统计</td><td colspan="7">${sIndex}</td></tr></tfoot>
</table>
</#if>

<#if resp?exists>
<br />
<b class="bts">管理责任</b>
<table class="gom_tb">
<thead><tr><th>功能代码</th><th>主旨</th><th>比重(%)</th><th>说明</th></tr></thead>
<tbody>
<#list resp as r>
    <tr><td>${r.funcode }</td><td>${r.name }</td><td><#if r.expected?exists>${r.expected }</#if></td><td class="limited">${r.explanation }</td></tr>
</#list>
</tbody>
</table>
</#if>

<#if tasks?exists>
<br />
<b class="bts">工作指令</b>
<table class="gom_tb">
<thead><tr><th>任务标题</th><th>工作类型</th><th>预计工时</th><th>实际工时</th><th>完成比例(%)</th><th>开始时间 </th><th>结束时间</th></tr></thead>
<tbody>
<#list tasks as d>
    <tr><td>${d.taskTitle }</td><td>${d.taskType.des }</td><td>${d.expectedHours }</td><td><#if d.actualHours?exists>${d.actualHours }</#if></td><td><#if d.completedRate?exists>${d.completedRate }</#if></td><td>${(d.expectedStart?date)?string("yyyy-MM-dd HH:mm") }</td><td><#if d.expectedEnd?exists>${(d.expectedEnd?date)?string("yyyy-MM-dd HH:mm")}</#if></td></tr>
</#list>
</tbody>
</table>
</#if>

<#if doing?exists>
<br />
<b class="bts">需要做</b>
<table class="gom_tb">
<thead><tr><th>任务标题</th><th>工作类型</th><th>预计工时</th><th>完成比例(%)</th><th>开始时间 </th><th>结束时间</th></tr></thead>
<tbody>
<#list doing as d>
	<tr><td>${d.taskTitle }</td><td>${d.taskType.des }</td><td>${d.expectedHours }</td><td><#if d.completedRate?exists>${d.completedRate }</#if></td><td>${(d.expectedStart?date)?string("yyyy-MM-dd HH:mm")}</td><td><#if d.expectedEnd?exists>${(d.expectedEnd?date)?string("yyyy-MM-dd HH:mm")}</#if></td></tr>
</#list>
</table>
</#if>

<#if hows?exists>
<br />
<b class="bts">如何做</b>
<table class="gom_tb">
<thead><tr><th>标题</th><th>标准编号</th><th>文件日期</th><th>说明</th></tr></thead>
<tbody>
<#list hows as h>
	<tr><td>${h.title }</td><td>${h.number }</td><td>${(h.createDate?date)?string("yyyy-MM-dd") }</td><td class="limited"><#if h.gain?exists>${h.gain }</#if></td></tr>
</#list>
</tbody>
</table>
</#if>

<#if borrows?exists>
<br />
<b class="bts">资产管理</b>
<table class="gom_tb">
<thead><tr><th class="sht">SWOT</th><th>用户</th><th>主旨</th><th>领取日期</th><th>归还日期</th><th>说明</th></tr></thead>
<tbody>
<#list borrows as b>
	<tr><td style='background-color:${b.swot }'></td><td>${b.receiver }</td><td>${b.assetName }</td><td>${(b.receiveDate?date)?string("yyyy-MM-dd") }</td><td><#if b.returnDate?exists>${(b.returnDate?date)?string("yyyy-MM-dd") }</#if></td><td class="limited"><#if b.remark?exists>${b.remark }</#if></td></tr>
</#list>
</tbody>
</table>
</#if>

<#if logins?exists>
<br />
<b class="bts">使用时间</b>
<table class="gom_tb">
<thead><tr><th>日期</th><th>登入时间明细</th><th>登出时间</th></tr></thead>
<tbody>
<#list logins as l>
	<tr><td>${(l.loginTime?date)?string("yyyy-MM-dd HH:mm") }</td><td class="login_time">${l.loginTake}</td><td><#if l.loginOut?exists>${(l.loginOut?date)?string("yyyy-MM-dd HH:mm")}</#if></td></tr>
</#list>
</tbody>
</table>
</#if>

<br />
<div><#if signature?exists>${signature}</#if></div>
</body>
</html>