var editaddr = {zh: "", "zh_CN": "编辑地址", "zh_TW": "編輯地址"};
var colNames_cn = ['ID号','联系人','关系','邮编','手机','电话','地址类型','地址'];
var colNames_tw = ['ID號','聯系人','關系','郵編','手機','電話','地址類型','地址'];

var caption = {zh: "地址列表", "zh_CN": "地址列表", "zh_TW": "地址列表"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

var failure = {zh: "", "zh_CN": "操作失败", "zh_TW": "操作失敗"};

$(function(){
	$.fn.zTree.init($('#menu'), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	
	//$("#cell").mask("999 9999 9999");
	$("#zipcode").mask("999999");
	
	//显示用户所有的地址信息
	jQuery("#addr_tb").jqGrid({
		height: 350,
		width:793,
	   	url:'get_address.htm',
		datatype: "json",
		caption:caption[lang],
	   	colNames:colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   		{name:'contact',index:'contact',width:80,align:"center"},
	   		{name:'relation',index:'relation',width:70,align:"center"},
	   		{name:'zipcode',index:'zipcode',width:80,align:"center"},
	   		{name:'cell',index:'cell',width:150,align:"center"},		
	   		{name:'phone',index:'phone',width:150,align:"center"},
	   		{name:'addrType',index:'addrType',width:100,align:"center",formatter:addrType},
	   		{name:'address',index:'address', width:293,align:"center"}
	   	],
	   	rowNum:10,
	   	rowList:[10,20],
	   	pager: '#addr_pg',
	   	sortname: 'id',
	    viewrecords: true,
	    sortorder: "asc",
		multiselect: false,
		editurl:"",
		jsonReader:{root:'list',repeatitems:false}
	}).navGrid('#addr_pg',{addfunc:addAddrDlg,editfunc:editAddrDlg,del:false,search:false,view:false});
		
	$("#content_main").dialog({autoOpen:false,modal:true,resizable:true,width:700,buttons: {"添加": addAddr,"修改": editAddr,"取消": function() {$(this).dialog('close')}}});
	$("#gConsole").dialog({autoOpen:false,modal:true,resizable:true,width:180,buttons: {"删除": delAddr,"取消": function() {$(this).dialog('close')}}}); 
	
}); 

var addAddrDlg = function() {
	var dlg = $("#content_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('添加')").show();
	  
	dlg.dialog("option","title","添加新地址");
	dlg.find('#addrForm')[0].reset();
	dlg.find("label.error").remove();
	dlg.dialog('open');
};

var addAddr = function() {
	 var dlg = $('#content_main');
	  var params = {id:$.trim(dlg.find("#id").val()),
			  contact:$.trim(dlg.find("#contact").val()),
			  relation:$.trim(dlg.find("#relation").val()),
			  zipcode:$.trim(dlg.find("#zipcode").val()),
			  cell:$.trim(dlg.find("#cell").val().replace(/\s+/g,"")),
			  phone:$.trim(dlg.find("#phone").val()),
			  addrType:$.trim(dlg.find("#addrType").val()),
			  address:$.trim(dlg.find("#address").val())
		};
	  if (dlg.find('#addrForm').valid()) {
		  $.post('save_address.htm',params,function(data){
		      if(data.result == "SUCCESS") {
		    	$("#addr_tb").jqGrid("addRowData", data.addr.id, data.addr, "first");
				alert("操作成功");
		        dlg.dialog("close");
			  }
			 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
			 else alert(failure[lang]);
		  },'json'); 
	  }
};

var editAddrDlg = function() {
	var dlg = $("#content_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('修改')").show();
	  
	dlg.find("label.error").remove();
	 
	var selectrow = $("#addr_tb").jqGrid("getGridParam", "selrow");
	if(selectrow) {
	var rd = $('#addr_tb').jqGrid("getRowData", selectrow);
	   dlg.dialog("option", "title", editaddr[lang]);
	   dlg.find('#id').val(rd.id);
	   dlg.find('#contact').val(rd.contact);
	   dlg.find('#relation').val(rd.relation); 
	   dlg.find('#zipcode').val(rd.zipcode);
	   dlg.find('#cell').val(rd.cell);
	   dlg.find('#phone').val(rd.phone);
	   dlg.find('#addrType').val(rd.addrType);
	   dlg.find('#address').val(rd.address);
	   dlg.dialog('open');
	 }
};

var editAddr = function() {
	var dlg = $('#content_main');
	var params = {id:$.trim(dlg.find("#id").val()),
			  contact:$.trim(dlg.find("#contact").val()),
			  relation:$.trim(dlg.find("#relation").val()),
			  zipcode:$.trim(dlg.find("#zipcode").val()),
			  cell:$.trim(dlg.find("#cell").val()),
			  phone:$.trim(dlg.find("#phone").val()),
			  addrType:$.trim(dlg.find("#addrType").val()),
			  address:$.trim(dlg.find("#address").val())
		};

	  if (dlg.find('#addrForm').valid()) {
		  $.post('save_address.htm',params,function(data){
		      if(data.result == "SUCCESS") {
		    	var dr = {contact:params.contact,relation:params.relation,zipcode:params.zipcode,cell:params.cell,phone:params.phone,address:params.address,addrType:params.addrType};
				$("#addr_tb").jqGrid("setRowData", params.id, dr, {color:"#FF0000"});
				alert("操作成功");
		        dlg.dialog("close");
			  }
			 else if(data.result == "PARAM_EMPTY") alert(complete_all_warn[lang]);
			 else alert(failure[lang]);
			},'json');
	  }
};

var delAddrDlg = function() {
	var dlg = $("#gConsole");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('删除')").show();
	dlg.dialog("option","title","删除").dialog('open');
};
var delAddr = function() {
	 var dlg = $("#gConsole");
	 var tid = jQuery("#addr_tb").jqGrid('getGridParam','selarrrow');
	 if(tid) {
	    $.getJSON('del_address.htm',{'id':tid},function(data){
		  if(data.result=="SUCCESS") {
		    $('#addr_tb').jqGrid("delRowData",tid);
			dlg.dialog("close");
			alert("操作成功！");
		  } else alert(failure[lang]);
		});
	  }else alert(selectline[lang]);
};

