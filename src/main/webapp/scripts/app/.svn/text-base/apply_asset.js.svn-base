var msg_cn = {funCode:{required:"功能代码不能为空！"},receiveNum:{required:"数量不能为空！"},receiveDate:{required:"领取日期不能为空！"},returnDate:{required:"交还日期不能为空！"}};
var msg_tw = {funCode:{required:"功能代碼不能為空！"},receiveNum:{required:"數量不能為空！"},receiveDate:{required:"領取日期不能為空！"},returnDate:{required:"交還日期不能為空！"}};

var colNames_cn = ['ID','名称','资产类型','所属部门','说明','可用数量','单位','资产状态','管理员','采购人员','采购日期','保修到期','管制日期','报废日期','附件','资产类型','资产状态'];
var colNames_tw = ['ID','名稱','資產類型','所屬部門','說明','可用數量','單位','資產狀態','管理員','采購人員','采購日期','保修到期','管制日期','報廢日期','附件','資產類型','資產狀態'];

var caption = {zh: "申请物资", "zh_CN": "申请物资", "zh_TW": "申請物資"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
	$.fn.zTree.init($("#menu"), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	
	$("#receiveDate").datepicker({changeMonth:true,changeYear:true,onSelect:function(selectedDate){$("#returnDate").datepicker("option", "minDate", selectedDate)}});
    $("#returnDate").datepicker({changeMonth:true,changeYear:true,onSelect:function(selectedDate){$("#receiveDate").datepicker("option", "maxDate", selectedDate)}});

    //控制申领数量如果输入错误或数量大于库存
	$("#receiveNum").keyup(function() { 
		$(this).val($(this).val().replace(/[^0-9.]/g,''));
		if($(this).val() > $('#buyNum').val()) {
			$(this).val($('#buyNum').val());
		}
	});
    
	//显示所有资产信息
	jQuery("#asset_tb").jqGrid({
	   	url:'../get_assets.htm',
	   	mtype:'POST',
		datatype:'json',
		width:793,
		height:350,
		caption: caption[lang],
	   	colNames:colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   		{name:'assetName',index:'assetName',width:60,align:"center"},
	   		{name:'assetType',index:'assetType',width:60,align:"center",formatter:assetTypefmt},
	   		{name:'ascription',index:'ascription',width:60,align:"center"},
	   		{name:'des',index:'des',hidden:true},
	   		{name:'buyNum',index:'buyNum',width:40,align:"center"},
	   		{name:'unit',index:'unit',width:60,align:"center"},
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
	   	rowNum:20,
	   	rowList:[20,40,90],
	   	pager: '#asset_pg',
	   	sortname: 'id',
	    viewrecords: true,
	    rownumbers:true,
	    sortorder: "asc",
		multiselect: false,
		jsonReader:{root:'list',repeatitems:false}
	}).jqGrid('navGrid','#asset_pg',{add:false,editfunc:applyDlg,edittitle:"申领资产",editicon:"ui-icon-tag",del:false,view:true,search:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:false},{});
	
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:750,
		   buttons: {
			  "提交": applyAsset,
			  "取消": function() {$(this).dialog('close')}}
	});
	
	//Form 验证字段内容
	$("#borrowForm").validate({  
		rules : {  
//			"funCode":{required:true},  
			"receiveNum":{required:true, maxlength:4},
			"receiveDate":{required:true},
			"returnDate":{required:true}
	    },
	    onkeyup:false,
		messages : {
//			funCode:{required:"功能代码不能为空！"},
			receiveNum:{required:"数量不能为空！"},
			receiveDate:{required:"领取日期不能为空！"},
			returnDate:{required:"交还日期不能为空！"}
		}
	});
	
}); 

var applyDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('提交')").show();
	 
	 var selectrow = $("#asset_tb").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
		 var rd = $('#asset_tb').jqGrid("getRowData", selectrow);
		 if(rd.buyNum <= 0) {alert("可用数量为0，您不能借出！");return false;}
	   	 dlg.dialog("option","title","申请资产单据");
	   	 
	   	 /** 基本信息 **/
	   	 dlg.find('#show_title, #describe').empty();
		 dlg.find('#show_title').prepend("<b>物品名称：</b><span>" + rd.assetName + "</span><span><b>可用数量：</b>" + rd.buyNum + " &nbsp; " + rd.unit + "</span><p><em>资产状态：" + assetStatefmt(rd.assetState) + "</em></p>");
		 dlg.find('#describe').prepend("<span><b>资产类型：</b>" + assetTypefmt(rd.assetType) + "</span> &nbsp;&nbsp;&nbsp;&nbsp;<span><b>所属部门：</b>" + rd.ascription + "</span> &nbsp;&nbsp;&nbsp;&nbsp;<span><b>管理员：</b>" + rd.admin + "</span> &nbsp;&nbsp;&nbsp;&nbsp; <span><b>采购人员：</b>" + rd.buyer + "</span>");
		 
	   	 dlg.find('#id').val('');
	   	 dlg.find('#assetId').val(rd.id);
	   	 dlg.find('#assetName').val(rd.assetName);
	   	 dlg.find('#buyNum').val(rd.buyNum);
//		 dlg.find('#funCode').val('');
		 dlg.find('#receiveNum').val('');
		 dlg.find('#receiver').val('');
		 dlg.find('#receiveDate').val('');
		 dlg.find('#returnDate').val('');
		 dlg.find('#overStaff').val('');
		 dlg.find('#remark').val('');
		 dlg.find('label.error').hide();
		 dlg.dialog('open');
	 }
};

var applyAsset = function() {
	var dlg = $('#content_main');
	var params = {id:$.trim(dlg.find("#id").val()),
			  assetId:$.trim(dlg.find("#assetId").val()),
			  assetName:$.trim(dlg.find("#assetName").val()),
//			  funCode:$.trim(dlg.find("#funCode").val()),
			  applyState:$.trim(dlg.find("#applyState").val()),
			  receiveNum:$.trim(dlg.find("#receiveNum").val()),
			  receiver:'',
			  receiveDate:$.trim(dlg.find("#receiveDate").val()),
			  returnDate:$.trim(dlg.find("#returnDate").val()),
			  overStaff:'',
			  remark:$.trim(dlg.find("#remark").val())
	};
	  
	if(!dlg.find("#borrowForm").valid()) return false;
	  
	$.post('save_borrow.htm?operate=apply',params,function(data){
		if(data.result == "SUCCESS") {
			var dr = {id:params.assetId,buyNum:$('#buyNum').val()-params.receiveNum};
			$("#asset_tb").jqGrid("setRowData", params.assetId, dr, {color:"#FF0000"});
			alert("操作成功！");
	        dlg.dialog("close");
		}
		else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		else if(data.result == "UNSUPPORT") alert("抱歉，该产品数量库存不足！");
		else alert("操作失败！");
	},'json');
};
