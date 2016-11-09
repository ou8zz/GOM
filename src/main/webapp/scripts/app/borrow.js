
var colNames_cn = ['ID号','功能代码','申领物资','申领状态','数量','领用人','领取日期','交还日期','接收员','备注','状态'];
var colNames_tw = ['ID號','功能代碼','申領物資','申領狀態','數量','領用人','領取日期','交還日期','接收員','備註','狀態'];

var caption = {zh: "借据列表", "zh_CN": "借据列表", "zh_TW": "借據列表"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
	$.fn.zTree.init($("#menu"), setting);
	
	$("#receiveDate,#returnDate").datepicker({changeMonth:true,changeYear:true});
	
	//显示用户所有的借据信息
	jQuery("#borrow_tb").jqGrid({
		height:350,
		width:793,
	   	url:'get_borrows.htm',
		datatype: "json",
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   	    {name:'funCode',index:'funCode',hidden:true,width:80,align:"center"},
	   	    {name:'assetName',index:'assetName',width:80,align:"center"},
	   	    {name:'applyState',index:'applyState',width:80,align:"center",formatter:applyStatefmt},
	   	    {name:'receiveNum',index:'receiveNum',width:40,align:"center"},
	   	    {name:'receiver',index:'receiver',width:60,align:"center"},
	   		{name:'receiveDate',index:'receiveDate',width:120,align:"center"},		
	   		{name:'returnDate',index:'returnDate',width:120,align:"center"},
	   		{name:'overStaff',index:'overStaff',width:80,align:"center"},
	   		{name:'remark',index:'remark', width:150,align:"center"},
	   		{name:'applyState',index:'applyState',hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#borrow_pg',
	   	sortname: 'id',
	    viewrecords: true,
	    sortorder: "asc",
		multiselect: false,
		editurl:"",
		jsonReader:{root:'list',repeatitems:false}
	}).navGrid('#borrow_pg',{add:false,editfunc:editDlg,del:false,search:true,view:false});
		
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:730,
		   buttons: {
			  "修改": editBorrow,
			  "取消": function() {$(this).dialog('close')}}
		 });
		
	$("#gConsole").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:180,
		   buttons: {
		      "删除": delBorrow,
			  "取消": function() {$(this).dialog('close')}
			  }
		 }); 
	
}); 

var editDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('修改')").show();
	  
	 var selectrow = $("#borrow_tb").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	 var rd = $('#borrow_tb').jqGrid("getRowData", selectrow);
	   dlg.dialog("option","title","编辑单据 ");
	   dlg.find('#id').val(rd.id);
	   dlg.find('#funCode').val(rd.funCode);
	   dlg.find('#applyState').val(rd.applyState); 
	   dlg.find('#receiveNum').val(rd.receiveNum);
	   dlg.find('#receiver').val(rd.receiver);
	   dlg.find('#receiveDate').val(rd.receiveDate);
	   dlg.find('#returnDate').val(rd.returnDate);
	   dlg.find('#overStaff').val(rd.overStaff);
	   dlg.find('#remark').val(rd.remark);
	   dlg.dialog('open');
	 }
};
var editBorrow = function() {
	 var dlg = $('#content_main');
	  var params = {id:$.trim(dlg.find("#id").val()),
			  funCode:$.trim(dlg.find("#funCode").val()),
			  applyState:$.trim(dlg.find("#applyState").val()),
			  receiveNum:$.trim(dlg.find("#receiveNum").val()),
			  receiver:$.trim(dlg.find("#receiver").val().replace(/\s+/g,"")),
			  receiveDate:$.trim(dlg.find("#receiveDate").val()),
			  returnDate:$.trim(dlg.find("#returnDate").val()),
			  overStaff:$.trim(dlg.find("#overStaff").val()),
			  remark:$.trim(dlg.find("#remark").val())
		};
	  if(!vali(params)) {
		  alert('信息填写不完整，请填写完整后再提交');
		  return false;
	  }
		$.post('save_borrow.htm?operate=admin',params,function(data){
	      if(data.result == "SUCCESS") {
	    	var dr = {funCode:params.funCode,applyState:params.applyState,receiveNum:params.receiveNum,receiver:params.receiver,receiveDate:params.receiveDate,returnDate:params.returnDate,overStaff:params.overStaff,remark:params.remark};
	  		$("#borrow_tb").jqGrid("setRowData", params.id, dr, {color:"#FF0000"});
			alert("更新成功！");
	        dlg.dialog("close");
		  }
		 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		 else alert("更新操作失败！");
		},'json');
};

var delDlg = function() {
	var dlg = $("#gConsole");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('删除')").show();
	dlg.dialog("option","title","删除").dialog('open');
};
var delBorrow = function() {
	 var dlg = $("#gConsole");
	 var tid;
	 tid = jQuery("#borrow_tb").jqGrid('getGridParam','selarrrow');
	 if(tid) {
	    $.getJSON('del_borrow.htm',{'id':tid},function(data){
		  if(data.result=="SUCCESS") {
		    $('#borrow_tb').jqGrid("delRowData",tid);
			dlg.dialog("close");
			alert("删除成功！");
		  }else alert("删除操作失败！");
		});
	  }else alert("请选择需要删除的条目！");
};

//验证
function vali(p) {
	if(isEmpty(p.funCode)) return false;
	if(isEmpty(p.applyState)) return false;
	if(isEmpty(p.receiveNum)) return false;
	if(isEmpty(p.receiver)) return false;
	if(isEmpty(p.receiveDate)) return false;
	if(isEmpty(p.returnDate)) return false;
	if(isEmpty(p.overStaff)) return false;
	if(isEmpty(p.remark)) return false;
	
	return true;
}