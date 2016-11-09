<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="../styles/app.css" media="screen" rel="stylesheet" type="text/css"/>
<link href="../styles/jquery-ui-1.8.4.custom.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen" />
<script src="../scripts/common/jquery-1.5.1.js" type="text/javascript"></script>
<script src="../scripts/common/jquery-ui-1.8.20.js" type="text/javascript"></script>
<script src="../scripts/common/ztree.core-3.0.js" type="text/javascript"></script>
<script src="../scripts/common/jquery-ui-1.8.20.js" type="text/javascript"></script>
<script src="../scripts/common/grid.locale-cn.js" type="text/javascript"></script>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/menu.js" type="text/javascript"></script>
<script src="../scripts/common/jquery.blockUI.js" type="text/javascript"></script>
<script src="../scripts/app/get_leaves.js" type="text/javascript"></script>
<title>待处理请假单据 - SQE SERVICE GOM</title>
<meta name="description" content="Amazine,Balanced Trace Mineral,Greens&Reds" />
<meta name="keywords" content="Amazine Balanced Trace Mineral Greens&Reds" />
</head>
<body>
<div class="container_24">
<div id="header" class="grid_24"><h1>SQE SERVICE GOM</h1></div>
<div class="grid_24">
<div class="grid_4 alpha">
<ul id="menu" class="ztree"></ul>
</div>
<div id="content" class="alpha grid_20 omega">
<div id="l_mgr" class="clearfix">
<table id="zgrid"></table>
<div id="zpager"></div>
</div>
<div id="leave_detail">
<form id="leaveForm" method="post">
<table id="ldlg" width="560" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <th rowspan="2" scope="col" width="120">申请人</th>
    <td align="center" class="nob_l_r bg" scope="col" width="120">部门</td>
    <td align="center" class="tbt bg" scope="col" width="120">姓名</td>
    <td align="center" class="nob_l_r bg" scope="col" width="80">工号</td>
    <td align="center" class="tbt bg" scope="col" width="120">职务</td>
  </tr>
  <tr>
    <td class="nobo" id="cdepartment"></td>
    <td class="nob_t_b" id="ename"></td>
    <td class="nobo" id="jobNo"></td>
    <td class="nob_t_b" id="cposition"></td>
  </tr>
  <tr>
    <td colspan="5" class="left_right">&nbsp;</td>
  </tr>
  <tr>
    <th rowspan="2">时间</th>
    <td align="center" class="nobo bg">开始时间</td>
    <td align="center" class="nob_t_b bg">结束时间</td>
    <td align="center" class="nobo bg">总计天数</td>
    <td align="center" class="nob_t_b bg">假期联系方式</td>
  </tr>
  <tr>
    <td class="nob_l_r" id="startDate"></td>
    <td class="tbb" id="endDate"></td>
    <td class="nob_l_r" id="days"></td>
    <td class="tbb" id="contact"></td>
  </tr>
  <tr>
    <td colspan="5" class="nob_t_b">&nbsp;</td>
  </tr>
  <tr>
    <th rowspan="3">说明</th>
    <td align="right" class="nob_l_r trg">请假类别</td>
    <td colspan="3" class="all" id="type"></td>
  </tr>
  <tr>
    <td align="right" class="nobo trg">事由</td>
    <td colspan="3" class="nob_t_b" id="event"></td>
  </tr>
  <tr>
    <td align="right" class="nob_l_r trg">工作交接</td>
    <td colspan="3" class="all" id="handOver"></td>
  </tr>
  <tr class="whide">
    <td colspan="5" class="nob_t_b">&nbsp;</td>
  </tr>
  <tr class="whide">
    <th rowspan="2">代理人</th>
    <td class="nob_l_r bg">部门</td>
    <td class="all bg">姓名</td>
    <td class="nob_l_r bg">工号</td>
    <td class="all bg">职务</td>
  </tr>
  <tr>
    <td class="nobo" id="agent_dpt"></td>
    <td class="nob_t_b" id="agent_name"></td>
    <td class="nobo" id="agent_no"></td>
    <td class="nob_t_b" id="agent_pst"></td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <th>审批状态</th>
    <td colspan="4" class="nob_t_b" id="comment"></td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <th>处理</th>
    <td class="nob_l_r trg">意见</td>
    <td class="all" id="hd1"><select id="handler1" name="handler1" class="inp" tabindex="1">
       <option value="">请选择</option><option value="AGREE">同意</option><option value="DISAGREE">不同意</option></select></td>
    
    <td class="all" id="hd2"><select id="handler2" name="handler2" class="inp" tabindex="1">
       <option value="">请选择</option><option value="APPROVAL">批准</option><option value="REJECT">拒绝</option><option value="REVOKE">驳回</option></select></td>
    <td class="nob_l_r trg">批注</td>
    <td class="all"><input type="text" name="opinion" id="opinion" class="inp" tabindex="2" maxlength="30"/></td>
  </tr>
</table>
<input type="hidden" name="id" id="id"/>
<input type="hidden" name="state" id="state" />
<input type="hidden" name="agent" id="agent"/>
<input type="hidden" name="position" id="position" />
<input type="hidden" name="day" id="day"/>
<input type="hidden" name="traceId" id="traceId"/>
<input type="hidden" name="node" id="node"/>
<input type="hidden" name="rc" id="rc"/>
</form>
</div>
</div>
</div>
<!-- end main -->
<%@include file="/common/footer.html" %>
</div>
</body>
</html>