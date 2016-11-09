<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>

<style type="text/css">

.tr_con:hover{border:1px solid #a6c9e2;background-color:#d0e5f5;text-decoration:none;}
.tr_con td{border:1px solid #a6c9e2;}

table.tb{clear:both;margin:15px 0;padding:0;border:0;width:100%;}
.tb{border-collapse:collapse;border-left:#A6C9E2 solid 1px;border-top:#A6C9E2 solid 1px;text-align:left;width:750px;}
.tb td,.tb th{border-right:#A6C9E2 solid 1px;border-bottom:#A6C9E2 solid 1px;padding:3px 3px 2px;}
.tb th{font-weight:bold;}
.tb th,.tb .tb_bg{background-color:#A6C9E2;text-align:center;vertical-align:middle;}
.tb .tmp td{margin:0;padding:0;clear:both;}
.tb caption{font-weight:bold;font-size:1.1em;}
.sht{width:20px;}
.bts{color:blue;}


/* 分页 */
.pagination{text-align:right;float:right;padding-bottom:5px;}
.pagination a, .pagination a:link, .pagination a:visited{padding:2px 5px;margin:2px;border:1px solid #999;background-color:#ccc;text-decoration:none;color:#693;}
.pagination a:hover, .pagination a:active{border:1px solid #690;color:#fff;background-color:#693;text-decoration:none;}
.pagination span.current{padding:2px 5px;margin:2px -2px 2px 2px;border:1px solid #690;font-weight:bold;background-color:#693;color:#fff;}
.pagination span.disabled{padding:2px 5px;margin:2px;border:1px solid #eee;background-color:#fff;color:#ddd;}
.pagination b{padding:0 2px;color:#f00}

/*- Menu Tabs J--------------------------- */
#tabsJ {float:left;width:100%;background:#F4F4F4;font-size:93%;line-height:normal;border-bottom:1px solid #24618E;}
#tabsJ ul {margin:0;padding:10px 10px 0 50px;list-style:none;}
#tabsJ li {display:inline;margin:0;padding:0;}
#tabsJ a {float:left;background:url("../images/tableftj.gif") no-repeat left top;margin:0;padding:0 0 0 5px;text-decoration:none;}
#tabsJ a span {float:left;display:block;background:url("../images/tabrightj.gif") no-repeat right top;padding:5px 15px 4px 6px;color:#24618E;}
/* Commented Backslash Hack hides rule from IE5-Mac \*/
#tabsJ a span {float:none;}
/* End IE5-Mac hack */
#tabsJ a:hover span {color:#FFF;}
#tabsJ a:hover {background-position:0% -42px;}
#tabsJ a:hover span {background-position:100% -42px;}

.tolong_300{width:300px;white-space:nowrap;text-overflow:ellipsis; -o-text-overflow:ellipsis; overflow: hidden;}
.tolong_100{width:100px;white-space:nowrap;text-overflow:ellipsis; -o-text-overflow:ellipsis; overflow: hidden;}
</style>
<script src="../scripts/common/utils.js" type="text/javascript"></script>
<script src="../scripts/app/summary.js" type="text/javascript"></script>

<title><fmt:message key="tj.title" /> -SQE SERVICE GOM</title>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="alpha grid_20 omega">
<div id="content_main">
	
<!-- 菜单列表 -->
<div id="tabsJ">
<h2 id="rctype"><fmt:message key="tj.title" /></h2>
  <ul>
  	<li><a href="javascript:dispose('attendance');" title="<fmt:message key="tj.attendance" />"><span><fmt:message key="tj.attendance" /></span></a></li>
  	<li><a href="javascript:dispose('plan');" title="<fmt:message key="tj.plan" />"><span><fmt:message key="tj.plan" /></span></a></li>
    <li><a href="javascript:dispose('doing');" title="<fmt:message key="rc.doing" />"><span><fmt:message key="rc.doing" /></span></a></li>
    <li><a href="javascript:dispose('daily');" title="<fmt:message key="rc.type.day" />"><span><fmt:message key="rc.type.day" /></span></a></li>
    <li><a href="javascript:dispose('weekly');" title="<fmt:message key="rc.type.week" />"><span><fmt:message key="rc.type.week" /></span></a></li>
    <li><a href="javascript:dispose('monthly');" title="<fmt:message key="rc.type.month" />"><span><fmt:message key="rc.type.month" /></span></a></li>
  	<li><a href="javascript:dispose('resp');" title="<fmt:message key="rc.repos" />"><span><fmt:message key="rc.repos" /></span></a></li>
 	<li><a href="javascript:dispose('login');" title="<fmt:message key="rc.login" />"><span><fmt:message key="rc.login" /></span></a></li>
  </ul>
</div>

<!-- 表格数据 -->
<table id="t_tab" class="tb">
    <thead id="t_thead"></thead>
	<tbody id="t_body"></tbody>
	<tfoot id="t_foot"></tfoot>
</table>

<!-- 人员选择 -->
<div id="user_main">
	<div id="dpt_dl"></div>
	<div id="user_dl"></div>
</div>

</div> <!-- end content_main -->
</div> <!-- end content -->
</div> <!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div> <!-- end container_24 -->
</body>
</html>