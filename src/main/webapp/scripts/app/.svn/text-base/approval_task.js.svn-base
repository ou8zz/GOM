
$(function(){
	$.fn.zTree.init($("#menu"), setting);
	
	//显示所有工作任务
	initGrid('get_tasks.htm?state=InProgress');
	
	//进度文档上传
	$('#attachments').uploadify({
		  'uploader':'../common/uploadify.swf',
		  'script':'../upload.htm',
		  'cancelImg':'../images/cancel.png',
		  'fileExt':'*.docx;*.doc',
		  'fileDesc':'只允许上传(.doc, .docx)',
		  'sizeLimit':102400,
		  'buttonImg':'../images/browse.jpg',
		  'displayData':'speed',
		  'expressInstall':'../common/expressInstall.swf',
		  'auto':true,
		  'onComplete':function(event,ID,fileObj,response,data) {
			  var obj = $.parseJSON(response);
			  $('#attachment').val(obj.fileName);
		  },
		  'onError':function(event, queueID, fileObj) {
			  alert("文件:" + fileObj.name + "上传失败！");
		  }
	});
	
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:700,
		   buttons: {
			  "提交": editTask,
			  "取消": function() {$(this).dialog('close')}}
	});
	
}); 

//选择下拉框事件
var search = function(obj) {
	var id = obj.id;
	var key = obj.value;
	$("#task_tb").GridUnload();
	initGrid("get_tasks.htm?" + id + "=" + key);
	$("#"+id).val(key);
};

var colNames_cn = ['ID','任务标题','工作类型','工时','实际工时','完成%','指派人','开始时间','预计完成时间','执行人','实际完成时间','任务描述','任务文档','taskId','nodeName','nodeCode'];
var colNames_tw = ['ID','任務標題','工作類型','工時','實際工時','完成%','指派人','開始時間','預計完成時間','執行人','實際完成時間','任務描述','任務文檔','taskId','nodeName','nodeCode'];

var caption = {
		zh: "追踪执行", 
		"zh_CN": "追踪执行  <select id='taskType' onchange='javascript:search(this)'><option value=''>全部</option><option value='REGULAR'>固定</option><option value='PLAN'>计划</option><option value='TEMPORARY'>临时</option></select> <select id='state' onchange='javascript:search(this)'><option value='InProgress' selected>正在进行</option><option value='Completed'>已完成</option><option value='Obsolete'>已废除</option></select>", 
		"zh_TW": "追蹤執行  <select id='taskType' onchange='javascript:search(this)'><option value=''>全部</option><option value='REGULAR'>固定</option><option value='PLAN'>計劃</option><option value='TEMPORARY'>臨時</option></select> <select id='state' onchange='javascript:search(this)'><option value='InProgress' selected>正在進行</option><option value='Completed'>已完成</option><option value='Obsolete'>已廢除</option></select>"
};

var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

var initGrid = function(url) {
	jQuery("#task_tb").jqGrid({
	   	url:url,
		datatype: "json",
		height:350,
		width:793,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   		{name:'taskTitle',index:'taskTitle',width:90,align:"center"},
	   		{name:'taskType',index:'taskType',width:60,align:"center", formatter:taskTypefmt,sortable:false},
	   		{name:'hours',index:'hours', width:40,align:"center",sortable:false},
	   		{name:'actualHours',index:'actualHours', width:40,align:"center",sortable:false},
	   		{name:'completedRate',index:'completedRate',width:50,align:"center",sortable:false},
	   		{name:'assignor',index:'assignor',width:50,align:"center",sortable:false},
	   		{name:'startTime',index:'startTime',width:80,align:"center",sortable:false},
	   		{name:'expectedTime',index:'expectedTime',width:80,align:"center",sortable:false},
	   		{name:'executor',index:'executor',hidden:true},
	   		{name:'endDate',index:'endDate',hidden:true},
	   		{name:'describe',index:'describe',hidden:true},
	   		{name:'document',index:'document',hidden:true},
	   		{name:'traceId',index:'traceId',hidden:true},
	   		{name:'nodeName',index:'nodeName',hidden:true},
	   		{name:'nodeCode',index:'nodeCode',hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#task_pg',
	   	sortname: 'id',
	    viewrecords: true,
	    rownumbers: false,
	    sortorder: "asc",
		multiselect: false,
		jsonReader:{root:'list',repeatitems:false},
	   	grouping: true,
	   	groupingView: {
	   		groupField:['executor'], 
	   		groupColumnShow : [false], 
	   		groupText : ['执行人 ：{0} - ({1})'],
	   		groupCollapse : false, 
	   		groupOrder: ['desc'] 
		}
	}).jqGrid('navGrid','#task_pg',{add:false,editfunc:editTaskDlg,editicon:"ui-icon-key",del:false,view:true,search:false, alerttext:"请选择需要操作的数据行!"},{},{},{},{},{});
	
};

//编辑工作任务
var editTaskDlg = function() {
	var rd = null;
	var dlg = $("#content_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('提交')").show();
	dlg.find("#lf").show();
	 
	$('#task,#describe,#staff,#date').empty();
	
	var selectrow = $("#task_tb").jqGrid("getGridParam", "selrow");
	if(selectrow) rd = $('#task_tb').jqGrid("getRowData", selectrow);
	else {alert("请先选择需要操作的行！"); return false;}
	
	dlg.dialog("option", "title", "工作流程进度 － " + rd.taskTitle);
	dlg.find('#id').val(rd.id);
	dlg.find('#traceId').val(rd.traceId);
	dlg.find('#nodeCode').val(rd.nodeCode);
	if(rd.nodeCode != "Director") {
		dlg.find("#lf").hide();
		panel.find("button:contains('提交')").hide();
	}
	
	/** 基本信息 **/
	dlg.find('#task').prepend("<b>任务标题：</b>" + rd.taskTitle + "<p>开始时间：" + rd.startTime + "<em>完成比例：" + rd.completedRate + "%</em></p>");
	dlg.find('#describe').prepend("<span><b>任务类型：</b>" + rd.taskType + "</span> &nbsp; <p>任务描述：" + rd.describe + "</p>");
	dlg.find('#staff').prepend("<label>工作指派人/工作执行人：</label>" + rd.assignor + " / " + rd.executor + "");
	dlg.find('#date').prepend("<label>预计完成 时间/工时：</label>" + rd.expectedTime + " / " + rd.hours + "");
	  
	/** 工作流程 **/
	$.post('get_taskTrace.htm', {processId:rd.id}, function(data){
		  if(data.result == 'SUCCESS') {
			  dlg.find("#t_body,#t_foot").empty();
			  dlg.find("#t_foot").append('<span><img src="../images/trace/start.png" alt="start"/><h6>任务开始</h6></span>');
		      $.each(data.ts, function(i, t) {
		    	  var time = "";
		     	  var att = "";
		     	  var opinion = "";
		    	  if(!isEmpty(t.deliverTime) && t.deliverTime != undefined) time = t.deliverTime;
		    	  if(!isEmpty(t.opinion) && t.opinion != undefined) opinion = t.opinion;
		    	  if(!isEmpty(t.attachment) && t.attachment != undefined) att = "<a href=javascript:downAttachment('"+t.attachment+"');>下载</a>";
				  var cindex = t.arrow.indexOf("_");
				  var arrow = "right";
				  var tar = t.arrow.substring(0,cindex);
				  if(tar == "up" || tar == "left") arrow = "left";
				  dlg.find("#t_body").append("<tr class='nob_t_b'><td class='tbt'>" + t.nodeName + "("+t.actor+")"+"</td><td class='tbt'>"+time+"</td><td class='all'>"+opinion+"</td><td class='all'>"+att+"</td></tr>");
				  dlg.find("#t_foot").append("<img class='arrow' src='../images/trace/" + arrow + t.arrow.substring(cindex) + "'/><span><img src='../images/trace/" + t.icon + "'/><h6>" + t.nodeName + "(" + t.actor + ")</h6></span>");
		      });
		  }
	 },'json');
	 dlg.dialog('open');
};
//提交修改的工作
var editTask = function() {
	 var dlg = $('#content_main');
	 var params = {id:$.trim(dlg.find("#traceId").val()),
		 processId:$.trim(dlg.find("#id").val()),
		 approval:dlg.find("input[name=state]:checked").val(),
		 nodeCode:$.trim(dlg.find("#nodeCode").val()),
		 opinion:$.trim(dlg.find("#opinion").val()),
		 attachment:$.trim(dlg.find("#attachment").val())
	 };
	 
	 if(params.approval == undefined) {
		dlg.find("#error_state").html("请选择您要做的操作！"); 
		return false;
	 } else dlg.find("#error_state").html(""); 	
	 
	 $.post('save_taskTrace.htm',params,function(data){
	     if(data.result == "SUCCESS") {
		    $('#task_tb').jqGrid("delRowData",params.processId);
		    alert("操作成功！");
	        dlg.dialog("close");
		 }
		 else alert("操作失败！");
	},'json');	
};
