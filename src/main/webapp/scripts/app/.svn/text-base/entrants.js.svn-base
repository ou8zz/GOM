var colNames_cn = ['ID','traceId','nodeCode','nodeOrder','头像','部门','职务','工号','英文名','中文名','称谓','出生年月','户籍','民族','手机','身份证','身份证附件','开户行','账号'];
var colNames_tw = ['ID','traceId','nodeCode','nodeOrder','頭像','部門','職務','工號','英文名','中文名','稱謂','出生年月','戶籍','民族','手機','身份證','身份證附件','開戶行','賬號'];
var acolNames_cn = ['ID','UID','联系人','关系', '手机','电话','地址类型','地址', '邮编'];
var acolNames_tw = ['ID','UID','聯系人','關系', '手機','電話','地址類型','地址', '郵編'];
var ecolNames_cn = ['ID','UID','附件','开始日期','结束日期', '学历', '毕业学校','专业','证书编号'];
var ecolNames_tw = ['ID','UID','附件','開始日期','結束日期', '學歷', '畢業學校','專業','證書編號'];
var caption = {zh: "入职审核人员", "zh_CN": "入职审核人员", "zh_TW": "入職審核人員"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};
var acaption = {zh: "联系人地址信息", "zh_CN": "联系人地址信息", "zh_TW": "聯系人地址信息"};
var acolNames = {zh: acolNames_cn, "zh_CN": acolNames_cn, "zh_TW": acolNames_tw};
var ecaption = {zh: "教育/培训经历", "zh_CN": "教育/培训经历", "zh_TW": "教育/培訓經歷"};
var ecolNames = {zh: ecolNames_cn, "zh_CN": ecolNames_cn, "zh_TW": ecolNames_tw};

// unblock when ajax activity stops 
$(document).ajaxStop($.unblockUI);
$(function(){
	$.fn.zTree.init($('#menu'), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	
	//查找到所有部门遍历到department_SELECT
	$.post('../departments.htm',function(data){
		 var option = $("#email");
		 option.empty();
		 option.append("<option value=''>-请选择部门-</option>");
		 $.each(data, function(i, d){ option.append("<option value='"+d.id+"'>"+d.cname+"</option>"); });
	},'json');
	
	$('#email').change(function(){
		if($(this).val()){
			$('#emailPwd').empty();
			$.post('../dpt_users.htm',{'dpt':$(this).val(),'type':'POSITION','ismgr':true},function(data){
				var option = "";
				$.each(data, function(i,val){option += "<option value='" + val.ename + "'>" + val.ename + "</option>";});
				$('#emailPwd').append(option);
			},'json');
		}else alert("请先选择部门！");
	});
	
	var msg = "不能为空";
	$("#entryForm").validate({
		rules:{entryDate:{required:true},bank:{required:true},accountNo:{required:true},cell:{required:true},censusType:{required:true},idcard:{required:true},email:{required:true},emailPwd:{required:true},checkbox:{required:true}},
		invalidHandler:function(e, validator) {
			var errors = validator.numberOfInvalids();
			if(errors){
				var message = errors == 1 ? '高亮显示的栏位为空，请填写完后再提交' : '你有 ' + errors + ' 栏位为空或有误.  请按错误提示来更正';
				$("tr.error span").html(message);
				$("tr.error").show();
			}else{$("tr.error").hide();}
		},
		onkeyup:false,
		submitHandler:function() {$("tr.error").hide();},
		messages:{entryDate:{required:msg},bank:{required:msg},accountNo:{required:msg},cell:{required:msg},censusType:{required:msg},idcard:{required:msg},checkbox:{required:msg}}
	});
	
$("#startDate").datepicker({changeMonth:true,changeYear:true,onSelect:function(selectedDate){$("#endDate").datepicker("option","minDate",selectedDate);}});
$("#endDate").datepicker({changeMonth:true,changeYear:true});
$("#fullDate,#entryDate").datepicker({minDate:new Date(),changeMonth:true,changeYear:true});
	
	//显示所有用户信息
	$('#zgrid').jqGrid({
	   	url:'get_users.htm',
		datatype:'json',
		mtype:'GET',
		height:250,
		width:793,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
		    {name:'id',index:'id',hidden:true},
			{name:'traceId',index:'traceId',hidden:true},
			{name:'nodeCode',index:'nodeCode',hidden:true},
			{name:'nodeOrder',index:'nodeOrder',hidden:true},
			{name:'portrait',index:'portrait',hidden:true},
	   		{name:'cdepartment',index:'cdepartment',width:50},
			{name:'cposition',index:'cposition',width:50},
			{name:'jobNo',index:'jobNo',width:60},
	   		{name:'ename',index:'ename',width:60},
	   		{name:'cname',index:'cname',width:60},		
	   		{name:'gender',index:'gender',width:40,formatter:genderType},
			{name:'birthday',index:'birthday',width:85},
			{name:'censusType',index:'censusType',width:60,formatter:censusType},
			{name:'nation',index:'nation',width:60},
	   		{name:'cell',index:'cell',width:95},
			{name:'idcard',index:'idcard',width:140},
			{name:'idScan',index:'idScan',hidden:true},
			{name:'bank',index:'bank',hidden:true},
			{name:'accountNo',index:'accountNo',hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager:'#zpager',
	    viewrecords:true,
	    rownumbers:true,
		rownumWidth:30,
		sortname:'ename',
		sortorder:'asc',
		prmNames:{search:'search'},
	    jsonReader:{root:'list',repeatitems:false},
		multiselect:false,
		cmTemplate:{sortable:false},
		onSelectRow:function(ids) {
			$('#id').val(ids);
			var rowData = $('#zgrid').jqGrid("getRowData",ids);
			$('#pwd').val(ids);
			$('#ename').val(rowData.ename);
			$('#agrid').jqGrid('setGridParam',{url:"get_user_edu.htm?isgrid=true&t=ADR&id="+ids,page:1});
			$('#agrid').jqGrid('setCaption', rowData.ename + ' 的地址信息').trigger('reloadGrid');
		}
	});

$('#zgrid').jqGrid('navGrid','#zpager',{add:false,editfunc:editUserDlg,del:false,search:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:true},{});
	
	//显示用户所有的地址信息
	$('#agrid').jqGrid({
		height:100,
		width:793,
		datatype:'json',
		caption: acaption[lang],
	   	colNames: acolNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true,editable:false},
			{name:'uid',index:'uid',hidden:true,editable:true},
	   		{name:'contact',index:'contact',width:60,editable:true,editoptions:{size:10},editrules:{required:true}},
	   		{name:'relation',index:'relation',width:50,editable:true,editoptions:{size:10},editrules:{required:true}},
	   		{name:'cell',index:'cell',width:100,editable:true,editoptions:{size:20},editrules:{custom:true,custom_func:checkCell}},
			{name:'phone',index:'phone',width:110,editable:true,editoptions:{size:18},editrules:{custom:true,custom_func:checkPhone}},
	   		{name:'addrType',index:'addrType',width:100,formatter:addrType,editable:true,edittype:"select",editoptions:{value:"PRESENT:现居住址;FAMILY:家庭住址;S_P_F:家庭与现居同一;CENSUS:户籍地址;EMERGENCY:紧急联络;S_C_P:户籍与现居同一;S_C_F:户籍与家庭同一;C_P_F:户籍现居家庭同一"},editrules:{required:true}},
	   		{name:'address',index:'address', width:270,editable:true,editoptions:{size:35},editrules:{required:true}},
			{name:'zipcode',index:'zipcode',width:70,editable:true,editoptions:{size:10},editrules:{custom:true,custom_func:checkpostCode}}
	   	],
		beforeSubmitCell:function(rowid, cellname, value, iRow, iCol) {
			return {id:$('#id').val(),uid:$('#pwd').val()};
		},
	   	rowNum:10,
	   	rowList:[10],
	   	pager:'#apager',
	    viewrecords:true,
		sortname:'contact',
	    sortorder:"asc",
		rownumbers:true,
		rownumWidth:30,
		cmTemplate:{sortable:false},
		editCaption:'编辑联系人地址信息',
		editurl:'get_user_addr.htm',
		gridComplete:function(){
			$('#egrid').jqGrid('setGridParam',{url:"get_user_edu.htm?isgrid=true&t=EDU&id="+$('#id').val(),page:1});
			$('#egrid').jqGrid('setCaption', $('#ename').val() + ' 的教育经历').trigger('reloadGrid');
		},
		jsonReader:{root:'list',repeatitems:false}
	}).navGrid('#apager',{edit:true,add:true,del:false,view:true,search:false},{closeAfterEdit:true,reloadAfterSubmit:false},{closeAfterAdd:true,reloadAfterSubmit:false,
	beforeSubmit:function(postdata, formid){postdata.uid=$('#id').val();postdata.id=0;return[true,""];}},{reloadAfterSubmit:false},{});
	
	//显示用户的所有教育经历
	$('#egrid').jqGrid({
		height:100,
		width:793,
		datatype:'json',
		caption: ecaption[lang],
	   	colNames: ecolNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
			{name:'uid',index:'uid',hidden:true},
			{name:'idScan',index:'idScan',hidden:true},
	   		{name:'startDate',index:'startDate',width:90},
	   		{name:'endDate',index:'endDate',width:90},
	   		{name:'ed',index:'ed', width:70},
	   		{name:'school',index:'school',width:200},		
	   		{name:'major',index:'major',width:100},
	   		{name:'idno',index:'idno',width:210}
	   	],
	   	rowNum:10,
	   	rowList:[10],
	   	pager:'#epager',
	   	sortname:'startDate',
	    viewrecords:true,
	    sortorder:'asc',
		rownumbers:true,
		rownumWidth:30,
		cmTemplate:{sortable:false},
		jsonReader:{root:'list',repeatitems:false}
	}).navGrid('#epager',{addfunc:addEduDlg,editfunc:editEduDlg,del:false,search:false,view:true},{reloadAfterSubmit:false},{reloadAfterSubmit:false},{reloadAfterSubmit:false},{});
	
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:470,
		   buttons: {
			  "提交":editUser,
			  "取消":function() {$(this).dialog('close')}}
	 });
	
	$("#content_edu").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:480,
		   buttons:{"添加":addEdu,"修改":editEdu,"取消":function(){$(this).dialog('close')}}
	});

$('#idScanImage,#zjScanImage').uploadify({
  'uploader':'../common/uploadify.swf',
  'script':'../upload.htm',
  'cancelImg':'../images/cancel.png',
  'fileExt':'*.jpg;*.png',
  'fileDesc':'只允许上传(.JPG,.PNG)',
  'sizeLimit':102400,
  'buttonImg':'../images/browse.jpg',
  'displayData':'speed',
  'expressInstall':'../common/expressInstall.swf',
  'auto':true,
  'onComplete':function(event,ID,fileObj,response,data) {
	  var obj = $.parseJSON(response);
	  $('#portrait').attr("value",obj.fileName);
	  $('#idScan').attr("src", "../uploads/images/"+obj.fileName);
	  $('#zjScan').attr("src", "../uploads/images/"+obj.fileName);
  },
  'onError':function(event, queueID, fileObj) {
	  alert("文件:" + fileObj.name + "上传失败！");
  }
});

});

var editUserDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	  
	 var selectrow = $('#zgrid').jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	 var rd = $('#zgrid').jqGrid("getRowData", selectrow);
	 dlg.find('#entryForm')[0].reset();
	 dlg.dialog("option","title","审核或补充 <b style='color:blue'>" + rd.ename + "</b> 的个人资料");
	 dlg.find('#id').val(rd.id);
	 dlg.find('#traceId').val(rd.traceId);
	 dlg.find('#name').empty();
	 dlg.find('#name').prepend("<h2>"+ rd.cname +"</h2> "+ rd.ename + "<span>联系电话：" + rd.cell + "</span>");
	 dlg.find('#header_line span').remove();
	 dlg.find('#header_line').prepend("<span>"+rd.gender+" | "+rd.birthday+" | "+rd.nation+"</span>");
	 if(rd.portrait) dlg.find('#touxian').attr("src", "../uploads/images/" + rd.portrait);
	 else dlg.find('#touxian').attr("src", "../images/touxian.gif");
	 dlg.find('#department').after(rd.email);
	 dlg.find('#position').after(rd.emailPwd);
	 dlg.find('#bank').val(rd.bank);
	 dlg.find('#accountNo').val(rd.accountNo);
	 dlg.find('#cell').val(rd.cell);
	 dlg.find('#nodeCode').val(rd.nodeCode);
	 dlg.find('#nodeOrder').val(rd.nodeOrder);
	 dlg.find('#jobNo').val(rd.jobNo);
	 dlg.find('#cdepartment').empty().append(rd.cdepartment);
	 dlg.find('#cposition').empty().append(rd.cposition);
	 
	 var ct = 'COUNTRYSIDE';
	 if(rd.censusType == '城镇') ct='TOWN';
	 dlg.find("input[name='censusType'][value="+ ct + "]").attr("checked",true);  
	 dlg.find('#idcard').val(rd.idcard);
	 dlg.find('#tmp_portrait').hide();
	 if(rd.idScan) {dlg.find('#idScan').attr("src", "../uploads/images/" + rd.idScan);$('#portrait').val(rd.idScan)}
	 else dlg.find('#idScan').attr("src", "../images/noIdScan.jpg");
	 dlg.dialog('open');
	 }
};

var editUser = function() {
  var dlg = $('#content_main');
  if($('#entryForm').valid() && dlg.find('#approval').attr('checked')){
	  $.blockUI({message:'<h6><img src="../images/ztree/loading.gif" /> 系统正在处理中，请稍候！</h6>',css:{border:'none',padding:'15px',backgroundColor:'#000', '-webkit-border-radius':'10px', '-moz-border-radius':'10px', opacity:.5, color:'#fff' 
        }});
	  $.ajax({url:'edit_entrant.htm',type:'POST',data:$('form').serialize(),dataType:'json',cache:false,success:function(data){
	      if(data.result == "SUCCESS") {
	        var uid = $("#zgrid").jqGrid('getGridParam','selrow');
			$('#zgrid').jqGrid("delRowData",uid);
			alert("操作成功！");
	        dlg.dialog("close");
		  }
		 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		 else alert("更新操作失败！");}
		});
  }
 else alert("所有必填选项均不能为空，且没上传证件的请先上传证件");
};

var addEduDlg = function() {
	 var dlg = $('#content_edu');
	 var panel = dlg.siblings('.ui-dialog-buttonpane');
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('添加')").show();
	 dlg.dialog("option","title","添加教育经历");
	 $('#id').val('');
	 dlg.find('#startDate').val('');
	 dlg.find('#endDate').val(''); 
	 dlg.find('#ed').val('');
	 dlg.find('#school').val('');
	 dlg.find('#major').val('');
	 dlg.find('#idno').val('');
	 dlg.find('#zjScan').attr('src','');
	 dlg.dialog('open');
};

var editEduDlg = function() {
	 var dlg = $('#content_edu');
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('修改')").show();
	  
	 var selectrow = $("#egrid").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	   var edu = $('#egrid').jqGrid("getRowData", selectrow);
	   dlg.dialog("option","title","编辑教育经历");
	   $('#id').val(edu.id);
	   dlg.find('#startDate').val(edu.startDate);
	   dlg.find('#endDate').val(edu.endDate); 
	   dlg.find('#ed').val(edu.ed);
	   dlg.find('#school').val(edu.school);
	   dlg.find('#major').val(edu.major);
	   dlg.find('#idno').val(edu.idno);
	   $('#portrait').val(edu.idScan);
	   dlg.find('#zjScan').attr('src','../uploads/images/' + edu.idScan);
	   dlg.dialog('open');
	 }
};

var addEdu = function() {
	var dlg = $('#content_edu');
	var params = {id:$("#id").val(),uid:$('#pwd').val(),idScan:$("#portrait").val(),startDate:$.trim(dlg.find("#startDate").val()),endDate:$.trim(dlg.find("#endDate").val()),ed:$.trim(dlg.find("#ed").val()),school:$.trim(dlg.find("#school").val()),major:$.trim(dlg.find("#major").val()),idno:$.trim(dlg.find("#idno").val())};
	  //验证方法
	  if(!valiEdu(params)) {
		  alert("信息不完整或未选择要添加教育的用户");
		  return false;
	  }else {
		$.post('save_user_edu.htm',params,function(data){
	      if(data.result == "SUCCESS") {
			  var srcrowid = $("#egrid").jqGrid("getGridParam","selrow");
			  if(srcrowid) $("#egrid").jqGrid("addRowData", params.id, params, "before", srcrowid);
			  else {$("#egrid").jqGrid("addRowData", params.id, params, "first");}
			  alert(params.school + " － 新增成功！");
			  dlg.dialog("close");
		  }
		 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		 else alert("更新操作失败！");
		},'json');
	  }
};

var editEdu = function() {
	 var dlg = $('#content_edu');
	 var params = {id:$("#id").val(),uid:$("#pwd").val(),idScan:$("#portrait").val(),startDate:$.trim(dlg.find("#startDate").val()),endDate:$.trim(dlg.find("#endDate").val()),ed:$.trim(dlg.find("#ed").val()),school:$.trim(dlg.find("#school").val()),major:$.trim(dlg.find("#major").val()),idno:$.trim(dlg.find("#idno").val())};
	  //验证方法
	  if(!valiEdu(params)) {
		  alert("信息不完整或未选择要添加教育的用户");
		  return false;
	  }
	$.post('save_user_edu.htm',params,function(data){
	    if(data.result == "SUCCESS") {
		  $("#egrid").jqGrid("setRowData", params.id, params, {color:"#FF0000"});
		  alert(params.school + "更新成功！");
	      dlg.dialog("close");
		}
	  else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
	  else alert("更新操作失败！");
	},'json');
};

//验证Edu
function valiEdu(p) {
	if(isEmpty(p.uid)) return false;
	if(isEmpty(p.startDate)) return false;
	if(isEmpty(p.endDate)) return false;
	if(isEmpty(p.ed)) return false;
	if(isEmpty(p.school)) return false;
	if(isEmpty(p.major)) return false;
	if(isEmpty(p.idno))return false;
	return true;
}

function isNull(str){
	  if(str == "") return true;
	  var reg = /^[ ]+$/;
	  return reg.test(str);
}

function checkCell(value,colname){
if(value == null || value=="") return [false,"手机号不能为空"];
else if(/^(\(\+?86\)-?)?(1(3|4|5|8)\d{1}-?\d{4}-?\d{4})$/.test(value)) return [true,""]; 
else return [false,"手机号正确格式:(86)138-1760-1860"];
} 

function checkPhone(value,colname) {
if(value == null || value=="") return [false,"电话不能为空"];
else if(/^(\+?86-?)?((\([1,2]{1}\d{1}\)?\d{4}-?\d{4})|(\([3-9]{1}\d{2}\)?\d{4}-?\d{3,4}))$/.test(value)) return [true,""];
else return [false,"电话正确格式: 86(21)1760-1860"];
}

function checkpostCode(value,colname){ 
if(value == null || value=="") return [false,"邮编不能为空"];
else if(/^\d{6}$/.test(value)) return [true,""]; 
else return [false,"邮编输入有误"];
}