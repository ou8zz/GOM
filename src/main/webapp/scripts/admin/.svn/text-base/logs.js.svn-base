var msg_cn = {type:{required:"请选择类型！"},logger:{required:"请输入日志！"},level:{required:"请输入级别！"},message:{required:"日志不能为空！"}};
var msg_tw = {type:{required:"請選擇類型！"},logger:{required:"請輸入日誌！"},level:{required:"請輸入級別！"},message:{required:"日誌不能為空！"}};
var colNames_cn = ['ID','类型','日期','日志','级别','类型DATA','日志内容'];
var colNames_tw = ['ID','類型','日期','日誌','級別','類型DATA','日誌內容'];
var caption = {zh: "日志列表", "zh_CN": "日志列表", "zh_TW": "日誌列表"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};
    
var editor;
$(function(){
	$.fn.zTree.init($("#menu"), setting);
	
	//显示所有日志信息
	jQuery("#zgrid").jqGrid({
	   	url:'get_logs.htm',
		datatype: "json",
		height:'auto',
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   		{name:'type',index:'type',width:150,align:"center",sortable:false,formatter:logTypeFmt},
	   		{name:'dated',index:'dated',width:180,align:"center"},
	   		{name:'logger',index:'logger',width:300,align:"center",sortable:false},
	   		{name:'level',index:'level',width:107,align:"center"},
	   		{name:'type',index:'type',hidden:true},
	   		{name:'message',index:'message',hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#zpager',
	   	sortname: 'id',
	    viewrecords: true,
	    rownumbers:true,
	    sortorder: "asc",
		multiselect: false,
		jsonReader:{root:'list',repeatitems:false}
	});
	
	$('#zgrid').jqGrid('navGrid','#zpager',{addfunc:addDlg,editfunc:editDlg,del:false,search:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:false},{});
	
	//Form 验证字段内容
	$("#logForm").validate({  
		rules : {  
			"type":{required:true},  
			"logger":{required:true},
			"level":{required:true},
			"message":{required:true}
	    },
	    onkeyup:false,
		messages : {
			type:{required:"请选择类型！"},
			logger:{required:"请输入日志！"},
			level:{required:"请输入级别！"},
			message:{required:"日志不能为空！"}
		}
	});
	
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:750,
		   buttons: {
			  "添加": addLog,
			  "提交": editLog,
			  "取消": function() {$(this).dialog('close')}}
		});
	
	//日志内容编辑器
	editor = KindEditor.create('textarea[name="message"]', {
		resizeType : 1,
		allowPreviewEmoticons : false,
		allowImageUpload : false,
		items : [
			'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
			'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'indent', 'outdent', 
			'subscript', 'superscript', 'insertorderedlist', 'insertunorderedlist', '|', 'fullscreen']
	});
	
}); 

//日志添加弹出窗
var addDlg = function() {
	var dlg = $("#content_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('添加')").show();
	dlg.dialog("option","title","添加日志");
	 
	dlg.find('#logForm')[0].reset();
	editor.html('');
	
	dlg.find('label.error').hide();
	dlg.dialog('open');
};

//修改弹出窗
var editDlg = function() {
	var dlg = $("#content_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('提交')").show();
	  
	var selectrow = $("#zgrid").jqGrid("getGridParam", "selrow");
	if (selectrow) {
		var rd = $('#zgrid').jqGrid("getRowData", selectrow);
		dlg.dialog("option", "title", "编辑日志");
		
		dlg.find('#id').val(rd.id);
		dlg.find('#type').val(rd.type);
		dlg.find('#logger').val(rd.logger);
		dlg.find('#level').val(rd.level);
		dlg.find('#message').val(rd.message);
		editor.html(rd.message);
		
		dlg.find('label.error').hide();
		dlg.dialog('open');
	}
};

//添加日志
var addLog = function() {
	var dlg = $('#content_main');
	dlg.find("#message").val(editor.html());
	
	// 验证表单如果通过则提交
	if (dlg.find("#logForm").valid()) {
		$.post('save_log.htm', dlg.find("#logForm").serialize(),
				function(data) {
					if (data != null && data.result == "SUCCESS") {
						$("#zgrid").jqGrid("addRowData", data.logs.id, data.logs, "first");
						alert("添加成功！");
						dlg.dialog("close");
					} 
					else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
					else if(data.result == "INVALID") alert("日志内容过长，请减少内容编辑再次提交！");
					else alert("添加操作失败！");
				}, 'json');
	}
};

//修改
var editLog = function() {
	var dlg = $('#content_main');
	dlg.find("#message").val(editor.html());
	
	if (dlg.find("#logForm").valid()) {
		$.post('save_log.htm', dlg.find("#logForm").serialize(), function(data) {
			if (data != null && data.result == "SUCCESS") {
				$("#zgrid").jqGrid("setRowData", data.logs.id, data.logs, { color : "#FF0000" });
				alert("操作成功！");
				dlg.dialog("close");
			} 
			else if (data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
			else if(data.result == "INVALID") alert("日志内容过长，请减少内容编辑再次提交！");
			else alert("操作失败！");
		}, 'json');
	}
};
