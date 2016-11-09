var colNames_cn = ['ID','节假名称','开始时间','结束时间','天数'];
var colNames_tw = ['ID','節假名稱','開始時間','結束時間','天數'];
var caption = {zh: "节假日期", "zh_CN": "节假日期", "zh_TW": "節假日期"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
	$.fn.zTree.init($("#menu"), setting);
	
	$("#startDate, #endDate").datepicker({changeMonth:true,changeYear:true});
    
	//显示所有产品信息
	jQuery("#zgrid").jqGrid({
	   	url:'get_holidays.htm',
		datatype: "json",
		height:350,
		width:793,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   		{name:'name',index:'name',width:100},
	   		{name:'startDate',index:'startDate',width:100,sortable:false},
	   		{name:'endDate',index:'endDate',width:100,sortable:false},
	   		{name:'days',index:'days',width:100}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#zpager',
	   	sortname:'name',
	    viewrecords: true,
	    rownumbers:true,
		rownumWidth:33,
	    sortorder:"desc",
		multiselect:false,
		jsonReader:{root:'list',repeatitems:false}
	});
	
	$('#zgrid').jqGrid('navGrid','#zpager',{addfunc:addDlg,editfunc:editDlg,del:false,search:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:false},{});
	
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:700,
		   buttons: {
			  "添加": addHolidays,
			  "提交": editHolidays,
			  "取消": function() {$(this).dialog('close')}}
		 });
	
	//表单验证
	$("dd span.error_msg").hide();
	var validator = $('#holidaysForm').validate({
		rules:{name:"required",startDate:"required",endDate:"required",days:{"required":true, "number":true}},
		messages:{name:"名称不能为空",startDate:"开始时间不能为空",endDate:"结束时间不能为空",days:{"required":"天数不能为空", "number":"天数只能是数字"}},
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
	 dlg.dialog("option","title","添加节假日");
	 dlg.find('#id').val('');
	 dlg.find('#holidaysForm')[0].reset();
	 dlg.find("label.error").remove();
	 $("dd span.error_msg").hide();
	 dlg.dialog('open');
};

var editDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('提交')").show();
	 dlg.find('#holidaysForm')[0].reset();
	 dlg.find("label.error").remove();
	 $("dd span.error_msg").hide();
	 var selectrow = $("#zgrid").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	 var rd = $('#zgrid').jqGrid("getRowData", selectrow);
	   dlg.dialog("option","title","编辑 － " + rd.name);
	   dlg.find('#id').val(rd.id);
	   dlg.find('#name').val(rd.name);
	   dlg.find('#startDate').val(rd.startDate);
	   dlg.find('#endDate').val(rd.endDate);
	   dlg.find('#days').val(rd.days);
	   dlg.dialog('open');
	 }
};

var addHolidays = function() {
	var dlg = $('#content_main');
	var hf = dlg.find('#holidaysForm');
	if (hf.valid()) {
		$.post('save_holidays.htm', $("#holidaysForm").serialize(), function(
				data) {
			if (data.result == "SUCCESS") {
				$("#zgrid").jqGrid("addRowData", data.holidays.id,
						data.holidays, "first");
				alert("添加成功！");
				dlg.dialog("close");
			} else if (data.result == "PARAM_EMPTY")
				alert("请填写完整后再提交！");
			else
				alert("添加操作失败！");
		}, 'json');
	}
};

var editHolidays = function() {
	var dlg = $('#content_main');
	if ($('#holidaysForm').valid()) {
		$.post('save_holidays.htm', $("#holidaysForm").serialize(), function(
				data) {
			if (data.result == "SUCCESS") {
				$("#zgrid").jqGrid("setRowData", data.holidays.id,
						data.holidays, {
							color : "#FF0000"
						});
				alert(data.holidays.name + " － 操作成功！");
				dlg.dialog("close");
			} else if (data.result == "PARAM_EMPTY")
				alert("请填写完整后再提交！");
			else
				alert("操作失败！");
		}, 'json');
	}
};
