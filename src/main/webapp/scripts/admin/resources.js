var colNames_cn = ['ID','是否有效','文件类型','标准编号','版本','标题','创建日期','上传日期','更新日期','上传者','所属部门','说明','附件','文件类型','是否有效','路径'];
var colNames_tw = ['ID','是否有效','文件類型','標準編號','版本','標題','創建日期','上傳日期','更新日期','上傳者','所屬部門','說明','附件','文件類型','是否有效','路徑'];
var caption = {zh: "文件管理", "zh_CN": "文件管理", "zh_TW": "文件管理"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};
	

$(function(){
	$.fn.zTree.init($("#menu"), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	
	//文件上传
	$('#att').uploadify({
		  'uploader':'../common/uploadify.swf',
		  'script':'../upload.htm',
		  'cancelImg':'../images/cancel.png',
		  'fileExt':'*.jpg;*.gif;*.png;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;*.swf;',
		  'fileDesc':'您可以上传(JPG,PNG,GIF,DOC,XLS,PPT)小于4M的文件！',
		  'sizeLimit':409600,
		  'buttonImg':'../images/browse.jpg',
		  'displayData':'speed',
		  'expressInstall':'../common/expressInstall.swf',
		  'auto':true,
		  'onComplete':function(event,ID,fileObj,response,data) {
			  var obj = $.parseJSON(response);
			  $('#attachment').attr("value",obj.fileName);
		  },
		  'onError':function(event, queueID, fileObj) {alert("文件:" + fileObj.name + "上传失败！");}
		});
	
	//显示信息
	jQuery("#res_tb").jqGrid({
	   	url:'get_resources.htm',
		datatype:"json",
		height:450,
		width:793,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   	    {name:'isValid',index:'isValid',width:60,align:"center",formatter:validfmt},
	   		{name:'resourceType',index:'resourceType',width:60,align:"center",formatter:resourceTypefmt},
	   		{name:'number',index:'number',width:60,align:"center"},
	   		{name:'version',index:'version',width:60,align:"center"},
	   		{name:'title',index:'title',width:60,align:"center"},
	   		{name:'createDate',index:'createDate',width:80,align:"center"},
	   		{name:'uploadDate',index:'uploadDate',width:80,align:"center"},
	   		{name:'updateDate',index:'updateDate',width:80,align:"center"},
	   		{name:'uploadEname',index:'uploadEname',width:60,align:"center"},
	   		{name:'maintainDpt',index:'maintainDpt',width:60,align:"center"},
	   		{name:'des',index:'des',hidden:true},
	   		{name:'attachment',index:'attachment',hidden:true},
	   		{name:'resourceType',index:'resourceType',hidden:true},
	   		{name:'isValid',index:'isValid',hidden:true},
	   		{name:'path',index:'path',hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10],
	   	pager:'#res_pg',
	   	sortname:'id',
	    viewrecords:true,
	    rownumbers:true,
	    sortorder:"asc",  
		multiselect: true,
		jsonReader:{root:'list',repeatitems:false}
		});
	
	$('#res_tb').jqGrid('navGrid','#res_pg',{addfunc:addDlg,editfunc:editDlg,delfunc:delDlg,search:true,alerttext:"请选择需要操作的数据行!@"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:false},{});
	
	//预先添加目录列表
	$.post('../get_ctree.htm',function(data){
		var path = $("#content_main").find('#path').empty();
		if(!isEmpty(data)) {
			$.each(data, function(i, c) {
				var nbsp = "";
				var node = c.node.split(".").length;
				for(var i=1; i<node; i++) {nbsp += "&nbsp;&nbsp;&nbsp;";}
				path.append("<option value='"+c.id+"'>"+nbsp+c.name+"</option>");
			});
		}
	 },'json');
	 
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:750,
		   buttons: {
			  "添加": addRes,
			  "提交": editRes,
			  "取消": function() {$(this).dialog('close')}}
		 });
	
	$("#gConsole").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:180,
		   buttons: {
		      "删除": delRes,
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
	 dlg.find('#path').val('');
	 dlg.find('#resourceType').val('');
	 dlg.find('#number').val('');
	 dlg.find('#version').val('');
	 dlg.find('#title').val('');
	 dlg.find('#des').val('');
	 dlg.find('#createDate').val('');
	 dlg.find('#updateDate').val('');
	 dlg.find('#isValid').val('');
	 dlg.find('#uploadDate').val('');
	 dlg.find('#uploadEname').val('');
	 dlg.find('#maintainDpt').val('');
	 dlg.find('#attachment').val('');
	 dlg.find("#dd_createDate").hide();
	 dlg.find("#dd_updateDate").hide();
	 dlg.find('#dd_uploadDate').hide();
	 dlg.dialog('open');
	
};

var editDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('提交')").show();
	  
	 var selectrow = $("#res_tb").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	 var rd = $('#res_tb').jqGrid("getRowData", selectrow);
	   dlg.find('#id').val(rd.id);
	   dlg.find('#path').val(rd.path);
	   dlg.find('#resourceType').val(rd.resourceType);
	   dlg.find('#number').val(rd.number);
	   dlg.find('#version').val(rd.version);
	   dlg.find('#title').val(rd.title);
	   dlg.find('#des').val(rd.des);
	   dlg.find('#createDate').val(rd.createDate);
	   dlg.find('#updateDate').val(rd.updateDate);
	   dlg.find('#isValid').val(rd.isValid);
	   dlg.find('#uploadDate').val(rd.uploadDate);
	   dlg.find('#uploadEname').val(rd.uploadEname);
	   dlg.find('#maintainDpt').val(rd.maintainDpt);
	   dlg.find('#attachment').val(rd.attachment);
	   dlg.find("#dd_createDate").show();
	   dlg.find("#dd_updateDate").show();
	   dlg.find('#dd_uploadDate').show();
	   dlg.dialog('open');
	 }
};

var addRes = function() {
	var dlg = $('#content_main');
	var params = {id:$.trim(dlg.find("#id").val()),
			  resourceType:$.trim(dlg.find("#resourceType").val()),
			  version:$.trim(dlg.find("#version").val()),
			  number:$.trim(dlg.find("#number").val()),
			  path:$.trim(dlg.find("#path").val()),
			  title:$.trim(dlg.find("#title").val()),
			  des:$.trim(dlg.find("#des").val()),
			  createDate:$.trim(dlg.find("#createDate").val()),
			  updateDate:$.trim(dlg.find("#updateDate").val()),
			  isValid:$.trim(dlg.find("#isValid").val()),
			  uploadDate:$.trim(dlg.find("#uploadDate").val()),
			  uploadEname:$.trim(dlg.find("#uploadEname").val()),
			  maintainDpt:$.trim(dlg.find("#maintainDpt").val()),
			  attachment:$.trim(dlg.find("#attachment").val())
		};
	  //验证方法
	if (!vali(params)) {
		alert("信息不完整");
		return false;
	}
	$.post('../app/save_resource.htm', params, function(data) {
		if (data.result == "SUCCESS") {
			$("#res_tb").jqGrid("addRowData", data.res.id, data.res, "first");
			alert("添加成功！");
			dlg.dialog("close");
		} else if (data.result == "PARAM_EMPTY")
			alert("请填写完整后再提交！");
		else
			alert("操作失败！");
	}, 'json');
};

var editRes = function() {
	 var dlg = $('#content_main');
	  var params = {id:$.trim(dlg.find("#id").val()),
			  resourceType:$.trim(dlg.find("#resourceType").val()),
			  version:$.trim(dlg.find("#version").val()),
			  number:$.trim(dlg.find("#number").val()),
			  path:$.trim(dlg.find("#path").val()),
			  title:$.trim(dlg.find("#title").val()),
			  des:$.trim(dlg.find("#des").val()),
			  createDate:$.trim(dlg.find("#createDate").val()),
			  updateDate:$.trim(dlg.find("#updateDate").val()),
			  isValid:$.trim(dlg.find("#isValid").val()),
			  uploadDate:$.trim(dlg.find("#uploadDate").val()),
			  uploadEname:$.trim(dlg.find("#uploadEname").val()),
			  maintainDpt:$.trim(dlg.find("#maintainDpt").val()),
			  attachment:$.trim(dlg.find("#attachment").val())
		};
		$.post('../app/save_resource.htm',params,function(data){
	      if(data.result == "SUCCESS") {
		    var dr = {resourceType:params.resourceType,version:params.version,title:params.title,des:params.des,
		    		createDate:params.createDate,updateDate:params.updateDate,updateEname:params.updateEname};
		    $("#res_tb").jqGrid("setRowData", params.id, dr, {color:"#FF0000"});
		    alert(dr.title + " －  操作成功！");
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

var delRes = function() {
	 var dlg = $("#gConsole");
	 var tid = jQuery("#res_tb").jqGrid('getGridParam','selarrrow');
	 if(tid) {
	    $.post('del_resource.htm',{'id':tid},function(data){
		  if(data.result=="SUCCESS") {
		    $('#res_tb').jqGrid("delRowData",tid);
			dlg.dialog("close");
			alert("删除成功！");
		  }else alert("删除操作失败！");
		},'json');
	  }else alert("请选择需要删除的条目！");
};

function resourceTypefmt(cellvalue, options, rowObject) {
	var tmp;
	if(cellvalue=="MANUAL") tmp="手册";
	else if(cellvalue=="MATERIAL") tmp="教材";
	else if(cellvalue=="TECHNICAL") tmp="技术档";
	else if(cellvalue=="HOW") tmp="如何做";
	else if(cellvalue=="EXPERIENCE") tmp="心得";
	else if(cellvalue=="VIDEO") tmp="视频";
	return tmp;
}

function validfmt(cellvalue, options, rowObject) {
	var tmp;
	if(cellvalue==true) tmp="有效";
	else if(cellvalue==false) tmp="无效";
	return tmp;
}

//简单验证
function vali(p) {
	if(isEmpty(p.version)) return false;
	if(isEmpty(p.title)) return false;
	if(isEmpty(p.attachment)) return false;
	return true;
}