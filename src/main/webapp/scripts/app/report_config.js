var editor;
$(document).ajaxStop($.unblockUI);
$(function(){
	$.fn.zTree.init($("#menu"), setting);
	
	$('#sendTime').focus(function(){WdatePicker({dateFmt:'H:mm'});});
	$("#scen").hide();
	
	//$('#sendTime').focus(function(){WdatePicker({dateFmt:'yyyy-MM-dd H:mm:ss',minDate:'%y-%M-%d'});});
	//onfocus="WdatePicker({dateFmt:'H:mm'})"
	
	//签名编辑器
	editor = KindEditor.create('textarea[name="content"]', {
		resizeType : 1,
		allowPreviewEmoticons : false,
		fileManagerJson : window.location.href,
		uploadJson : '../kindeditor_upload.htm',//图片上传action		
		allowImageUpload : false,	//是否上传图片	'image'
		afterUpload : function(url) {},	//回调fuction
		items : ['source', '|', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
			'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'indent', 'outdent', 
			'subscript', 'superscript', 'insertorderedlist', 'insertunorderedlist', '|', 'fullscreen']
	});
	editor.html($("#stext").val());
	var oldform = $("#reportForm").serialize();
	var oldstext = editor.html();
	
	//提交
	$("#report_sub").click(function() {
		if(oldform == $("#reportForm").serialize() && oldstext == editor.html()) return false;	//是否有修改
		if(oldstext != editor.html()) $("#stext").val(editor.html());
		
		$.blockUI({message:'<h6><img src="../images/ztree/loading.gif" /> 系统正在处理中，请稍候！</h6>',css:{border:'none',padding:'15px',backgroundColor:'#000', '-webkit-border-radius':'10px', '-moz-border-radius':'10px', opacity:.5, color:'#fff' }}); 
		
		$.post('save_report_config.htm', $("#reportForm").serialize(),
				function(data) {
					if (data.reslut == "SUCCESS") {
						$("#id").val(data.id);
						oldform = $("#reportForm").serialize();
						oldstext = editor.html();
						alert("操作成功");
					} 
					else alert("操作失败");
		}, 'json');
	});
	
	//改变相应类型
	$("#type").change(function() {
		$("#scen").show();
		if($(this).val() == "MORNING") {
			$("#cst").html("<input id='sendTime' name='sendTime' type='hidden' value='' />");
			$("#scen").hide();
		}
		else if($(this).val() == "DAY") $("#cst").html("<input id='sendTime' name='sendTime' type='hidden' value='' />");				//<input id='sendTime' name='sendTime' onfocus=WdatePicker({dateFmt:'H:mm'}) class='Wdate'/>
		else if($(this).val() == "WEEK") $("#cst").html("周<select id='sendTime' name='sendTime'><option value='1'>日</option><option value='2'>一</option><option value='3'>二</option><option value='4'>三</option><option value='5'>四</option><option value='6'>五</option><option value='7'>六</option></select>");
		else if($(this).val() == "MONTH") $("#cst").html("<select id='sendTime' name='sendTime'><option value='1'>1</option><option value='15'>15</option><option value='30'>30</option></select>号");
		else if($(this).val() == "QUARTER") $("#cst").html("<input id='sendTime' name='sendTime' type='hidden' value='' />");
		else if($(this).val() == "YEAR") $("#cst").html("<input id='sendTime' name='sendTime' type='hidden' value='' />");
		
		$.post('get_report_config.htm', {type:$(this).val()}, function(data) {
			if (data.type != undefined) {
				$("#id").val(data.id);
				$("input[name=summary]").attr("checked", data.summary);
				$("input[name=devote]").attr("checked", data.devote);
				$("input[name=weekDevote]").attr("checked", data.weekDevote);
				$("input[name=repos]").attr("checked", data.repos);
				$("input[name=task]").attr("checked", data.task);
				$("input[name=doing]").attr("checked", data.doing);
				$("input[name=help]").attr("checked", data.help);
				$("input[name=daily]").attr("checked", data.daily);
				$("input[name=weekly]").attr("checked", data.weekly);
				$("input[name=perMonth]").attr("checked", data.perMonth);
				$("input[name=quarterly]").attr("checked", data.quarterly);
				$("input[name=how]").attr("checked", data.how);
				$("input[name=assets]").attr("checked", data.assets);
				$("input[name=login]").attr("checked", data.login);
				$("input[name=send]").attr("checked", data.send);
				$("#sendTime").val(data.sendTime);
				$("#ename").val(data.ename);
				$("#ccename").val(data.ccename);
				$("#receiver").val(data.receiver);
				$("#cc").val(data.cc);
				oldform = $("#reportForm").serialize();
			} else {
				$("#id").val('');
				$("input[name=summary]").attr("checked", false);
				$("input[name=devote]").attr("checked", false);
				$("input[name=weekDevote]").attr("checked", false);
				$("input[name=repos]").attr("checked", false);
				$("input[name=task]").attr("checked", false);
				$("input[name=doing]").attr("checked", false);
				$("input[name=help]").attr("checked", false);
				$("input[name=daily]").attr("checked", false);
				$("input[name=weekly]").attr("checked", false);
				$("input[name=perMonth]").attr("checked", false);
				$("input[name=quarterly]").attr("checked", false);
				$("input[name=how]").attr("checked", false);
				$("input[name=assets]").attr("checked", false);
				$("input[name=login]").attr("checked", false);
				$("input[name=send]").attr("checked", false);
				$("#sendTime").val('');
				$("#ename").val('');
				$("#ccename").val('');
				$("#receiver").val('');
				$("#cc").val('');
				//$('#reportForm')[0].reset();
				oldform = $("#reportForm").serialize();
			}
		}, 'json');
		
	});
	
	//点击发送测试邮件
	$("#sendTest").click(function() {
		$("#stext").val(editor.html());
		
		$.blockUI({message:'<h6><img src="../images/ztree/loading.gif" /> 系统正在处理中，请稍候！</h6>',css:{border:'none',padding:'15px',backgroundColor:'#000', '-webkit-border-radius':'10px', '-moz-border-radius':'10px', opacity:.5, color:'#fff' }}); 
		
		$.post('../report.htm', $("#reportForm").serialize(), function(data){
			if(data == "SUCCESS") alert("发送成功");
			else alert("发送失败");
		});
	});
	
	//查找到所有部门遍历到department_SELECT
	$.post('../departments.htm', function(data){
		 var user = "";
		 $.each(data, function(i, d){ 
			 user += "<label><input type='checkbox' onclick='getUser(this);' name='dpt' value='"+d.id+"' />"+d.cname+"</label>";
		 });
		 $("#user_main").find("#dpt_dl").html(user);
	},'json');
	
	$("#user_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:450,
		   buttons: {
			  "确定": selectedUser,
			  "提交": selectedCc,
			  "取消": function() {$(this).dialog('close')}}
		});
	
}); 


//人员选择
var userDlg = function (va) {
	var dlg = $("#user_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	panel.find("button:not(:contains('取消'))").hide();
	if(va == "cc") panel.find("button:contains('提交')").show();
	else panel.find("button:contains('确定')").show();
	dlg.dialog("option","title","请按部门选择用户");
	dlg.find("#user_dl").empty();
	dlg.find("#dpt_dl").find("input:checked").attr("checked", false);
	dlg.dialog('open');
};

//从选中的部门当中展示用户
var getUser = function(obj) {
	var user = $("#user_main").find('#user_dl');
	var id = obj.value;
	if(obj.checked){
		$.post('../dpt_users.htm',{'dpt':id,'type':'DEPARTMENT', ismgr:false, 'user':'true'},function(data){
			var du = "";
			$.each(data, function(i,u){
				du += "<label><input type='checkbox' checked='checked' name='puser' id='"+u.email+"' value='"+u.ename+"' />"+u.cname+"</label>";
			});
			user.append("<div id='du"+id+"'>"+du+"</div>");
		},'json');
	 } 
	else user.find("#du"+id).empty();
};

//确定把值传给文本框
var selectedUser = function () {
	var dlg = $("#content_main");
	var user = $("#user_main").find('#user_dl');
	var enames = new Array();
	var emails = new Array();
	var i=0;
	user.find("input[name=puser]:checked").each(function(){ enames[i] = $(this).val(); if($(this).attr('id') == "undefined") emails[i] = ''; else emails[i] = $(this).attr('id'); i++;});
	dlg.find("#ename").val(enames);
	dlg.find("#receiver").val(emails);
	$("#user_main").dialog('close');
};

var selectedCc = function () {
	var dlg = $("#content_main");
	var user = $("#user_main").find('#user_dl');
	var enames = new Array();
	var emails = new Array();
	var i=0;
	user.find("input[name=puser]:checked").each(function(){ enames[i] = $(this).val(); if($(this).attr('id') == "undefined") emails[i] = ''; else emails[i] = $(this).attr('id'); i++;});
	dlg.find("#ccename").val(enames);
	dlg.find("#cc").val(emails);
	$("#user_main").dialog('close');
};
