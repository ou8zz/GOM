<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<%@include file="/common/common_import.html" %>
<link href="../styles/app.css" media="screen" rel="stylesheet" type="text/css"/>
<link href="../styles/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<style type="text/css">
#group{position:relative;border-bottom:1px solid #36F;}
#group span{padding-left:10px;}
#group p{padding:0;float:right;}
#group p em{padding-left:20px;color:#F00;font-style:normal;}
</style>
<script src="../scripts/common/grid.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/uploadify-2.1.4.js" type="text/javascript"></script>
<script src="../scripts/common/maskedinput.js" type="text/javascript"></script>
<script src="../scripts/common/md5.js" type="text/javascript" charset="utf-8"></script>
<script src="../scripts/common/validate.js" type="text/javascript"></script>
<script src="../scripts/admin/users.js" type="text/javascript"></script>

<title><fmt:message key="users.page.title" /> -SQE SERVICE GOM</title>
</head>
<body>
<%@include file="/common/admin_header.html" %>
<div id="content" class="alpha grid_20 omega">
<div id="g_mgr">
<table id="users_tb"></table>
<div id="users_pg"></div>
<br />
<table id="edu_tb"></table>
<div id="edu_pg"></div>
<br />
<table id="addr_tb"></table>
<div id="addr_pg"></div>
</div>
<div id="gConsole"><span style="color:red;"><fmt:message key="general.delete.msg" /></span></div>
<div id="content_main">

<!-- 弹出窗口显示用户不能修改的信息 -->
<div id="group"></div>
<div id=""></div>
<div id="" style="clear:both"></div>
<div id=""></div>

<form:form id="userForm" modelAttribute="u">
<form:hidden path="id" />
<form:hidden path="pwd" />
<form:hidden path="emailPwd" />
<dl id="lf">
    <dd>
     <label class="label"><fmt:message key="user.cname" /><form:input path="cname" maxlength="15" cssClass="inp"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="user.cell" /><form:input path="cell" maxlength="17" cssClass="inp required mobileCN"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="user.gender" /><select id="gender" name="gender" class="inp required" tabindex="5">
        	<option value="M"><fmt:message key="user.gender.m" /></option>
        	<option value="F"><fmt:message key="user.gender.f" /></option>
        </select></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="user.birthday" /><form:input path="birthday" maxlength="15" cssClass="inp required"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="user.nation" />
     <select id="nation" name="nation" cssClass="inp required" tabindex="10">
          <option value=""><fmt:message key="general.select" /></option>
          <option><fmt:message key="user.nation.hz" /></option>
          <option value="<fmt:message key='user.nation.mgz' />"><fmt:message key="user.nation.mgz" /></option>
          <option value="<fmt:message key='user.nation.zz' />"><fmt:message key="user.nation.zz" /></option>
          <option value="<fmt:message key='user.nation.wwez' />"><fmt:message key="user.nation.wwez" /></option>
          <option value="<fmt:message key='user.nation.mz' />"><fmt:message key="user.nation.mz" /></option>
          <option value="<fmt:message key='user.nation.yz' />"><fmt:message key="user.nation.yz" /></option>
          <option value="<fmt:message key='user.nation.zuz' />"><fmt:message key="user.nation.zuz" /></option>
          <option value="<fmt:message key='user.nation.byz' />"><fmt:message key="user.nation.byz" /></option>
          <option value="<fmt:message key='user.nation.cxz' />"><fmt:message key="user.nation.cxz" /></option>
          <option value="<fmt:message key='user.nation.manz' />"><fmt:message key="user.nation.manz" /></option>
          <option value="<fmt:message key='user.nation.tonz' />"><fmt:message key="user.nation.tonz" /></option>
          <option value="<fmt:message key='user.nation.yaoz' />"><fmt:message key="user.nation.yaoz" /></option>
          <option value="<fmt:message key='user.nation.baiz' />"><fmt:message key="user.nation.baiz" /></option>
          <option value="<fmt:message key='user.nation.tjz' />"><fmt:message key="user.nation.tjz" /></option>
          <option value="<fmt:message key='user.nation.hanz' />"><fmt:message key="user.nation.hanz" /></option>
          <option value="<fmt:message key='user.nation.hskz' />"><fmt:message key="user.nation.hskz" /></option>
          <option value="<fmt:message key='user.nation.tz' />"><fmt:message key="user.nation.tz" /></option>
          <option value="<fmt:message key='user.nation.lz' />"><fmt:message key="user.nation.lz" /></option>
          <option value="<fmt:message key='user.nation.llz' />"><fmt:message key="user.nation.llz" /></option>
          <option value="<fmt:message key='user.nation.wz' />"><fmt:message key="user.nation.wz" /></option>
          <option value="<fmt:message key='user.nation.sez' />"><fmt:message key="user.nation.sez" /></option>
          <option value="<fmt:message key='user.nation.ysz' />"><fmt:message key="user.nation.ysz" /></option>
          <option value="<fmt:message key='user.nation.lgz' />"><fmt:message key="user.nation.lgz" /></option>
          <option value="<fmt:message key='user.nation.suiz' />"><fmt:message key="user.nation.suiz" /></option>
          <option value="<fmt:message key='user.nation.dxz' />"><fmt:message key="user.nation.dxz" /></option>
          <option value="<fmt:message key='user.nation.nxz' />"><fmt:message key="user.nation.nxz" /></option>
          <option value="<fmt:message key='user.nation.jpz' />"><fmt:message key="user.nation.jpz" /></option>
          <option value="<fmt:message key='user.nation.kezmz' />"><fmt:message key="user.nation.kezmz" /></option>
          <option value="<fmt:message key='user.nation.tuz' />"><fmt:message key="user.nation.tuz" /></option>
          <option value="<fmt:message key='user.nation.dhez' />"><fmt:message key="user.nation.dhez" /></option>
          <option value="<fmt:message key='user.nation.mlz' />"><fmt:message key="user.nation.mlz" /></option>
          <option value="<fmt:message key='user.nation.qz' />"><fmt:message key="user.nation.qz" /></option>
          <option value="<fmt:message key='user.nation.blz' />"><fmt:message key="user.nation.blz" /></option>
          <option value="<fmt:message key='user.nation.slz' />"><fmt:message key="user.nation.slz" /></option>
          <option value="<fmt:message key='user.nation.mnz' />"><fmt:message key="user.nation.mnz" /></option>
          <option value="<fmt:message key='user.nation.qlz' />"><fmt:message key="user.nation.qlz" /></option>
          <option value="<fmt:message key='user.nation.xbz' />"><fmt:message key="user.nation.xbz" /></option>
          <option value="<fmt:message key='user.nation.acz' />"><fmt:message key="user.nation.acz" /></option>
          <option value="<fmt:message key='user.nation.pmz' />"><fmt:message key="user.nation.pmz" /></option>
          <option value="<fmt:message key='user.nation.tjkz' />"><fmt:message key="user.nation.tjkz" /></option>
          <option value="<fmt:message key='user.nation.nuz' />"><fmt:message key="user.nation.nuz" /></option>
          <option value="<fmt:message key='user.nation.wmbkz' />"><fmt:message key="user.nation.wmbkz" /></option>
          <option value="<fmt:message key='user.nation.elsz' />"><fmt:message key="user.nation.elsz" /></option>
          <option value="<fmt:message key='user.nation.ewkz' />"><fmt:message key="user.nation.ewkz" /></option>
          <option value="<fmt:message key='user.nation.daz' />"><fmt:message key="user.nation.daz" /></option>
          <option value="<fmt:message key='user.nation.banz' />"><fmt:message key="user.nation.banz" /></option>
          <option value="<fmt:message key='user.nation.ygz' />"><fmt:message key="user.nation.ygz" /></option>
          <option value="<fmt:message key='user.nation.jingz' />"><fmt:message key="user.nation.jingz" /></option>
          <option value="<fmt:message key='user.nation.ttez' />"><fmt:message key="user.nation.ttez" /></option>
          <option value="<fmt:message key='user.nation.dlz' />"><fmt:message key="user.nation.dlz" /></option>
          <option value="<fmt:message key='user.nation.elcz' />"><fmt:message key="user.nation.elcz" /></option>
          <option value="<fmt:message key='user.nation.hzz' />"><fmt:message key="user.nation.hzz" /></option>
          <option value="<fmt:message key='user.nation.mbz' />"><fmt:message key="user.nation.mbz" /></option>
          <option value="<fmt:message key='user.nation.gbz' />"><fmt:message key="user.nation.gbz" /></option>
        </select></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="user.height" /><form:input path="height" cssClass="inp"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="user.marriage" /><form:select path="marriage" cssClass="inp required" tabindex="11">
        <form:option value=""><fmt:message key="general.select" /></form:option>
        <form:option value="SINGLE"><fmt:message key="user.marriage.single" /></form:option>
        <form:option value="MARRIED"><fmt:message key="user.marriage.married" /></form:option>
        <form:option value="DIVOCED"><fmt:message key="user.marriage.divoced" /></form:option>
        <form:option value="WIDOWED"><fmt:message key="user.marriage.widowed" /></form:option>
        <form:option value="SEPARATED"><fmt:message key="user.marriage.separated" /></form:option>
      </form:select></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="user.privateMail" /><form:input path="privateMail" cssClass="inp"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="user.phone" /><form:input path="phone" cssClass="inp required phoneCN"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="user.telExt" /><form:input path="telExt" cssClass="inp"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="user.idcard" /><form:input path="idcard" cssClass="inp required isIdCardNo"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="user.census" /><select id="censusType" name="censusType" class="inp required" tabindex="5">
        	<option value="COUNTRYSIDE"><fmt:message key="user.census.countryside" /></option>
        	<option value="TOWN"><fmt:message key="user.census.town" /></option>
        	<option value="GANGAOTAIBAO"><fmt:message key="user.census.gangao" /></option>
        	<option value="FOREIGNER"><fmt:message key="user.census.foreigner" /></option>
        </select></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="user.bank" /><form:input path="bank" cssClass="inp"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="user.accountNo" /><form:input path="accountNo" cssClass="inp"/></label>
   </dd>
   <dd>
     <label class="label"><fmt:message key="users.menu.title" /><input type="checkbox" id="generic" name="generic" class="inp"/></label>
   </dd>
 </dl>
</form:form> 
</div>

<div id="content_edu">
<form:form id="eduForm" modelAttribute="e">
<form:hidden path="id" />
<form:hidden path="idScan" />
<dl id="lf">
   <dd><label class="label"><fmt:message key="user.school" /><form:input path="school" cssClass="inp required"/></label></dd>
   <dd><label class="label"><fmt:message key="user.ed" /><form:input path="ed" cssClass="inp required"/></label></dd>
   <dd><label class="label"><fmt:message key="general.startDate" /><form:input path="startDate" cssClass="inp required"/></label></dd>
   <dd><label class="label"><fmt:message key="general.endDate" /><form:input path="endDate" cssClass="inp required"/></label></dd>
   <dd><label class="label"><fmt:message key="user.major" /><form:input path="major" cssClass="inp required"/></label></dd>
   <dd><label class="label"><fmt:message key="user.idno" /><form:input path="idno" cssClass="inp required"/></label></dd>
   <dd class="idscanimg">
		 <label class="label"><fmt:message key="user.idScanImg" /><input type="file" name="idScanImg" id="idScanImg"/>
		    <img src="" id="idScanShow" width="300" height="180" alt=""/>
		 </label>    
    </dd>
 </dl>
</form:form> 
</div>

<div id="content_addr">
<form:form id="addrForm" modelAttribute="a">
<form:hidden path="id" />
<dl id="lf">
   <dd><label class="label"><fmt:message key="user.contact" /><form:input path="contact" cssClass="inp inp required"/></label></dd>
   <dd><label class="label"><fmt:message key="user.relation" /><form:input path="relation" cssClass="inp required"/></label></dd>
   <dd><label class="label"><fmt:message key="user.zipcode" /><form:input path="zipcode" cssClass="inp required"/></label></dd>
   <dd><label class="label"><fmt:message key="user.cell" /><form:input path="cell" cssClass="inp required mobileCN"/></label></dd>
   <dd><label class="label"><fmt:message key="user.zuoji" /><form:input path="phone" cssClass="inp required phoneCN"/></label></dd>
   <dd>
     <label class="label"><fmt:message key="user.addrtype" /><select id="addrType" name="addrType" class="inp required">
        	<option value="PRESENT"><fmt:message key="user.addrtype.present" /></option>
        	<option value="FAMILY"><fmt:message key="user.addrtype.family" /></option>
        	<option value="CENSUS"><fmt:message key="user.addrtype.census" /></option>
        	<option value="EMERGENCY"><fmt:message key="user.addrtype.emergency" /></option>
        </select></label>
   </dd>
   <dd><label class="label"> <fmt:message key="user.address" /><form:textarea path="address" cssClass="inp area"></form:textarea></label></dd>
 </dl>
</form:form> 
</div>

</div>
</div><!-- end content -->
<%@include file="/common/footer.html" %>
</div><!-- end container_24 -->
</body>
</html>