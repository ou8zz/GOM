<div class="signiture">
<h3>Best Regards</h3>
<h3>${user.ename}(${user.cname})</h3>
<table width="519" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="119" rowspan="2"><img src="../images/sqe_logo.png" width="119" height="45" alt="LOGO" /></td>
    <td width="240"><b>TEL:</b> ${tel} ext. <#if user.telExt?exists>${user.telExt}<#else>0</#if></td>
    <td width="160"><b>FAX:</b> ${fax}</td>
  </tr>
  <tr>
    <td><b>EMAIL:</b> ${user.email}</td>
    <td><b>WEB:</b> <a href="http://${web}">${web}</a></td>
  </tr>
</table>
<p>GOM_v${version} Copyright&copy;2005-2013 ${company_cn} ${company_en} 版权所有</p>
</div>