<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/include_top.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh">
<head>
<title><fmt:message key="user.title" /> -SQE SERVICE GOM</title>
<link href="styles/reg.css" media="screen" rel="stylesheet" type="text/css"/>
<link href="styles/jquery-ui-1.8.20.css" media="screen" rel="stylesheet" type="text/css"/>
<%@include file="/common/header.html" %>
<script src="scripts/common/jquery-ui-1.8.20.js" type="text/javascript"></script>
<script src="scripts/common/uploadify-2.1.4.js" type="text/javascript"></script>
<script src="scripts/common/jcrop.js" type="text/javascript"></script>
<script src="scripts/common/validate.js" type="text/javascript"></script>
<script type="text/javascript" src="scripts/common/maskedinput.js"></script>
<script src="scripts/common/md5.js" type="text/javascript"></script>
<script src="scripts/common/jquery.blockUI.js" type="text/javascript"></script>
<script src="scripts/signup.js" type="text/javascript"></script>
</head>
<body>
<div id="container">
<div id="header"></div>
<div id="content">
<div id="left_side">
<h1><fmt:message key="user.ent" /></h1>
<div id="proceede">
<h2><fmt:message key="user.reported" /></h2>
<a class="step step1"><fmt:message key="user.mesgs" /></a>
<a class="step step2"><fmt:message key="user.hrcheck" /></a>
<a class="step step3"><fmt:message key="user.itsendmail" /></a>
</div>
</div>
<div id="right_side">
<h1>Step 1 of 3 </h1>
<form:form id="userForm" method="post" modelAttribute="u" action="save_reg.htm">
<input type="hidden" id="token" name="token" value="${token }"/>
<form:hidden path="id" />
<form:hidden path="idScan" />
<form:hidden path="portrait" />
<form:hidden path="jobNo" />
<input type="hidden" id="zw" name="zw" />
<input type="hidden" id="zh" name="zh" />
<input type="hidden" id="x" name="x" />
<input type="hidden" id="y" name="y" />
<fieldset class="fs_title">
  <legend class="leg_title"><fmt:message key="user.basic" /></legend>
  <ul class="nav_title"><li>&gt;&gt; <a href="reg.htm"><fmt:message key="user.inbisic" /></a></li><c:if test="${!empty u.id}"><li>&gt; <a href="next_edu.htm"><fmt:message key="user.inedu" /></a></li><li>&gt; <a href="next_addr.htm"><fmt:message key="user.inaddr" /></a></li></c:if></ul><br/><br/><br/>
   <div class="error" style="display:none;">
      <img src="images/warning.gif" alt="Warning!" width="24" height="24" style="float:left; margin: -5px 10px 0px 0px; " />
      <span><form:errors path="*" cssStyle="color:red"/></span><br clear="all"/>
    </div>
    <div style="clear:both"></div>
    <dl>
      <dd>
        <label class="lab"><fmt:message key="user.ename" /></label> <form:input path="ename" id="ename" cssClass="inp" tabindex="1" maxlength="15"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.cname" /></label> <form:input path="cname" id="cname" cssClass="inp required" tabindex="2" maxlength="5"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.pwd" /></label> <form:password path="pwd" id="pwd" cssClass="inp required password" tabindex="3" maxlength="32"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.pwds" /></label> <input type="password" id="repwd" name="repwd" equalTo="#pwd" class="inp required" tabindex="4" maxlength="32"/>
        <div class="formError"></div>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="general.dpt" /></label><form:select path="dptId" cssClass="inp required" tabindex="5">
        <form:option value=""><fmt:message key="general.select" /></form:option>
        <form:options items="${departments}" itemValue="id" itemLabel="cname"/>
        </form:select>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="general.pst" /></label> 
        <form:select path="pstId" cssClass="inp required" tabindex="6">
        <form:option value=""><fmt:message key="general.select" /></form:option>
        <form:options items="${positions}" itemValue="id" itemLabel="cname"/>
        </form:select>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.gender" /></label> 
        <span><form:radiobutton path="gender" value="F" cssClass="required"/><label for="gender1"><fmt:message key="user.gender.f" /></label></span><span><form:radiobutton path="gender" value="M" cssClass="required"/><label for="gender2"><fmt:message key="user.gender.m" /></label></span>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.birthday" /></label> 
        <form:input id="birthday" path="birthday" cssClass="inp required" tabindex="9" maxlength="10"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.nation" /></label> 
        <form:select path="nation" cssClass="inp required" tabindex="10">
          <form:option value=""><fmt:message key="general.select" /></form:option>
          <option><fmt:message key="user.nation.hz" /></option>
          <option><fmt:message key="user.nation.mgz" /></option>
          <option><fmt:message key="user.nation.zz" /></option>
          <option><fmt:message key="user.nation.wwez" /></option>
          <option><fmt:message key="user.nation.mz" /></option>
          <option><fmt:message key="user.nation.yz" /></option>
          <option><fmt:message key="user.nation.zuz" /></option>
          <option><fmt:message key="user.nation.byz" /></option>
          <option><fmt:message key="user.nation.cxz" /></option>
          <option><fmt:message key="user.nation.manz" /></option>
          <option><fmt:message key="user.nation.tonz" /></option>
          <option><fmt:message key="user.nation.yaoz" /></option>
          <option><fmt:message key="user.nation.baiz" /></option>
          <option><fmt:message key="user.nation.tjz" /></option>
          <option><fmt:message key="user.nation.hanz" /></option>
          <option><fmt:message key="user.nation.hskz" /></option>
          <option><fmt:message key="user.nation.tz" /></option>
          <option><fmt:message key="user.nation.lz" /></option>
          <option><fmt:message key="user.nation.llz" /></option>
          <option><fmt:message key="user.nation.wz" /></option>
          <option><fmt:message key="user.nation.sez" /></option>
          <option><fmt:message key="user.nation.ysz" /></option>
          <option><fmt:message key="user.nation.lgz" /></option>
          <option><fmt:message key="user.nation.suiz" /></option>
          <option><fmt:message key="user.nation.dxz" /></option>
          <option><fmt:message key="user.nation.nxz" /></option>
          <option><fmt:message key="user.nation.jpz" /></option>
          <option><fmt:message key="user.nation.kezmz" /></option>
          <option><fmt:message key="user.nation.tuz" /></option>
          <option><fmt:message key="user.nation.dhez" /></option>
          <option><fmt:message key="user.nation.mlz" /></option>
          <option><fmt:message key="user.nation.qz" /></option>
          <option><fmt:message key="user.nation.blz" /></option>
          <option><fmt:message key="user.nation.slz" /></option>
          <option><fmt:message key="user.nation.mnz" /></option>
          <option><fmt:message key="user.nation.qlz" /></option>
          <option><fmt:message key="user.nation.xbz" /></option>
          <option><fmt:message key="user.nation.acz" /></option>
          <option><fmt:message key="user.nation.pmz" /></option>
          <option><fmt:message key="user.nation.tjkz" /></option>
          <option><fmt:message key="user.nation.nuz" /></option>
          <option><fmt:message key="user.nation.wmbkz" /></option>
          <option><fmt:message key="user.nation.elsz" /></option>
          <option><fmt:message key="user.nation.ewkz" /></option>
          <option><fmt:message key="user.nation.daz" /></option>
          <option><fmt:message key="user.nation.banz" /></option>
          <option><fmt:message key="user.nation.ygz" /></option>
          <option><fmt:message key="user.nation.jingz" /></option>
          <option><fmt:message key="user.nation.ttez" /></option>
          <option><fmt:message key="user.nation.dlz" /></option>
          <option><fmt:message key="user.nation.elcz" /></option>
          <option><fmt:message key="user.nation.hzz" /></option>
          <option><fmt:message key="user.nation.mbz" /></option>
          <option><fmt:message key="user.nation.gbz" /></option>
        </form:select>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.census" /></label>
        <span><form:radiobutton path="censusType" value="COUNTRYSIDE" cssClass="required"/><label for="censusType1"><fmt:message key="user.census.countryside" /></label></span><span><form:radiobutton path="censusType" value="TOWN" cssClass="required"/><label for="censusType2"><fmt:message key="user.census.town" /></label></span><span><form:radiobutton path="censusType" value="GANGAOTAIBAO" cssClass="required"/><label for="censusType3"><fmt:message key="user.census.gangao" /></label></span><span><form:radiobutton path="censusType" value="FOREIGNER" cssClass="required"/><label for="censusType4"><fmt:message key="user.census.foreigner" /></label></span>
      </dd>
       <dd><label class="lab"><fmt:message key="user.marriage" /></label>
      <form:select path="marriage" cssClass="inp required" tabindex="11">
        <form:option value=""><fmt:message key="general.select" /></form:option>
        <form:option value="SINGLE"><fmt:message key="user.marriage.single" /></form:option>
        <form:option value="MARRIED"><fmt:message key="user.marriage.married" /></form:option>
        <form:option value="DIVOCED"><fmt:message key="user.marriage.divoced" /></form:option>
        <form:option value="WIDOWED"><fmt:message key="user.marriage.widowed" /></form:option>
        <form:option value="SEPARATED"><fmt:message key="user.marriage.separated" /></form:option>
      </form:select>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.height" /></label>
        <form:input id="height" path="height" cssClass="inp required number" tabindex="13" maxlength="13"/><span class="suffix">CM</span>
      </dd>
       <dd>
        <label class="lab"><fmt:message key="user.privateMail" /></label>
        <form:input id="privateMail" path="privateMail" cssClass="inp required" tabindex="14" maxlength="40"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.phone" /></label>
        <form:input id="phone" path="phone" cssClass="inp phoneCN " tabindex="15" maxlength="16"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.documents" /></label>
        <span><form:radiobutton path="documents" value="PIDCard" cssClass="required"/>
        <label for="documents1"><fmt:message key="user.documents1" /></label></span><span>
        <form:radiobutton path="documents" value="PASSPORT" cssClass="required"/>
        <label for="documents2"><fmt:message key="user.documents2" /></label></span><span>
        <form:radiobutton path="documents" value="MTPs" cssClass="required"/>
        <label for="documents3"><fmt:message key="user.documents3" /></label></span>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.idcard" /></label>
        <form:input id="idcard" path="idcard" cssClass="inp required isIdCardNo" tabindex="17" maxlength="21"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.cell" /></label>
        <form:input id="cell" path="cell" cssClass="inp mobileCN" tabindex="16" maxlength="17"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.bank" /></label>
        <form:input id="bank" path="bank" cssClass="inp required" tabindex="18" maxlength="20"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.accountNo" /></label>
        <form:input id="accountNo" path="accountNo" cssClass="inp required number" tabindex="19" maxlength="19"/>
      </dd>
       <dd>
        <label class="lab"><fmt:message key="user.idScanImage" /></label>
        <input type="file" name="idScanImage" id="idScanImage" tabindex="20"/>
      </dd>
      <dd>
        <label class="lab"></label>
        <input type="file" name="portraitImage" id="portraitImage" tabindex="21"/>
      </dd>
      <dd>
        <label class="lab"><fmt:message key="user.cut" /></label>
        <input type="button" name="crop_submit" value="<fmt:message key="user.crop_submit" />" id="crop_submit" tabindex="22" class="aqua_but"/>
      </dd>
      <dd><span style="color:#F00"><fmt:message key="user.cut.msg" /></span></dd>
  </dl>
<div style="clear:both"></div>
<div class="tmp_view">
    <div id="sfz"></div>
    <div id="touxian"></div>
</div>
<div id="thumbnail">
  <img id="tmp_portrait" src="" alt="<fmt:message key="user.image.alt" />"/>
  <div id="preview"><img id="idScan_tmp" src="" alt="idScan_tmp"/></div>
</div>
</fieldset>
<c:if test="${empty TMP_USER_TAKEN}">
<div class="buttonSubmit" id="butSubmit">
  <span></span>
  <input type="submit" name="userSubmit" value="<fmt:message key="user.next" />" id="userSubmit" tabindex="23"/>
</div>
</c:if>
</form:form>
</div>
</div>
<%@include file="/common/footer.html" %>
</div>
</body>
</html>