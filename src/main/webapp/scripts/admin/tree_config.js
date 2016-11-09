var colNames_cn = ['ID','工号','中文名称','英文名称','性别','部门','职务'];
var colNames_tw = ['ID','工號','中文名稱','英文名稱','性別','部門','職務'];
var caption = {zh: "用户定制列表", "zh_CN": "用户定制列表", "zh_TW": "用戶定制列表"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
	$.fn.zTree.init($("#menu"), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
		
	//显示所有用户信息
	$("#zgrid").jqGrid({
	    url:'../get_users.htm',
	    datatype:'json',
		mtype:'GET',
		height: 'auto',
		caption: caption[lang],
	    colNames: colNames[lang],
	    colModel:[ 
		  {name:'id',index:'id',hidden:true},
		  {name:'jobNo',index:'jobNo',width:158,align:"center",sortable:false},
		  {name:'ename',index:'ename',width:158,sortable:false},
		  {name:'cname',index:'cname',width:158,sortable:false}, 
		  {name:'gender',index:'gender',width:136,sortable:false,formatter:genderType},
		  {name:'department',index:'department'}, 
		  {name:'position',index:'position',width:158,sortable:false}
		  ],
		rowNum:10,
	    rowList:[10,30,50],
		pager:'#zpager',
		viewrecords:true,
		rownumbers:true, 
		rownumWidth:35,
		sortname:'ename',
		sortorder:'desc',
		grouping: true,
	   	groupingView: {
	   		groupField:['department'], 
	   		groupColumnShow : [false], 
	   		groupCollapse : true, 
	   		groupText : ['<b>{0}</b> - <b>{1} 条</b>'],
	   		groupOrder: ['desc'] 
		},
		prmNames:{search:'search'},
		jsonReader:{root:'list',repeatitems:false}
	});
	$('#zgrid').jqGrid('navGrid','#zpager',{add:false,editfunc:editDlg,del:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"Let's go!", multipleSearch:true},{});

	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:790,
		   buttons: {
			  "提交": editZtree,
			  "取消": function() {$(this).dialog('close')}}
	 });
	
	//全选按纽
	$("#allc").click(function() {
		var bool = false;
		if($(this).attr("checked")) bool = true;
		$("input:[name=treeid]").attr("checked", bool);
	});
	
}); 

//菜单显示弹出窗口
var editDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('提交')").show();
	  
	 var selectrow = $("#zgrid").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	   var rd = $('#zgrid').jqGrid("getRowData", selectrow);
	   dlg.dialog("option","title","编辑用户左侧菜单");
	   dlg.find('#uid').val(rd.id);
	   dlg.find("input:[name=treeid]").attr("checked", false);
	   dlg.find("#head_data").empty().append("<b>"+rd.cname+"("+rd.ename+")</b>  <span>"+rd.department+"</span> "+rd.position);
	   
	   $.post('../get_trees.htm',{uid:rd.id},function(data){
		   	var tbody = dlg.find("#tree_body");
		   	tbody.empty();
			$.each(data, function(i, t){
				var tn = "";
				var icon = "无";
				var inp = "";
				var tr_class="";
				
				if(t.node.split(".").length == 2) tn = "<i>&nbsp;&nbsp;&nbsp;</i>";
				else if(t.node.split(".").length == 3) tn = "<i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</i>";
				
				if(parseInt(t.node) == t.node) tn += "<i class='ui-icon treeclick ui-icon-triangle-1-s'></i>";
				else {
					tr_class = "tr_con";
					tn += "<i class='ui-icon ui-icon-radio-off'></i>";
					inp = "<input type='checkbox' onclick=closeBok(this) id='t"+t.id+"' name='treeid' value='"+t.id+"' />";
				}
				
//				if(t.ico != undefined) icon = "<img src='../uploads/images/"+t.ico+"' />";
				
				tbody.append("<tr class='"+tr_class+"' onclick='select(this,"+t.id+","+t.pid+")'><td>" + inp + "</td>" +
				 		"<td class='nob_l_r'>"+tn+t.name+"</td>" +
				 		"<td class='tbt'>"+t.title+"</td>" +
				 		"<td class='tbt'>"+t.url+"</td>" +
				 		"<td class='tbt'>"+icon+"</td> </tr>");
				
				if(t.user == 1 && t.url != "") tbody.find("#t"+t.id).attr("checked", true);
			});
			tbody.find("tr.tr_con").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
	   },'json');
	   
	   dlg.dialog('open');
	 }
};

//POST提交修改的菜单
var editZtree = function() {
	var dlg = $('#content_main');
	var ids = new Array();
	dlg.find("input[name=treeid]:checked").each(function(i){ ids[i] = $(this).val(); });  
	//提交
	$.post('save_treeConfig.htm', {uid:$.trim(dlg.find("#uid").val()), zid:ids}, function(data){
		if(data.result == "SUCCESS") {
			alert("操作成功！");
	        dlg.dialog("close");
		}
		else alert("操作失败！");
	},'json');
};

//点击TD触发radio选中事件
function select(obj,id,pid) {
//	$(obj).parent().children('tr').removeClass("ui-state-highlight")
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