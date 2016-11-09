var msg_cn = {tprogram:"项目不能为空",trainingTime:{required:"训练时数不能为空", number:"请正确输入小时数"},fee:{required:"上课费用不能空", number:"请正确输入费用"},qualification:"讲师资质不能空",startDate:"开始时间不能为空",endDate:"结束时间不能为空",tcontent:"内容不能空"};
var msg_tw = {tprogram:"項目不能為空",trainingTime:{required:"訓練時數不能為空", number:"請正確輸入小時數"},fee:{required:"上課費用不能空", number:"請正確輸入費用"},qualification:"講師資質不能空",startDate:"開始時間不能為空",endDate:"結束時間不能為空",tcontent:"內容不能空"};
var colNames_cn = ['ID','训练项目','讲师','培训类型','训练时数','上课费用','其它费用','开始日期','结束日期','讲师资质','内容','培训类型notfmt'];
var colNames_tw = ['ID','訓練項目','講師','培訓類型','訓練時數','上課費用','其它費用','開始日期','結束日期','講師資質','內容','培訓類型notfmt'];
var caption = {zh: "培训列表", "zh_CN": "培训列表", "zh_TW": "培訓列表"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
	$.fn.zTree.init($("#menu"), setting);
		
    $("#startDate").datepicker({changeMonth:true,changeYear:true,onSelect:function(selectedDate){$("#endDate").datepicker("option", "minDate", selectedDate)}});
    $("#endDate").datepicker({changeMonth:true,changeYear:true,onSelect:function(selectedDate){$("#startDate").datepicker("option", "maxDate", selectedDate)}});
    
    //显示所有培训信息
	jQuery("#training_tb").jqGrid({
	   	url:'get_trainings.htm',
		datatype: "json",
		width:793,
		height:430,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   		{name:'tprogram',index:'tprogram',width:90,align:"center",sortable:false},
	   		{name:'lecturer',index:'lecturer',width:60,align:"center",sortable:false},
	   		{name:'trainingType',index:'trainingType',width:60,align:"center",sortable:false,formatter:trainingTypefmt},
	   		{name:'trainingTime',index:'trainingTime',width:60,align:"center",sortable:false},
	   		{name:'fee',index:'fee',width:60,align:"center",sortable:false},
	   		{name:'otherFee',index:'otherFee',width:60,align:"center",sortable:false},
	   		{name:'startDate',index:'startDate',width:90,align:"center",sortable:false},
	   		{name:'endDate',index:'endDate',width:90,align:"center",sortable:false},
	   		{name:'qualification',index:'qualification',width:60,align:"center",sortable:false},
	   		{name:'tcontent',index:'tcontent',width:60,align:"center",sortable:false},
	   		{name:'trainingType',index:'trainingType',hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#training_pg',
	   	sortname: 'id',
	    viewrecords: true,
	    grouping:false,
	   	groupingView:{groupField : ['id']},
	    rownumbers:true,
	    sortorder:"asc",
		multiselect: false,
		jsonReader:{root:'list',repeatitems:false}
	});
	
	$('#training_tb').jqGrid('navGrid','#training_pg',{addfunc:addDlg,editfunc:editDlg,delfunc:delDlg,search:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:false},{});
	
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:680,
		   buttons: {
			  "添加": addTraining,
			  "提交": editTraining,
			  "取消": function() {$(this).dialog('close')}}
		 });
	
	$("#gConsole").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:180,
		   buttons: {
		      "删除": delTraining,
			  "取消": function() {$(this).dialog('close')}
			  }
		 }); 
	
	$("dd span.error_msg").hide();
	var validator = $('#trainingForm').validate({
		rules:{tprogram:"required",trainingTime:{required:true,number:true},fee:{required:true,number:true},otherFee:{required:true,number:true},qualification:"required",startDate:{required:true},endDate:{required:true},tcontent:"required"},
		messages:{tprogram:"项目不能为空",trainingTime:{required:"训练时数不能为空", number:"请正确输入小时数"},fee:{required:"上课费用不能空", number:"请正确输入费用"},otherFee:{required:"请输入费用如果没有请输入0", number:"请正确输入费用"},qualification:"讲师资质不能空",startDate:"开始时间不能为空",endDate:"结束时间不能为空",tcontent:"内容不能空"},
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
//添加弹出窗
var addDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('添加')").show();
	 dlg.dialog("option","title","添加培训");
	 dlg.find('#trainingForm')[0].reset();
	 dlg.find("label.error").remove();
	 $("dd span.error_msg").hide();
	 dlg.dialog('open');
};

var editDlg = function() {
	var dlg = $("#content_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('提交')").show();
	
	var selectrow = $("#training_tb").jqGrid("getGridParam", "selrow");
	if(selectrow) {
	var rd = $('#training_tb').jqGrid("getRowData", selectrow);
	   dlg.dialog("option","title","编辑 － " + rd.tprogram);
	   dlg.find('#id').val(rd.id);
	   dlg.find('#tprogram').val(rd.tprogram);
	   dlg.find('#lecturer').val(rd.lecturer);
	   dlg.find('#trainingType').val(rd.trainingType);
	   dlg.find('#trainingTime').val(rd.trainingTime);
	   dlg.find('#fee').val(rd.fee);
	   dlg.find('#otherFee').val(rd.otherFee);
	   dlg.find('#startDate').val(rd.startDate);
	   dlg.find('#endDate').val(rd.endDate);
	   dlg.find('#qualification').val(rd.qualification);
	   dlg.find('#tcontent').val(rd.tcontent);
	   dlg.find("label.error").remove();
	   $("dd span.error_msg").hide();
	   dlg.dialog('open');
	}
};

var addTraining = function() {
	var dlg = $('#content_main');
	var f = dlg.find("#trainingForm");
	if(f.valid()) {
		$.post('save_training.htm',f.serialize(),function(data){
			if(data.result == "SUCCESS") {
				$("#training_tb").jqGrid("addRowData", data.training.id, data.training, "first");
				alert(data.training.tprogram + " － 添加成功！");
		        dlg.dialog("close");
			}
			else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
			else alert("添加操作失败！");
		},'json');
	}
};

var editTraining = function() {
	var dlg = $('#content_main');
	var f = dlg.find("#trainingForm");
	if(f.valid()) {
		$.post('save_training.htm',f.serialize(),function(data){
			if(data.result == "SUCCESS") {
				$("#training_tb").jqGrid("setRowData", data.training.id, data.training, {color:"#FF0000"});
				alert(data.training.tprogram + " －  操作成功！");
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

var delTraining = function() {
	var tid = jQuery("#training_tb").jqGrid('getGridParam','selrow');
	if(tid) {
		$.post('del_training.htm',{'id':tid},function(data){
			if(data.result=="SUCCESS") {
				$('#training_tb').jqGrid("delRowData", tid);
				$("#gConsole").dialog("close");
				alert("删除成功！");
			}
			else alert("删除操作失败！");
		},'json');
	}
	else alert("请选择需要删除的条目！");
};

//培训类型格式化
function trainingTypefmt(cellvalue, options, rowObject){
	var tmp;
	if(cellvalue=="INTERNAL") tmp="内训";
	else if(cellvalue=="EXTERNAL") tmp="外训";
	else if(cellvalue=="SELF_TRAINING") tmp="自训";
	return tmp;
}
