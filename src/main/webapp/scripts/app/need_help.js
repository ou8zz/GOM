var colNames_cn = ['ID','任务标题','工作类型','完成%','指派人','预计工时','预计开始时间','预计完成时间','实际开始时间','实际完成时间','实际工时','执行人','任务描述','taskId','nodeName','nodeCode'];
var colNames_tw = ['ID','任務標題','工作類型','完成%','指派人','預計工時','預計開始時間','預計完成時間','實際開始時間','實際完成時間','實際工時','執行人','任務描述','taskId','nodeName','nodeCode'];
var caption = {zh: "需要帮忙", "zh_CN": "需要帮忙", "zh_TW": "需要幫忙"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
	$.fn.zTree.init($("#menu"), setting);
	
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
	
	//显示所有需要幫忙工作任务
	jQuery("#zgrid").jqGrid({
	   	url:'get_tasks.htm?help=true',
		datatype: "json",
		height:350,
		width:793,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   		{name:'taskTitle',index:'taskTitle',width:90,align:"center"},
	   		{name:'taskType',index:'taskType',width:60,align:"center", formatter:taskTypefmt,sortable:false},
	   		{name:'completedRate',index:'completedRate',width:50,align:"center",sortable:false},
	   		{name:'assignor',index:'assignor',width:50,align:"center",sortable:false},
	   		{name:'expectedHours',index:'expectedHours',width:50,align:"center",sortable:false},
	   		{name:'expectedStart',index:'expectedStart',width:120,align:"center",sortable:false},
	   		{name:'expectedEnd',index:'expectedEnd',width:120,align:"center",sortable:false},
	   		{name:'actualStart',index:'actualStart',hidden:true},
	   		{name:'actualEnd',index:'actualEnd',hidden:true},
	   		{name:'actualHours',index:'actualHours',hidden:true},
	   		{name:'executor',index:'executor',hidden:true},
	   		{name:'describe',index:'describe',hidden:true},
	   		{name:'traceId',index:'traceId',hidden:true},
	   		{name:'nodeName',index:'nodeName',hidden:true},
	   		{name:'nodeCode',index:'nodeCode',hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#zpager',
	   	sortname: 'id',
	    viewrecords: true,
	    rownumbers: false,
	    sortorder: "asc",
		multiselect: false,
		jsonReader:{root:'list',repeatitems:false},
	   	grouping: false,
	   	groupingView: {
	   		groupField:['assignor'], 
	   		groupColumnShow : [false], 
	   		groupText : ['指派人 ：{0} - ({1})'],
	   		groupCollapse : false, 
	   		groupOrder: ['desc'] 
		}
	}).jqGrid('navGrid','#zpager',{add:false,editfunc:editTaskDlg,editicon:"ui-icon-key",del:false,view:true,search:false, alerttext:"请选择需要操作的数据行!"},{},{},{},{},{});
	
	
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

//编辑工作任务
var editTaskDlg = function() {
	var rd = null;
	var dlg = $("#content_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('提交')").show();
	
	$('#task,#describe,#staff,#date').empty();
	
	var selectrow = $("#zgrid").jqGrid("getGridParam", "selrow");
	if(selectrow) rd = $('#zgrid').jqGrid("getRowData", selectrow);
	else {alert("请先选择需要操作的行！"); return false;}
	
	if(rd.nodeCode != "Help") {
		dlg.find("#lf").hide();
		panel.find("button:contains('提交')").hide();
	}
	
	dlg.dialog("option","title","工作流程进度 － " + rd.taskTitle);
	dlg.find('#id').val(rd.id);
	dlg.find('#traceId').val(rd.traceId);
	dlg.find('#nodeCode').val(rd.nodeCode);
	dlg.find('#expectedHours').val(rd.expectedHours);
	
	/** 基本信息 **/
	dlg.find('#task').prepend("<b>任务标题：</b>" + rd.taskTitle + "<p>预计开始时间：" + rd.expectedStart + "<em>完成比例：" + rd.completedRate + "%</em></p>");
	dlg.find('#describe').prepend("<span><b>任务类型：</b>" + rd.taskType + "</span> &nbsp; <p>任务描述：" + rd.describe + "</p>");
	dlg.find('#staff').prepend("<label>工作指派人/工作执行人：</label>" + rd.assignor + " / " + rd.executor + "");
	dlg.find('#date').prepend("<label>预计完成 时间/工时：</label>" + rd.expectedEnd + " / " + rd.expectedHours + "");
	
	/** 工作流程 **/
	$.post('get_taskTrace.htm',{processId:rd.id},function(data){
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
			 hours:$.trim(dlg.find("#hours").val()),
			 nodeCode:$.trim(dlg.find("#nodeCode").val()),
			 opinion:$.trim(dlg.find("#opinion").val()),
			 attachment:$.trim(dlg.find("#attachment").val())
	 };
	 
	 $.post('save_taskTrace.htm',params,function(data){
	     if(data.result == "SUCCESS") {
		    $('#zgrid').jqGrid("delRowData",params.processId);
		    alert("操作成功！");
	        dlg.dialog("close");
		 }
		 else alert("操作失败！");
	},'json');	
};
