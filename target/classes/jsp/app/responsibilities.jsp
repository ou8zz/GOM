<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<title>新职员职责分配 - SQE SERVICE GOM</title>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen" />
<link rel="stylesheet" href="../common/nyroModal/styles/nyroModal.css" type="text/css" media="screen" />
<%@include file="/common/common_import.html" %>
<script src="../scripts/common/grid.js" type="text/javascript"></script>
<script src="../scripts/common/jquery.blockUI.js" type="text/javascript"></script>
<script src="../common/nyroModal/js/jquery.nyroModal.custom.min.js" type="text/javascript"></script>
<!--[if IE 6]><script type="text/javascript" src="../common/nyroModal/js/jquery.nyroModal-ie6.min.js"></script><![endif]-->
<script src="../scripts/app/responsibilities.js" type="text/javascript"></script>
<style type="text/css">
.gom_tb,.resp{width:600px;border-collapse:collapse;border-left:#A6C9E2 solid 1px;border-top:#A6C9E2 solid 1px;font-size:1em;text-align:left;}
.gom_tb td,.gom_tb th,.resp td,.resp th{border-right:#A6C9E2 solid 1px;border-bottom:#A6C9E2 solid 1px;padding:10px 10px 6px;}
.gom_tb tbody th,.resp thead th{background-color:#C5DBEC;font-weight:normal;text-align:center;}
.gom_tb tbody b{font-size:1.1em;}
.gom_tb thead th{padding:10px 5px;font-size:1.2em;font-weight:bold;}
.gom_tb tbody td ul{list-style:none;position:relative;margin:0;margin:-10px 0 0;}
.gom_tb tbody td ul li{float:left;height:20;line-height:20px;margin:0 0 20px;padding:0 10px;border-right:1px #333 solid;}.gom_tb tbody td ul li.last{border:none;}
table.resp caption{font-weight:bold;font-size:1.1em;}
table.resp td.primary,table.resp td.first{text-align:left;position:relative;background-color:#9cf}
table.resp input.inps,table.resp select.inps{width:75%}
table.resp input.inpw,table.resp select.inpw{width:90%}
table.resp input.inph{width:100%}
table.resp td.first i{float:left;margin:0;padding:0;}
table.resp td.primary i{float:left;margin:-4px 0 0 -10px;padding:0;}
table.resp td.secondary,table.resp td.second{text-align:right;position:relative;}
table.resp td.second i,table.resp td.second span{float:right;margin:0;padding:0;}
table.resp td.secondary i{margin:-25px 0 0 4px;padding:0;float:left;}
table.resp td.secondary span{float:right;margin:0;padding:0;}
</style>
</head>
<body>
<div class="container_24">
<%@include file="/common/app_header.html" %>
<div id="content" class="grid_20 omega">
<table id="zgrid"></table>
<div id="zpager"></div>

<div id="content_main">
<form:form id="entryForm" modelAttribute="entrant" method="post" action="">
<form:hidden path="id" />
<form:hidden path="traceId" />
<form:hidden path="nodeCode" />
<form:hidden path="nodeOrder" />
<form:hidden path="portrait" />
<form:hidden path="ename" />
<input type="hidden" id="approval" name="approval" value="APPROVAL">
<table cellspacing="0" cellpadding="0" class="gom_tb" summary="新员工职责分配"></table>
</form:form>
<form id="responsibilityForm" method="post">
<table width="100%" class="resp"><caption>分配新职员职责</caption>
<thead><tr><th width="20%">FunCode</th><th width="22%">责任名称</th><th width="18%">预设比重(%)</th><th width="40%">责任说明</th></tr></thead>
<tbody><tr id="inputInfo"><td class="primary "><span><select id="responId" name="responId" class="inps" tabindex="1"></select></span><i class="ui-icon treeclick ui-icon-triangle-1-s"></i><input type="hidden" id="node" name="node" value="0.0"/></td><td id="name"></td><td><input id="expected" name="expected" class="inps father" tabindex="2"/></td><td id="explanation"></td></tr>
<tr><td class="secondary"><span><select id="node0" name="node" class="inps" tabindex="3"></select></span><i class="ui-icon ui-icon-radio-off"></i></td><td><select id="responId0" name="responId" class="inpw" tabindex="4"></select></td><td><input id="expected0" name="expected" class="inps son" tabindex="5"/></td><td id="explanation0"></td></tr>
<tr><td class="secondary"><span><select id="node1" name="node" class="inps" tabindex="6"></select></span><i class="ui-icon ui-icon-radio-off"></i></td><td><select id="responId1" name="responId" class="inpw" tabindex="7"></select></td><td><input id="expected1" name="expected" class="inps son" tabindex="8"/></td><td id="explanation1"></td></tr>
<tr><td class="secondary"><span><select id="node2" name="node" class="inps" tabindex="9"></select></span><i class="ui-icon ui-icon-radio-off"></i></td><td><select id="responId2" name="responId" class="inpw" tabindex="10"></select></td><td><input id="expected2" name="expected" class="inps son" tabindex="11"/></td><td id="explanation2"></td></tr>
<tr><td class="secondary"><span><select id="node3" name="node" class="inps" tabindex="12"></select></span><i class="ui-icon ui-icon-radio-off"></i></td><td><select id="responId3" name="responId" class="inpw" tabindex="13"></select></td><td><input id="expected3" name="expected" class="inps son" tabindex="14"/></td><td id="explanation3"></td></tr>
<tr><td class="secondary"><span><select id="node4" name="node" class="inps" tabindex="15"></select></span><i class="ui-icon ui-icon-radio-off"></i></td><td><select id="responId4" name="responId" class="inpw" tabindex="16"></td><td><input id="expected4" name="expected" class="inps son" tabindex="17"/></td><td id="explanation4"></td></tr>
<tfoot><tr><td colspan="4"><span class="error_msg"></span></td></tr></tfoot>
</tbody></table>
<div class="submit_msg"><input type="button" name="userSubmit" id="userSubmit" value="增加" tabindex="18"></div>
</form>
</div><!-- end content_main -->

</div><!-- end content -->
</div><!-- end grid_24 -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>