<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>职员请假单 -${company}</title>
<style type="text/css">
body{font:0.8em/150% Arial,sans-serif,simsung,Verdana,Tahoma,Helvetica;}
.gom_tb{border-collapse:collapse;border-left:#A6C9E2 solid 1px;border-top:#A6C9E2 solid 1px;text-align:left;width:700px;}
.gom_tb td,.gom_tb th{border-right:#A6C9E2 solid 1px;border-bottom:#A6C9E2 solid 1px;padding:10px 10px 6px;}
.gom_tb th{font-weight:bold;}
.gom_tb th,.gom_tb .tb_bg{background-color:#A6C9E2;text-align:center;vertical-align:middle;}
.gom_tb .tmp td{margin:0;padding:0;clear:both;}
.gom_tb caption{font-weight:bold;font-size:1.1em;}
</style>
</head>
<body>
<br/>
<table class="gom_tb" border="0" align="center" cellpadding="0" cellspacing="0" summary="职员请假单">
<caption>${company} - 职员请假单</caption>
  <tr class="tb_bg">
    <th rowspan="2" width="20%">请假人</th>
    <td width="20%">部门</td>
    <td width="20%">姓名</td>
    <td width="15%">工号</td>
    <td width="25%">职务</td>
  </tr>
  <tr>
    <td>${leave.cdepartment}</td>
    <td>${leave.ename}（${leave.cname}）</td>
    <td>${leave.jobNo}</td>
    <td>${leave.cposition}</td>
  </tr>
   <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr class="tb_bg">
    <th rowspan="2">时&nbsp;间</th>
    <td>开始时间</td>
    <td>结束时间</td>
    <td>申请天数</td>
    <td>假期联系方式</td>
  </tr>
  <tr>
    <td>${(leave.startDate?date)?string("yyyy-MM-dd")}</td>
    <td>${(leave.endDate?date)?string("yyyy-MM-dd")}</td>
    <td>${leave.days}</td>
    <td>${leave.contact}</td>
  </tr>
   <tr>
     <td colspan="5">&nbsp;</td>
   </tr>
   <tr>
    <th>类别</th>
    <td>${leave.type.des}</td>
    <td class="tb_bg">事由</td>
    <td colspan="2">${leave.event}</td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <th>事务交待</th>
    <td colspan="4">${leave.handOver}</td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr class="tb_bg">
    <th rowspan="2">工作代理人</th>
    <td>部门</td>
    <td>姓名</td>
    <td>工号</td>
    <td>职务</td>
  </tr>
  <tr>
    <td>${leave.agentDpt}</td>
    <td>${leave.agent}（${leave.agentCname}）</td>
    <td>${leave.agentJobNo}</td>
    <td>${leave.agentPst}</td>
  </tr>
  <tr>
    <td colspan="5" align="right">出单日期：${(leave.applyDate?date)?string("yyyy-MM-dd")}</td>
  </tr>
</table>
</body>
</html>