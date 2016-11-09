var msg_cn = {funcode:{required:"功能代码不能为空！", minlength:"请至少输入3个以上字符！"}, name:{required:"责任名称不能为空！", minlength:"请至少输入4个以上字符！"}, explanation:{required:"分配说明不能为空！", minlength:"请至少输入5个以上字符！"}};
var msg_tw = {funcode:{required:"功能代碼不能為空！", minlength:"請至少輸入3個以上字符！"}, name:{required:"責任名稱不能為空！", minlength:"請至少輸入4個以上字符！"}, explanation:{required:"分配說明不能為空！", minlength:"請至少輸入5個以上字符！"}};
var colNames_cn = ['ID','功能代码','责任名称','责任说明'];
var colNames_tw = ['ID','功能代碼','責任名稱','責任說明'];
var caption = {zh: "责任管理", "zh_CN": "责任管理", "zh_TW": "責任管理"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
	$.fn.zTree.init($('#menu'), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	
	//显示所有信息
	initGrid("get_responsibility.htm");
	
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:710,
		   buttons: {
			  "添加": addResp,
			  "提交": editResp,
			  "取消": function() {$(this).dialog('close')}}
	});
	
	//Form 验证字段内容
	$("#respForm").validate({  
		rules : {  
			"funcode":{required:true, minlength:3},  
	        "name":{required:true, minlength:4},  
	        "explanation":{required:true, minlength:5}  
	    },
	    onkeyup:false,
		messages : {
			funcode:{required:"功能代码不能为空！", minlength:"请至少输入3个以上字符！"},
			name:{required:"责任名称不能为空！", minlength:"请至少输入4个以上字符！"},
			explanation:{required:"责任说明不能为空！", minlength:"请至少输入5个以上字符！"}
		}
	});  
}); 

var initGrid = function(url) {
	jQuery("#zgrid").jqGrid({
	   	url:url,
	   	treedatatype: "xml",
	   	treeGridModel:'adjacency',
	   	mtype: "POST",
		height:'auto',
		width:793,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   		{name:'funcode',index:'funcode',width:123,sortable:false},
	   		{name:'name',index:'name',width:270,sortable:false},
			{name:'explanation',index:'explanation',width:400,sortable:false}
	   	],
	   	pager:'#zpager',
	   	sortname:'funcode',
	   	treeGrid: true,
		prmNames:{search:'search'},
	   	ExpandColumn:'funcode',
	   	ExpandColClick:true
	});
	
	$('#zgrid').jqGrid('navGrid','#zpager',{addfunc:addDlg,editfunc:editDlg,del:false,view:true,search:false,alerttext:"请选择需要操作的数据行!@"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:false},{});
};

//添加责任弹出框
var addDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('添加')").show();
	 dlg.dialog("option","title","添加责任管理");
	 dlg.find("label.error").hide();
	 dlg.find('#id').val('');
	 dlg.find('#funcode').val('');
	 dlg.find('#name').val('');
	 dlg.find('#explanation').val('');
	 dlg.dialog('open');
};

//添加方法提交
var addResp = function() {
	 var dlg = $('#content_main');
	 var srcrowid = $("#zgrid").jqGrid("getGridParam","selrow");
	 var params;
	 if(srcrowid) {
	   var rd = $('#zgrid').jqGrid("getRowData", srcrowid);
	   params = {parentId:rd.id,funcode:$.trim(dlg.find("#funcode").val()),name:$.trim(dlg.find("#name").val()),explanation:$.trim(dlg.find("#explanation").val())};
	 }else {
		 params = {funcode:$.trim(dlg.find("#funcode").val()),name:$.trim(dlg.find("#name").val()),explanation:$.trim(dlg.find("#explanation").val())};
	 }
	 
	 // 手工验证表单, 使用验证插件的valid()方法  
	 if (dlg.find("#respForm").valid()) {
		 $.post('../save_responsibility.htm',params,function(data){
		     if(data.result == "SUCCESS") {
				 var dataRow = {id:data.resp.id,funcode:data.resp.funcode,name:data.resp.name,explanation:data.resp.explanation};
				 if(srcrowid) $("#zgrid").jqGrid("addRowData", dataRow.id, dataRow, "before", srcrowid);
				 else {$("#zgrid").jqGrid("addRowData", dataRow.id, dataRow, "first");}
				 alert(data.resp.name + " － 新增成功！");
		        dlg.dialog("close");
			  }
			 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
			 else alert("添加失败！");
		 },'json');
	 }
};

var editDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('提交')").show();
	 dlg.find("label.error").hide();
	 
	 var selectrow = $("#zgrid").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	   var rd = $('#zgrid').jqGrid("getRowData", selectrow);
	   dlg.dialog("option","title","编辑 － " + rd.name);
	   dlg.find('#id').val(rd.id);
	   dlg.find('#funcode').val(rd.funcode);
	   dlg.find('#name').val(rd.name);
	   dlg.find('#explanation').val(rd.explanation);
	   
	   dlg.dialog('open');
	 }
};

var editResp = function() {
	var dlg = $('#content_main');
	var params = {id:$.trim(dlg.find("#id").val()),
		funcode:$.trim(dlg.find("#funcode").val()),
		name:$.trim(dlg.find("#name").val()),
		explanation:$.trim(dlg.find("#explanation").val())
	};
	
	// 手工验证表单, 使用验证插件的valid()方法  
	if (dlg.find("#respForm").valid()) {
		$.post('../save_responsibility.htm',params,function(data){
			 if(data.result == "SUCCESS") {
				 var dr = {funcode:params.funcode,name:params.name,explanation:params.explanation};
			     $("#zgrid").jqGrid("setRowData", params.id, dr, {color:"#FF0000"});
			     alert(dr.name + " －  操作成功！");
			     dlg.dialog("close");
			 }
			 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
			 else alert("操作失败！");
		},'json'); 
	}
};
