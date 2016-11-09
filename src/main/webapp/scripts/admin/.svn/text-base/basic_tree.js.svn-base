var colNames_cn = ['目录名','显示标题','路径','职务','角色','菜单类型','ID','图标','节点','菜单类型'];
var colNames_tw = ['目錄名','顯示標題','路徑','職務','角色','菜單類型','ID','圖標','節點','菜單類型'];
var caption = {zh: "通用配置", "zh_CN": "通用配置", "zh_TW": "通用配置"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
	$.fn.zTree.init($("#menu"), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	
	//显示所有信息
	initGrid("get_ztrees.htm?isBasic=true");
	
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
	
	//点击选择checked 全选
	$("#allc").click(function() {
		var dlg = $('#tree_tab');
		if($(this).attr("checked")) dlg.find("input:[name=treeid]").attr("checked", true);
		else dlg.find("input:[name=treeid]").attr("checked", false);
	});
	
}); 

var initGrid = function(url) {
	jQuery("#ztree_tb").jqGrid({
	   	url:url,
	   	treedatatype: "xml",
	   	treeGridModel:'adjacency',
	   	mtype: "GET",
		height:'auto',
		width:793,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   		{name:'name',index:'name', width:150},
	   		{name:'title',index:'title',width:150,align:"center"},
	   		{name:'url',index:'url',width:200,align:"center"},
	   		{name:'position',index:'position',width:80,align:"center"},
	   		{name:'role',index:'role',width:80,align:"center"},
	   		{name:'menuType',index:'menuType',hidden:true},
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
	
	$('#ztree_tb').jqGrid('navGrid','#ztree_pg',{addfunc:editDlg,addtitle:"删除基础菜单",addicon:"ui-icon-minus",edit:false,del:false,view:true,search:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:false},{});
	//添加一个新添加按纽
	$("#ztree_tb").jqGrid('navButtonAdd','#ztree_pg',{caption: "", buttonicon:"ui-icon-plus", position:"first", title:"添加基础菜单", onClickButton:addDlg});

};

var addDlg = function() {
	var dlg = $("#content_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('添加')").show();
	dlg.dialog("option","title","通用菜单配置");
	
	$.post('../get_basic_tree.htm', {basic:false}, function(data){
	 	var tbody = dlg.find("#tree_body");
	 	tbody.empty();
		$.each(data, function(i, t){
			var tn = "";
			var icon = "无";
			var inp = " ";
			var tr_class="";
			
			if(t.node.split(".").length == 2) tn = "<i>&nbsp;&nbsp;&nbsp;</i>";
			else if(t.node.split(".").length == 3) tn = "<i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</i>";
			
//			if(t.url == "" || t.url == null) tn += "<i class='ui-icon treeclick ui-icon-triangle-1-s'></i>";
//			else tn += "<i class='ui-icon ui-icon-radio-off'></i>";
			
			if(parseInt(t.node) == t.node) tn += "<i class='ui-icon treeclick ui-icon-triangle-1-s'></i>";
			else {
				tr_class = "tr_con";
				tn += "<i class='ui-icon ui-icon-radio-off'></i>";
				inp = "<input type='checkbox' onclick=closeBok(this) id='t"+t.id+"' name='treeid' value='"+t.id+"' />";
			}
			
//			if(t.ico != undefined) icon = "<img src='../uploads/images/"+t.ico+"' />";
			
//			if(t.role != 'user' || t.url == "" || t.pid == undefined) {
				tbody.append("<tr class='"+tr_class+"' onclick='select(this,"+t.id+","+t.pid+")'><td>" + inp + "</td>" +
			 		"<td class='nob_l_r'>"+tn+t.name+"</td>" +
			 		"<td class='tbt'>"+t.title+"</td>" +
			 		"<td class='tbt'>"+t.url+"</td>" +
			 		"<td class='tbt'>"+icon+"</td> </tr>");
//			} 
		});
		tbody.find("tr.tr_con").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
 },'json');
 dlg.dialog('open');
}

var editDlg = function(ai) {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('提交')").show();
	 dlg.dialog("option","title","通用菜单配置");
	 
	 $.post('../get_basic_tree.htm', {basic:true},function(data){
		 	var tbody = dlg.find("#tree_body");
		 	tbody.empty();
			$.each(data, function(i, t){
				var tn = "";
				var icon = "无";
				var inp = " ";
				var tr_class="";
				
				if(t.node.split(".").length == 2) tn = "<i>&nbsp;&nbsp;&nbsp;</i>";
				else if(t.node.split(".").length == 3) tn = "<i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</i>";
				
//				if(t.url == "" || t.url == null) tn += "<i class='ui-icon treeclick ui-icon-triangle-1-s'></i>";
//				else tn += "<i class='ui-icon ui-icon-radio-off'></i>";
				
				if(parseInt(t.node) == t.node) tn += "<i class='ui-icon treeclick ui-icon-triangle-1-s'></i>";
				else {
					tr_class = "tr_con";
					tn += "<i class='ui-icon ui-icon-radio-off'></i>";
					inp = "<input type='checkbox' onclick=closeBok(this) id='t"+t.id+"' name='treeid' value='"+t.id+"' />";
				}
				
//				if(t.ico != undefined) icon = "<img src='../uploads/images/"+t.ico+"' />";
				
//				if(t.url == "" || t.pid == undefined) {
					tbody.append("<tr class='"+tr_class+"' onclick='select(this,"+t.id+","+t.pid+")'><td>"+inp+"</td>" +
				 		"<td class='nob_l_r'>"+tn+t.name+"</td>" +
				 		"<td class='tbt'>"+t.title+"</td>" +
				 		"<td class='tbt'>"+t.url+"</td>" +
				 		"<td class='tbt'>"+icon+"</td> </tr>");
					tbody.find("#t"+t.id).attr("checked", true);
//				}
			});
			tbody.find("tr.tr_con").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
	 },'json');
	 dlg.dialog('open');
};

var addZtree = function() {
	var dlg = $('#content_main');
	var ids = new Array();
	dlg.find("input[name=treeid]:checked").each(function(i){ ids[i] = $(this).val(); }); 
	
	if(ids.length < 1) {alert("请选择要添加的项"); return false;}
	
	//提交
	$.post('save_treeConfig.htm', {isAdd:true, zid:ids}, function(data){
		if(data.result == "SUCCESS") {
			alert("操作成功！");
			dlg.dialog("close");
			$("#ztree_tb").GridUnload();
			initGrid("get_ztrees.htm?isBasic=true");
		}
		else if(data.result == "PARAM_EMPTY") {
			 alert("基础菜单获取失败，请检查基础菜单用户完整性！");
		}
		else alert("操作失败！");
	},'json');
};

var editZtree = function() {
	var dlg = $('#content_main');
	var ids = new Array();
	dlg.find("input[name=treeid]:not(:checked)").each(function(i){ ids[i] = $(this).val(); });  

	if(ids.length < 1) {alert("请取消要移除的项"); return false;}

	//提交
	$.post('save_treeConfig.htm', {zid:ids}, function(data){
		if(data.result == "SUCCESS") {
			alert("操作成功！");
			dlg.dialog("close");
			$("#ztree_tb").GridUnload();
			initGrid("get_ztrees.htm?isBasic=true");
		} 
		else if(data.result == "PARAM_EMPTY") {
			 alert("基础菜单获取失败，请检查基础菜单用户完整性！");
		}
		else alert("操作失败！");
	},'json');
};


//点击TD触发radio选中事件
function select(obj,id,pid) {
//	$(obj).parent().children('tr.tr_con').removeClass("ui-state-highlight")
//	$(obj).addClass("ui-state-highlight");
	
	var tid = $("#t"+id);
	if(tid.attr("checked")) {
		tid.attr("checked",false);
		if(pid != undefined) {
			$("#t"+pid).attr("checked",false);
		}
	} else {
		tid.attr("checked",true);
		if(pid != undefined) {
			$("#t"+pid).attr("checked",true);
			//$(this).find(":checkbox").attr("checked",true);
		}
	}
}

function closeBok(obj){
	$(obj).attr('checked')?$(obj).attr('checked',false):$(obj).attr('checked',true);
}