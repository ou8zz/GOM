var colNames_cn = ['ID号','异常类型','异常用户','直接主管','间接主管','异常说明','type','traceId','nodeName','nodeCode'];
var colNames_tw = ['ID號','異常類型','異常用户','直接主管','間接主管','異常說明','type','traceId','nodeName','nodeCode'];
var caption = {zh: "异常列表", "zh_CN": "异常列表<select id='abtype' onchange='javascript:search(this)'><option value='user'>当前异常</option><option value='early'>早期异常</option></select>", "zh_TW": "異常列表<select id='abtype' onchange='javascript:search(this)'><option value='user'>當前異常</option><option value='early'>早期異常</option></select>"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

//unblock when ajax activity stops 
$(document).ajaxStop($.unblockUI);
$(function(){
	$.fn.zTree.init($('#menu'), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	
	//显示异常的列表
	initGrid("get_abnormals.htm?sh=user");
		
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:350,
		   buttons: {
			  "提交": editSub,
			  "取消": function() {$(this).dialog('close')}}
	});
	
	$("#show_process").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:700,
		   buttons: {
			  "取消": function() {$(this).dialog('close')}}
	});
	
	//查找到所有部门遍历到department_SELECT
	$.post('../departments.htm',function(data){
		 var option = $("#rep_dpt, #in_dpt");
		 option.empty();
		 option.append("<option value=''>-请选择部门-</option>");
		 $.each(data, function(i, d){ option.append("<option value='"+d.id+"'>"+d.cname+"</option>"); });
	},'json');
	
	//选择部门 加载此部门下面的非Employee职位的用户
	$('#in_dpt').change(function(){
		 var ad = $(this).val();
		 var opt = $('#indirect').empty();
		 if(ad){
			$.post('../dpt_users.htm',{'dpt':ad,'type':'DEPARTMENT', ismgr:true},function(data){
				$.each(data, function(i,val){opt.append("<option value='" + val.ename + "'>" + val.ename + "</option>");});
			},'json');
		 } else alert("请先选择部门！");
	});
}); 

//选择下拉框事件
var search = function(obj) {
	var id = obj.id;
	var key = obj.value;
	$("#zgrid").GridUnload();
	initGrid("get_abnormals.htm?sh=" + key);
	$("#abtype").val(key);
};

//审核确认窗口
var shenheDlg = function() {
	var dlg = $("#content_main");
	var enames = new Array();
	var selectrow = $("#zgrid").jqGrid("getGridParam", "selarrrow");
	if(selectrow) {
		var panel = dlg.siblings(".ui-dialog-buttonpane");
		dlg.find("input").removeAttr("disabled");
		panel.find("button:not(:contains('取消'))").hide();
		panel.find("button:contains('同意')").show();
		dlg.dialog("option", "title", "审核异常");
		for(var i in selectrow) {
			var rd = $('#zgrid').jqGrid("getRowData", selectrow[i]);
			enames[i] = rd.ename;
		}
		dlg.find("#abnormal_title").html("<b><span style='color:green;'>您是否同时操作 <span style='color:blue;'>" + enames + "</span> 用户异常！</span></b>");
		dlg.find("#dd_indirect").hide();
		dlg.dialog('open');
	}
};
var rejectSub = function() {traceAbnormal('REJECT');};	//同意
var agreeSub = function() {traceAbnormal('APPROVAL');};	//拒绝

//提交给上级主管
var editDlg = function() {
	var dlg = $("#content_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('提交')").show();
	dlg.dialog('option', 'title', '审核异常');
	var selectrow = $("#zgrid").jqGrid("getGridParam", "selrow");
	var selectrows = $("#zgrid").jqGrid("getGridParam", "selarrrow");
	if(selectrows.length > 1) alert("提交上级主管一次只能提交一个用户，系统会选择最近选择的用户提交，请留意提交的用户名！");
	if(selectrow) {
		var rd = $('#zgrid').jqGrid("getRowData", selectrow);
		dlg.find("#dd_indirect").show();
		dlg.find("#id").val(rd.id);
		dlg.find("#traceId").val(rd.traceId);
		dlg.find("#abnormal_title").html("<b><span style='color:green;'>用户 <span style='color:blue;'>" + rd.ename + "</span> 的异常将提交给上级审核</span></b>");
		
		dlg.dialog('open');
	}
};
var editSub = function() {
	var dlg = $('#content_main');
	var params = {
		id:$.trim(dlg.find("#id").val()),
		traceId:$.trim(dlg.find("#traceId").val()),
		indirect:$.trim(dlg.find("#indirect").val()),
		des:$.trim(dlg.find("#des").val())
	};
	
	$.blockUI({message:'<h6><img src="../images/ztree/loading.gif" /> 系统正在处理中，请稍候！</h6>',css:{border:'none',padding:'15px',backgroundColor:'#000', '-webkit-border-radius':'10px', '-moz-border-radius':'10px', opacity:.5, color:'#fff' }}); 
	
	$.post('save_abnormal.htm', params, function(data) {
		if (data.result == "SUCCESS") {
			alert("操作成功");
			$('#zgrid').jqGrid("delRowData",params.id);
			dlg.dialog("close");
		} 
		else alert("操作失败");
	}, 'json');
};

//查看流程进度
var viewProcess = function() {
	var dlg = $("#show_process");
	var selectrow = $("#zgrid").jqGrid("getGridParam", "selrow");
	dlg.dialog("option", "title", "查看流程进度");
	if(selectrow) {
		var rd = $('#zgrid').jqGrid("getRowData", selectrow);
	
		 /** 基本信息 **/
		dlg.find('#task, #describe').empty();
		dlg.find('#task').prepend("<b>异常类型：</b><span class='taskTitle'>" + fmtAbnormalType(rd.type) + "</span>");
		dlg.find('#describe').prepend("<label>异常说明：</label><p>" + rd.des + "</p>");
		 
		 /** 流程 **/
		 $.post('get_abnormal_trace.htm',{processId:rd.id},function(data){
			  if(data.result == 'SUCCESS') {
				  dlg.find("#t_foot,#t_body").empty();
				  dlg.find("#t_foot").append('<span><img src="../images/trace/start.png" alt="start"/><h6>任务开始</h6></span>');
		    	  $.each(data.abnormal, function(i, t) {
		    		  var time = "";
			     	  var att = "";
			     	  var opinion = "";
			     	  if(t.icon == "active.gif") dlg.find('#traceId').val(t.id);
			    	  if(!isEmpty(t.deliverTime) && t.deliverTime != undefined) time = t.deliverTime;
			    	  if(!isEmpty(t.opinion) && t.opinion != undefined) opinion = t.opinion;
			    	  if(!isEmpty(t.attachment) && t.attachment != undefined) att = "<a href=javascript:downAttachment('"+t.attachment+"');>下载</a>";
					  var cindex = t.arrow.indexOf("_");
					  var arrow = "right";
					  var tar = t.arrow.substring(0,cindex);
					  if(tar == "up" || tar == "left") arrow = "left";
					  dlg.find("#t_body").append("<tr class='nob_t_b'><td class='tbt'>" + t.nodeName + "("+t.actor+")</td><td class='tbt'>"+time+"</td><td class='all'>"+opinion+"</td><td class='all'>"+att+"</td></tr>");
					  dlg.find("#t_foot").append("<img class='arrow' src='../images/trace/" + arrow + t.arrow.substring(cindex) + "'/><span><img src='../images/trace/" + t.icon + "'/><h6>" + t.nodeName + "(" + t.actor + ")</h6></span>");
		    	  });
			  }
		 },'json');
		 dlg.dialog('open');
	} else alert("请选择记录");
};

var initGrid = function(url) {
	jQuery("#zgrid").jqGrid({
		height: 400, width:793, url:url, datatype: "json",
		caption:caption[lang],
	   	colNames:colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   		{name:'type',index:'type',width:100,sortable:false,formatter:fmtAbnormalType},
	   		{name:'ename',index:'ename',width:100,sortable:false,align:"center"},
	   		{name:'reporter',index:'reporter',width:100,sortable:false,align:"center"},
	   		{name:'indirect',index:'indirect',width:100,sortable:false,align:"center"},
	   		{name:'des',index:'des',width:390,sortable:false,align:"center"},
	   		{name:'type',index:'type',hidden:true},
	   		{name:'traceId',index:'traceId',hidden:true},
	   		{name:'nodeName',index:'nodeName',hidden:true},
	   		{name:'nodeCode',index:'nodeCode',hidden:true}
	   	],
	   	rowNum:15,
	   	rowList:[15,30],
	   	pager: '#zpager',
	   	sortname: 'id',
	    viewrecords: true,
	    sortorder: "DESC",
		multiselect: false,
		editurl:"",
		jsonReader:{root:'list',repeatitems:false}
	}).navGrid('#zpager', {add:false, edit:false, del:false, deltitle:"提交给下个负责人", delicon:"ui-icon-circle-triangle-e", search:false}).jqGrid('navButtonAdd','#zpager',{caption: "查看流程", onClickButton:viewProcess});
};