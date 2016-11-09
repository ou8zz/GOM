var colNames_cn = ['ID','分类名','层级'];
var colNames_tw = ['ID','分類名','層級'];
var caption = {zh: "分类信息", "zh_CN": "分类信息", "zh_TW": "分類信息"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
	$.fn.zTree.init($("#menu"), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	
	//显示所有用户信息
	jQuery("#cate_tb").jqGrid({
	   	url:'get_category.htm',
		datatype: "xml",
		treeGridModel:'adjacency',
		height:'auto',
		width:790,
		caption: caption[lang],
	   	colNames:colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   		{name:'name',index:'name',width:60},
	   		{name:'num',index:'num',width:60}
	   	],
	   	pager: '#cate_pg',
	    sortorder: "desc",
		multiselect: false,
		treeGrid: true,
	   	ExpandColumn : 'name',
	   	ExpandColClick: true,
	   	autowidth: true
	});
	
	$('#cate_tb').jqGrid('navGrid','#cate_pg',{addfunc:addDlg,editfunc:editDlg,delfunc:delDlg,search:false,alerttext:"请选择需要操作的数据行!@"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:false},{});
	
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:450,
		   buttons: {
			  "添加": addCate,
			  "提交": editCate,
			  "取消": function() {$(this).dialog('close')}}
	 });
	
	$("#gConsole").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:180,
		   buttons: {
		      "删除": delCate,
			  "取消": function() {$(this).dialog('close')}
			  }
		 }); 
}); 

var addDlg = function() {
	var dlg = $("#content_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('添加')").show();
	dlg.dialog("option","title","添加资源分类");
	
	dlg.find('#id').val('');
	dlg.find('#name').val('');
	dlg.find("#dd_path").show();
	
	$.post('../get_ctree.htm',function(data){
		var path = dlg.find('#path').empty().append("<option value=''>/</option>");
		if(!isEmpty(data)) {
			$.each(data, function(i, c) {
				var nbsp = "";
				var node = c.node.split(".").length;
				for(var i=1; i<node; i++) {nbsp += "&nbsp;&nbsp;&nbsp;";}
				path.append("<option value='"+c.id+"'>"+nbsp+c.name+"</option>");
			});
		}
	 },'json');
	 dlg.dialog('open');
};

var editDlg = function() {
	var dlg = $("#content_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('提交')").show();
	  
	var selectrow = $("#cate_tb").jqGrid("getGridParam", "selrow");
	if(selectrow) {
	var rd = $('#cate_tb').jqGrid("getRowData", selectrow);
	   dlg.dialog("option","title","编辑 － " + rd.name);
	   dlg.find('#id').val(rd.id);
	   dlg.find('#name').val(rd.name);
	   $("#dd_path").hide();
	   dlg.dialog('open');
	}
};

var addCate = function() {
	var dlg = $('#content_main');
	var params = {id:$.trim(dlg.find("#id").val()),
		name:$.trim(dlg.find("#name").val()),
		pid:$.trim(dlg.find("#path").val())
	};
	
	//验证方法
	if(isEmpty(params.name)) {
		alert("请至少输入目录名");
		return false;
	}
	$.post('save_category.htm',params,function(data){
		if(data.result == "SUCCESS") {
	    	$("#cate_tb").jqGrid("addRowData", params.id, params, "first");
			alert("添加成功！");
	        dlg.dialog("close");
		}
		else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		else alert("添加失败！");
	},'json');
};

var editCate = function() {
	var dlg = $('#content_main');
	var params = {id:$.trim(dlg.find("#id").val()),
		name:$.trim(dlg.find("#name").val()),
		pid:$.trim(dlg.find("#path").val())
	};
	//验证方法
	if(isEmpty(params.name)) {
		alert("请至少输入目录名");
		return false;
	}
	$.post('save_category.htm',params,function(data){
		if(data.result == "SUCCESS") {
			var dr = {name:params.name,path:params.path};
		    $("#cate_tb").jqGrid("setRowData", params.id, dr, {color:"#FF0000"});
			alert(dr.name + " －  操作成功！");
	        dlg.dialog("close");
		}
		else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		else alert("操作失败！");
	},'json');
};

var delDlg = function() {
	var dlg = $("#gConsole");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('删除')").show();
	dlg.dialog("option","title","删除").dialog('open');
};

var delCate = function() {
	var dlg = $("#gConsole");
	var tid = jQuery("#cate_tb").jqGrid('getGridParam','selrow');
	if(tid) {
		$.post('del_category.htm',{'id':tid},function(data){
			if(data.result=="SUCCESS") {
				$('#cate_tb').jqGrid("delRowData",tid);
				dlg.dialog("close");
				alert("删除成功！");
			}
			else alert("删除操作失败！");
		},'json');
	}
	else alert("请选择需要删除的条目！");
};

