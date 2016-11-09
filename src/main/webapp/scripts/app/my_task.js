var msg_cn = {assignor:{required:"请选择指派人！"},taskTitle:{required:"任务标题不能为空！", minlength:"请至少输入3个以上字符！"},expectedHours:{required:"时间不能为空！", maxlength:"请正确合适的输入工时！"},expectedEnd:{required:"请输入预计完成时间！"},describe:{required:"任务描述不能为空！", minlength:"请至少输入5个以上字符！"}};
var msg_cn = {assignor:{required:"請選擇指派人！"},taskTitle:{required:"任務標題不能為空！", minlength:"請至少輸入3個以上字符！"},expectedHours:{required:"時間不能為空！", maxlength:"請正確合適的輸入工時！"},expectedEnd:{required:"請輸入預計完成時間！"},describe:{required:"任務描述不能為空！", minlength:"請至少輸入5個以上字符！"}};
var colNames_cn = ['ID','任务标题','工作类型','完成%','指派人','预计工时','预计开始时间','预计完成时间','实际开始时间','实际完成时间','实际工时','执行人','任务描述','taskId','nodeName','nodeCode'];
var colNames_tw = ['ID','任務標題','工作類型','完成%','指派人','預計工時','預計開始時間','預計完成時間','實際開始時間','實際完成時間','實際工時','執行人','任務描述','taskId','nodeName','nodeCode'];
var caption = {zh: "待批审领", "zh_CN": "我的任务信息  <select id='taskType' onchange='javascript:search(this)'><option value=''>全部</option><option value='REGULAR'>固定</option><option value='PLAN'>计划</option><option value='TEMPORARY'>临时</option></select> <select id='state' onchange='javascript:search(this)'><option value=''>全部</option><option value='InProgress' selected>正在进行</option><option value='Completed'>已完成</option></select>", "zh_TW": "我的任務信息  <select id='taskType' onchange='javascript:search(this)'><option value=''>全部</option><option value='REGULAR'>固定</option><option value='PLAN'>計劃</option><option value='TEMPORARY'>臨時</option></select> <select id='state' onchange='javascript:search(this)'><option value=''>全部</option><option value='InProgress' selected>正在進行</option><option value='Completed'>已完成</option></select>"};
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
	
	//显示所有工作任务
	initGrid('get_tasks.htm?state=InProgress');
	
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:700,
		   buttons: {
			  "提交": editTask,
			  "工作开始":startTask,
			  "工作结束":endTask,
			  "取消": function() {$(this).dialog('close')}}
	});
	
	$("#addTask").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:700,
		   buttons: {
			  "提交": addTask,
			  "取消": function() {$(this).dialog('close')}}
	});
	
	$("#gConsole").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:400,
		   buttons: {
			  "确定": delaySub,
			  "取消": function() {$("#delay").val(''); $("#content_main").siblings(".ui-dialog-buttonpane").find("button:contains('工作结束')").show();$(this).dialog('close')}}
	});
	
	//查找到所有部门遍历到department_SELECT
	$.post('../departments.htm',function(data){
		 var option = $("#assignorDpt,#executorDpt");
		 option.empty();
		 option.append("<option value=''>选择部门</option>");
		 $.each(data, function(i, d){ option.append("<option value='"+d.id+"'>"+d.cname+"</option>"); });
	},'json');
	
	//选择部门 加载此部门下面的非Employee职位的用户
	$('#assignorDpt').change(function(){
		 var ad = $(this).val();
		 var opt = $('#assignor').empty();
		 if(ad){
			$.post('../dpt_users.htm',{'dpt':ad,'type':'DEPARTMENT', ismgr:true},function(data){
				$.each(data, function(i,val){opt.append("<option value='" + val.ename + "'>" + val.ename + "</option>");});
			},'json');
		 } else alert("请先选择部门！");
	});
	
	//选择部门 加载此部门下面的非Employee职位的用户
	$('#executorDpt').change(function(){
		 var ad = $(this).val();
		 var opt = $('#backer').empty();
		 if(ad){
			$.post('../dpt_users.htm',{'dpt':ad,'type':'DEPARTMENT', ismgr:true},function(data){
				$.each(data, function(i,val){opt.append("<option value='" + val.ename + "'>" + val.ename + "</option>");});
			},'json');
		 } else alert("请先选择部门！");
	});
	
	//需要帮忙checked点击事件
	$("#needState_dd").hide();
	$('#backer_dd').hide();
	$("#needHelp").click(function() {
		var dlg = $("#content_main");
		var panel = dlg.siblings(".ui-dialog-buttonpane");
		if($(this).attr('checked')) {
			$('#backer_dd').show();
			$("#needState_dd").show();
			panel.find("button:contains('提交')").show();
			panel.find("button:contains('工作开始')").hide();
			panel.find("button:contains('工作结束')").hide();
		} else {
			$('#backer_dd').hide();
			$("#needState_dd").hide();
			panel.find("button:contains('提交')").hide();
			panel.find("button:contains('工作结束')").hide();
			panel.find("button:contains('工作开始')").show();
		}
	});
	
	//Form 验证字段内容
	$("#taskForm").validate({
		rules : {  
			"assignor":{required:true},  
			"taskTitle":{required:true, minlength:3},  
			"expectedHours":{required:true, number:true},
			"expectedEnd":{required:true},
	        "describe":{required:true, minlength:5}  
	    },
	    onkeyup:false,
		messages : {
			assignor:{required:"请选择指派人！"},
			taskTitle:{required:"任务标题不能为空！", minlength:"请至少输入3个以上字符！"},
			expectedHours:{required:"时间不能为空！", number:"请正确合适的输入工时！"},
			expectedEnd:{required:"请输入预计完成时间！"},
			describe:{required:"任务描述不能为空！", minlength:"请至少输入5个以上字符！"}
		}
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

var initGrid = function(url) {
	jQuery("#task_tb").jqGrid({
	   	url:url, datatype: "json", height:350, width:790,
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
	   	pager: '#task_pg',
	   	sortname: 'id',
	    viewrecords: true,
	    rownumbers: false,
	    sortorder: "asc",
		multiselect: false,
		jsonReader:{root:'list',repeatitems:false},
	   	grouping: true,
	   	groupingView: {
	   		groupField:['assignor'], 
	   		groupColumnShow : [false], 
	   		groupText : ['指派人 ：{0} - ({1})'],
	   		groupCollapse : false, 
	   		groupOrder: ['desc'] 
		}
	}).jqGrid('navGrid','#task_pg',{addfunc:addTaskDlg,addtitle:"添加临时工作",editfunc:editTaskDlg,editicon:"ui-icon-key",del:false,view:true,search:false, alerttext:"请选择需要操作的数据行!"},{},{},{},{},{});
	
}

//任务添加弹出窗
var addTaskDlg = function() {
	 var dlg = $("#addTask");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('提交')").show();
	 dlg.dialog("option","title","添加临时工作任务");
	 dlg.find('#id').val('');
	 dlg.find('#taskTitle').val('');
	 dlg.find('#taskType').val('');
	 dlg.find('#assignor').val('');
	 dlg.find('#expectedHours').val('');
	 dlg.find('#expectedEnd').val('');
	 dlg.find('#describe').val('');
	 dlg.find('label.error').remove();
	 dlg.dialog('open');
};

//添加任务提交POST
var addTask = function() {
	var dlg = $('#addTask');
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	var params = {id:$.trim(dlg.find("#id").val()),
		 taskTitle:$.trim(dlg.find("#taskTitle").val()),
		 taskType:'TEMPORARY',
		 assignor:$.trim(dlg.find("#assignor").val()),
		 expectedHours:$.trim(dlg.find("#expectedHours").val()),
		 expectedEnd:$.trim(dlg.find("#expectedEnd").val()),
		 attachment:$.trim(dlg.find("#attachment").val()),
		 describe:$.trim(dlg.find("#describe").val())
	 };
	 
	 //验证方法
	 if($("#taskForm").valid()) {
		 panel.find("button:contains('提交')").hide();
		 $.post('save_task.htm',params,function(data){
		     if(data.result == "SUCCESS") {
		    	$("#task_tb").jqGrid("addRowData", data.task.id, data.task, "first");
				alert("添加临时工作任务成功！");
		        dlg.dialog("close");
			 }
		     else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
			 else alert("添加操作失败！");
		     panel.find("button:contains('提交')").show();
		 },'json'); 
	 }
};

//编辑工作任务
var editTaskDlg = function() {
	var rd = null;
	var dlg = $("#content_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	
	$('#task,#describe,#staff,#date').empty();
	
	var selectrow = $("#task_tb").jqGrid("getGridParam", "selrow");
	if(selectrow) rd = $('#task_tb').jqGrid("getRowData", selectrow);
	else {alert("请先选择需要操作的行！"); return false;}
	
	
	if(rd.actualStart == "") panel.find("button:contains('工作开始')").show();
	else panel.find("button:contains('工作结束')").show();
	if(rd.nodeCode != "Executor") {
		dlg.find("#lf").hide();
		panel.find("button:contains('提交')").hide();
		panel.find("button:contains('工作开始')").hide();
		panel.find("button:contains('工作结束')").hide();
	}
	
	dlg.dialog("option","title","工作流程进度 － " + rd.taskTitle);
	dlg.find('#id').val(rd.id);
	dlg.find('#traceId').val(rd.traceId);
	dlg.find('#nodeCode').val(rd.nodeCode);
	dlg.find('#expectedHours').val(rd.expectedHours);
	dlg.find('#expectedEnd').val(rd.expectedEnd);
	dlg.find('#delay').val('');
	dlg.find('#needHelp').val('');
	
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
			 needHelp:'',
			 delay:$.trim($("#delay").val()),
			 needState:$.trim(dlg.find("#needState").val()),
			 backer:$.trim(dlg.find("#backer").val()),
			 processId:$.trim(dlg.find("#id").val()),
			 hours:$.trim(dlg.find("#hours").val()),
			 nodeCode:$.trim(dlg.find("#nodeCode").val()),
			 opinion:$.trim(dlg.find("#opinion").val()),
			 attachment:$.trim(dlg.find("#attachment").val())
	 };
	 
	 if(dlg.find("#needHelp").attr('checked') == 'checked') params.needHelp = true;
	 
	 $.post('save_taskTrace.htm',params,function(data){
	     if(data.result == "SUCCESS") {
		    $('#task_tb').jqGrid("delRowData",params.processId);
		    alert("操作成功！");
	        dlg.dialog("close");
		 }
		 else alert("操作失败！");
	},'json');	
};

//延误工作原因弹出窗口处理
var delaySub = function() {
	var dlg = $('#gConsole');
	if(isEmpty(dlg.find('#delay').val())) {
		dlg.find('#delayError').html("请描述延误工作原因！");
		return false;
	}
	editTask();
	dlg.dialog("close");
};

//工作开始
var startTask = function() {
	var dlg = $('#content_main');
	$.post('edit_time.htm',{processId:$.trim(dlg.find("#id").val()), state:'start'},function(data){
	     if(data != null && data == "SUCCESS") {
		    alert("任务开始");
	        dlg.dialog("close");
	        $("#task_tb").GridUnload();
			initGrid("get_tasks.htm?state=InProgress");
		 }
		 else alert("操作失败！");
	},'json');
};

//工作结束
var endTask = function() {
	var dlg = $('#content_main');
	$.post('edit_time.htm',{processId:$.trim(dlg.find("#id").val()), state:'end'},function(data){
	    if(data != null && data == "SUCCESS") {
	    	var expectedEnd = new Date($("#expectedEnd").val().replace(/\-/g, "\/"));
	        if(expectedEnd < new Date()) {
	    	   	//如果提交时间 大于 预计结束时间 说明延误工作，弹出输入延误工作原因
	    	   	var gg = $("#gConsole");
	    	   	var pp = dlg.siblings(".ui-dialog-buttonpane");
	    	   	gg.find("input").removeAttr("disabled");
	    	   	pp.find("button:not(:contains('取消'))").hide();
	    	   	pp.find("button:contains('确定')").show();
	    	   	gg.dialog("option","title","添加延误原因");
	    	   	gg.find('#delay').val('');
	    	   	gg.dialog('open');
	        } else {
	        	alert("操作成功！");
	        	dlg.siblings(".ui-dialog-buttonpane").find("button:contains('工作结束')").hide();
			    dlg.siblings(".ui-dialog-buttonpane").find("button:contains('提交')").show();
	        }
		}
		else if(data == "FAILED") alert("您还不能这么快结束现有工作！");
		else alert("操作失败！");
	},'json');
};
