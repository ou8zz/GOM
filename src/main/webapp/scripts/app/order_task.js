var colNames_cn = ['任务标题','工作类型','工时','完成例%','执行人','任务描述','ID','指派人','state'];
var colNames_tw = ['任務標題','工作類型','工時','完成例%','執行人','任務描述','ID','指派人','state'];
var caption_cn = "工作命令  <select id='taskType' onchange='javascript:search(this)'><option value=''>全部</option><option value='REGULAR'>固定</option><option value='PLAN'>计划</option><option value='TEMPORARY'>临时</option></select>  <select id='state' onchange='javascript:search(this)'><option value=''>全部</option><option value='Ready' selected>未分配</option><option value='InProgress'>正在进行</option><option value='Completed'>已完成</option><option value='Obsolete'>已废除</option></select>";
var caption_tw = "工作命令  <select id='taskType' onchange='javascript:search(this)'><option value=''>全部</option><option value='REGULAR'>固定</option><option value='PLAN'>計劃</option><option value='TEMPORARY'>臨時</option></select>  <select id='state' onchange='javascript:search(this)'><option value=''>全部</option><option value='Ready' selected>未分配</option><option value='InProgress'>正在進行</option><option value='Completed'>已完成</option><option value='Obsolete'>已廢除</option></select>";
var caption = {zh: caption_cn, "zh_CN": caption_cn, "zh_TW": caption_tw};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
	$.fn.zTree.init($("#menu"), setting);
	
	//显示所有工作任务
	initGrid("get_tasks.htm?role=order&&state=Ready");
	
	$('#expectedStart').focus(function(){WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d'});});
	$('#expectedEnd').focus(function(){WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'expectedStart\');}'});});
	
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
			  alert("上传成功！");
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
	
	//查找到所有部门遍历到department_SELECT
	$.post('../departments.htm',function(data){
		 var option = $("#assignorDpt,#executorDpt").empty().append("<option value=''>-请选择部门-</option>");
		 $.each(data, function(i, d){option.append("<option value='"+d.id+"'>"+d.cname+"</option>"); });
	},'json');
	
	//选择部门 加载此部门下面的非Employee职位的用户
	$('#assignorDpt').change(function(){
		 var ad = $(this).val();
		 var opt = $('#assignor').empty();
		 if(ad){
			$.post('../dpt_users.htm',{'dpt':ad,'type':'DEPARTMENT', ismgr:true}, function(data){
				$.each(data, function(i,val){opt.append("<option value='" + val.ename + "'>" + val.ename + "</option>");});
			},'json');
		 }else alert("请先选择部门！");
	});
	
	//选择部门 加载此部门下面的所有用户
	$('#executorDpt').change(function(){
		 var ad = $(this).val();
		 var executor = $('#executor').empty();
		 if(ad){
			$.post('../dpt_users.htm',{'dpt':ad,'type':'DEPARTMENT', ismgr:false},function(data){
				$.each(data, function(i,val){executor.append("<option value='" + val.ename + "'>" + val.ename + "</option>");});
				getUserResponsibility(executor.val());
			},'json');
		 } else alert("请先选择部门！");
	});
	
	//选择用户名得到这个用户的管理责任
	$('#executor').change(function () {getUserResponsibility($(this).val());});
	
	//选择责任分配
	$('#responsibility').change(function () {
		if(isEmpty($(this).val())) return false;
		$.get('get_responsibility.htm',{node:$(this).val(), ename:$("#executor").val()},function(data){
			var tbody = $("#res_body").empty();
			$.each(data, function(i, d){
				tbody.append("<tr onclick='select(this,"+d.id+")'><td><input type='radio' id='p"+d.id+"' name='respons' value='"+d.id+"' /></td><td>"+d.funcode+"</td><td>"+d.name+"</td><td>"+d.expected+"%</td></tr>");
			});
			tbody.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
		},'json');
	});
	
	//Form 验证字段内容
	$("#taskForm").validate({  
		rules : {  
			"assignor":{required:true},  
			"executor":{required:true},
			"respons":{required:true},
			"expectedStart":{required:true},
			"expectedEnd":{required:true}
	    },
	    onkeyup:true,
		messages : {
			assignor:{required:"请选择指派者！"},
			executor:{required:"请选择工作者！"},
			respons:{required:"请选择责任管理！"},
			expectedStart:{required:"预计开始时间不能为空！"},
			expectedEnd:{required:"预计结束时间不能为空！"}
		}
	});
	
}); 

//点击TR触发radio选中事件
function select(obj, id) {
	$(obj).parent().children('tr').removeClass("ui-state-highlight")
	$(obj).addClass("ui-state-highlight");
	$("#p"+id).attr("checked",true);
}

//执行者管理责任加载SELECT
var getUserResponsibility = function(ename) {
	var option = $("#responsibility");
	$.get('get_responsibility.htm',{ename:ename, isf:true},function(data){
		option.empty();
		option.append("<option value=''>-请选择责任管理-</option>");
		$.each(data, function(i, d){option.append("<option value='"+d.node+"'>"+d.name+"</option>");});
	 },'json');
};

//选择下拉框事件
var search = function(obj) {
	var id = obj.id;
	var key = obj.value;
	$("#task_tb").GridUnload();
	initGrid("get_tasks.htm?role=order&&" + id + "=" + key);
	$("#"+id).val(key);
};


var initGrid = function(url) {
	jQuery("#task_tb").jqGrid({
	   	url:url,
		datatype: "json",
		height:350,
		width:790,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   		{name:'taskTitle',index:'taskTitle',width:100},
	   		{name:'taskType',index:'taskType',width:60,formatter:taskTypefmt,sortable:false},
	   		{name:'expectedHours',index:'expectedHours', width:40,sortable:false},
	   		{name:'completedRate',index:'completedRate',width:60,sortable:false},
	   		{name:'executor',index:'executor',width:60,sortable:false},
	   		{name:'describe',index:'describe'},
	   		{name:'id',index:'id',hidden:true},
	   		{name:'assignor',index:'assignor',hidden:true},
	   		{name:'state',index:'state',hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#task_pg',
	   	sortname: 'id',
	    viewrecords: true,
	    rownumbers: false,
	    sortorder: "asc",
		multiselect: false,
		jsonReader:{root:'list',repeatitems:false}
	}).jqGrid('navGrid','#task_pg',{add:false,editfunc:editTaskDlg,edittitle:"分配任务",editicon:"ui-icon-key",del:false,search:false, alerttext:"请选择需要操作的数据行!"},{},{},{},{},{});
	
};

//编辑工作任务
var editTaskDlg = function() {
	 var rd = null;
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('提交')").show();
	 dlg.find(".fenpei").show();
	 
	 $('#task,#describe,#staff,#date').empty();
	 
	 var selectrow = $("#task_tb").jqGrid("getGridParam", "selrow");
	 if(selectrow) rd = $('#task_tb').jqGrid("getRowData", selectrow);
	 else {alert("请先选择需要审核的行！"); return false;}
	 
	 dlg.dialog("option","title","编辑 － " + rd.taskTitle);
	 dlg.find('#id').val(rd.id);
	 
	 if(rd.state != "Ready") {
		 dlg.find(".fenpei").hide();
		 panel.find("button:contains('提交')").hide();
	 }
	 
	 /** 基本信息 **/
	 dlg.find('#task').prepend("<b>任务标题：</b><span class='taskTitle'>" + rd.taskTitle + "</span><span><b>任务类型：</b>" + rd.taskType + "</span><p><em>完成比例：" + rd.completedRate + "%</em></p>");
	 dlg.find('#describe').prepend("<label>任务描述：</label><p>" + rd.describe + "</p>");
	 dlg.find('#date').prepend("<label>预计工时：</label><span>" + rd.expectedHours + "</sapn>");
	 
	 /** 工作流程 **/
	 $.post('get_taskTrace.htm',{processId:rd.id},function(data){
		  if(data.result == 'SUCCESS') {
			  dlg.find("#t_foot,#t_body").empty();
			  dlg.find("#t_foot").append('<span><img src="../images/trace/start.png" alt="start"/><h6>任务开始</h6></span>');
	    	  $.each(data.ts, function(i, t) {
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
		   
};
//提交修改的工作
var editTask = function() {
	 var dlg = $('#content_main');
	 
	 //验证
	 if(!$("#taskForm").valid()) return false;
	 	 
	 var params = {id:$.trim(dlg.find("#id").val()),
		 taskType:'PLAN',
		 taskTitle:$.trim(dlg.find("#task span.taskTitle").html()),
		 expectedHours:$.trim(dlg.find("#date span").html()),
		 responId:$("input[name=respons]:checked").val(),
		 traceId:$.trim(dlg.find("#traceId").val()),
		 completedRate:$.trim(dlg.find("#completedRate").val()),
		 executor:$.trim(dlg.find("#executor").val()),
		 assignor:$.trim(dlg.find("#assignor").val()),
		 describe:$.trim(dlg.find("#describe p").html()),
		 expectedStart:$.trim(dlg.find("#expectedStart").val()),
		 expectedEnd:$.trim(dlg.find("#expectedEnd").val()),
		 attachment:$.trim(dlg.find("#attachment").val())
	 };
	 
	 $.post('save_task.htm',params,function(data){
	     if(data.result == "SUCCESS") {
			alert("操作成功！");
			dlg.find(".fenpei").hide();
			$("#task_tb").GridUnload();
			initGrid("get_tasks.htm?role=order&&state=Ready");
	        dlg.dialog("close");
		 }
		 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		 else if(data.result == "FAILED") alert("您没有权限提交");
		 else alert("操作失败！");
	 },'json');
};

