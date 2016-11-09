
var colNames_cn = ['ID','开始日期','结束日期', '学历', '学校','专业','证书编号','idScan'];
var colNames_tw = ['ID','開始日期','結束日期', '學歷', '學校','專業','證書編號','idScan'];

var caption = {zh: "教育经历", "zh_CN": "教育经历", "zh_TW": "教育經歷"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(document).ajaxStop($.unblockUI);
$(function(){
	$.fn.zTree.init($('#menu'), setting);
	
	//学历开始时间不能大于结束时间
	$("#startDate").datepicker({defaultDate: "+1w",changeMonth: true, changeYear: true, numberOfMonths: 3,onClose: function( selectedDate ) {$("#endDate").datepicker( "option", "minDate", selectedDate );}});
	$("#endDate").datepicker({defaultDate: "+1w",changeMonth: true, changeYear: true, numberOfMonths: 3,onClose: function( selectedDate ) {$("#startDate").datepicker( "option", "maxDate", selectedDate );}});
	
	//身份证上传
	var jcrop_api,boundx,boundy;
	$('#thumbnail').hide();
	$('#idScanImg').uploadify({
		  'uploader':'../common/uploadify.swf',
		  'script':'../upload.htm',
		  'cancelImg':'../images/cancel.png',
		  'fileExt':'*.jpg;*.png',
		  'fileDesc':'只允许上传(.JPG,.PNG)',
		  'sizeLimit':512000,
		  'buttonImg':'../images/browse.jpg',
		  'displayData':'speed',
		  'expressInstall':'../common/expressInstall.swf',
		  'auto':true,
		  'onComplete':function(event,ID,fileObj,response,data) {
			  var obj = $.parseJSON(response);
			  $('#thumbnail').show();
			  $('#idScan').attr("value", obj.fileName);
			  $('#tmp_img').attr("src", "../uploads/images/"+obj.fileName);
			  $('#preview').attr("src", "../uploads/images/"+obj.fileName);
			  $('#tmp_img').Jcrop({boxWidth:670,boxHeight:670,onChange:showPreview,onSelect:showPreview,aspectRatio:5/3},function(){var bounds=this.getBounds();boundx=bounds[0];boundy=bounds[1];jcrop_api=this;});
			  jcrop_api.setImage("../uploads/images/"+obj.fileName);
			  alert("上传成功！");
		  },
	      'onSelect':function(event, queueID, fileObj){
	    	  //选择的文件对象，fileObj有name、size、creationDate、modificationDate、type 5个属性。
	      },
		  'onError':function(event, queueID, fileObj) {
			  if(fileObj.size > 512000) alert("您上传的文件已经超过限制文件(500kb)大小");
			  else alert("文件:" + fileObj.name + "上传失败！");
		  }
	});
	function showPreview(c){
		 $('#zw').val(c.w);
		 $('#zh').val(c.h);
		 $('#x').val(c.x);
		 $('#y').val(c.y);
		  if(parseInt(c.w) > 0){var rx=450/c.w;var ry=270/c.h;
		  $('#preview').css({
			  width:Math.round(rx*boundx)+'px', 
			  height:Math.round(rx*boundy)+'px', 
			  marginLeft:'-'+Math.round(rx*c.x)+'px',
			  marginTop:'-'+Math.round(ry*c.y)+'px'});
		  }
	};
	  
	$('#crop_submit').click(function(){
		  if(parseInt($('#x').val())) {
			  $.post('../crop.htm', {w:450,h:270,'zw':$('#zw').val(),'zh': $('#zh').val(),'x':$('#x').val(),'y': $('#y').val(),'oriName':$('#idScan').val()}, function(data) { 
					if(data.result == "SUCCESS") {
						$('#idScan').attr("value",data.fileName);
						$('#idscan').attr("src","../uploads/images/"+data.fileName);
						$('#tmp_img').attr("src","");
						$('#preview').attr("src","");
						$('#thumbnail').hide();
						alert("裁剪成功！");
						jcrop_api.destroy();
						} else { alert("生成略缩头像失败");} 
				},'json');
		  }else{alert("要先在图片上划一个选区再单击确认剪裁的按钮哦！");	}
	});
    
	//显示用户的所有教育经历
	jQuery("#edu_tb").jqGrid({
		height: 350,
		width:793,
	   	url:'get_education.htm',
		datatype: "json",
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   		{name:'startDate',index:'startDate',width:90,align:"center",sortable:false},
	   		{name:'endDate',index:'endDate',width:90,align:"center",sortable:false},
	   		{name:'ed',index:'ed', width:70,align:"center",sortable:false},
	   		{name:'school',index:'school',width:90,align:"center",sortable:false},		
	   		{name:'major',index:'major',width:90,align:"center",sortable:false},
	   		{name:'idno',index:'idno',width:120,align:"center",sortable:false},
	   		{name:'idScan',index:'idScan',hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20],
	   	pager: '#edu_pg',
	   	sortname: 'id',
	    viewrecords: true,
	    sortorder: "asc",
		multiselect: false,
		editurl:"",
		jsonReader:{root:'list',repeatitems:false}
	}).navGrid('#edu_pg',{addfunc:addEduDlg,editfunc:editEduDlg,del:false,search:false,view:false});
			
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:700,
		   buttons: {
			  "添加": addEdu,
			  "修改": editEdu,
			  "取消": function() {$(this).dialog('close')}}
		 });
		
	$("#gConsole").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:180,
		   buttons: {
		      "删除": delEdu,
			  "取消": function() {$(this).dialog('close')}
			  }
		 }); 
		
	//Form 验证字段内容
	$("#eduForm").validate({  
		rules : {  
			"startDate":{required:true},  
			"endDate":{required:true},
			"ed":{required:true},
			"school":{required:true},
			"major":{required:true},  
			"idno":{required:true},
			"idScan":{required:true}
	    },
	    onkeyup:false,
		messages : {
			startDate:{required:"开始日期不能为空！"},
			endDate:{required:"结束日期不能为空！"},
			ed:{required:"学历/职称不能为空！"},
			school:{required:"学校不能为空！"},
			major:{required:"专业不能为空！"},
			idno:{required:"证书编号不能为空！"},
			idScan:{required:"请上传证书扫描件！"}
		}
	});
	
}); 

var addEduDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('添加')").show();
	 dlg.dialog("option","title","添加教育经历");
	 
	 dlg.find('#eduForm')[0].reset();
	 dlg.find("label.error").remove();

	 dlg.find('#idscan').attr("src",'../uploads/images/null.jpg');
	 dlg.dialog('open');
};
var editEduDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('修改')").show();
	 
	 dlg.find("label.error").remove();
	 
	 var selectrow = $("#edu_tb").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	 var rd = $('#edu_tb').jqGrid("getRowData", selectrow);
	   dlg.dialog("option","title","编辑教育经历");
	   dlg.find('#id').val(rd.id);
	   dlg.find('#startDate').val(rd.startDate);
	   dlg.find('#endDate').val(rd.endDate); 
	   dlg.find('#ed').val(rd.ed);
	   dlg.find('#school').val(rd.school);
	   dlg.find('#major').val(rd.major);
	   dlg.find('#idno').val(rd.idno);
	   dlg.find('#idScan').val(rd.idScan);
	   dlg.find('#idscan').attr("src",'../uploads/images/'+rd.idScan);
	   dlg.dialog('open');
	 }
};
var delEduDlg = function() {
	var dlg = $("#gConsole");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('删除')").show();
	dlg.dialog("option","title","删除").dialog('open');
};
var addEdu = function() {
	var dlg = $('#content_main');
	var params = {id:$.trim(dlg.find("#id").val()),
			startDate:$.trim(dlg.find("#startDate").val()),
			endDate:$.trim(dlg.find("#endDate").val()),
			ed:$.trim(dlg.find("#ed").val()),
			school:$.trim(dlg.find("#school").val()),
			major:$.trim(dlg.find("#major").val()),
			idno:$.trim(dlg.find("#idno").val()),
			idScan:$.trim(dlg.find("#idScan").val())
	};
	
	//验证方法
	if (dlg.find('#eduForm').valid()) {
		$.post('save_education.htm',params,function(data){
		     if(data.result == "SUCCESS") {
				$("#edu_tb").jqGrid("addRowData", data.edu.id, data.edu, "first");
				alert("添加成功！");
		        dlg.dialog("close");
			  }
			 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
			 else alert("添加操作失败！");
		},'json');	
	}
};
var editEdu = function() {
	var dlg = $('#content_main');
	var params = {
		id : $.trim(dlg.find("#id").val()),
		startDate : $.trim(dlg.find("#startDate").val()),
		endDate : $.trim(dlg.find("#endDate").val()),
		ed : $.trim(dlg.find("#ed").val()),
		school : $.trim(dlg.find("#school").val()),
		major : $.trim(dlg.find("#major").val()),
		idno : $.trim(dlg.find("#idno").val()),
		idScan : $.trim(dlg.find("#idScan").val())
	};
	// 验证方法
	if (dlg.find('#eduForm').valid()) {
		$.post('save_education.htm', params, function(data) {
			if (data.result == "SUCCESS") {
				var dr = {
					startDate : params.startDate,
					endDate : params.endDate,
					ed : params.ed,
					school : params.school,
					major : params.major,
					idno : params.idno,
					idScan : params.idScan
				};
				$("#edu_tb").jqGrid("setRowData", params.id, dr, { color : "#FF0000" });
				alert("更新成功！");
				dlg.dialog("close");
			} else if (data.result == "PARAM_EMPTY")
				alert("请填写完整后再提交！");
			else
				alert("更新操作失败！");
		}, 'json');
	}
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
			alert("删除成功！");
		  }else alert("删除操作失败！");
		});
	  }else alert("请选择需要删除的条目！");
};

$.fn.hoverClass = function(classname) {
	return this.hover(function() {
		$(this).addClass(classname);
	}, function() {
		$(this).removeClass(classname);
	});
};
