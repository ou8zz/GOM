var sizeLimit = 4248576;
var fileExt = '*.jpg;*.gif;*.png;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;';
var fileDesc = '您可以上传(JPG,PNG,GIF,DOC,XLS,PPT)小于4M的文件！';
var sub_count = 0;

$(function(){
	$.fn.zTree.init($("#menu"), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});

	//文件上传
	$('#atta').uploadify({
		  'uploader':'../common/uploadify.swf',
		  'script':'../upload.htm',
		  'cancelImg':'../images/cancel.png',
		  'fileExt':fileExt,
		  'fileDesc':fileDesc,
		  'sizeLimit':sizeLimit,
		  'buttonImg':'../images/browse.jpg',
		  'displayData':'speed',
		  'expressInstall':'../common/expressInstall.swf',
		  'auto':true,
		  'onComplete':function(event,ID,fileObj,response,data) {
			  var obj = $.parseJSON(response);
			  $('#attachment').attr("value",obj.fileName);
			  alert("上传成功！");
		  },
		  'onError':function(event, queueID, fileObj) {
			  if(fileObj.size > sizeLimit) alert("您上传的文件已经超过限制文件大小");
			  alert("文件:" + fileObj.name + "上传失败！");
		  }
	});
	
	//查找
	$("#search").click(function(){document.location.href = "resource.htm?type="+$("#filetype").val()+"&&name="+$("#filename").val();});
	
	//重置
	$("#reset").click(function(){document.location.href = "resource.htm";});
	
	//加载文件类型select数据   <查询条件>
	$("#filetype").val($("#ftype").val());
	
	//类型分类
	$("#filetype").change(function() {document.location.href = "resource.htm?type="+$(this).val();});
	
	//预先添加目录列表
	$.post('../get_ctree.htm',function(data){
		var path = $("#content_main").find('#path').empty();
		if(!isEmpty(data)) {
			$.each(data, function(i, c) {
				var nbsp = "";
				var node = c.node.split(".").length;
				for(var i=1; i<node; i++) {nbsp += "&nbsp;&nbsp;&nbsp;";}
				path.append("<option value='"+c.id+"'>"+nbsp+c.name+"</option>");
			});
		}
	 },'json');
	
	//预先加载父责任
	$.post('get_responsibilitys.htm', {isf:true}, function(data){
		var path = $("#resForm").find('#respar').empty().append("<option value=''>-请选择-</option>");
		if(!isEmpty(data)) {
			$.each(data, function(i, c) {
				path.append("<option value='"+c.id+"'>"+c.name+"</option>");
			});
		}
	 },'json');
	
	 //如果选择select为“如何做”,添加“管理责任，责任分数，SWOT”
	 $("#resourceType").change(function(){
		if($("#resourceType").val() == "HOW") {
			$("#dd_responsibility").show();
			$("#swot_dd").show();	
		} else {
			$("#dd_responsibility").hide();
			$("#swot_dd").hide();
		}
		//限制文件类型如果为视频改变设置
		uploadifys($(this).val());
	 });
	
	 //管理责任下拉菜单
	 $("#respar").change(function() {
		 $.post('get_responsibilitys.htm', {pid:$(this).val(), onlyf:false}, function(data){
			 var path = $("#resForm").find('#responsibility').empty();
				if(!isEmpty(data)) {
					$.each(data, function(i, c) {
						if(i==0) path.append("<option disabled='disabled' value='"+c.id+"'>"+c.name+"</option>");
						else path.append("<option value='"+c.id+"'>&nbsp;&nbsp;"+c.name+"</option>");
					});
				}
		},'json');
	 });
	 
	 
	//配置对话框
	 $("#content_main").dialog({autoOpen:false, modal:true, resizable:true, width:750, buttons: {"添加": addRes,"提交": editRes,"取消": function() {$(this).dialog('close')}}});
	 
	 //下载弹出框
	 $("#down_how").dialog({autoOpen:false, modal:true, resizable:true, width:320,height:140,buttons: {"取消": function() {$(this).dialog('close')}}});
		
	//视频播放弹出窗口
	$("#play_video").dialog({ autoOpen:false, modal:true, resizable:true, width:'auto', close:function(){flowplayer("player", "../common/flowplayer.swf")}, buttons: {"关闭": function() {$(this).dialog('close')}}});

}); 

//点击TR触发radio选中事件
function select(id) {$("#checkbox"+id).attr("checked",true);}

//文件下载按纽
function downDlg(id) {
	var conn = $("#down_how");
	//如果下载为如何做，则弹出窗口
	if($('#resourceType'+id).val() == "HOW") {
		conn.find("#original").attr("href","javascript:downloadAttachment('"+id+"');");
		conn.find("#original").html("发布版本 "+$("#version"+id).html());
		$.post('downloadHow.htm',{fileName:id, updateDate:$('#updateDate'+id).html(), downloadDate:$('#downloadDate'+id).val()},function(data){
			conn.find("#howtodo").attr("href","javascript:downloadAttachment('"+id+"','how');");
			conn.find("#howtodo").html("新增部分"+data.result);
			conn.dialog("option","title","下载文件").dialog('open');
		},'json');
	} else {
		//否则有附件直接下载
		downloadAttachment(id);
	}
}

//下载文件处理
function downloadAttachment(id,how){
	var attachment = $("#attachment"+id).val();
	if(how == 'how') attachment = "how_"+attachment;
	$("#downForm").submit(function() {$("#downForm").find("#fileName").val(attachment);});
	if(!isEmpty(attachment)) {
		$.post('../find_file.htm',{fileName:attachment},function(data){
			if(data.result == "SUCCESS") {
			    $("#downForm").submit();
			    if(how == 'how') {//如果下载了如何做的新增部分，则添加或更新下载时间
			    	$.post('updateDownloadDate.htm',{resourceId:id},function(data){},'json');
			    }
			} else alert("没有这个文件！");
		},'json');
	}
}

var addDlg = function() {
	var dlg = $("#content_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('添加')").show();
	dlg.dialog("option","title","添加资源文件");
	dlg.find('#id').val('');
	dlg.find('#path').val('');
	dlg.find('#resourceType').val('');
	dlg.find('#version').val('');
	dlg.find('#title').val('');
	dlg.find('#des').val('');
	dlg.find('#isValid').val('');
	dlg.find('#uploadDate').val('');
	dlg.find('#updateEname').val('');
	dlg.find('#maintainDpt').val('');
	dlg.find('#attachment').val('');
	dlg.find('#score').val('');
	dlg.find('#swot').val('');
	dlg.find('#number_dd').show();
	dlg.find('#dd_resourceType').show();
	dlg.find('#resDate').hide();
	dlg.find('#resVersion').hide();
	
	$("#dd_responsibility").hide();
	$("#swot_dd").hide();
	
	dlg.dialog('open');
};

//POST提交文件
var addRes = function() {
	var dlg = $('#content_main');
	sub_count++;
	if(sub_count == 1) {
		// 验证方法
		if (isEmpty(dlg.find("#title").val())) {
			alert("请至少填写标题！");
			sub_count = 0;
			return false;
		} else if (isEmpty(dlg.find("#resourceType").val())) {
			alert("请选择文件类型！");
			sub_count = 0;
			return false;
		} else if (isEmpty(dlg.find("#path").val())) {
			alert("请选择目录！");
			sub_count = 0;
			return false;
		} 
		
		$.post('save_resource.htm', dlg.find("#resForm").serialize(),
				function(data) {
					if (data.result == "SUCCESS") {
						alert("添加成功文件成功！");
						window.location.reload(); // 添加完成刷新页面
						dlg.dialog("close");
					} 
					else if (data.result == "PARAM_EMPTY")
						alert("请填写完整后再提交！");
					else
						alert("添加操作失败！");
					sub_count = 0;
				}, 'json');
	}
};

var editDlg = function() {
	 var id = $("input:checked").val();
	 if(id != null){
		 var dlg = $("#content_main");
		 var panel = dlg.siblings(".ui-dialog-buttonpane");
		 dlg.find("input").removeAttr("disabled");
		 panel.find("button:not(:contains('取消'))").hide();
		 panel.find("button:contains('提交')").show();
		 dlg.find('#id').val(id);
		 dlg.find('#path').val($('#path'+id).val());
		 dlg.find('#resourceType').val($('#resourceType'+id).val());
		 dlg.find('#vers').html($('#version'+id).html());
		 dlg.find('#version').val($('#version'+id).html());
		 dlg.find('#title').val($('#title'+id).html());
		 dlg.find('#des').val($('#des'+id).val());
		 dlg.find('#num').html($('#number'+id).html());
		 dlg.find('#createDate').html($('#createDate'+id).html());
		 dlg.find('#updateDate').html($('#updateDate'+id).html());
		 dlg.find('#uploadDate').html($('#uploadDate'+id).html());
		 dlg.find('#uploadEname').val($('#uploadEname'+id).html());
		 dlg.find('#maintainDpt').val($('#maintainDpt'+id).html());
		 dlg.find('#attachment').val($('#attachment'+id).val());
		 dlg.find('#isValid').val($('#isValid'+id).val());
		 dlg.find('#responsibility').val($('#responsibility'+id).val());
		 dlg.find('#score').val($('#score'+id).val());
		 dlg.find('#swot').val($('#swot'+id).val());
		 dlg.find('#number_dd').hide();
		 dlg.find('#dd_resourceType').hide();
		 dlg.find('#resType').html(dlg.find("#resourceType>option:selected").text());
		 dlg.find('#resDate').show();
		 dlg.find("#resVersion").show();
		
		 if($("#resourceType").val() == "HOW") {
			$("#responsibility_dd").show();
			$("#swot_dd").show();	
		 } else {
			$("#responsibility_dd").hide();
			$("#swot_dd").hide();
		 }	
		 dlg.dialog('open'); 
		 
		//限制文件类型如果为视频改变设置
		 setTimeout('uploadifys($("#resourceType").val())', 500); 
	 } else {
		alert("请选择需要操作的数据行");
	 }
};

//POST提交
var editRes = function() {
	var dlg = $('#content_main');
	sub_count++;
	if(sub_count == 1) {
		// 验证方法
		if (isEmpty(dlg.find("#title").val())) {
			alert("请至少填写标题！");
			sub_count = 0;
			return false;
		} else if (isEmpty(dlg.find("#path").val())) {
			alert("请选择目录！");
			sub_count = 0;
			return false;
		}
		
		$.post('save_resource.htm?oldfile=' + $('#attachment' + dlg.find("#id").val()).html(),
				dlg.find("#resForm").serialize(), function(data) {
					if (data.result == "SUCCESS") {
						alert(dlg.find("#title").val() + " －  修改操作成功！");
						dlg.dialog("close");
						window.location.reload();
					} else if (data.result == "PARAM_EMPTY")
						alert("请填写完整后再提交！");
					else
						alert("抱歉！修改失败！");
					sub_count = 0;
				}, 'json');
	}
};

//文件类型如果为视频，则改变类型和上传大小限制
function uploadifys(file) {
	if(file == "VIDEO") {
		sizeLimit = 20248576;
		fileExt = '*.swf;*.flv;';
		fileDesc = '您可以上传(SWF,FLV)小于20M的文件！';
	} else {
		sizeLimit = 4248576;
		fileExt = '*.jpg;*.gif;*.png;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;';
		fileDesc = '您可以上传(JPG,PNG,GIF,DOC,XLS,PPT)小于4M的文件！';
	}
	$("#atta").uploadifySettings('sizeLimit',sizeLimit);
	$("#atta").uploadifySettings('fileExt',fileExt);
	$("#atta").uploadifySettings('fileDesc',fileDesc);
}

//点击播放视频文件
function playVideo(attachment) {
	var dlg = $("#play_video");
	dlg.dialog("option", "title", "正在播放");
	
	//检查是否存在此文件，如果有则播放文件，否则提示没有该文件
	$.post('../find_file.htm',{fileName:attachment},function(data){
		if(data.result == "SUCCESS") {
			//改变视频
			$("#player").attr("href", "../uploads/swf/" + attachment);
			
			//初始化播放器
			flowplayer("player", "../common/flowplayer.swf", 
					{
					  clip: {
					        // these two configuration variables does the trick
					        autoPlay: false,
					        autoBuffering: true // <- do not place a comma here
					    },
					    
					    //播放列表
						//playlist: vvs,
					
						plugins: { // load one or more plugins
					    	controls: { // load the controls plugin
					    	 
						        //菜单工具条flash
						        url: '../common/flowplayer.controls.swf',
						
						        // now the custom options of the Flash object
						        playlist: false,

						        //backgroundColor: '#aedaff',
						        tooltips: { // this plugin object exposes a 'tooltips' object
						            buttons: true,
						            fullscreen: '点击进入全屏',
						            pause: '点击暂停',
						            play: '点击播放',
						            previous: '上一个',
						            next: '下一个',
						            mute: '静音',
						            unmute: '开启音量'
						        }
					    	}
						},
						//当暂停时执行操作
						onPause: function() { },
						//当完成播放后执行操作
						onFinish: function() { }
					});
			dlg.dialog("open");
		} else alert("文件不存在！");
	},'json');
}
