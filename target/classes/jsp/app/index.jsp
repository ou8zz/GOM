<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link href="../styles/calendar.css" rel="stylesheet" type="text/css" media="screen"/>
<script src="../scripts/common/flowplayer-3.2.12.min.js" type="text/javascript"></script>
<script src="../scripts/common/utils.js" type="text/javascript"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../common/date/WdatePicker.js" type="text/javascript" language="javascript"></script>
<script src="../scripts/common/ztree.core-3.0.js" type="text/javascript"></script>
<script src="../scripts/app_index.js" type="text/javascript"></script>
<style type="text/css">
/*页面*/
#lf dd {width:320px; height:68px; float:left;}
#lf dd label.lab{font-size:1.1em;line-height:26px;height:26px;color:#0E5080;margin-left:30px;}
#lf dd input.inp, #lf dd select.inp{border:1px solid #628EB1;height:22px;line-height:22px;margin-left:5px;width:200px;font-size:1.1em;margin-top:10px;}
#lf dd input.minp,#lf dd select.minp{font:left; border:1px solid #628EB1;height:22px;line-height:22px;width:95px;font-size:1.1em;}

#t_tab tfoot tr td{text-align:right;}
.tbl{border:1px solid #6666FF;width:310px;margin-left:7px;}
.head_tr{background-color:#ADB9D1;font-weight:bold;}
legend{color:#1F4998;}
.a{color:#333399;}
.tab{width:100%;}
.tab th, .tab td{color:#333;border-collapse:collapse;border:1px solid #aabcfe; padding:3px;}
.tab th{background-color:#F4F4F4;text-align:center;vertical-align:middle;font-weight:bold;}
.tr_con:hover{border:1px solid #a6c9e2;background-color:#d0e5f5;text-decoration:none;}

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

#cont{position:relative;border-bottom:1px solid #36F;}
#cont span{padding-left:10px;}
#cont p{padding:0;float:right;}
#cont p em{padding-left:20px;color:orange;font-style:normal;}
#describe,#staff{position:relative;}
#describe label{float:left;width:80px;}
#describe p{width:474px;float:left;}
#staff label{float:left;width:150px;}

/* 播放器css */
#player{display:block;width:520px;height:330px}

/* .tbh{width:100%;border:#A9C8CE 1px solid; background:#F4F4F4;} */
.cal_sty{width:100%;height:auto;border:#A9C8CE 1px solid;position:relative;}
/* #t_meeting{border:#A9C8CE 1px solid;border-top-width:0px;position:absolute;left:350px;top:10px;} */
#t_task{width:99%;position:relative; top:10px; margin-left: 1px; margin-bottom: 22px;}

#index_calendar{width:100%;}

</style>
<title><fmt:message key="index.title" /> - SQE SERVICE GOM</title>
</head>
<body onload="initial()">
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="grid_20 omega">
<div id="content_main">
<div id="cont"></div>
<div id="describe"></div>
<div id="staff" style="clear:both"></div>
<div id="parti"></div>
<div id="explain"></div>
</div>

<!-- 视频播放弹出窗口 -->
<div id="play_video">
<a id="player" href=""></a>
</div>

<form id="downForm" method="post" action="../download.htm"><input type="hidden" id="fileName" name="fileName" /></form>

<!-- 
<div id="google_task">
<form id="googleForm" method="post"> 
<div>标题<input id="title" name="title" size="40"/></div><br/>
<div><input id="startTime" name="startTime" class="Wdate" />
到<input id="endTime" name="endTime" class="Wdate" /></div><br/>
<div>说明<textarea id="content" name="content" cols="40" rows="3"></textarea></div>
</form>
</div>

<div id="google_login">
<div>Email:<input id="email" name="email"/></div>
<div>Password:<input type="password" id="pwd" name="pwd"/></div>
</div> -->

<div id="tabsJ">
<h2><fmt:message key="index.title" /></h2>
  <ul>
  	<li><a href="javascript:dispose('index');" title="<fmt:message key="index.index" />"><span><fmt:message key="index.index" /></span></a></li>
    <li><a href="javascript:dispose('leave');" title="<fmt:message key="index.leave" />"><span><fmt:message key="index.leave" /></span></a></li>
    <li><a href="javascript:dispose('entry');" title="<fmt:message key="index.entry" />"><span><fmt:message key="index.entry" /></span></a></li>
    <li><a href="javascript:dispose('departure');" title="<fmt:message key="index.departure" />"><span><fmt:message key="index.departure" /></span></a></li>
  	<li><a href="javascript:dispose('video');" title="<fmt:message key="index.video" />"><span><fmt:message key="index.video" /></span></a></li>
  </ul>
</div>
<table id="index_calendar">
<tr><td>
<!--万年历 内容 开始-->
<div id="gom_calendar" class="CAL_wid">
<div class="CAL_wid_LT"></div>
<div class="CAL_wid_LR"></div>
<div class="CAL_wid_top"></div>
<div class="CAL_LN"><div class="CAL_Az"></div><a href="javascript:void(0)" class="CAL_A1" onclick="pushBtm('YU')" title="上一年">上一年</a><a href="javascript:void(0)" class="CAL_A2" title="上一月" onclick="pushBtm('MU')">上一月</a><a href="javascript:void(0)" title="今日" class="CAL_A3" onclick="pushBtm('')"></a><a href="javascript:void(0)" class="CAL_A4" title="下一月" onclick="pushBtm('MD')">下一月</a><a href="javascript:void(0)" class="CAL_A5" title="下一年" onclick="pushBtm('YD')">下一年</a></div>
<!--日历内容区 开始-->
<div class="CAL_div">
<!--嵌入万年历代码 开始-->
<div id="detail" style="position: absolute; visibility: hidden; left: 377px; top: 161px;">
<table border="0" cellpadding="2" cellspacing="0" width="130"><tbody><tr><td>
<table bgcolor="#DCEDF5" border="0" cellpadding="0" cellspacing="0" width="100%">
<tbody><tr><td align="right"><font style="font-size:12px;" color="#000000">2013 年 3 月 2 日<br>星期六<br><font color="02346F">农历 1 月 21 日</font><br><font color="02346F">癸巳年 甲寅月 丁卯日</font></font></td></tr>
</tbody></table>
</td></tr>
</tbody>
</table>
</div>
<form name="CLD" id="CLD">
<table align="center" border="0" cellpadding="0" cellspacing="0">
<tbody>
<tr bgcolor="#F2F4F4">
<td colspan="7"> &nbsp;<strong>当前查看：</strong><span class="sm"><font color="#333399" style="font-SIZE: 12px;">公历 </font>
<font style="font-SIZE: 9pt" color="#ffffff">
<select onchange="changeCld()" name="SY" id="SY"> 
	<option>1900</option><option>1901</option><option>1902</option>
	<option>1903</option><option>1904</option><option>1905</option>
	<option>1906</option><option>1907</option><option>1908</option>
	<option>1909</option><option>1910</option><option>1911</option>
	<option>1912</option><option>1913</option><option>1914</option>
	<option>1915</option><option>1916</option><option>1917</option>
	<option>1918</option><option>1919</option><option>1920</option>
	<option>1921</option><option>1922</option><option>1923</option>
	<option>1924</option><option>1925</option><option>1926</option>
	<option>1927</option><option>1928</option><option>1929</option>
	<option>1930</option><option>1931</option><option>1932</option>
	<option>1933</option><option>1934</option><option>1935</option>
	<option>1936</option><option>1937</option><option>1938</option>
	<option>1939</option><option>1940</option><option>1941</option>
	<option>1942</option><option>1943</option><option>1944</option>
	<option>1945</option><option>1946</option><option>1947</option>
	<option>1948</option><option>1949</option><option>1950</option>
	<option>1951</option><option>1952</option><option>1953</option>
	<option>1954</option><option>1955</option><option>1956</option>
	<option>1957</option><option>1958</option><option>1959</option>
	<option>1960</option><option>1961</option><option>1962</option>
	<option>1963</option><option>1964</option><option>1965</option>
	<option>1966</option><option>1967</option><option>1968</option>
	<option>1969</option><option>1970</option><option>1971</option>
	<option>1972</option><option>1973</option><option>1974</option>
	<option>1975</option><option>1976</option><option>1977</option>
	<option>1978</option><option>1979</option><option>1980</option>
	<option>1981</option><option>1982</option><option>1983</option>
	<option>1984</option><option>1985</option><option>1986</option>
	<option>1987</option><option>1988</option><option>1989</option>
	<option>1990</option><option>1991</option><option>1992</option>
	<option>1993</option><option>1994</option><option>1995</option>
	<option>1996</option><option>1997</option><option>1998</option>
	<option>1999</option><option>2000</option><option>2001</option>
	<option>2002</option><option>2003</option><option>2004</option>
	<option>2005</option><option>2006</option><option>2007</option>
	<option selected="">2008</option>
	<option>2009</option><option>2010</option><option>2011</option>
	<option>2012</option><option>2013</option><option>2014</option>
	<option>2015</option><option>2016</option><option>2017</option>
	<option>2018</option><option>2019</option><option>2020</option>
	<option>2021</option><option>2022</option><option>2023</option>
	<option>2024</option><option>2025</option><option>2026</option>
	<option>2027</option><option>2028</option><option>2029</option>
	<option>2030</option><option>2031</option><option>2032</option>
	<option>2033</option><option>2034</option><option>2035</option>
	<option>2036</option><option>2037</option><option>2038</option>
	<option>2039</option><option>2040</option><option>2041</option>
	<option>2042</option><option>2043</option><option>2044</option>
	<option>2045</option><option>2046</option><option>2047</option>
	<option>2048</option><option>2049</option>
</select> 
</font>
<font color="#333399" style="font-SIZE: 12px;">年 </font>
<font style="font-size: 9pt" color="#ffffff">
<select onchange="changeCld()" name="SM" id="SM"><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option><option>10</option><option>11</option><option>12</option></select> 
 </font></span><font style="font-SIZE: 9pt" color="#ffffff"></font><span class="sm"><font color="#333399" style="font-SIZE: 12px;">月</font><br><b><font class="sm" id="GZ" style="font-SIZE: 12px; color:blue">&nbsp;&nbsp;农历癸巳年 &nbsp;<span class="smlb">&nbsp;【<span class="smlb">蛇</span><span class="smlb">】</span></span></font></b><font color="#333399"> </font></span></td></tr>
</tbody>
<tbody><tr class="sundayr" align="center"><td class="weekend_ms" width="57">日</td><td width="57">一</td><td width="57">二</td><td width="57">三 </td><td width="57">四</td><td width="57">五</td><td class="weekend_ms" width="57">六</td></tr></tbody>
<tbody id="caid"></tbody>
</table>  
<!--嵌入万年历代码 结束-->				
</form>
</div>	
</div>
<!--日历内容区 结束-->
</td><td>
<!-- 会议 -->
<table id="t_meeting" class="" style="margin-left: 10px;">
	<tbody id="t_body"></tbody>
</table>
</td></tr>
<tr><td colspan="2">
<!-- 今日需要做 -->
<table id="t_task" class="tab">
    <thead id="t_thead"></thead>
	<tbody id="t_body"></tbody>
	<tfoot id="t_foot"></tfoot>
</table>
</td></tr>
</table>

<!-- 全局table -->
<table id="t_tab" class="tab">
    <thead id="t_thead"></thead>
	<tbody id="t_body"></tbody>
	<tfoot id="t_foot"></tfoot>
</table>

<!-- 异常 -->
<div id="isAbnormal">
<form id="abnormalForm" name="abnormalForm" method="post" action="">
<!-- <input type="hidden" id="id" name="id"/> -->
<dl id="lf">
 <dd><label class="lab"><fmt:message key="abnormal.type" /></label><select id="type" name="type" class="inp"><option value="SERVER"><fmt:message key="abnormal.type.server" /></option><option value="POWER"><fmt:message key="abnormal.type.power" /></option><option value="TASK"><fmt:message key="abnormal.type.task" /></option></select></dd>
 <dd><label class="lab"><fmt:message key="abnormal.reporter" /></label><select id="rep_dpt" class="minp"></select><select id="reporter" name="reporter" class="minp"></select></dd> 
<%--  <dd><label class="lab"><fmt:message key="abnormal.indirect" /></label><select id="in_dpt" class="minp"></select><select id="indirect" class="minp"></select></dd> --%>
 <dd><label class="lab"><fmt:message key="general.explain" /></label><textarea id="des" name="des" cols="32" rows="3"></textarea></dd>
</dl>
</form>
</div>

</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>


