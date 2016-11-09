var colNames_cn = ['ID号','功能代码','申领物资','申领状态','数量','领用人','领取日期','交还日期','接收员','备注','物资ID','状态'];
var colNames_tw = ['ID號','功能代碼','申領物資','申領狀態','數量','領用人','領取日期','交還日期','接收員','備註','物資ID','狀態'];
var caption = {zh: "待批审领", "zh_CN": "待批审领", "zh_TW": "待批審領"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
	$.fn.zTree.init($("#menu"), setting);
    
	//显示用户所有的申领信息
	jQuery("#handle_tb").jqGrid({
		width:793,
	   	url:"get_borrows.htm?operate=handle",
		datatype: "json",
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   	    {name:'funCode',index:'funCode',width:80,align:"center"},
	   	    {name:'assetName',index:'assetName',width:80,align:"center"},
	   	    {name:'applyState',index:'applyState',width:80,align:"center",formatter:applyStatefmt},
	   	    {name:'receiveNum',index:'receiveNum',width:40,align:"center"},
	   	    {name:'receiver',index:'receiver',width:60,align:"center"},
	   		{name:'receiveDate',index:'receiveDate',width:120,align:"center"},		
	   		{name:'returnDate',index:'returnDate',width:120,align:"center"},
	   		{name:'overStaff',index:'overStaff',width:80,align:"center"},
	   		{name:'remark',index:'remark', width:150,align:"center"},
	   		{name:'assetId',index:'assetId',hidden:true},
	   		{name:'applyState',index:'applyState',hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#handle_pg',
	   	sortname: 'id',
	    viewrecords: true,
	    rownumbers:true,
	    sortorder: "asc",
		multiselect: false,
		editurl:"",
		jsonReader:{root:'list',repeatitems:false}
	}).navGrid('#handle_pg',{add:false,editfunc:editDlg,del:false,search:false,view:true});
	
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:530,
		   buttons: {
			  "提交": editBorrow,
			  "取消": function() {$(this).dialog('close')}}
		 });
		
}); 

var editDlg = function() {
	var dlg = $("#content_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('提交')").show();
	  
	var selectrow = $("#handle_tb").jqGrid("getGridParam", "selrow");
	if(selectrow) {
		var rd = $('#handle_tb').jqGrid("getRowData", selectrow);
		dlg.find('#mag').empty().prepend("<b>领取物资：</b>" + rd.assetName + "<span>领取数量：" + rd.receiveNum + "</span><p><em>领用人：" + rd.receiver + "<em></p>");
	 	dlg.find('#md').empty().prepend("功能代码：" + rd.funCode + "<span>领取日期：" + rd.receiveDate + "</span><span>交还日期：" + rd.returnDate + "</span>");
	 
	 	dlg.dialog("option","title","编辑单据 ");
	 	dlg.find('#id').val(rd.id);
	 	dlg.find('#assetId').val(rd.assetId);
	 	dlg.find('#applyState').val(rd.applyState); 
	 	dlg.find('#remark').val(rd.remark);
	 	dlg.dialog('open');
	}
};
var editBorrow = function() {
	var dlg = $('#content_main');
	var params = {id:$.trim(dlg.find("#id").val()),
			  assetId:$.trim(dlg.find("#assetId").val()),
			  applyState:$.trim(dlg.find("#applyState").val()),
			  remark:$.trim(dlg.find("#remark").val())
	};
	$.post('save_borrow.htm?operate=handle',params,function(data){
	      if(data.result == "SUCCESS") {
	    	var dr = {funCode:params.funCode,applyState:params.applyState,receiveNum:params.receiveNum,receiver:params.receiver,receiveDate:params.receiveDate,returnDate:params.returnDate,overStaff:params.overStaff,remark:params.remark};
			$("#handle_tb").jqGrid("setRowData", params.id, dr, {color:"#FF0000"});
			alert("操作成功！");
	        dlg.dialog("close");
	      }
		 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		 else alert("操作失败！");
	},'json');
};
