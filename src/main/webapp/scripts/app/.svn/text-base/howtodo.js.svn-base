var colNames_cn = ['如何做ID','文件类型','版本','标题','创建日期','上传者','所属部门','如何做内容','文件ID'];
var colNames_tw = ['如何做ID','文件類型','版本','標題','創建日期','上傳者','所屬部門','如何做內容','文件ID'];
var caption = {zh: "如何做", "zh_CN": "如何做", "zh_TW": "如何做"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};
var editor;

$(function(){
	$.fn.zTree.init($("#menu"), setting);
	 
	//显示所有如何做
    initGrid('get_howtodos.htm');
    
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:700,
		   buttons: {
			  "添加": addHow,
			  "提交": editHow,
			  "取消": function() {$(this).dialog('close')}}
		 });
	
	//编辑器
	editor = KindEditor.create('textarea[name="gain"]', {
		resizeType : 1,
		allowPreviewEmoticons : false,
		allowImageUpload : false,
		items : [
			'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
			'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'indent', 'outdent', 
			'subscript', 'superscript', 'insertorderedlist', 'insertunorderedlist', '|', 'fullscreen']
	});
	
}); 

var initGrid = function(url) {
	jQuery("#how_tb").jqGrid({
	   	url:url,
		datatype:"json",
		height:350,
		width:793,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   		{name:'resourceType',index:'resourceType',align:"center",formatter:resourceTypefmt,sortable:false},
	   		{name:'version',index:'version',align:"center",sortable:false},
	   		{name:'title',index:'title',align:"center",sortable:false},
	   		{name:'createDate',index:'createDate',align:"center",sortable:false},
	   		{name:'uploadEname',index:'uploadEname',align:"center",sortable:false},
	   		{name:'maintainDpt',index:'maintainDpt',align:"center",sortable:false},
	   		{name:'howGain',index:'howGain',hidden:true},
	   		{name:'resourceId',index:'resourceId',hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager:'#how_pg',
	   	sortname:'id',
	    viewrecords:true,
	    rownumbers:true,
	    sortorder:"asc",  
		multiselect: false,
		jsonReader:{root:'list',repeatitems:false}
	});
	$('#how_tb').jqGrid('navGrid','#how_pg',{addfunc:addDlg,addtitle:"添加如何做",editfunc:editDlg,edittitle:"编辑如何做",del:false,view:true,search:true,alerttext:"请选择一条数据行!"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:false},{});
};

var addDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('添加')").show();
	 
	 //下拉框填充resourceType为How标题
	 $.post('select_resources.htm',{},function(data){
		 var res = data.resource;
		 dlg.find("#resource option").remove();
		 if(res.length == 0) dlg.find('#resource').append("<option value=''>没有如何做标题内容</option>");
		 for(var i=0; i<res.length; i++) {dlg.find('#resource').append("<option value='"+res[i].id+"'>"+res[i].title+"</option>");}
	 },'json');
	      
	 dlg.dialog("option","title","添加如何做");
	 dlg.find('#id').val('');
	 dlg.find('#resId').val('');
	 editor.html('');
	 dlg.dialog('open');
};
var addHow = function() {
	var dlg = $('#content_main');
	var params = {id:$.trim(dlg.find("#id").val()), resourceId:$.trim(dlg.find('#resource').val()), gain:editor.html()};
	
	if(isEmpty(params.gain)) {alert("不能添加空的内容！"); return false;}
	
	$.post('save_how.htm',params,function(data){
		if(data.result == "SUCCESS") {
			alert("添加成功！");
			$("#how_tb").GridUnload();
			initGrid('get_howtodos.htm');
	    	dlg.dialog("close");
		}
		else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		else alert("操作失败！");
	},'json');
};

var editDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('提交')").show();
	  
	 var selectrow = $("#how_tb").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	 var rd = $('#how_tb').jqGrid("getRowData", selectrow);
	 	dlg.dialog("option","title","如何做");
	 	dlg.find('#id').val(rd.id);
	 	dlg.find('#resId').val(rd.resourceId);
	 	dlg.find("#resource option").remove();
	 	dlg.find('#resource').append("<option value='"+rd.id+"'>"+rd.title+"</option>");
	 	editor.html(rd.howGain);
	 	//dlg.find('#gain').val(rd.howGain);
	 	dlg.dialog('open');
	 }
};
var editHow = function() {
	var dlg = $('#content_main');
	var params = {id:$.trim(dlg.find("#id").val()), resourceId:$.trim(dlg.find("#resId").val()), gain:editor.html()};
	
	if(isEmpty(params.gain)) {alert("不能添加空的内容！"); return false;}
	
	$.post('save_how.htm',params,function(data){
		if(data.result == "SUCCESS") {
			alert("操作成功！");
			$("#how_tb").GridUnload();
			initGrid('get_howtodos.htm');
	        dlg.dialog("close");
		 }
		 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		 else alert("操作失败！");
	},'json');
};

//格式化文件类型
function resourceTypefmt(cellvalue, options, rowObject) {
	var tmp;
	if(cellvalue=="MANUAL") tmp="手册";
	else if(cellvalue=="MATERIAL") tmp="教材";
	else if(cellvalue=="TECHNICAL") tmp="技术档";
	else if(cellvalue=="HOW") tmp="如何做";
	return tmp;
}
