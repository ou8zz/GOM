var colNames_cn = ['ID','流程类型','节点顺序','流程代码','流程名称','节点负责人','执行属性','节点图标'];
var colNames_tw = ['ID','流程類型','節點順序','流程代碼','流程名稱','節點負責人','執行屬性','節點圖標'];
var caption = {zh: "流程节点管理", "zh_CN": "流程节点管理", "zh_TW": "流程節點管理"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
	$.fn.zTree.init($('#menu'), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	var target_url = "get_processes.htm?type=DEPARTURE";
	initGrid(target_url);
	$('#process').change(function(){
		if($(this).val()){target_url="get_processes.htm?type="+$(this).val(); $("#zgrid").GridUnload();initGrid(target_url);}
	});

$('#assignType').change(function(){
var at = $(this).val();
$('#exexutors,#template').val('');
if(at=="PERSON"){$('dd.selt,div.executor').show();$('div.posting,div.executors,dd.parameter').hide();}
else if(at=="PEOPLE"){$('dd.selt,div.executor,div.executors').show();$('div.posting,dd.parameter').hide();}
else if(at == "POSITION") {$('dd.selt,div.posting').show();$('div.executor,div.executors,dd.parameter').hide();}
else if(at=="DYNAMIC"){$('dd.selt').hide();}
else{$('dd.selt').hide();$('dd.parameter').show();}
});

$('#actor').change(function(){
	var actor = $(this).val();
	var exexutor = $('#exexutors').val();
	if($('#assignType').val() == "PEOPLE") {
		if(exexutor == null || exexutor == "") {
			$('#exexutors').val(actor);
		} else $('#exexutors').val($('#exexutors').val()+","+actor);
	}
});

$('#dptOper').change(function(){
if($(this).val()){
	$.post('../dpt_users.htm',{'dpt':$(this).val(),'type':'DEPARTMENT','ismgr':false},function(data){
		$('option.choose').remove();
		var option = "";
		$.each(data, function(i,val){option += "<option class='choose' value='" + val.ename + "'>" + val.ename + "</option>";});
		$('#actor').append(option);
	},'json');
}else alert("请先选执行人部门！");
});
	
//配置对话框
$("#content_main").dialog({
   autoOpen:false,
   modal:true,
   resizable:true,
   width:420,
   buttons: {
      "增加":addProcess,
	  "修改":updateProcess,
	  "取消": function() {$(this).dialog('close')}
	  }
});
 
$("#process_preview").dialog({
   autoOpen:false,
   modal:true,
   resizable:true,
   width:610,
   buttons: {"关闭": function() {$(this).dialog('close')}}
});
 
$('#choiceProcess button').click(function(){
	var dlg = $("#process_preview");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	$.get(target_url,function(data){if(data.records >= 0){$('.nav_img').empty(); var node_tmp = "<div class='nav_img'><img src='../images/trace/start.png' alt='start' align='middle'/><h6>任务开始</h6></div>";
	  $.each(data.list, function(i,val){
	  node_tmp += "<div class='nav_img'><img class='arrow' src='../images/trace/right_green_arrow.jpg'/><img src='../uploads/images/" + val.icon + "'/><h6>" + val.nodeName + "(" + assignTypefmt(val.assignType) + ")</h6></div>";
	});
  $('.trace').empty().append(node_tmp);
  }else alert("通行错误！");},'json');
  dlg.dialog("option","title","预览 <span style='color:#333'>" + $('#process').find('option:selected').text() + "</span> 流程").dialog('open');
  return false;
});
 
//文档上传
$('#file_img').uploadify({
	'uploader':'../common/uploadify.swf',
	'script':'../upload.htm',
	'cancelImg':'../images/cancel.png',
	'fileExt':'*.jpg;*.gif;*.png',
	'fileDesc':'只允许上传(.jpg, .png, .gif)',
	'sizeLimit':102400,
	'buttonImg':'../images/browse.jpg',
	'displayData':'speed',
	'expressInstall':'../expressInstall.swf',
	'auto':true,
	'onComplete':function(event,ID,fileObj,response,data) {
		var obj = $.parseJSON(response);
		$('#icon').val(obj.fileName);
		$('.tbiao img').attr("src","../uploads/images/" + obj.fileName);
	},
	'onError':function(event, queueID, fileObj) {
		alert("文件:" + fileObj.name + "上传失败！");
	}
});
$("#choiceProcess button").button();
});//END global

var addProcessDlg = function() {
  var dlg = $("#content_main");
  var panel = dlg.siblings(".ui-dialog-buttonpane");
  panel.find("button:not(:contains('取消'))").hide();
  panel.find("button:contains('增加')").show();
  dlg.find("#nodeCode").val('');
  dlg.find("#node_name").val('');
  dlg.find("#assignType").val('');
  $("#icon").val('');
  dlg.find("#file_img").val('');
  $('div.executor').hide(); 
  $('div.posting').show();
  $('div.tbiao').hide();
  
  dlg.dialog("option","title","增加流程节点").dialog('open');
};

var updateProcessDlg = function() {
  var dlg = $("#content_main");
  var panel = dlg.siblings(".ui-dialog-buttonpane");
  panel.find("button:not(:contains('取消'))").hide();
  panel.find("button:contains('修改')").show();
  
  var selectrow = $("#zgrid").jqGrid("getGridParam", "selrow");
  if(selectrow) {
   var rd = $('#zgrid').jqGrid("getRowData", selectrow);
   dlg.dialog("option","title","编辑 － " + rd.nodeName);
   dlg.find('.tbiao img').attr("src","");
   dlg.find('#id').val(rd.id);
   dlg.find('#icon').val(rd.icon);
   if(rd.assignType == "动态"){dlg.find('dd.selt,dd.parameter').hide();dlg.find('#assignType').val("DYNAMIC");}
   else if(rd.assignType == "参数") {dlg.find('dd.selt').hide();dlg.find('dd.parameter').show();dlg.find("#template").val(rd.actor);dlg.find('#assignType').val("PARAMETER");}
   else{dlg.find('dd.selt').show();dlg.find('dd.parameter').hide();
	   if(rd.assignType == "个人"){dlg.find('div.executor').show();dlg.find('div.posting,div.executors').hide();dlg.find('#assignType').val("PERSON");}
	   else if(rd.assignType == "多人"){dlg.find('div.executor,div.executors').show();dlg.find('div.posting').hide();dlg.find("#exexutors").val(rd.actor);dlg.find('#assignType').val("PEOPLE");}
	   else if(rd.assignType == "职务"){dlg.find('div.executor,div.executors').hide();dlg.find('div.posting').show();dlg.find('#assignType').val("POSITION");}
	   else{dlg.find('div.selt').hide();dlg.find('#assignType').val("DYNAMIC");}
	   if(rd.actor && (rd.assignType == "多人" || rd.assignType == "个人")) {$.get('get_user.htm',{name:$.trim(rd.actor)},function(data){$("#dptOper").val(data.department);$('#actor').append("<option class='choose' value='" + data.ename + "'>" + data.ename + "</option>");$("#actor").val(data.email);},'json');}
   }
   dlg.find('#nodeCode').val(rd.nodeCode);
   dlg.find('#node_name').val(rd.nodeName);
   dlg.find('#nodeOrder').val(rd.nodeOrder);
   if(rd.icon){dlg.find('.tbiao img').show().attr("src","../uploads/images/" + rd.icon);}
   dlg.dialog('open');
  }else {alert("请先选择需要编辑的行！"); return false;}
};

var addProcess = function() {
var dlg = $('#content_main');
var at = $.trim(dlg.find("#assignType").val());
var actor=$.trim(dlg.find("#actor").val());
if(at=="PARAMETER") actor=$.trim(dlg.find("#template").val());
else if(at=="POSITION") actor=$.trim(dlg.find("#excPst").val());
else if(at=="PEOPLE")actor=$.trim(dlg.find("#exexutors").val());
else if(at=="DYNAMIC") actor="";
$.post('save_process.htm',{process:$.trim($("#process").val()),nodeCode:$.trim(dlg.find("#nodeCode").val()),nodeName:$.trim(dlg.find("#node_name").val()),assignType:$.trim(dlg.find("#assignType").val()),icon:$.trim($("#icon").val()),actor:actor},function(data){
if(data.result == "SUCCESS") {
  var dataRow = {id:data.process.id,nodeCode:$.trim(dlg.find("#nodeCode").val()),nodeName:$.trim(dlg.find("#node_name").val()),assignType:$.trim(dlg.find("#assignType").val()),icon:$.trim($("#icon").val()),actor:actor};
  var srcrowid = $("#zgrid").jqGrid("getGridParam","selrow");
  if(srcrowid) $("#zgrid").jqGrid("addRowData", dataRow.id, dataRow, "before", srcrowid);
  else {$("#zgrid").jqGrid("addRowData", dataRow.id, dataRow, "first");}
  alert(dlg.find('#node_name').val() + " － 增加成功！");
  dlg.dialog("close");
}
else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
else alert("增加流程节点时发生错误！");
},'json');
};

var updateProcess = function() {
  var dlg = $('#content_main');
  var at = $.trim(dlg.find("#assignType").val());
  var actor=$.trim(dlg.find("#actor").val());
  if(at=="PARAMETER") actor=$.trim(dlg.find("#template").val());
  else if(at=="POSITION") actor=$.trim(dlg.find("#excPst").val());
  else if(at=="PEOPLE")actor=$.trim(dlg.find("#exexutors").val());
  else if(at=="DYNAMIC") actor="";
  $.post('save_process.htm',{process:$.trim($("#process").val()),id:$.trim($("#id").val()),nodeCode:$.trim(dlg.find("#nodeCode").val()),nodeName:$.trim(dlg.find("#node_name").val()),assignType:$.trim(dlg.find("#assignType").val()),icon:$.trim($("#icon").val()),actor:actor,nodeOrder:$.trim(dlg.find("#nodeOrder").val())},function(data){
      if(data.result == "SUCCESS") {
        var dr = {id:$.trim($("#id").val()),type:data.process.type,nodeCode:$.trim(dlg.find("#nodeCode").val()),nodeName:$.trim(dlg.find("#node_name").val()),actor:data.process.actor,assignType:$.trim(dlg.find("#assignType").val()),icon:data.process.icon};
	    var srcrowid = $("#zgrid").jqGrid("getGridParam","selrow");
		$("#zgrid").jqGrid("setRowData", srcrowid, dr, {color:"#FF0000"});
		alert(dr.nodeName + " －  修改成功！");
        dlg.dialog("close");
	  }
	 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
	 else alert("修改操作失败！");
	},'json');
};

function initGrid(config_url) {
	$('#zgrid').jqGrid({
	   	url:config_url,
		datatype:'json',
		mtype:'GET',
		height:250,
		width:790,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
		    {name:'id',index:'id',hidden:true},
			{name:'type',index:'type',hidden:true},
			{name:'nodeOrder',index:'nodeOrder',hidden:true},
			{name:'nodeCode',index:'nodeCode',width:150,sortable:false},
			{name:'nodeName',index:'nodeName',width:200,sortable:false},
			{name:'actor',index:'actor',width:150,sortable:false},
			{name:'assignType',index:'assignType',width:100,sortable:false,formatter:assignTypefmt},
			{name:'icon',index:'icon',hidden:true},
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager:'#zpager',
	    viewrecords:true,
	    rownumbers:true,
		rownumWidth:30,
		sortname:'id',
		sortorder:'asc',
		prmNames:{search:'search'},
	    jsonReader:{root:'list',repeatitems:false},
		multiselect:false
	});

$('#zgrid').jqGrid('navGrid','#zpager',{addfunc:addProcessDlg,editfunc:updateProcessDlg,del:false,view:true,search:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:true},{});
}

//NODE枚举格式化
function assignTypefmt(cellvalue){
	var tmp;
	if(cellvalue=="PERSON") tmp="个人";
	else if(cellvalue=="PEOPLE") tmp="多人";
	else if(cellvalue=="POSITION") tmp="职务";
	else if(cellvalue=="DYNAMIC") tmp="动态";
	else if(cellvalue=="PARAMETER") tmp="参数";
	return tmp;
}

function imageFormat(cellvalue, options, rowObject){
	$('#icon').val(cellvalue);
	return '<img src="../uploads/images/'+cellvalue+'" />';
}