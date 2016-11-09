var colNames_cn = ['ID','编号','会议主题','时间','主持人','记录人','参会人员','地点','内容','说明','是否追踪','追踪日期','结束日期'];
var colNames_tw = ['ID','編號','會議主題','時間','主持人','記錄人','參會人員','地點','內容','說明','是否追蹤','追蹤日期','結束日期'];
var caption = {zh: "会议列表", "zh_CN": "会议列表", "zh_TW": "會議列表"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};
var editor;
$(function(){
	$.fn.zTree.init($("#menu"), setting);
	
	//$("#traceDate,#endDate").datepicker({changeMonth:true,changeYear:true});
	
	//显示所有会议信息
	jQuery("#zgrid").jqGrid({
	   	url:'get_meeting.htm',
		datatype: "json",
		height:'auto',
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   		{name:'number',index:'number',width:70,align:"center",sortable:false},
	   		{name:'title',index:'title',width:90,align:"center"},
	   		{name:'time',index:'time',width:120,align:"center"},
	   		{name:'host',index:'host',width:70,align:"center"},
	   		{name:'notes',index:'notes',width:70,align:"center"},
	   		{name:'participants',index:'participants',width:123,align:"center",sortable:false},
	   		{name:'locale',index:'locale',width:180,align:"center",sortable:false},
	   		{name:'content',index:'content',hidden:true},
	   		{name:'explain',index:'explain',hidden:true},
	   		{name:'isTrace',index:'isTrace',hidden:true},
	   		{name:'traceDate',index:'traceDate',hidden:true},
	   		{name:'endDate',index:'endDate',hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#zpager',
	   	sortname: 'id',
	    viewrecords: true,
	    rownumbers:true,
	    sortorder: "asc",
		multiselect: false,
		jsonReader:{root:'list',repeatitems:false},
	});
	
	$('#zgrid').jqGrid('navGrid','#zpager',{addfunc:addDlg,editfunc:editDlg,del:false,search:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:false},{});
	
	//Form 验证字段内容
	$("#meetingForm").validate({  
		rules : {  
			"number":{required:true, minlength:3},  
			"title":{required:true},
			"locale":{required:true},
			"time":{required:true},
			"host":{required:true},
			"notes":{required:true},
			"participants":{required:true},
			"explain":{required:true}
	    },
	    onkeyup:false,
		messages : {
			number:{required:"编号不能为空！", minlength:"请至少输入3个以上字符！"},
			title:{required:"请填写会议主题！"},
			locale:{required:"请填写会议地点！"},
			time:{required:"请选择会议时间！"},
			host:{required:"请选择主持人！"},
			notes:{required:"请选择记录人！"},
			participants:{required:"参会人员不能为空，如多个请于逗号隔开！"},
			explain:{required:"请简述说明！"}
		}
	});
	
	$("#editForm").validate({  
		rules : {"participants":{required:true}, "content":{required:true}},
	    onkeyup:false,
		messages : {participants:{required:"参会人员多个请用逗号隔开！"}, content:{required:"请填写会议内容！"}}
	});
	
	
	//配置对话框
	$("#add_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:750,
		   buttons: {
			  "提交": addMeeting,
			  "取消": function() {$(this).dialog('close')}}
		});
	
	$("#edit_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:750,
		   buttons: {
			  "提交": editMeeting,
			  "取消": function() {$(this).dialog('close')}}
		});
	
	$("#user_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:450,
		   buttons: {
			  "确定": selectedUser,
			  "取消": function() {$(this).dialog('close')}}
		});
	
	//是否追踪选择
	$("#isTrace").click(function() {
		$('#traceDate').val('');
		$('#endDate').val('');
		if($(this).attr('checked')) {
			$('#traceDate_dd').show();
			$('#endDate_dd').hide();
		} 
		else {
			$('#traceDate_dd').hide();
			$('#endDate_dd').show();
		}
	});		
	
	//查找到所有部门遍历到department_SELECT
	$.post('../departments.htm',function(data){
		 var option = $("#hostDpt, #notesDpt");
		 option.empty();
		 option.append("<option value=''>选择部门</option>");
		 var user = "";
		 $.each(data, function(i, d){ 
			 option.append("<option value='"+d.id+"'>"+d.cname+"</option>"); 
			 user += "<label><input type='checkbox' onclick='getUser(this);' name='dpt' value='"+d.id+"' />"+d.cname+"</label>";
		 });
		 $("#user_main").find("#dpt_dl").html(user);
	},'json');
	
	//选择部门 加载此部门下面的 所有用户
	$('#hostDpt').change(function(){
		 var ad = $(this).val();
		 $('#host').empty();
		 if(ad){
			$.post('../dpt_users.htm',{'dpt':ad,'type':'DEPARTMENT', ismgr:false, 'user':'true'},function(data){
				var option = "";
				$.each(data, function(i,val){option += "<option value='" + val.ename + "'>" + val.ename + "</option>";});
				$('#host').append(option);
			},'json');
		 } else alert("请先选择部门！");
	});
	
	$('#notesDpt').change(function(){
		 var ad = $(this).val();
		 $('#notes').empty();
		 if(ad){
			$.post('../dpt_users.htm',{'dpt':ad, 'type':'DEPARTMENT', ismgr:false, 'user':'true'},function(data){
				var option = "";
				$.each(data, function(i,val){option += "<option value='" + val.ename + "'>" + val.ename + "</option>";});
				$('#notes').append(option);
			},'json');
		 } else alert("请先选择部门！");
	});
	
	//会议内容编辑器
	editor = KindEditor.create('textarea[name="content"]', {
		resizeType : 1,
		allowPreviewEmoticons : false,
		allowImageUpload : false,
		items : [
			'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
			'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'indent', 'outdent', 
			'subscript', 'superscript', 'insertorderedlist', 'insertunorderedlist', '|', 'fullscreen']
	});
	
}); 

//发起会议弹出窗
var addDlg = function() {
	var dlg = $("#add_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('提交')").show();
	dlg.dialog("option","title","发起会议");
	 
	dlg.find('#meetingForm')[0].reset();
	
	dlg.find('label.error').hide();
	dlg.dialog('open');
};

//修改弹出窗
var editDlg = function() {
	var dlg = $("#edit_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('提交')").show();
	  
	var selectrow = $("#zgrid").jqGrid("getGridParam", "selrow");
	if (selectrow) {
		var rd = $('#zgrid').jqGrid("getRowData", selectrow);
		dlg.dialog("option", "title", "会议补充");

		/** 会议基本信息 * */
		dlg.find('#cont, #describe,#describe,#staff').empty();
		dlg.find('#cont').prepend("<b>编号：</b>" + rd.number + "<p><b>会议主题</b>：" + rd.title + "<em>时间：" + rd.time + "</em></p>");
		dlg.find('#describe').prepend("<span><b>地点：</b>" + rd.locale + "</span>");
		dlg.find('#staff').prepend("<label>会议主持人/记录人：</label>" + rd.host + " / " + rd.notes + "");
		dlg.find('#editForm')[0].reset();
		
		dlg.find('#isTrace').attr('checked', true);
		dlg.find('#id').val(rd.id);
		dlg.find('#participants').val(rd.participants);
		dlg.find('#host').val(rd.host);
		dlg.find('#title').val(rd.title);
		dlg.find('#time').val(rd.time);
		dlg.find('#traceDate').val(rd.traceDate);
		dlg.find('#endDate').val(rd.endDate);
		dlg.find('#content').val(rd.content);
		editor.html(rd.content);
		dlg.find('#explain').val(rd.explain);
		
		dlg.find('#traceDate_dd').show();
		dlg.find('#endDate_dd').hide();
		dlg.find('label.error').hide();
		dlg.dialog('open');
	}
};

//添加、发起会议
var addMeeting = function() {
	var dlg = $('#add_main');
	// 验证表单如果通过则提交
	if (dlg.find("#meetingForm").valid()) {
		$.post('save_meeting.htm', dlg.find("#meetingForm").serialize(),
				function(data) {
					if (data != null && data.result == "SUCCESS") {
						$("#zgrid").jqGrid("addRowData", data.meeting.id, data.meeting, "first");
						alert("会议发起成功！");
						dlg.dialog("close");
					} 
					else if(data.result == "UNSUPPORT") alert("用户邮件设置有务，请用户正确设置发送邮箱号！");
					else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
					else if(data.result == "INVALID") alert("会议内容过长，请减少内容编辑再次提交！");
					else if(data.result == "ERROR") alert("添加操作失败,可能因为邮箱服务出错或邮件发送方式错误！");
				}, 'json');
	}
};

//再次完整会议（修改）
var editMeeting = function() {
	var dlg = $('#edit_main');
	dlg.find("#content").val(editor.html());
	if (dlg.find("#editForm").valid()) {
		$.post('save_meeting.htm', dlg.find("#editForm").serialize(), function(data) {
			if (data != null && data.result == "SUCCESS") {
				$("#zgrid").jqGrid("setRowData", data.meeting.id, data.meeting, { color : "#FF0000" });
				alert("操作成功！");
				dlg.dialog("close");
			} else if (data.result == "PARAM_EMPTY")
				alert("请填写完整后再提交！");
			else
				alert("操作失败，请检查收件邮箱是否设置正确！");
		}, 'json');
	}
};

//参会人员选择
var userDlg = function () {
	var dlg = $("#user_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('确定')").show();
	dlg.dialog("option","title","参会人员选择");
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
				du += "<label><input type='checkbox' checked='checked' name='puser' value='"+u.ename+"' />"+u.cname+"</label>";
			});
			user.append("<div id='du"+id+"'>"+du+"</div>");
		},'json');
	 } 
	else user.find("#du"+id).empty();
};

//确定把值传给文本框
var selectedUser = function () {
	var user = $("#user_main").find('#user_dl');
	var ids = new Array();
	var i=0;
	user.find("input[name=puser]:checked").each(function(){ ids[i++] = $(this).val(); });
	$("#add_main").find("#participants").val(ids);
	$("#user_main").dialog('close');
};