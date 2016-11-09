
var colNames_cn = ['ID','名称','资产类型','所属部门','说明','可用数量','单位','资产状态','管理员','采购人员','采购日期','保修到期','管制日期','报废日期','附件','资产类型','资产状态'];
var colNames_tw = ['ID','名稱','資產類型','所屬部門','說明','可用數量','單位','資產狀態','管理員','采購人員','采購日期','保修到期','管制日期','報廢日期','附件','資產類型','資產狀態'];

var caption = {zh: "资产列表", "zh_CN": "资产列表", "zh_TW": "資產列表"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
	$.fn.zTree.init($("#menu"), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	
	$("#buyDate,#warrantyDate,#controlDate,#scrapDate").datepicker({changeMonth:true,changeYear:true});
	
	//附件上传
	$('#att').uploadify({
		  'uploader':'../common/uploadify.swf',
		  'script':'../upload.htm',
		  'cancelImg':'../images/cancel.png',
		  'fileExt':'*.jpg;*.gif;*.png;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;',
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
		  'onError':function(event, queueID, fileObj) {
			  alert("文件:" + fileObj.name + "上传失败！");
		  }
	});
	
	//显示所有用户信息
	jQuery("#asset_tb").jqGrid({
	   	url:'../get_assets.htm',
		datatype: "json",
		mtype:'POST',
		height:350,
		width:793,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   		{name:'assetName',index:'assetName',width:60,align:"center"},
	   		{name:'assetType',index:'assetType',width:60,align:"center",formatter:assetTypefmt},
	   		{name:'ascription',index:'ascription',width:60,align:"center"},
	   		{name:'des',index:'des',hidden:true},
	   		{name:'buyNum',index:'buyNum',width:50,align:"center"},
	   		{name:'unit',index:'unit',width:30,align:"center"},
	   		{name:'assetState',index:'assetState',width:60,align:"center",formatter:assetStatefmt},
	   		{name:'admin',index:'admin',width:60,align:"center"},
	   		{name:'buyer',index:'buyer',width:60,align:"center"},
	   		{name:'buyDate',index:'buyDate',width:60,align:"center"},
	   		{name:'warrantyDate',index:'warrantyDate',hidden:true},
	   		{name:'controlDate',index:'controlDate',hidden:true},
	   		{name:'scrapDate',index:'scrapDate',hidden:true},
	   		{name:'attachment',index:'attachment',hidden:true},
	   		{name:'assetType',index:'assetType',hidden:true},
	   		{name:'assetState',index:'assetState',hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#asset_pg',
	   	sortname: 'id',
	    viewrecords: true,
	    grouping:false,
	   	groupingView : {
	   		groupField : ['id']
	   	},
	    rownumbers:true,
	    sortorder: "asc",
		multiselect: false,
		jsonReader:{root:'list',repeatitems:false}
	});
	
	$('#asset_tb').jqGrid('navGrid','#asset_pg',{addfunc:addDlg,editfunc:editDlg,del:false,search:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:false},{});
	
	//$('#buyer').blur(function(){ isBuyer($(this).val()); });
	
	//Form 验证字段内容
	$("#assetForm").validate({  
		rules : {  
			"assetName":{required:true, minlength:3},  
			"assetType":{required:true},
			"buyNum":{required:true},
			"unit":{required:true},
			"admin":{required:true},
			"buyer":{required:true},
			"buyDate":{required:true}
	    },
	    onkeyup:false,
		messages : {
			assetName:{required:"标题不能为空！", minlength:"请至少输入3个以上字符！"},
			assetType:{required:"请选择资产类型！"},
			buyNum:{required:"购买数量只能是数字！"},
			unit:{required:"请选择单位！"},
			admin:{required:"管理员不能为空！"},
			buyer:{required:"采购人不能为空！"},
			buyDate:{required:"采购日期不能为空！"}
		}
	});
	
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:750,
		   buttons: {
			  "添加": addAsset,
			  "提交": editAsset,
			  "取消": function() {$(this).dialog('close')}}
		 });
	
	//选择采购员，从部门
	$('#buyDpt').change(function() {
		var buyer = $("#buyer").empty();
		$.post('../dpt_users.htm',{'dpt':$(this).val(),'type':'DEPARTMENT','ismgr':false,'user':true},function(data){
			$.each(data, function(i,val){buyer.append("<option value='" + val.ename + "'>" + val.ename + "</option>");});
		},'json');
	});
}); 

var addDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('添加')").show();
	 dlg.dialog("option","title","添加资产文件");
	 
	 dlg.find('#assetForm')[0].reset();
	 dlg.find('#assetForm').find("input[type=hidden]").val('');
	 
	 dlg.find('#admin_id').hide();
	 dlg.find('label.error').hide();
	 dlg.dialog('open');
};

var editDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('提交')").show();
	  
	 var selectrow = $("#asset_tb").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	 var rd = $('#asset_tb').jqGrid("getRowData", selectrow);
	   dlg.dialog("option","title","编辑 － " + rd.assetName);
	   dlg.find('#id').val(rd.id);
	   dlg.find('#assetName').val(rd.assetName);
	   dlg.find('#assetType').val(rd.assetType);
	   dlg.find('#ascription').val(rd.ascription);
	   dlg.find('#des').val(rd.des);
	   dlg.find('#buyNum').val(rd.buyNum);
	   dlg.find('#unit').val(rd.unit);
	   dlg.find('#assetState').val(rd.assetState);
	   dlg.find('#admin').val(rd.admin);
	   dlg.find('#buyer').empty().append('<option value="'+rd.buyer+'">'+rd.buyer+'</option>'); //val(rd.buyer);
	   dlg.find('#buyDate').val(rd.buyDate);
	   dlg.find('#warrantyDate').val(rd.warrantyDate);
	   dlg.find('#controlDate').val(rd.controlDate);
	   dlg.find('#scrapDate').val(rd.scrapDate);
	   dlg.find('#attachment').val(rd.attachment);
	   dlg.find('#admin_id').show();
	   dlg.find('label.error').hide();
	   dlg.dialog('open');
	 }
};

var addAsset = function() {
	var dlg = $('#content_main');
	if(dlg.find("#assetForm").valid()) {
		$.post('../save_asset.htm', $("#assetForm").serialize(), function(data){
		     if(data.result == "SUCCESS") {
		    	$("#asset_tb").jqGrid("addRowData", data.asset.id, data.asset, "first");
				alert("添加成功！");
		        dlg.dialog("close");
		      }
		      else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		      else alert("添加操作失败！");
		},'json');
	}
};

var editAsset = function() {
	var dlg = $('#content_main');
	if (dlg.find("#assetForm").valid()) {
		$.post('../save_asset.htm', $("#assetForm").serialize(), function(data) {
			if (data.result == "SUCCESS") {
				$("#asset_tb").jqGrid("setRowData", data.asset.id, data.asset, { color : "#FF0000" });
				alert(data.asset.assetName + " －  操作成功！");
				dlg.dialog("close");
			} else if (data.result == "PARAM_EMPTY")
				alert("请填写完整后再提交！");
			else
				alert("操作失败！");
		}, 'json');
	}
};