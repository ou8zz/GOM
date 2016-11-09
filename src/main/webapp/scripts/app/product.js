var msg_cn = {productName:"产品名称不能为空",productType:"产品类型不能为空",num:{required:"产品数量不能为空",number:"产品数量只能是整数"},unit:"产品单位不能为空",outputDate:"生产日期不能为空",version:"版本不能空",explains:"描述说明不能为空"};
var msg_tw = {productName:"產品名稱不能為空",productType:"產品類型不能為空",num:{required:"產品數量不能為空",number:"產品數量只能是整數"},unit:"產品單位不能為空",outputDate:"生產日期不能為空",version:"版本不能空",explains:"描述說明不能為空"};
var colNames_cn = ['ID','产品名称','产品类型','版本','数量','单位','生产日期','说明','产品类型'];
var colNames_tw = ['ID','產品名稱','產品類型','版本','數量','單位','生產日期','說明','產品類型'];
var caption = {zh: "产品管理", "zh_CN": "产品管理", "zh_TW": "產品管理"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
	$.fn.zTree.init($("#menu"), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	$("dd span.error_msg").hide();
	$("#outputDate").datepicker({changeMonth:true,changeYear:true});
		
	//显示所有产品信息
	jQuery("#product_tb").jqGrid({
	   	url:'get_products.htm',
		datatype: "json",
		height:350,
		width:793,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   		{name:'productName',index:'productName',width:100},
	   		{name:'productType',index:'productType',width:80,formatter:productTypefmt},
	   		{name:'version',index:'version',width:60,sortable:false},
	   		{name:'num',index:'num',width:60,sortable:false},
	   		{name:'unit',index:'unit',width:60,sortable:false},
	   		{name:'outputDate',index:'outputDate',width:90},
	   		{name:'explains',index:'explains',width:310,sortable:false},
	   		{name:'productType',index:'productType',hidden:true, width:0}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#product_pg',
	   	sortname:'outputDate',
	    viewrecords: true,
	    rownumbers:true,
		rownumWidth:33,
	    sortorder:"desc",
		multiselect:false,
		jsonReader:{root:'list',repeatitems:false}
	});
	
	$('#product_tb').jqGrid('navGrid','#product_pg',{addfunc:addDlg,editfunc:editDlg,delfunc:delDlg,search:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:false},{});
	
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:730,
		   height:400,
		   buttons: {
			  "添加": addProduct,
			  "提交": editProduct,
			  "取消": function() {$(this).dialog('close')}}
		 });
	
	$("#gConsole").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:180,
		   buttons: {
		      "删除": delProduct,
			  "取消": function() {$(this).dialog('close')}
			  }
		 }); 
	var validator = $('#productForm').validate({
		rules:{productName:"required",productType:"required",num:{required:true,number:true},unit:"required",outputDate:"required",version:"required",explains:"required"},
		messages:{productName:"产品名称不能为空",productType:"产品类型不能为空",num:{required:"产品数量不能为空",number:"产品数量只能是整数"},unit:"产品单位不能为空",outputDate:"生产日期不能为空",version:"版本不能空",explains:"描述说明不能为空"},
		errorPlacement:function(error, element) {
			if(element.is(":radio")) error.appendTo(element.parent().parent().next().next());
			else if(element.is(":checkbox")) error.appendTo(element.next());
			else error.appendTo(element.parent());
		},
		invalidHandler:function(e, validator) {
			var errors = validator.numberOfInvalids();
			if(errors) {
				var message = errors == 1 ? '高亮显示的栏位为空，请填写完后再提交' : '你有 ' + errors + ' 栏位为空或有误.  请按错误提示来更正';
				$("dd span.error_msg").html(message);
				$("dd span.error_msg").show();
			}else {
				$("dd span.error_msg").hide();
			}
		},
		submitHandler:function() {
			$("dd span.error_msg").hide();
		},
		success:function(label) {label.html(" ").addClass("checked");}
  }); 
}); 

var addDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('添加')").show();
	 dlg.dialog("option","title","添加新产品");
	 dlg.find('#id').val('');
	 dlg.find('#productForm')[0].reset();
	 dlg.dialog('open');
};

var editDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('提交')").show();
	 dlg.find('#productForm')[0].reset();
	 var selectrow = $("#product_tb").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	 var rd = $('#product_tb').jqGrid("getRowData", selectrow);
	   dlg.dialog("option","title","编辑 － " + rd.productName);
	   dlg.find('#id').val(rd.id);
	   dlg.find('#productName').val(rd.productName);
	   dlg.find('#productType').val(rd.productType);
	   dlg.find('#version').val(rd.version);
	   dlg.find('#explains').val(rd.explains);
	   dlg.find('#num').val(rd.num);
	   dlg.find('#unit').val(rd.unit);
	   dlg.find('#outputDate').val(rd.outputDate);
	   dlg.dialog('open');
	 }
};

var addProduct = function() {
	 var dlg = $('#content_main');
	  if($('#productForm').valid()) {
		  $.post('save_product.htm',$("#productForm").serialize(),function(data){
	      if(data.result == "SUCCESS") {
			$("#product_tb").jqGrid("addRowData", data.product.id, data.product, "first");
			alert("添加成功！");
	        dlg.dialog("close");
		  }
	     else if(data.result == "UNSUPPORT") alert("产品名已存在！");
	     else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		 else alert("添加操作失败！");
		},'json');
	  }
};

var editProduct = function() {
	 var dlg = $('#content_main');
	  if($('#productForm').valid()) {
		$.post('save_product.htm',$("#productForm").serialize(),function(data){
	      if(data.result == "SUCCESS") {
			var pp = data.product;
	        var dr = {id:pp.id,productName:pp.productName,productType:pp.productType,version:pp.version,explains:pp.explains,unit:pp.unit,num:pp.num,outputDate:pp.outputDate};
		    $("#product_tb").jqGrid("setRowData", pp.id, dr, {color:"#FF0000"});
			alert(dr.productName + " － 操作成功！");
	        dlg.dialog("close");
		  }
		 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		 else alert("操作失败！");
		},'json');
	 }
};

var delDlg = function() {
	var dlg = $("#gConsole");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('删除')").show();
	dlg.dialog("option","title","删除").dialog('open');
};

var delProduct = function() {
	 var dlg = $("#gConsole");
	 var tid;
	 tid = jQuery("#product_tb").jqGrid('getGridParam','selrow');
	 if(tid) {
	    $.post('del_product.htm',{'id':tid},function(data){
		  if(data.result=="SUCCESS") {
		    $('#product_tb').jqGrid("delRowData",tid);
			dlg.dialog("close");
			alert("删除成功！");
		  }else alert("删除操作失败！");
		},'json');
	  }else alert("请选择需要删除的条目！");
};

//资产类型格式化
function productTypefmt(cellvalue, options, rowObject){
	var tmp;
	if(cellvalue=="SOFTWARE") tmp="软件";
	else if(cellvalue=="CONSULTING") tmp="咨询服务";
	else if(cellvalue=="TRAINNING") tmp="培训服务";
	return tmp;
}