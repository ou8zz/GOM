var colNames_cn = ['ID','工作号','部门','职务','英文名','邮箱','手机','民族','性别','出生年月','中文名','性别','部门ID','职务ID','密码','邮箱密码','身份证号','身份证扫描件','户籍','开户银行','银行号','身高','婚姻','私人信箱','固话','分机号','个人头像','菜单通用'];
var colNames_tw = ['ID','工作號','部門','職務','英文名','郵箱','手機','民族','性別','出生年月','中文名','性別','部門ID','職務ID','密碼','郵箱密碼','身份證號','身份證掃描件','戶籍','開戶銀行','銀行號','身高','婚姻','私人信箱','固話','分機號','個人頭像','菜單通用'];
var acolNames_cn = ['ID号','联系人','关系','邮编','手机','电话','地址类型','地址'];
var acolNames_tw = ['ID號','聯系人','關系','郵編','手機','電話','地址類型','地址'];
var ecolNames_cn = ['ID号','开始日期','结束日期','学历','学校','专业','证书编号','证书扫描件'];
var ecolNames_tw = ['ID號','開始日期','結束日期','學歷','學校','專業','證書編號','證書掃描件'];
var caption = {zh: "用户信息列表", "zh_CN": "用户信息列表", "zh_TW": "用戶信息列表"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};
var acaption = {zh: "联系人地址信息", "zh_CN": "联系人地址信息", "zh_TW": "聯系人地址信息"};
var acolNames = {zh: acolNames_cn, "zh_CN": acolNames_cn, "zh_TW": acolNames_tw};
var ecaption = {zh: "教育/培训经历", "zh_CN": "教育/培训经历", "zh_TW": "教育/培訓經歷"};
var ecolNames = {zh: ecolNames_cn, "zh_CN": ecolNames_cn, "zh_TW": ecolNames_tw};

$(function(){
	$.fn.zTree.init($("#menu"), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	
	$("#cell").mask("(99)999-9999-9999");
	$("#zipcode").mask("999999");
	$("#birthday").datepicker({changeMonth:true,changeYear:true});
	
	//学历开始时间不能大于结束时间
	$("#startDate").datepicker({defaultDate: "+1w",changeMonth: true, changeYear: true, numberOfMonths: 3,onClose: function( selectedDate ) {$("#endDate").datepicker( "option", "minDate", selectedDate );}});
	$("#endDate").datepicker({defaultDate: "+1w",changeMonth: true, changeYear: true, numberOfMonths: 3,onClose: function( selectedDate ) {$("#startDate").datepicker( "option", "maxDate", selectedDate );}});
	
	
	//教育毕业证上传
	$('#idScanImg').uploadify({
		  'uploader':'../common/uploadify.swf',
		  'script':'../upload.htm',
		  'cancelImg':'../images/cancel.png',
		  'fileExt':'*.jpg;*.gif;*.png',
		  'fileDesc':'只允许上传(.JPG,.PNG)',
		  'sizeLimit':102400,
		  'buttonImg':'../images/browse.jpg',
		  'displayData':'speed',
		  'expressInstall':'../common/expressInstall.swf',
		  'auto':true,
		  'onComplete':function(event,ID,fileObj,response,data) {
			  var obj = $.parseJSON(response);
			  var edudlg = $('#content_edu');
			  edudlg.find('#idScan').attr("value",obj.fileName);
			  edudlg.find('#idScanShow').attr("src",'../uploads/images/'+obj.fileName);
			  alert("上传成功！");
		  },
		  'onError':function(event, queueID, fileObj) {
			  alert("文件:" + fileObj.name + "上传失败！");
		  }
	 });
	
	//显示所有用户信息
	jQuery("#users_tb").jqGrid({
	   	url:'get_users.htm',
		datatype: "json",
		height:330,
		width:'auto',
		caption: caption[lang],
		colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   		{name:'jobNo',index:'jobNo',width:93,align:"center"},
	   		{name:'cdepartment',index:'cdepartment',align:"center"},
	   		{name:'cposition',index:'cposition',width:60,align:"center",sortable:false},
	   		{name:'ename',index:'ename',width:80,align:"center"},
	   		{name:'email',index:'email',width:220,align:"center",sortable:false},		
	   		{name:'cell',index:'cell', width:130,align:"center",sortable:false},
	   		{name:'nation',index:'nation', width:60,align:"center",sortable:false},
	   		{name:'gender',index:'gender',width:50,align:"center",formatter:genderType,sortable:false}, //格式化function
	   		{name:'birthday',index:'birthday',width:80,align:"center"},
	   		{name:'cname',index:'cname',hidden:true},
	   		{name:'gender',index:'gender',hidden:true},
	   		{name:'dptId',index:'dptId',hidden:true},
	   		{name:'pstId',index:'pstId',hidden:true},
	   		{name:'pwd',index:'pwd',hidden:true,readonly:true},
	   		{name:'emailPwd',index:'emailPwd',hidden:true,readonly:true},
	   		{name:'idcard',index:'idcard',hidden:true},
	   		{name:'idScan',index:'idScan',hidden:true},
	   		{name:'censusType',index:'censusType',hidden:true},
	  		{name:'bank',index:'bank',hidden:true},
	  		{name:'accountNo',index:'accountNo',hidden:true},
	  		{name:'height',index:'height',hidden:true},
	  		{name:'marriage',index:'marriage',hidden:true},
	  		{name:'privateMail',index:'privateMail',hidden:true},
	  		{name:'phone',index:'phone',hidden:true},
	  		{name:'telExt',index:'telExt',hidden:true},
	  		{name:'portrait',index:'portrait',hidden:true},
	  		{name:'generic',index:'generic',hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#users_pg',
	   	sortname: 'id',
	    viewrecords: true,
	    sortorder: "asc",
		multiselect: false,
		jsonReader:{root:'list',repeatitems:false},
		grouping: true,
	   	groupingView: {
	   		groupField:['cdepartment'],
	   		groupColumnShow : [false],
	   		groupText : ['<b>{0}</b> - <b>{1} 条</b>']
	   	},
		onSelectRow: function(ids) {
			if(ids == null) {
				ids=0;
				if(jQuery("#edu_tb").jqGrid('getGridParam','records') >0 ) {
					jQuery("#edu_tb").jqGrid('setGridParam',{url:"get_education.htm?q=1&id="+ids,page:1});
					jQuery("#edu_tb").jqGrid('setCaption',"教育经历").trigger('reloadGrid');
					
					jQuery("#addr_tb").jqGrid('setGridParam',{url:"get_address.htm?q=1&id="+ids,page:1});
					jQuery("#addr_tb").jqGrid('setCaption',"地址列表").trigger('reloadGrid');
				}
			} else {
				jQuery("#edu_tb").jqGrid('setGridParam',{url:"get_education.htm?q=1&id="+ids,page:1});
				jQuery("#edu_tb").jqGrid('setCaption',"教育经历").trigger('reloadGrid');
				
				jQuery("#addr_tb").jqGrid('setGridParam',{url:"get_address.htm?q=1&id="+ids,page:1});
				jQuery("#addr_tb").jqGrid('setCaption',"地址列表").trigger('reloadGrid');
			}
		}
	});
	
	$('#users_tb').jqGrid('navGrid','#users_pg',{add:false,editfunc:editUserDlg,del:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:true},{});
	
	//显示用户的所有教育经历
	jQuery("#edu_tb").jqGrid({
		height: 100,
		width:793,
	   	url:'',
		datatype: "json",
		caption: ecaption[lang],
	   	colNames: ecolNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   		{name:'startDate',index:'startDate',width:90,align:"center"},
	   		{name:'endDate',index:'endDate',width:90,align:"center"},
	   		{name:'ed',index:'ed', width:70,align:"center"},
	   		{name:'school',index:'school',width:90,align:"center"},		
	   		{name:'major',index:'major',width:90,align:"center"},
	   		{name:'idno',index:'idno',width:120,align:"center"},
	   		{name:'idScan',index:'idScan',hidden:true}
	   	],
	   	rowNum:5,
	   	rowList:[5,10,20],
	   	pager: '#edu_pg',
	   	sortname: 'id',
	    viewrecords: true,
	    sortorder: "asc",
		multiselect: false,
		editurl:"save_education.htm",
		jsonReader:{root:'list',repeatitems:false}
	}).navGrid('#edu_pg',{add:false,editfunc:editEduDlg,del:false,search:false,view:true});
		
	//显示用户所有的地址信息
	jQuery("#addr_tb").jqGrid({
		height:100,
		width:793,
	   	url:'',
		datatype: "json",
		caption: acaption[lang],
	   	colNames: acolNames[lang],
	   	colModel:[
	   	     {name:'id',index:'id',hidden:true},
	   		{name:'contact',index:'contact',width:100,align:"center"},
	   		{name:'relation',index:'relation',width:60,align:"center"},
	   		{name:'zipcode',index:'zipcode',width:80,align:"center"},
	   		{name:'cell',index:'cell',width:120,align:"center"},		
	   		{name:'phone',index:'phone',width:120,align:"center"},
	   		{name:'addrType',index:'addrType',width:120,align:"center",formatter:addrType},
	   		{name:'address',index:'address', width:250,align:"center"}
	   	],
	   	rowNum:5,
	   	rowList:[5,10,20],
	   	pager: '#addr_pg',
	   	sortname: 'id',
	    viewrecords: true,
	    sortorder: "asc",
		multiselect: false,
		editurl:"save_address.htm",
		jsonReader:{root:'list',repeatitems:false}
	}).navGrid('#addr_pg',{add:false,editfunc:editAddrDlg,del:false,search:false,view:true});

	
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:750,
		   buttons: {
			  "修改": editUser,
			  "取消": function() {$(this).dialog('close')}}
		 });
	
	$("#content_edu").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:700,
		   buttons: {
			  "修改": editEdu,
			  "取消": function() {$(this).dialog('close')}}
		 });
	
	$("#content_addr").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:700,
		   buttons: {
			  "修改": editAddr,
			  "取消": function() {$(this).dialog('close')}}
		 });
	
	$("#gConsole").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:180,
		   buttons: {
		      "删除用户":delUser,
		      "删除地址":delAddr,
		      "删除教育":delEdu,
			  "取消": function() {$(this).dialog('close')}
			  }
		 }); 
	
	//用户验证validate
	$('#userForm').validate({
		rules:{
			cell:"required",
			phone:"required",
			privateMail:{required:true,email:true},
			telExt:{required:true,number:true},
			bank:"required",
			accountNo:{required:true,number:true},
			idScan:"required",
			portrait:"required"
		},
		messages:{
			cell:{required:"为方便联系，请填写手机号", mobileCN:"正确格式:(86)138-1760-1860"},
			phone:{required:"固定电话留一个", phoneCN:"正确格式：86(21)1760-1860"},
			privateMail:{required:"私人邮箱留个以防公司邮箱出问题", email:"邮箱格式有误"},
			telExt:{required:"输入公司分配的分机号",number:"输入有误，分机号只能为数字"},
			bank:"输入开户行名称",
			accountNo:{required:"确认银行账号正确",number:"银行账号只能为数字"},
			idScan:"请上传身份证扫描件",
			portrait:"请上传个人头像"
		},
		invalidHandler: function(e, validator) {
			var errors = validator.numberOfInvalids();
			if (errors) {
				var message = errors == 1 ? '高亮显示的栏位为空，请填写完后再提交' : '你有 ' + errors + ' 栏位为空或有误.  请按错误提示来更正';
				$("div.error span").html(message);
				$("div.error").show();
			} else {
				$("div.error").hide();
			}
		},
		onkeyup:false,
		submitHandler:function(form) {
			$("div.error").hide();
			if(oldform == $("#userForm").serialize()) return false;	//是否有修改
		},
		debug:false
	});
	
	//地址和教育信息验证validate
	$('#eduForm').validate();
	$('#addrForm').validate();
}); 

//弹出用户信息窗口
var editUserDlg = function() {
	var dlg = $("#content_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('修改')").show();
	 
	var selectrow = $("#users_tb").jqGrid("getGridParam", "selrow");
	if(selectrow) {
	   var rd = $('#users_tb').jqGrid("getRowData", selectrow);
	   dlg.dialog("option","title","编辑 － " + rd.cname);
	   
	   dlg.find('#group').empty().prepend("<b>工号" + rd.jobNo + "</b><span>" + rd.cname + "(" + rd.ename + ")</span><span>" + rd.cdepartment + "</span><span>" + rd.cposition + "</span><p><em>邮箱：" + rd.email + "</em></p>");
	   
	   dlg.find('#id').val(rd.id);
	   dlg.find('#cname').val(rd.cname);
	   dlg.find('#cell').val(rd.cell);
	   dlg.find('#gender').val(rd.gender); 
	   dlg.find('#birthday').val(rd.birthday);
	   dlg.find('#nation').val(rd.nation);
	   dlg.find('#censusType').val(rd.censusType);
	   dlg.find('#idcard').val(rd.idcard);
	   dlg.find('#bank').val(rd.bank);
	   dlg.find('#accountNo').val(rd.accountNo);
	   dlg.find('#height').val(rd.height);
	   dlg.find('#marriage').val(rd.marriage);
	   dlg.find('#privateMail').val(rd.privateMail);
	   dlg.find('#phone').val(rd.phone);
	   dlg.find('#telExt').val(rd.telExt);
	   
	   var bool = true;
	   if(rd.generic=='false') bool = false;
	   $("input[name=generic]").attr('checked', bool);
	   
	   dlg.dialog('open');
	}
};
//POST提交用户信息
var editUser = function() {
	var dlg = $('#content_main');
	var params = {id:$.trim(dlg.find("#id").val()),
		cname:$.trim(dlg.find("#cname").val()),
		cell:$.trim(dlg.find("#cell").val().replace(/\s+/g,"")),
		gender:$.trim(dlg.find("#gender").val()),
		idcard:$.trim(dlg.find("#idcard").val().replace(/\s+/g,"")),
		nation:$.trim(dlg.find("#nation").val()),
		censusType:$.trim(dlg.find("#censusType").val()),
		birthday:$.trim(dlg.find("#birthday").val()),
		bank:$.trim(dlg.find("#bank").val()),
		accountNo:$.trim(dlg.find("#accountNo").val().replace(/\s+/g,"")),
		height:$.trim(dlg.find("#height").val()),
		marriage:$.trim(dlg.find("#marriage").val()),
		privateMail:$.trim(dlg.find("#privateMail").val()),
		phone:$.trim(dlg.find("#phone").val()),
		telExt:$.trim(dlg.find("#telExt").val()),
		generic:Boolean($("input[name=generic]:checked").val())		//如果选中设置为Boolean.true未选择为空设置为Boolean.false
	};

	if($("#userForm").valid()) {
		$.post('save_user.htm', params, function(data){
			if(data.result == "SUCCESS") {
				var dr = {cname:params.cname,
						cell:params.cell,
						gender:params.gender,
						idcard:params.idcard,
						nation:params.nation,
						censusType:params.censusType,
						birthday:params.birthday,
						bank:params.bank,
						accountNo:params.accountNo,
						height:params.height,
						marriage:params.marriage,
						privateMail:params.privateMail,
						phone:params.phone,
						telExt:params.telExt
					};
			    $("#users_tb").jqGrid("setRowData", params.id, dr, {color:"#FF0000"});
				alert(dr.cname + " －  更新成功！");
		        dlg.dialog("close");
			}
			else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
			else alert("更新操作失败！");
		},'json');
	}
};

var delUserDlg = function() {
	var dlg = $("#gConsole");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('删除用户')").show();
	dlg.dialog("option","title","删除用户").dialog('open');
};

var delUser = function() {
	var tid = $("#users_tb").jqGrid('getGridParam','selrow');
	if(tid) {
	   var rd = $('#users_tb').jqGrid("getRowData", tid);
	   $.getJSON('del_user.htm',{'id':$.trim(rd.id),'ename':$.trim(rd.ename)},function(data){
		   if(data.result=="SUCCESS") {
			   $('#users_tb').jqGrid("delRowData",tid);
			   $("#gConsole").dialog("close");
			   alert("用户删除成功！");
		   }
		   else alert("用户删除操作失败！");
	   });
	}
	else alert("请选择需要删除的条目！");
};

//弹出教育信息窗口
var editEduDlg = function() {
	var dlg = $("#content_edu");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('修改')").show();
	  
	var selectrow = $("#edu_tb").jqGrid("getGridParam", "selrow");
	if(selectrow) {
		var rd = $('#edu_tb').jqGrid("getRowData", selectrow);
		dlg.dialog("option","title","编辑教育信息");
		dlg.find('#id').val(rd.id);
		dlg.find('#startDate').val(rd.startDate);
		dlg.find('#endDate').val(rd.endDate); 
		dlg.find('#ed').val(rd.ed);
		dlg.find('#school').val(rd.school);
		dlg.find('#major').val(rd.major);
		dlg.find('#idno').val(rd.idno);
		dlg.find('#idScan').val(rd.idScan);
		dlg.find('#idScanShow').attr("src",'../uploads/images/'+rd.idScan);
		dlg.dialog('open');
	}
};
//POST提交教育信息
var editEdu = function() {
	var dlg = $('#content_edu');
	var params = {id:$.trim(dlg.find("#id").val()),
			startDate:$.trim(dlg.find("#startDate").val()),
			endDate:$.trim(dlg.find("#endDate").val()),
			ed:$.trim(dlg.find("#ed").val()),
			school:$.trim(dlg.find("#school").val()),
			major:$.trim(dlg.find("#major").val()),
			idno:$.trim(dlg.find("#idno").val()),
			idScan:$.trim(dlg.find("#idScan").val())
	};
	
	if (dlg.find('#eduForm').valid()) {
		$.post('save_education.htm',params,function(data){
			if(data.result == "SUCCESS") {
				var dr = {startDate:params.startDate,endDate:params.endDate,ed:params.ed,school:params.school,major:params.major,idno:params.idno};
				$("#edu_tb").jqGrid("setRowData", params.id, dr, {color:"#FF0000"});
				alert("操作成功！");
		        dlg.dialog("close");
			}
			else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
			else alert("更新操作失败！");
		},'json');
	}
};
var delEduDlg = function() {
	var dlg = $("#gConsole");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('删除教育')").show();
	dlg.dialog("option","title","删除用户").dialog('open');
};
var delEdu = function() {
	 var dlg = $("#gConsole");
	 var tid;
	 tid = jQuery("#edu_tb").jqGrid('getGridParam','selarrrow');
	 if(tid) {
	    $.getJSON('del_education.htm',{'id':tid},function(data){
		  if(data.result=="SUCCESS") {
		    $('#edu_tb').jqGrid("delRowData",tid);
			dlg.dialog("close");
			alert("用户删除成功！");
		  }else alert("用户删除操作失败！");
		});
	  }else alert("请选择需要删除的条目！");
};

//弹出地址修改窗口
var editAddrDlg = function() {
	 var dlg = $("#content_addr");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('修改')").show();
	  
	 var selectrow = $("#addr_tb").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	 var rd = $('#addr_tb').jqGrid("getRowData", selectrow);
	   dlg.dialog("option","title","编辑地址信息");
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
//POST提交地址信息
var editAddr = function() {
	var dlg = $('#content_addr');
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
		$.post('save_address.htm', params, function(data){
		      if(data.result == "SUCCESS") {
		    	  var dr = {contact:params.contact,relation:params.relation,zipcode:params.zipcode,cell:params.cell,phone:params.phone,addrType:params.addrType,address:params.address};
		    	  $("#addr_tb").jqGrid("setRowData", params.id, dr, {color:"#FF0000"});
		    	  alert("操作成功！");
		    	  dlg.dialog("close");
			  }
		      else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		      else alert("更新操作失败！");
		},'json');
	}
};
var delAddrDlg = function() {
	var dlg = $("#gConsole");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('删除地址')").show();
	dlg.dialog("option","title","删除用户").dialog('open');
};
var delAddr = function() {
	 var dlg = $("#gConsole");
	 var tid;
	 tid = jQuery("#addr_tb").jqGrid('getGridParam','selarrrow');
	 if(tid) {
	    $.getJSON('del_address.htm',{'id':tid},function(data){
		  if(data.result=="SUCCESS") {
		    $('#addr_tb').jqGrid("delRowData",tid);
			dlg.dialog("close");
			alert("用户删除成功！");
		  }else alert("用户删除操作失败！");
		});
	  }else alert("请选择需要删除的条目！");
};
