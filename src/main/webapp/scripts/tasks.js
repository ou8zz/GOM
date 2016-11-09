$(function(){
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	
//	$("#expectedStart,#expectedEnd").datepicker({changeMonth:true,changeYear:true});
	
	//任务文档上传
	$('#documents').uploadify({
		  'uploader':'../common/uploadify.swf',
		  'script':'../upload.htm',
		  'cancelImg':'../images/cancel.png',
		  'fileExt':'*.docx;*.doc',
		  'fileDesc':'只允许上传(.doc, .docx)',
		  'sizeLimit':102400,
		  'buttonImg':'../images/browse.jpg',
		  'displayData':'speed',
		  'expressInstall':'../common/expressInstall.swf',
		  'auto':true,
		  'onComplete':function(event,ID,fileObj,response,data) {
			  var obj = $.parseJSON(response);
			  $('#document').val(obj.fileName);
		  },
		  'onError':function(event, queueID, fileObj) {
			  alert("文件:" + fileObj.name + "上传失败！");
		  }
	});

	//进度文档上传
	$('#attachments').uploadify({
		  'uploader':'../common/uploadify.swf',
		  'script':'../upload.htm',
		  'cancelImg':'../images/cancel.png',
		  'fileExt':'*.docx;*.doc',
		  'fileDesc':'只允许上传(.doc, .docx)',
		  'sizeLimit':102400,
		  'buttonImg':'../images/browse.jpg',
		  'displayData':'speed',
		  'expressInstall':'../common/expressInstall.swf',
		  'auto':true,
		  'onComplete':function(event,ID,fileObj,response,data) {
			  var obj = $.parseJSON(response);
			  $('#attachment').val(obj.fileName);
		  },
		  'onError':function(event, queueID, fileObj) {
			  alert("文件:" + fileObj.name + "上传失败！");
		  }
	});
}); 

//点击TR触发radio选中事件
function select(id) {$("#p"+id).attr("checked",true);}

//下载文档操作
var downDocument = function() {
	var selectrow = $("#task_tb").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
		var rd = $('#task_tb').jqGrid("getRowData", selectrow);
		downAttachment(rd.document);	//附件下载
	 }
}

//下载附件方法
function downAttachment(file) {
	if(!isNull(file)) {
		$.post('../find_file.htm',{fileName:file},function(data){
		     if(data.result == "SUCCESS") {
		    	 location.href="../download.htm?fileName="+file;
		     } else alert("抱歉！此文档可能丢失或找不到这个文件！");
		},'json');
	} else alert("抱歉！没有这个文档！");
}

//分配类型grid格式化
function assignTypefmt(cellvalue, options, rowObject){var tmp;if(cellvalue=="PERSON") tmp="个人";else if(cellvalue=="DEPARTMENT") tmp="部门";return tmp;}
//工作类型grid格式化
function taskTypefmt(cellvalue, options, rowObject){var tmp;if(cellvalue=="REGULAR") tmp="固定";else if(cellvalue=="PLAN") tmp="计划";else if(cellvalue=="TEMPORARY") tmp="临时";return tmp;}
//NODE枚举格式化
function nodefmt(cellvalue){
	var tmp;
	if(cellvalue=="DEPARTMENT") tmp="部门";
	else if(cellvalue=="ALLOCATION") tmp="分配人";
	else if(cellvalue=="EXECUTOR") tmp="执行人";
	return tmp;
}
