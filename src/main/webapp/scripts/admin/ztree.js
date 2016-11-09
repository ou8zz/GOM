var colNames_cn = ['目录名','显示标题','路径','职务','角色','菜单类型','ID','图标','节点','菜单类型'];
var colNames_tw = ['目錄名','顯示標題','路徑','職務','角色','菜單類型','ID','圖標','節點','菜單類型'];
var caption = {zh: "全局配置", "zh_CN": "全局配置", "zh_TW": "全局配置"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
	$.fn.zTree.init($("#menu"), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	
	//图标上传
	$('#icon').uploadify({
		  'uploader':'../common/uploadify.swf',
		  'script':'../upload.htm',
		  'cancelImg':'/images/cancel.png',
		  'fileExt':'*.png;*.gif;*.jpg',
		  'fileDesc':'只允许上传(.png, .gif, .jpg)',
		  'sizeLimit':102400,
		  'buttonImg':'../images/browse.jpg',
		  'displayData':'speed',
		  'expressInstall':'../common/expressInstall.swf',
		  'auto':true,
		  'onComplete':function(event,ID,fileObj,response,data) {
			  var obj = $.parseJSON(response);
			  $('#ico').val(obj.fileName);
		  },
		  'onError':function(event, queueID, fileObj) {
			  alert("文件:" + fileObj.name + "上传失败！");
		  }
	 });
	
	//显示所有信息
	jQuery("#ztree_tb").jqGrid({
	   	url:'get_ztrees.htm',
	   	treedatatype: "xml",
	   	treeGridModel:'adjacency',
	   	mtype: "GET",
		height:'auto',
		width:793,
		caption: caption[lang],
		colNames: colNames[lang],
	   	colModel:[
	   		{name:'name',index:'name'},
	   		{name:'title',index:'title',width:203},
	   		{name:'url',index:'url',width:200},
	   		{name:'position',index:'position',width:80,align:"center"},
	   		{name:'role',index:'role',width:80,align:"center"},
	   		{name:'menuType',index:'menuType',width:80,align:"center",formatter:menuTypeFmt},
	   		{name:'id',index:'id',hidden:true},
	   	    {name:'ico',index:'ico',hidden:true},
	   		{name:'node',index:'node',hidden:true},
	   		{name:'menuType',index:'menuType',hidden:true}
	   	],
	   	pager: '#ztree_pg',
	   	sortname: 'id',
	   	treeGrid: true,
	   	ExpandColumn : 'name',
	   	ExpandColClick: true,
	   	autowidth: true
	});
	
	$('#ztree_tb').jqGrid('navGrid','#ztree_pg',{addfunc:addDlg,editfunc:editDlg,del:false,view:true,search:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:false},{});
	
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:730,
		   buttons: {
			  "添加": addZtree,
			  "提交": editZtree,
			  "取消": function() {$(this).dialog('close')}}
		 });
	
}); 

// 添加菜单弹出窗口
var addDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('添加')").show();
	 dlg.dialog("option","title","添加新节点");
	 
	 dlg.find('#ztreeForm')[0].reset();
	 dlg.find('#ztreeForm').find("input[type=hidden]").val('');
	 
	 var selectrow = $("#ztree_tb").jqGrid("getGridParam", "selrow");
	 if(selectrow != null) {
		 var rd = $('#ztree_tb').jqGrid("getRowData", selectrow);
		 if(confirm("您确定在 <"+rd.name+"> 下添加子类吗！")) {
			 dlg.dialog("option","title"," 在 <"+rd.name+"> 添加子类 ");
			 dlg.find('#pid').val(rd.id);
			 dlg.find('#node').val(rd.node);
		 } else {
			 dlg.find('#pid').val('');
			 dlg.find('#node').val('');
		 }
	 } 
	 dlg.dialog('open');
};

// 添加菜单项
var addZtree = function() {
	var dlg = $('#content_main');
	$.post('save_ztree.htm', $("#ztreeForm").serialize(), function(data) {
		if (data.result == "SUCCESS") {
			$("#ztree_tb").jqGrid("addRowData", data.ztree.id, data.ztree, "first");
			alert("添加成功！");
			dlg.dialog("close");
		} else if (data.result == "PARAM_EMPTY")
			alert("请填写完整后再提交！");
		else
			alert("添加操作失败！");
	}, 'json');
};

// 修改菜单弹出窗口
var editDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('提交')").show();
	  
	 var selectrow = $("#ztree_tb").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	 var rd = $('#ztree_tb').jqGrid("getRowData", selectrow);
	   dlg.dialog("option","title","编辑 － " + rd.name);
	   dlg.find('#id').val(rd.id);
	   dlg.find('#name').val(rd.name);
	   dlg.find('#title').val(rd.title);
	   dlg.find('#url').val(rd.url);
	   dlg.find('#ico').val(rd.ico);
	   dlg.find('#node').val(rd.node);
	   dlg.find('#position').val(rd.position);
	   dlg.find('#role').val(rd.role);
	   dlg.find('#menuType').val(rd.menuType);
	   dlg.dialog('open');
	 }
};

//提交修改
var editZtree = function() {
	var dlg = $('#content_main');
	var dr = {
		id : $.trim(dlg.find("#id").val()),
		name : $.trim(dlg.find("#name").val()),
		title : $.trim(dlg.find("#title").val()),
		url : $.trim(dlg.find("#url").val()),
		ico : $.trim(dlg.find("#ico").val()),
		node : $.trim(dlg.find("#node").val()),
		position : $.trim(dlg.find("#position").val()),
		role : $.trim(dlg.find("#role").val()),
		menuType : $.trim(dlg.find("#menuType").val())
	};
	// 提交
	$.post('save_ztree.htm', $("#ztreeForm").serialize(), function(data) {
		if (data.result == "SUCCESS") {
			$("#ztree_tb").jqGrid("setRowData", dr.id, dr, {
				color : "#FF0000"
			});
			alert(dr.name + " －  操作成功！");
			dlg.dialog("close");
		} else if (data.result == "PARAM_EMPTY")
			alert("请填写完整后再提交！");
		else
			alert("操作失败！");
	}, 'json');
};

//菜单类型
function menuTypeFmt(cellvalue, options, rowObject){var tmp; if(cellvalue=="General") tmp="通用"; else if(cellvalue=="Custom") tmp="自定义";  return tmp;}
