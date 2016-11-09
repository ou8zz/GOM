var colNames_cn = ['任务标题','工作类型','预计工时','预计占比(%)','任务描述','ID','工作状态Data','工作类型Data'];
var colNames_tw = ['任務標題','工作類型','預計工時','預計占比(%)','任務描述','ID','工作狀態Data','工作類型Data'];
var caption = {zh: "task", "zh_CN": "工作任务  <select id='taskType' onchange='javascript:search(this)'><option value=''>全部</option><option value='REGULAR'>固定</option><option value='PLAN'>计划</option><option value='TEMPORARY'>临时</option></select> <select id='state' onchange='javascript:search(this)'><option value=''>全部</option><option value='Ready' selected>未分配</option><option value='InProgress'>正在进行</option><option value='Completed'>已完成</option><option value='Obsolete'>已废除</option></select>", "zh_TW": "工作任務  <select id='taskType' onchange='javascript:search(this)'><option value=''>全部</option><option value='REGULAR'>固定</option><option value='PLAN'>計劃</option><option value='TEMPORARY'>臨時</option></select> <select id='state' onchange='javascript:search(this)'><option value=''>全部</option><option value='Ready' selected>未分配</option><option value='InProgress'>正在進行</option><option value='Completed'>已完成</option><option value='Obsolete'>已廢除</option></select>"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};


$(function(){
	$.fn.zTree.init($("#menu"), setting);
	$("dd span.error_msg").hide();
	//显示所有工作任务
	initGrid("get_tasks.htm?role=task&&state=Ready");
//	$("#occupyRate").keyup(function() { $(this).val($(this).val().replace(/[^0-9.]/g,'')); });
		
//配置对话框
$("#content_main").dialog({autoOpen:false,modal:true,resizable:true,width:700,height:600,buttons:{"添加":addTask,"修改":editTask,"取消":function() {$(this).dialog('close')}}});
	
/** 模块关联 */
$("#project").change(function() {
  var dlg = $('#content_main');
  var tb_tmp = dlg.find('.gom_tb tbody').empty();
  dlg.find('.project').show();
  $.get('get_project.htm',{pid:$(this).val()},function(data){
	  if(data == null || data == undefined) tb_tmp.append("<tr><td colspan='5'><b>没有可显示子项目模块</b></td></tr>");
	  else {$.each(data, function(i, p) {tb_tmp.append("<tr onclick=select(this,"+p.id+")><td><input type='radio' id='p"+p.id+"' name='p' value='"+p.id+"' /></td><td>"+p.projectName+"</td><td>"+p.projectNo+"</td><td>"+p.expectedTime+" p.t.</td><td>"+p.startDate+"</td><td>"+p.endDate+"</td></tr>");});
			   tb_tmp.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			}
  },'json');
});
	
	var validator = $('#taskForm').validate({rules:{"taskTitle":{required:true, minlength:3},"expectedHours":{required:true, number:true},"describe":{required:true, minlength:5}},messages:{taskTitle:{required:"任务标题不能为空！", minlength:"请至少输入3个以上字符！"},expectedHours:{required:"预计工时不能为空！", number:"预计工时只能是整数！"},describe:{required:"任务描述不能为空！", minlength:"请至少输入5个以上字符！"}},
		errorPlacement:function(error, element) {
			if(element.is(":radio")) error.appendTo(element.parent().parent().next().next());
			else if(element.is(":checkbox")) error.appendTo(element.next());
			else error.appendTo(element.parent());
		},
		invalidHandler:function(e, validator){
			var errors = validator.numberOfInvalids();
			if(errors) {
				var message = errors == 1 ? '高亮显示的栏位为空，请填写完后再提交' : '你有 ' + errors + ' 栏位为空或有误.  请按错误提示来更正';
				$("dd span.error_msg").html(message);
				$("dd span.error_msg").show();
			}else {
				$("dd span.error_msg").hide();
			}
		},
		submitHandler:function(){$("dd span.error_msg").hide();},
		success:function(label){label.html("").addClass("checked");}
  });
}); 

//点击TR触发radio选中事件
function select(obj,id){
  $(obj).parent().children('tr').removeClass("ui-state-highlight")
  $(obj).addClass("ui-state-highlight");
  $("#p"+id).attr("checked",true);
}

//选择下拉框事件
var search = function(obj){var id=obj.id;var key=obj.value; $("#task_tb").GridUnload();initGrid("get_tasks.htm?role=task&&" + id + "=" + key);$("#"+id).val(key);};

var initGrid = function(url){
		$("#task_tb").jqGrid({url:url,datatype: "json",height:350,width:793,
		caption: caption[lang],
		colNames: colNames[lang],
	   	colModel:[
	   		{name:'taskTitle',index:'taskTitle',width:160},
	   		{name:'taskType',index:'taskType',width:90,formatter:taskTypefmt,sortable:false},
	   		{name:'expectedHours',index:'expectedHours',width:70,sortable:false},
	   		{name:'occupyRate',index:'occupyRate',width:70,sortable:false},
	   		{name:'describe',index:'describe',width:120,sortable:false},
	   		{name:'id',index:'id',hidden:true},
	   		{name:'state',index:'state',hidden:true},
	   		{name:'taskType',index:'taskType',hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager:'#task_pg',
	   	sortname:'id',
	    viewrecords:true,
	    rownumbers:true,
		rownumWidth:33,
	    sortorder:"asc",
		multiselect:false,
		jsonReader:{root:'list',repeatitems:false}
	}).jqGrid('navGrid','#task_pg',{addfunc:addTaskDlg,addtitle:"分配新任务",editfunc:editTaskDlg,edittitle:"编辑任务",delfunc:abolish,deltitle:"废除或解除废除任务",delicon:"ui-icon-bullet",view:true,search:false, alerttext:"请选择需要操作的数据行!"},{},{},{},{},{});
};

//任务添加弹出窗
var addTaskDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('添加')").show();
	 dlg.dialog("option","title","添加工作任务");
	 dlg.find('#taskForm')[0].reset();
	 dlg.find('.project').show();
	 getProjects("#project","");
	 dlg.dialog('open');
};

//添加任务提交POST
var addTask = function() {
	var dlg = $('#content_main');
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	var params = {id:$.trim(dlg.find("#id").val()),proId:$("input[name=p]:checked").val(),state:'InProgress',taskType:'PLAN',taskTitle:$.trim(dlg.find("#taskTitle").val()),expectedHours:$.trim(dlg.find("#expectedHours").val()),describe:$.trim(dlg.find("#describe").val())};
	if(params.proId == undefined){alert("请选择项目模块！");return false;}
	
	if($("#taskForm").valid()){
		panel.find("button:contains('添加')").hide();
		$.post('save_task.htm', params, function(data){
			if(data.result == 'SUCCESS') {
				 $("#task_tb").jqGrid("addRowData", data.task.id, data.task, "first");
				 alert("添加成功！");
				 dlg.dialog("close");
			}
			else if(data.result == "UNSUPPORT") alert("此工作任务已存在！");
			else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
			else alert("添加操作失败！");
			panel.find("button:contains('添加')").show();
		},'json');
	}
};
/*编辑工作任务*/
var editTaskDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('修改')").show();
	 var selectrow = $("#task_tb").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
		 var rd = $('#task_tb').jqGrid("getRowData", selectrow);
		   dlg.dialog("option","title","编辑 － " + rd.taskTitle);
		   dlg.find('#id').val(rd.id);
		   dlg.find('#taskTitle').val(rd.taskTitle);
		   dlg.find('#occupyRate').val(rd.occupyRate);
		   dlg.find('#expectedHours').val(rd.expectedHours);
		   dlg.find('#describe').val(rd.describe);
		   dlg.find("#dd_project").hide();
		   dlg.find(".project_tab").hide();
		   dlg.dialog('open');
	 }
};
/**提交修改的工作*/
var editTask = function() {
	 var dlg = $('#content_main');
	 
	 if(!$("#taskForm").valid()) return false;
	 
	 var params = {id:$.trim(dlg.find("#id").val()),
		 taskType:'PLAN',
		 taskTitle:$.trim(dlg.find("#taskTitle").val()),
		 expectedHours:$.trim(dlg.find("#expectedHours").val()),
		 occupyRate:$.trim(dlg.find("#occupyRate").val()),
		 describe:$.trim(dlg.find("#describe").val())
	 };
	 $.post('save_task.htm',params,function(data){
	     if(data.result == "SUCCESS") {
	        var dr = {taskTitle:params.taskTitle,expectedHours:params.expectedHours,describe:params.describe};
		    $("#task_tb").jqGrid("setRowData", params.id, dr, {color:"#FF0000"});
			alert(dr.taskTitle + " －  更新成功！");
	        dlg.dialog("close");
		 }
		 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		 else alert("更新操作失败！");
	},'json');
};

/****废除功能****/
var abolish = function() {
	var bool = false;
	var state = ""
	var selectrow = $("#task_tb").jqGrid("getGridParam", "selrow");
	if(selectrow) {
		var rd = $('#task_tb').jqGrid("getRowData", selectrow);
		if(rd.state == "Obsolete") {
			//alert("已经废除了");
			bool = confirm("这项工作已经废除了,您是否要恢复到正常状态？");
			state = "Ready";
		} else {
			bool = confirm("您确定要废除 “"+rd.taskTitle+"” 这项工作吗？");
			state = "Obsolete";
		}
		
		if(bool) {
			$.post('abolish_task.htm', {id:rd.id, state:state}, function(data){
			     if(data.result == "SUCCESS") {
					alert("操作成功！");
				 }
				 else alert("操作失败！");
			},'json');
		}
	}
	return false;
	
	
};