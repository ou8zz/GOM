var colNames_cn = ['调休类型','假日/假期','调休日期','调休内容','ID','type','holidaysId'];
var colNames_tw = ['調休類型','假日/假期','調休日期','調休内容','ID','type','holidaysId'];
var caption = {zh: "调休", "zh_CN": "调休", "zh_TW": "調休"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};
    
$(function(){
	$.fn.zTree.init($("#menu"), setting);
	
	$("#dayoff, #workedon").datepicker({changeMonth:true,changeYear:true});
		
	//显示所有产品信息
	jQuery("#zgrid").jqGrid({
	   	url:'get_lieus.htm',
		datatype: "json",
		height:350,
		width:793,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   		{name:'type',index:'type1',width:100,formatter:typeFmt},
	   		{name:'dayoff',index:'dayoff',width:100,sortable:false},
	   		{name:'workedon',index:'workedon',width:100,sortable:false},
	   		{name:'explanation',index:'explanation',width:100,sortable:false},
	   		{name:'id',index:'id',hidden:true},
	   		{name:'type',index:'type',width:100,hidden:true},
	   		{name:'holidaysId',index:'holidaysId',width:100,hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#zpager',
	   	sortname:'id',
	    viewrecords: true,
	    rownumbers:true,
		rownumWidth:33,
	    sortorder:"asc",
		multiselect:false,
		jsonReader:{root:'list',repeatitems:false}
	});
	
	$('#zgrid').jqGrid('navGrid','#zpager',{addfunc:addDlg,editfunc:editDlg,del:false,search:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:false},{});
	
	//选择调休类型
	$("#type").change(function() {typeChange($(this).val());});
	
	//加载节假日
	$.get('../get_holidays.htm',function(data){
		 var option = $("#holidaysId").empty().append("<option value=''>选择假日</option>");
		 $.each(data, function(i, d){option.append("<option value='"+d.id+"'>"+d.name+"</option>");});
	},'json');
	
	//选择调休日期
	$("#workedon").change(function() {
		var dayoff = $("#dayoff").val();
		var workedon = $(this).val();
		if(isEmpty(dayoff)) {
			alert("请选择调休日期"); 
			$("#explan").html('&nbsp;');
			$("#explanation").val('');
			$(this).val('');
			return false;
		} else {
			$("#explan").html(dayoff + " TO " + workedon);
			$("#explanation").val(dayoff + " TO " + workedon);
		}
	});
	
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:700,
		   buttons: {
			  "添加": addLieu,
			  "提交": editLieu,
			  "取消": function() {$(this).dialog('close')}}
		 });
	
	//表单验证
	$("dd span.error_msg").hide();
	var validator = $('#lieuForm').validate({
		rules:{type:"required",dayoff:"required",workedon:{required: true}},
		messages:{type:"请选择类型",dayoff:"假期时间不能为空",workedon:"调休日期不能为空"},
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

var typeChange = function(val) {
	if(val == "COMMON") $("#dd_holidays").show();
	else {
		$("#dd_holidays").hide();
		$("#holidaysId").val('');
	}
};

var addDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('添加')").show();
	 dlg.dialog("option","title","调休");
	 dlg.find('#id').val('');
	 dlg.find("#explan").html('&nbsp;');
	 dlg.find('#lieuForm')[0].reset();
	 typeChange(dlg.find("#type").val());
	 dlg.find("label.error").remove();
	 $("dd span.error_msg").hide();
	 dlg.dialog('open');
};

var editDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('提交')").show();
	 dlg.find('#lieuForm')[0].reset();
	 dlg.find("label.error").remove();
	 $("dd span.error_msg").hide();
	 var selectrow = $("#zgrid").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	 var rd = $('#zgrid').jqGrid("getRowData", selectrow);
	   dlg.dialog("option","title","编辑");
	   dlg.find('#id').val(rd.id);
	   dlg.find('#type').val(rd.type);
	   dlg.find('#holidaysId').val(rd.holidaysId);
	   dlg.find('#dayoff').val(rd.dayoff);
	   dlg.find('#workedon').val(rd.workedon);
	   dlg.find('#explanation').val(rd.explanation);
	   dlg.find("#explan").html(rd.explanation);
	   typeChange(rd.type);
	   dlg.dialog('open');
	 }
};

var sub_count=0;
var addLieu = function() {
	sub_count++;
	var dlg = $('#content_main');
	var lf = dlg.find('#lieuForm');
	if (lf.valid() && sub_count==1) {
		if (!confirm("您确定要提交吗？")) { sub_count=0; return false; }
		
		if(lf.find("#type").val() == "COMMON" && isEmpty(lf.find("#holidaysId").val())) return false;
		$.post('save_lieu.htm', lf.serialize(), function(
				data) {
			if (data.result == "SUCCESS") {
				$("#zgrid").jqGrid("addRowData", data.lieu.id, data.lieu, "first");
				alert("添加成功！");
				dlg.dialog("close");
			} else if (data.result == "PARAM_EMPTY")
				alert("请填写完整后再提交！");
			else
				alert("添加操作失败！");
			sub_count=0;
		}, 'json');
	}
};

var editLieu = function() {
	var dlg = $('#content_main');
	var lf = dlg.find('#lieuForm');
	if (lf.valid()) {
		if(lf.find("#type").val() == "COMMON" && isEmpty(lf.find("#holidaysId").val())) return false;
		$.post('save_lieu.htm', lf.serialize(), function(
				data) {
			if (data.result == "SUCCESS") {
				$("#zgrid").jqGrid("setRowData", data.lieu.id,data.lieu, {color : "#FF0000"});
				alert("操作成功！");
				dlg.dialog("close");
			} else if (data.result == "PARAM_EMPTY")
				alert("验证错误，请检查数据是否正确");
			else
				alert("操作失败！");
		}, 'json');
	}
};
//调休类型格式化
function typeFmt(cellvalue, options, rowObject){
	var tmp;
	if(cellvalue=="COMMON") tmp="假日";
	else if(cellvalue=="USER") tmp="请假";
	return tmp;
}
