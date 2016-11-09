$(function(){
	$.fn.zTree.init($("#menu"), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
		
	$("#sDate,#eDate").datepicker({changeMonth:true,changeYear:true});
	
	//如果页面没有gian下载按纽将不显示
	if(undefined == $("#content").find("#isEmpty").val())$("#download").hide();
    else $("#download").show();
	
	//点击下载弹出窗
	$("#download").click(function () {$("#download-form").dialog('open');});

    $("#training-form").dialog({
    	title:"培训详情",
		autoOpen: false,
		width: 450,
		modal: true,
		buttons: {
			"取消": function() {$(this).dialog('close')}
		}
    });
    
    $("#exper-form").dialog({
    	title:"添加心得",
		autoOpen: false,
		width: 450,
		modal: true,
		buttons: {
			"添加": addGain,
			"提交": editGain,
			"取消": function() {$(this).dialog('close')}
		}
    });
    
    $("#download-form").dialog({
    	title:"下载心得文档",
		autoOpen: false,
		height: 190,
		width: 240,
		modal: true,
		buttons: {
			"下载": downGain,
			"取消": function() {$(this).dialog('close')}
		}
    });
    
});

//培训详细信息弹出
function showTraining(tprogram, lecturer, startDate, endDate, trainingType, trainingTime, fee, otherFee, qualification, tcontent) {
	var train = $("#train");
	train.find("#tprogram").html(tprogram);
	train.find("#lecturer").html(lecturer);
	train.find("#startDate").html(startDate);
	train.find("#endDate").html(endDate);
	train.find("#trainingType").html(trainingType);
	train.find("#trainingTime").html(trainingTime);
	train.find("#fee").html(fee);
	train.find("#otherFee").html(otherFee);
	train.find("#qualification").html(qualification);
	train.find("#tcontent").html(tcontent);
	$("#training-form").dialog('open');
}

//添加心得弹出
function addExper(trainId) {
	var dlg = $("#exper-form");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('添加')").show();
	dlg.find("#trainId").val(trainId);
	dlg.find("#gain").val('');
	dlg.dialog('open');
}

//编辑心得弹出
function editExper(trainId, experId) {
	var dlg = $("#exper-form");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	dlg.find("input").removeAttr("disabled");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('提交')").show();
	dlg.dialog("option","title","编辑心得");
	dlg.find("#trainId").val(trainId);
	dlg.find("#experId").val(experId);
	dlg.find("#gain").val($("#gainMsg"+trainId).html());
	dlg.dialog('open');
}

//添加心得
function addGain() {
	var dlg = $("#exper-form");
	var gain = $.trim(dlg.find("#gain").val());
	if(isEmpty(gain)) {
		alert("不能添加空的内容");
		return false;
	}
	var params = {id:'', trainingId:$.trim(dlg.find("#trainId").val()), student:'', gain:gain};
	$.post('save_experience.htm',params,function(data){
	      if(data.result == "SUCCESS") {
	    	dlg.dialog('close');
			alert("添加成功！");
			window.location.reload();
		  } else alert("操作失败！");
		},'json');
}

//编辑心得
function editGain() {
	var dlg = $("#exper-form");
	var gain = $.trim(dlg.find("#gain").val());
	if(isEmpty(gain)) {
		alert("不能添加空的内容");
		return false;
	}
	var params = {id:$.trim(dlg.find("#experId").val()), trainingId:$.trim(dlg.find("#trainId").val()), student:'', gain:gain};
	$.post('save_experience.htm',params,function(data){
	      if(data.result == "SUCCESS") {
	    	dlg.dialog('close');
			alert("操作成功！");
			window.location.reload();
		  } else alert("操作失败！");
	},'json');
}

function downGain(){
	var dlg = $("#downTag");
	var params = {startDate:$.trim(dlg.find("#sDate").val()),endDate:$.trim(dlg.find("#eDate").val())};
	$("#gainForm").submit();
}
