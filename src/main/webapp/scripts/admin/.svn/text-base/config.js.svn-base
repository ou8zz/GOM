var colNames_cn = ['ID','key','名称','设定值'];
var colNames_tw = ['ID','key','名稱','設定值'];
var caption = {zh: "后台参数设定", "zh_CN": "后台参数设定", "zh_TW": "後臺參數設定"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
$.fn.zTree.init($("#menu"), setting);
$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
initGrid("get_configs.htm?group=" + $('#group').val());

$('#group').change(function(){
var ad = $('#group').val();
if(ad){$("#zgrid").GridUnload();initGrid("get_configs.htm?group="+ad);}
});

$('#type').change(function() {
 var ctype = $('#type').val();
  if(ctype=='GROUP') $('dd.defProp').hide();
  else if(ctype=='DEF') $('dd.defProp').show();
});

//配置对话框
$("#content_main").dialog({
   autoOpen:false,
   modal:true,
   resizable:true,
   width:450,
   buttons: {
      "新增":addConfig,
	  "修改":updateConfig,
	  "取消": function() {$(this).dialog('close')}
	  }
 });

});

var addConfigDlg = function() {
  var dlg = $("#content_main");
  var panel = dlg.siblings(".ui-dialog-buttonpane");
  dlg.find("input").removeAttr("disabled").val("");
  panel.find("button:not(:contains('取消'))").hide();
  panel.find("button:contains('新增')").show();
  dlg.find('dd.prop').show();
  dlg.find("#key").val('').removeAttr('readonly');
  dlg.find('#key').css({"border":"", "font-weight":""});
  dlg.find("#name").val('');
  dlg.find("#type").val('');
  $("#setValue").empty().append('<input id="value" name="value" tabindex="4" maxlength="150" />');
  
  dlg.dialog("option","title","新增参数配置").dialog('open');
};

var updateConfigDlg = function() {
  var dlg = $("#content_main");
  var sval = dlg.find("#setValue");
  var panel = dlg.siblings(".ui-dialog-buttonpane");
  dlg.find("input").removeAttr("disabled");
  panel.find("button:not(:contains('取消'))").hide();
  panel.find("button:contains('修改')").show();
  dlg.find('dd.prop').hide();
  
  var selectrow = $("#zgrid").jqGrid("getGridParam", "selrow");
  if(selectrow) {
   var rd = $('#zgrid').jqGrid("getRowData", selectrow);
   dlg.dialog("option","title","编辑 － " + rd.name);
   dlg.find('#key').val(rd.key).attr('readonly', 'readonly');
   dlg.find('#key').css({"border":"0px", "font-weight":"bold"});
   sval.empty().append('<input id="value" name="value" value="' + rd.value + '"/><span style="color:red;" id="error"></span>');
   dlg.find('#name').val(rd.name);
   dlg.find('#value').val(rd.value);
   
   //验证上下班时间格式'HH:mm'
   if(rd.key == "basis.login.out" || rd.key == "basis.login.time") {
	   sval.empty().append('<input id="value" name="value" tabindex="4" maxlength="150" value="' + rd.value + '" readonly="readonly" class="Wdate"/>');
	   $('#value').click(function(){WdatePicker({dateFmt:'HH:mm'});});
   } 
   //验证IT管理员,离职财务核算专员,离职审核人事专员,入职资料审核人事专员
   else if(rd.key == "basis.adminIT" || rd.key == "departure.financial" || rd.key == "departure.HR" || rd.key == "entrant.HR") {
	   sval.empty().append('<select id="dpt" onchange="getUser();" style="width:150px;" ></select><select id="value" name="value" style="width:150px;"></select>');
	   getDpts("#dpt");
	   $("#dpt").click(function() {
		   if($(this).val() != "" && $("#value").val() != "") $("#is_sub").val(true);
		   else $("#is_sub").val(false);
	   });
   } 
   //验证只能输入数字,（系统版本，试用期员工离职提前天数，正式员工离职申请提前天数，实习生离职提前天数，部门经理可批准的请假天数，部门主管可批准的请假天数）
   else if(rd.key == "basis.version" || rd.key == "departure.training.days" || rd.key == "departure.qualified.days" || rd.key == "departure.fieldwork.days" || rd.key == "leave.daysMgr" || rd.key == "leave.daysDtr") {
	   var re = /^[\d.]+$/;
	   $("#value").keyup(function() {
		   if(!re.test($(this).val())) {
			   sval.find("#error").empty().append("只允许输入数字");
			   $("#is_sub").val(false);
		   }
		   else {
			   sval.find("#error").empty();
			   $("#is_sub").val(true);
		   }
	   });
   } 
   //验证邮箱格式：系统邮件账号
   else if(rd.key == "basis.mail.user") {
	   var re = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
	   $("#value").keyup(function() {
		   if(!re.test($(this).val())) {
			   sval.find("#error").empty().append("请输入正确的邮箱，示例：sqe_xx@sqeservice.com");
			   $("#is_sub").val(false);
		   }
		   else {
			   sval.find("#error").empty();
			   $("#is_sub").val(true);
		   }
	   });
   } 
   //验证大写英文字符（工号前缀，公司英文名）
   else if(rd.key == "basis.jobNo.prefix" || rd.key == "basis.company.en") {
	   var re = /^[A-Z ]+$/;
	   $("#value").keyup(function() {
		   if(!re.test($(this).val())) {
			   sval.find("#error").empty().append("请输入大写的字母");
			   $("#is_sub").val(false);
		   }
		   else {
			   sval.find("#error").empty();
			   $("#is_sub").val(true);
		   }
	   });
   }
   //验证英文字符（日志路径，上传根目录）
   else if(rd.key == "basis.logs.path" || rd.key == "fileUpload.rootPath") {
	   var re = /^[A-Za-z0-9\/:]+$/;
	   $("#value").keyup(function() {
		   if(!re.test($(this).val())) {
			   sval.find("#error").empty().append("抱歉，您输入的字符不允许使用");
			   $("#is_sub").val(false);
		   }
		   else {
			   sval.find("#error").empty();
			   $("#is_sub").val(true);
		   }
	   });
   }
   //验证 （邮箱服务器）
   else if(rd.key == "basis.mail.host") {
	   var re = /[A-Za-z0-9\.-]{3,}\.[A-Za-z]{3}/;
	   $("#value").keyup(function() {
		   if(!re.test($(this).val())) {
			   sval.find("#error").empty().append("请输入合格的服务器地址：mail.sqeservice.com");
			   $("#is_sub").val(false);
		   }
		   else {
			   sval.find("#error").empty();
			   $("#is_sub").val(true);
		   }
	   });
   }
   //验证url （公司网站）
   else if(rd.key == "basis.web") {
	   var re = /http:\/\/[A-Za-z0-9\.-]{3,}\.[A-Za-z]{3}/;
	   $("#value").keyup(function() {
		   if(!re.test($(this).val())) {
			   sval.find("#error").empty().append("请输入合格的网站URL示例：http://www.sqeservice.com");
			   $("#is_sub").val(false);
		   }
		   else {
			   sval.find("#error").empty();
			   $("#is_sub").val(true);
		   }
	   });
   }
   //验证中文字条 （公司中文名）
   else if(rd.key == "basis.company.cn") {
	   var re = /^[u4E00-u9FA5]+$/;
	   $("#value").keyup(function() {
		   if(re.test($(this).val())) {
			   sval.find("#error").empty().append("只允许输入中文字符");
			   $("#is_sub").val(false);
		   }
		   else {
			   sval.find("#error").empty();
			   $("#is_sub").val(true);
		   }
	   });
   }
   //验证电话号 （公司电话，传真）
   else if(rd.key == "basis.tel" || rd.key == "basis.fax") {
	   var re = /^(\+?86-?)?(([1,2]{1}\d{1}\-?\d{4}-?\d{4})|(\([3-9]{1}\d{2}\)?\d{4}-?\d{3,4}))$/;
	   $("#value").keyup(function() {
		   if(!re.test($(this).val())) {
			   sval.find("#error").empty().append("请按示例输入正确的电话号：+8621-50499035");
			   $("#is_sub").val(false);
		   }
		   else {
			   sval.find("#error").empty();
			   $("#is_sub").val(true);
		   }
	   });
   }
   //验证文件上传字符 （禁止上传类型，允许上传文件类型）
   else if(rd.key == "fileUpload.typesForbid" || rd.key == "fileUpload.typesAllows") {
	   var re = /^[A-Za-z,]+$/;
	   $("#value").keyup(function() {
		   if(!re.test($(this).val())) {
			   sval.find("#error").empty().append("请将多种类型按逗号分别开：jpg,gif,png,pdf");
			   $("#is_sub").val(false);
		   }
		   else {
			   sval.find("#error").empty();
			   $("#is_sub").val(true);
		   }
	   });
   }
   dlg.dialog('open');
  }
  else {alert("请先选择需要编辑的行！"); return false;}
};

var addConfig = function() {
var dlg = $('#content_main');
$.post('save_config.htm',{key:$.trim(dlg.find("#key").val()),name:$.trim(dlg.find("#name").val()),value:$.trim(dlg.find("#value").val()),group:$.trim(dlg.find("#pkey").val())},function(data){
if(data.result == "SUCCESS") {
  var dataRow = {key:data.key,name:$.trim(dlg.find("#name").val()),value:$.trim(dlg.find("#value").val())};
  var srcrowid = $("#zgrid").jqGrid("getGridParam","selrow");
  if(srcrowid) $("#zgrid").jqGrid("addRowData", dataRow.key, dataRow, "before", srcrowid);
  else {$("#zgrid").jqGrid("addRowData", dataRow.key, dataRow, "first");}
  alert(dlg.find('#name').val() + " － 新增成功！");
  dlg.dialog("close");
}
else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
else alert("新增参数时发生错误！");
},'json');
};

var updateConfig = function() {
	var dlg = $('#content_main');
	if(isEmpty(dlg.find("#value").val()) || dlg.find("#value").val() == null) return false;
	//alert(dlg.find("#value").val() + "    " + $("#is_sub").val());
	if($("#is_sub").val() == "true") {
		$.post('save_config.htm',{key:$.trim(dlg.find("#key").val()),name:$.trim(dlg.find("#name").val()),value:$.trim(dlg.find("#value").val())},function(data){
		      if(data.result == "SUCCESS") {
		        var dr = {key:$.trim(dlg.find("#key").val()),name:$.trim(dlg.find("#name").val()),value:$.trim(dlg.find("#value").val())};
			    var srcrowid = $("#zgrid").jqGrid("getGridParam","selrow");
				$("#zgrid").jqGrid("setRowData", srcrowid, dr, {color:"#FF0000"});
				alert(dr.name + " －  更新成功！");
		        dlg.dialog("close");
			  }
			 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
			 else alert("更新操作失败！");
		},'json');
	}
};

function initGrid(config_url) {
	$("#zgrid").jqGrid({
    url:config_url,
    datatype:'json',
	mtype:'GET',
	height:300,
	width:790,
	caption: caption[lang],
    colNames: colNames[lang],
    colModel:[ 
	  {name:'id',index:'id',hidden:true},
	  {name:'key',index:'key',width:150,editable:false}, 
	  {name:'name',index:'name',width:210,editable:true},
	  {name:'value',index:'value',width:400,editable:true}],
	rowNum:10,
    rowList:[10,20,30],
	pager:'#zpager',
	viewrecords:true,
	rownumbers:true, 
	rownumWidth:30,
	sortname:'name',
	sortorder:'desc',
	prmNames:{search:'search'},
	jsonReader:{root:'list',repeatitems:false}
});

$('#zgrid').jqGrid('navGrid','#zpager',{addfunc:addConfigDlg,editfunc:updateConfigDlg,del:false,view:true,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"Let's go!", multipleSearch:false},{});
}


/**
var values = null;
//选择用户或自定义值
function choice() {
	var su = $("#su");
	if(su.html() == "用户") {
		$("#su").html("自定");
		values = $("#value").val();
		$("#setValue").empty().append('<select id="dpt" onchange="getUser();" style="width:150px;" ></select><select id="value" name="value" style="width:150px;"></select>');
		getDpts("#dpt");
	} else {
		$("#su").html("用户");
		$("#setValue").empty().append('<input id="value" name="value" tabindex="4" maxlength="150" value="' + values + '"/>');
	}
}
 */

//选择部门get用户
function getUser() {
	var value = $("#value").empty();
	$.post('../dpt_users.htm',{'dpt':$("#dpt").val(),'type':'DEPARTMENT','ismgr':false,'user':true},function(data){
		$.each(data, function(i,val){value.append("<option value='" + val.ename + "'>" + val.ename + "</option>");});
	},'json');
}