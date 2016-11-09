<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>欢迎新同事${register.ename}加入  --${company}</title>
<style type="text/css">
body{font:0.8em/150% Arial,sans-serif,simsung,Verdana,Tahoma,Helvetica;}
.gom_tb{width:600px;border-collapse:collapse;border-left:#C8B9AE solid 1px;border-top:#C8B9AE solid 1px;font-size:1em;text-align:left;}
.gom_tb td,.gom_tb th{border-right:#C8B9AE solid 1px;border-bottom:#C8B9AE solid 1px;padding:10px 10px 6px;}
.gom_tb tbody th{background-color:#D7D1CB;font-weight:normal;text-align:center;}
.gom_tb tbody b,.gom_tb caption{font-size:1.1em;}
.gom_tb tbody th{padding:10px 5px;font-size:1.2em;}
.gom_tb tbody td ul{list-style:none;position:relative;margin:0;margin:-10px 0 0;}
.gom_tb tbody td ul li{float:left;height:20;line-height:20px;margin-bottom:20px; padding:0 10px;border-right:1px #333 solid;}.gom_tb tbody td ul li.last{border:none;}
.gom_tb tfoot i{text-align:right;float:right;}
</style>
</head>
<body>
<table cellspacing="0" cellpadding="0" class="gom_tb" summary="欢迎新同事"><caption>欢迎新同事${register.ename}加入  --${company}</caption>
<thead><tr><th colspan="5">${register.cname}（${register.ename}）</th></tr></thead>
<tbody>
<tr><td colspan="5" scope="col"><ul><li>${register.gender.des}</li><li>${(register.birthday?date)?string("yyyy-MM-dd")}</li><li>${register.marriage.des}</li><li class="last">${register.nation}</li></ul></td>
</tr>
  <tr>
    <th width="15%">就职部门</th>
    <td width="30%">${register.cdepartment}</td>
    <td width="10%" rowspan="4">&nbsp;</td>
    <th width="15%">工作职务</th>
    <td width="30%" >${register.cposition}</td>
  </tr>
  <tr>
    <th>入职日期</th>
    <td>${(register.entryDate?date)?string("yyyy-MM-dd")}</td>
    <th>转正日期</th>
    <td>${(register.fullDate?date)?string("yyyy-MM-dd")}</td>
  </tr>
  <tr>
    <th>员工号</th>
    <td>${register.jobNo}</td>
    <th>分机号</th>
    <td>${register.telExt}</td>
  </tr>
  <tr>
    <th>E-mail</th>
    <td>${register.email}</td>
    <th>联系电话</th>
    <td>${register.cell}</td>
  </tr>
</tbody>
<tfoot><tr><td colspan="5" scope="col"><i>出单日期：${(register.exitDate?date)?string("yyyy-MM-dd")}<i></td></tr></tfoot>
</table>
</body>
</html>