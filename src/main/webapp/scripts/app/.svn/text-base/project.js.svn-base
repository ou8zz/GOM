var msg_cn = {projectNo:"编号不能为空",projectName:"名称不能为空",startDate:"开始时间不能为空",endDate:"结束时间不能为空",dtrDptId:"主管部门不能空",director:"主管不能空",version:"版本不能空",expectedTime:{required:"预计工时不能为空",number:"工时只能是数字"},des:"描述说明不能为空"};
var msg_tw = {projectNo:"編號不能為空",projectName:"名稱不能為空",startDate:"開始時間不能為空",endDate:"結束時間不能為空",dtrDptId:"主管部門不能空",director:"主管不能空",version:"版本不能空",expectedTime:{required:"預計工時不能為空",number:"工時只能是數字"},des:"描述說明不能為空"};
var colNames_cn = ['ID','TYPE','项目名称','项目编号','版本','项目类型','项目主管','主管部门','开始时间','预计结束','预计工时(pt.)','项目说明','产品ID','产品名称','PID','名称'];
var colNames_tw = ['ID','TYPE','項目名稱','項目編號','版本','項目類型','項目主管','主管部門','開始時間','預計結束','預計工時(pt.)','項目說明','產品ID','產品名稱','PID','名稱'];
var caption = {zh: "项目管理", "zh_CN": "项目管理", "zh_TW": "項目管理"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};
    
$(function(){
	$.fn.zTree.init($("#menu"), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	$("#startDate").datepicker({changeMonth:true,changeYear:true,onSelect:function(selectedDate){$("#endDate").datepicker("option", "minDate", selectedDate);}});
	$("#endDate").datepicker({changeMonth:true,changeYear:true,onSelect:function(selectedDate) {$("#startDate").datepicker("option", "maxDate", selectedDate);}});
	$("dd span.error_msg").hide();
	
	//显示所有项目信息
	jQuery("#project_tb").jqGrid({
	   	url:'get_projects.htm',
	   	treedatatype: "xml",
		treeGridModel:'adjacency',
		mtype: "POST",
		height:'auto',
		width:793,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   	    {name:'type',index:'type',hidden:true},
	   		{name:'projectName',index:'projectName',width:100},
	   		{name:'projectNo',index:'projectNo',width:80},
	   		{name:'version',index:'version',width:53},
	   		{name:'typec',index:'typec',hidden:true},
			{name:'director',index:'director',width:80},
			{name:'dtrDptId',index:'dtrDptId',hidden:true},
	   		{name:'startDate',index:'startDate',width:90},
			{name:'endDate',index:'endDate',width:90},
	   		{name:'expectedTime',index:'expectedTime',width:90},
	   		{name:'des',index:'des',width:210},
			{name:'productId',index:'productId',hidden:true},
			{name:'productName',index:'productName',hidden:true},
			{name:'parentId',index:'parentId',hidden:true},
			{name:'parentName',index:'parentName',hidden:true}
	   	],
	   	pager:'#project_pg',
	   	treeGrid:true,
	   	ExpandColumn:'projectName',
	   	ExpandColClick:true,
	   	autowidth:true
	});
	
	$('#project_tb').jqGrid('navGrid','#project_pg',{addfunc:addDlg,editfunc:editDlg,delfunc:delDlg,view:true,search:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:false},{});
	
	$('#dtrDptId').change(function () {
		getMgrs('#director', this);
	});
	
	getDpts('#dtrDptId');
		
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:730,
		   buttons: {
			  "添加": addProject,
			  "提交": editProject,
			  "取消": function() {$(this).dialog('close')}}
		 });
	
	$("#gConsole").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:180,
		   buttons: {
		      "删除": delProject,
			  "取消": function() {$(this).dialog('close')}
			  }
	});
	
	var validator = $('#projectForm').validate({
		rules:{projectNo:"required",projectName:"required",startDate:"required",endDate:"required",dtrDptId:"required",director:"required",version:"required",expectedTime:{required:true,number:true},des:"required"},
		messages:{projectNo:"编号不能为空",projectName:"名称不能为空",startDate:"开始时间不能为空",endDate:"结束时间不能为空",dtrDptId:"主管部门不能空",director:"主管不能空",version:"版本不能空",expectedTime:{required:"预计工时不能为空",number:"工时只能是数字"},des:"描述说明不能为空"},
		errorPlacement:function(error, element) {
			if(element.is(":radio")) error.appendTo(element.parent().parent().next().next());
			else if(element.is(":checkbox")) error.appendTo(element.next());
			else error.appendTo(element.parent());
		},
		invalidHandler:function(e, validator) {
			var errors = validator.numberOfInvalids();
			if(errors) {
				var message = errors == 1 ? '高亮显示的栏位为空，请填写完后再提交' : '你有 ' + errors + ' 栏位为空或有误.  请按错误提示来更正';
				$("dd span.error_msg").html(message);
				$("dd span.error_msg").show();
			}else {
				$("dd span.error_msg").hide();
			}
		},
		submitHandler:function() {
			$("dd span.error_msg").hide();
		},
		success:function(label) {label.html(" ").addClass("checked");}
  }); 
}); 

var addDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('添加')").show();
	 dlg.dialog("option","title","添加新项目");
	 dlg.find('#projectForm')[0].reset();
	 var selectrow = $("#project_tb").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
		 var rd = $('#project_tb').jqGrid("getRowData", selectrow);
		 if(rd.type == "Project"){showModule(dlg,rd);dlg.dialog("option","title","添加新模块");if(rd.id) dlg.find('#project').empty().append("<option value='" + rd.id + "'>" + rd.projectName + "</option>").attr("disabled","disabled");} else {showProject(dlg,rd);getProducts(dlg.find('#productId'));}
	  } else {showProject(dlg,rd);getProducts(dlg.find('#productId'));}
	 
	 dlg.find("#dd_type").show();
	 getDpts('#dtrDptId');
	 dlg.find('#director').empty();
	 dlg.dialog('open');
};

var editDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('提交')").show();
	 
	 var selectrow = $("#project_tb").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	   var rd = $('#project_tb').jqGrid("getRowData", selectrow);
	   dlg.dialog("option","title","编辑 － " + rd.projectName);
	   
	   dlg.find('#dtrDptId').val(rd.dtrDptId);
	   dlg.find('#id').val(rd.id);
	   dlg.find('#projectNo').val(rd.projectNo);
	   dlg.find('#type').val(rd.type);
	   dlg.find('#projectName').val(rd.projectName);
	   dlg.find('#version').val(rd.version);
	   if(rd.director) dlg.find('#director').empty().append("<option value='" + rd.director + "'>" + rd.director + "</option>");
	   dlg.find('#member').val(rd.member);
	   dlg.find('#startDate').val(rd.startDate);
	   dlg.find('#endDate').val(rd.endDate);
	   dlg.find('#actualEnd').val(rd.actualEnd);
	   dlg.find('#expectedTime').val(rd.expectedTime);
	   dlg.find('#actualTime').val(rd.actualTime);
	   dlg.find('#des').val(rd.des);
	   if(rd.type == "Module") {
		   showModule(dlg,rd);
		   if(rd.parentName) dlg.find('#project').empty().append("<option value='" + rd.parentId + "'>" + rd.parentName + "</option>").attr("disabled","disabled");
	   } else {
		   showProject(dlg,rd);
		   dlg.find('#productId').empty().append("<option value='" + rd.productId + "'>" + rd.productName + "</option>").attr("disabled","disabled");
	   }
	   
	   dlg.dialog('open');
	 }
};

var addProject = function() {
	 var dlg = $('#content_main');
	 dlg.find('#type').removeAttr("disabled");
	 dlg.find('#productId').removeAttr("disabled");
	 dlg.find('#id').val("");
	if($("#projectForm").valid()) {
		$.post('save_project.htm',dlg.find("#projectForm").serialize(),function(data){
		if(data.result == "SUCCESS") {
			$("#project_tb").jqGrid("addRowData", data.project.id, data.project, "first");
			alert("添加成功！");
		    dlg.dialog("close");
		} 
		else if(data.result == "UNSUPPORT") alert("项目编号或项目名称已经存在！");
		else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		else alert("添加操作失败！");
	},'json');
	}else return false;
};

var editProject = function() {
  var dlg = $('#content_main');
  dlg.find('#type').removeAttr("disabled");
  if($("#projectForm").valid()) {
	  $.post('save_project.htm',dlg.find("#projectForm").serialize(),function(data){
		 if(data.result == "SUCCESS") {
          var p = data.project;
		  var dr = {id:p.id,type:p.type,projectName:p.projectName,projectNo:p.projectNo,version:p.version,typec:p.typec,director:p.director,dtrDptId:p.dtrDptId,startDate:p.startDate,endDate:p.endDate,expectedTime:p.expectedTime,des:p.des};
		  $("#project_tb").jqGrid("setRowData", p.id, dr, {color:"#FF0000"});
		  alert(dr.projectName + " －  操作成功！");
		  dlg.dialog("close");
		  }
		  else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		  else alert("操作失败！");
		},'json');
  }
};
var delDlg = function() {
	var dlg = $("#gConsole");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('删除')").show();
	dlg.dialog("option","title","删除").dialog('open');
};
var delProject = function() {
	 var dlg = $("#gConsole");
	 var tid;
	 tid = jQuery("#project_tb").jqGrid('getGridParam','selrow');
	 if(tid) {
	    $.post('del_project.htm',{'id':tid},function(data){
		  if(data.result=="SUCCESS") {
		    $('#project_tb').jqGrid("delRowData",tid);
			dlg.dialog("close");
			alert("删除成功！");
		  }else alert("删除操作失败！");
		},'json');
	  }else alert("请选择需要删除的条目！");
};
function showProject(dlg,rd) {
  dlg.find("#lab_pNo").html("项目编号：");
  dlg.find("#lab_pName").html("项目名称：");
  dlg.find("dd.module").hide();
  dlg.find("dd.project").show();
  dlg.find('#type').val("Project").attr("disabled","disabled");
}
function showModule(dlg,rd) {
	dlg.find('#parentId').val(rd.id);
	dlg.find("#lab_pNo").html("模块编号：");
	dlg.find("#lab_pName").html("模块名称：");
	dlg.find("#lab_dtr").html("模块主管：");
    dlg.find('#type').val("Module").attr("disabled","disabled");
	dlg.find("dd.module").show();
	dlg.find("dd.project").hide();
}