
var colNames_cn = ['ID','traceId','nodeCode','nodeOrder','头像','depId','部门','职务','工号','英文名','中文名','称谓','出生年月','户籍','民族','手机','身份证','身份证附件','开户行','入职日期','转正日期','婚姻','账号'];
var colNames_tw = ['ID','traceId','nodeCode','nodeOrder','頭像','depId','部門','職務','工號','英文名','中文名','稱謂','出生年月','戶籍','民族','手機','身份證','身份證附件','開戶行','入職日期','轉正日期','婚姻','賬號'];

var caption = {zh: "", "zh_CN": "新职员职责分配", "zh_TW": "新職員職責分配"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(document).ajaxStop($.unblockUI);
$(function(){
	$.fn.zTree.init($('#menu'), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	$("span.error_msg").hide();
	var msg = "不能为空";
	$("#entryForm").validate({
		rules:{telExt:{required:true},email:{required:true},emailPwd:{required:true},active:{required:true},lock:{required:true}},
		invalidHandler:function(e, validator) {
			var errors = validator.numberOfInvalids();
			if(errors){
				var message = errors == 1 ? '高亮显示的栏位为空，请填写完后再提交' : '你有 ' + errors + ' 栏位为空或有误.  请按错误提示来更正';
				$("span.error_msg").html(message);
				$("span.error_msg").show();
			}else{$("span.error_msg").hide();}
		},
		onkeyup:false,
		submitHandler:function() {$("span.error_msg").hide();},
		messages:{telExt:{required:msg},email:{required:msg},emailPwd:{required:msg},active:{required:msg},lock:{required:msg}}
	});
    
	//显示所有用户信息
	$('#zgrid').jqGrid({
	   	url:'get_users.htm',
		datatype:'json',
		mtype:'GET',
		height:250,
		width:790,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
		    {name:'id',index:'id',hidden:true},
			{name:'traceId',index:'traceId',hidden:true},
			{name:'nodeCode',index:'nodeCode',hidden:true},
			{name:'nodeOrder',index:'nodeOrder',hidden:true},
			{name:'portrait',index:'portrait',hidden:true},
			{name:'depId',index:'depId',hidden:true},
	   		{name:'cdepartment',index:'cdepartment',width:50},
			{name:'cposition',index:'cposition',width:50},
			{name:'jobNo',index:'jobNo',width:60},
	   		{name:'ename',index:'ename',width:60},
	   		{name:'cname',index:'cname',width:60},		
	   		{name:'gender',index:'gender',width:40,formatter:genderType},
			{name:'birthday',index:'birthday',width:85},
			{name:'censusType',index:'censusType',width:60,formatter:censusType},
			{name:'nation',index:'nation',width:60},
	   		{name:'cell',index:'cell',width:95},
			{name:'idcard',index:'idcard',width:140},
			{name:'idScan',index:'idScan',hidden:true},
			{name:'bank',index:'bank',hidden:true},
			{name:'entryDate',index:'entryDate',hidden:true},
			{name:'fullDate',index:'fullDate',hidden:true},
			{name:'marriage',index:'marriage',hidden:true,formatter:fmtMarital},
			{name:'accountNo',index:'accountNo',hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager:'#zpager',
	    viewrecords:true,
	    rownumbers:true,
		rownumWidth:30,
		sortname:'ename',
		sortorder:'asc',
		prmNames:{search:'search'},
	    jsonReader:{root:'list',repeatitems:false},
		multiselect:false,
		cmTemplate:{sortable:false}
	});

$('#zgrid').jqGrid('navGrid','#zpager',{add:false,editfunc:editUserDlg,del:false,search:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:true},{});
	
//配置对话框
$("#content_main").dialog({autoOpen:false,modal:true,resizable:true,width:620,buttons: {"确定":editUser,"取消":function() {$(this).dialog('close')}} });

});

var editUserDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	  
	 var selectrow = $('#zgrid').jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	 var rd = $('#zgrid').jqGrid("getRowData", selectrow);
	 dlg.dialog("option","title","为新员工 <b style='color:blue'>" + rd.ename + "</b> 开通公司各系统帐号");
	 
	 dlg.find('#id').val(rd.id);
	 dlg.find('#traceId').val(rd.traceId);
	 dlg.find('#nodeCode').val(rd.nodeCode);
	 dlg.find('#nodeOrder').val(rd.nodeOrder);
	 dlg.find('#ename').val(rd.ename);
	 dlg.find('#cname').val(rd.cname);
	 dlg.find('#jobNo').val(rd.jobNo);
	 dlg.find('#entryDate').val(rd.entryDate);
	 dlg.find('#fullDate').val(rd.fullDate);
	 dlg.find('#birthday').val(rd.birthday);
	 if(rd.gender=="男") dlg.find('#gender').val("M");
	 else dlg.find('#gender').val("F");
	 if(rd.marriage=="未婚") dlg.find('#marriage').val("SINGLE");
	 else if(rd.marriage=="已婚") dlg.find('#marriage').val("MARRIED");
	 else if(rd.marriage=="离异") dlg.find('#marriage').val("DIVOCED");
	 else if(rd.marriage=="丧偶") dlg.find('#marriage').val("WIDOWED");
	 else if(rd.marriage=="分居") dlg.find('#marriage').val("SEPARATED");
	 dlg.find('#nation').val(rd.nation);
	 dlg.find('#cell').val(rd.cell);
	 dlg.find('#depId').val(rd.depId);
	 dlg.find('#cdepartment').val(rd.cdepartment);
	 dlg.find('#cposition').val(rd.cposition);
	 
	 dlg.find('table.gom_tb').empty();
	 var info = "<thead><tr><th colspan='5'>"+rd.cname+"（" + rd.ename +"）</th></tr></thead><tbody><tr><td colspan='4' scope='col'><ul><li>"+rd.gender+"</li><li>"+rd.birthday+"</li><li>"+rd.marriage+"</li><li>"+rd.nation+"</li><li class='last'>"+rd.cell+"</li></ul></td><td width='20%' rowspan='3' align='center' scope='col'><img src='../uploads/images/"+rd.portrait+"' border='0'/></td></tr><tr><th scope='col' width='20%'>就职部门</th><td width='20%'>"+rd.cdepartment+"</td><th width='20%'>工作职务</th><td width='20%'>"+rd.cposition+"</td></tr><tr><th>入职日期</th><td>"+rd.entryDate+"</td><th>转正日期</th><td>"+rd.fullDate+"</td></tr>";
	 dlg.find('#telExt,#email,#emailPwd').val("");
	 dlg.find('#active,#lock').attr('checked', false);
	 dlg.find('table.gom_tb').append(info+"</tbody>");
	 dlg.dialog('open');
	 }
};

var editUser = function() {
  var dlg = $('#content_main');
  if(dlg.find('#entryForm').valid()){
	  var tid = $("#zgrid").jqGrid('getGridParam','selrow');
	  $.blockUI({message:'<h6><img src="../images/ztree/loading.gif" /> 系统正在处理中，请稍候！</h6>',css:{border:'none',padding:'15px',backgroundColor:'#000', '-webkit-border-radius':'10px', '-moz-border-radius':'10px', opacity:.5,color:'#fff' 
        }});
	  $.ajax({url:'edit_entrant.htm',type:'POST',data:dlg.find('#entryForm').serialize(),dataType:'json',cache:false,success:function(data){
	      if(data.result == "SUCCESS") {
	        $('#zgrid').jqGrid("delRowData",tid);
			alert("帐号开通成功！");
	        dlg.dialog("close");
		  }
		 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		 else alert("更新操作失败！");}
		});
  }else alert("帐号未设置完成，不能提交！");
};