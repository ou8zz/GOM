// unblock when ajax activity stops 
$(document).ajaxStop($.unblockUI);
$(function(){
$.fn.zTree.init($("#menu"), setting, app_tree);
$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
$('#startDate').focus(function(){
WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d'});
});
$('#endDate').focus(function(){
WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startDate\');}'});
});
$('#agentDepart').change(function(){
var ad = $('#agentDepart').val();
if(ad){
$.get('get_agents.htm',{'ename':ad},function(data){
 if(data.result=="SUCCESS"){
  var option = "";
  $.each(data.agents, function(i,val){
	  option += "<option value='" + val.ename + "'>" + val.ename + "</option>";
	});
  $('#agent').append(option);
}else alert("代理人部门选择有误！");
},'json');
}else alert("请先选择代理人部门！");
});

$("#zgrid").jqGrid({
    url:'get_leaves.htm',
    datatype:'json',
	mtype:'GET',
	height:260,
	width:793,
    colNames:['ID','Leave ID','User','Session ID','任务ID','工号','类别','交接','审核状态','部门','姓名','职务','开始时间','结束时间','天数','事因','假期联系方式','工作代理人'],
    colModel:[ 
	  {name:'processInstanceId',index:'processInstanceId',hidden:true},
	  {name:'id',index:'id',hidden:true},
	  {name:'applicant.emailPwd',index:'emailPwd',hidden:true},
	  {name:'sessionId',index:'sessionId',hidden:true},
	  {name:'taskId',index:'taskId',hidden:true},
	  {name:'applicant.jobNo',index:'jobNo',hidden:true},
	  {name:'type',index:'type',hidden:true,formatter:leaveType},
	  {name:'handOver',index:'handOver',hidden:true},
	  {name:'comment',index:'comment',hidden:true},
	  {name:'applicant.cdepartment',index:'cdepartment',width:60},
	  {name:'applicant.ename',index:'ename',width:60},
	  {name:'applicant.cposition',index:'cposition',width:60},
	  {name:'startDate',index:'startDate',width:90,formatter:'date',formatoptions:{srcformat:'Y-m-d H:i:s',newformat:'m-d H:i'}},
	  {name:'endDate',index:'endDate',width:90,formatter:'date',formatoptions:{srcformat:'Y-m-d H:i:s',newformat:'m-d H:i'}},
	  {name:'days',index:'days',width:40},
	  {name:'event',index:'event',width:180},
	  {name:'contact',index:'contact',width:100},
	  {name:'agent',index:'agent',width:80}],
	rowNum:10,
    rowList:[10],
	pager:'#zpager',
	viewrecords:true,
	rownumbers:true, 
	rownumWidth:32,
	sortname:'ename',
	sortorder:'desc',
	prmNames:{search:'search'},
	jsonReader:{root:'list',repeatitems:false},
    caption:'待处理请假清单'
});

$('#zgrid').jqGrid('navGrid','#zpager',{add:false,editfunc:updateLeaveDlg,del:false,search:false},{},{},{},{},{closeOnEscape:true});

//配置对话框
$("#leave_detail").dialog({
   autoOpen:false,
   modal:true,
   resizable:true,
   width:580,
   buttons: {
      "确定":updateLeave,
	  "取消": function() {$(this).dialog('close')}
	  }
 });
});

var updateLeaveDlg = function() {
  var rd;
  var selectrow = $("#zgrid").jqGrid("getGridParam", "selrow");
  if(selectrow) rd = $('#zgrid').jqGrid("getRowData", selectrow);
  else {alert("请先选择需要审核的行！"); return false;}
  var dlg = $("#leave_detail");
  if(rd.agent){
	$.get('get_user.htm',{'agent':rd.agent,'pid':rd.processInstanceId},function(data){
		if(data != "") {
			if(data.emailPwd=="1"){
				$("#hd1").show();
				$("#hd2").hide();
				dlg.dialog("option","title","你是否同意 － <span style='color:#000'>" + rd["applicant.ename"] + "</span> 的假期职务代理人请求");
			}else {
				$("#hd1").hide();
				$("#hd2").show();
				dlg.dialog("option","title","审核 － <span style='color:#000'>" + rd["applicant.ename"] + "</span> 的请假单");
			}
		
		$('p').remove();
		dlg.find('#pid').val(rd.processInstanceId);
		dlg.find('#id').val(rd.id);
		dlg.find('#sessionId').val(rd.sessionId);
		dlg.find('#taskId').val(rd.taskId);
		dlg.find('#user').val(rd["applicant.emailPwd"]);
		dlg.find('#cdepartment').prepend("<p>" +rd["applicant.cdepartment"]+ "</p>");
		dlg.find('#ename').prepend("<p>" +rd["applicant.ename"]+ "</p>");
		dlg.find('#jobNo').prepend("<p>" +rd["applicant.jobNo"]+ "</p>");
		dlg.find('#cposition').prepend("<p>" +rd["applicant.cposition"]+ "</p>");
		dlg.find('#startDate').prepend("<p>" + rd.startDate + "</p>");
		dlg.find('#endDate').prepend("<p>" +rd.endDate+ "</p>");
		dlg.find('#days').prepend("<p>" +rd.days+ "</p>");
		dlg.find('#contact').prepend("<p>" +rd.contact+ "</p>");
		dlg.find('#type').prepend("<p>" +rd.type+ "</p>");
		dlg.find('#event').prepend("<p>" +rd.event+ "</p>");
		dlg.find('#handOver').prepend("<p>" +rd.handOver+ "</p>");
		dlg.find('#comment').prepend("<p>" +rd.comment+ "</p>");
		dlg.find('#rc').val(rd.comment);
		$('tr.whide').show();
		dlg.find('#agent_dpt').prepend("<p>" +data.cdepartment+ "</p>");
		dlg.find('#agent_name').prepend("<p>" +data.ename+ "</p>");
		dlg.find('#agent_no').prepend("<p>" +data.jobNo+ "</p>");
		dlg.find('#agent_pst').prepend("<p>" +data.cposition+ "</p>");
		dlg.dialog('open');
	}else alert("通信错误！");
	},'json');
  }else{
	    $('tr.whide').hide();
	    $("p").remove();
		$("#hd1").hide();
		$("#hd2").show();
		dlg.find('#pid').val(rd.processInstanceId);
		dlg.find('#id').val(rd.id);
		dlg.find('#sessionId').val(rd.sessionId);
		dlg.find('#taskId').val(rd.taskId);
		dlg.find('#user').val(rd["applicant.emailPwd"]);
		dlg.find('#cdepartment').prepend("<p>" +rd["applicant.cdepartment"]+ "</p>");
		dlg.find('#ename').prepend("<p>" +rd["applicant.ename"]+ "</p>");
		dlg.find('#jobNo').prepend("<p>" +rd["applicant.jobNo"]+ "</p>");
		dlg.find('#cposition').prepend("<p>" +rd["applicant.cposition"]+ "</p>");
		dlg.find('#startDate').prepend("<p>" + rd.startDate + "</p>");
		dlg.find('#endDate').prepend("<p>" +rd.endDate+ "</p>");
		dlg.find('#days').prepend("<p>" +rd.days+ "</p>");
		dlg.find('#contact').prepend("<p>" +rd.contact+ "</p>");
		dlg.find('#type').prepend("<p>" +rd.type+ "</p>");
		dlg.find('#event').prepend("<p>" +rd.event+ "</p>");
		dlg.find('#handOver').prepend("<p>" +rd.handOver+ "</p>");
		dlg.find('#comment').prepend("<p>" +rd.comment+ "</p>");
		dlg.find('#rc').val(rd.comment);
		dlg.dialog('open');
  }
};

var updateLeave = function() {
  var dlg = $('#leave_detail');
  var hd1 = dlg.find('#handler1').val();
  if(!hd1) hd1 = dlg.find('#handler2').val();
  var tid = $("#zgrid").jqGrid('getGridParam','selrow');
  var pizhu = $.trim(dlg.find('#pizhu').val());
  var params = {'rc':$.trim(dlg.find("#rc").val()),'state':hd1,'comment':pizhu,'sessionId':$.trim(dlg.find("#sessionId").val()),'taskId':$.trim(dlg.find("#taskId").val()),'pid':$.trim(dlg.find("#pid").val()),'user':$.trim(dlg.find("#user").val()),'id':$.trim(dlg.find("#id").val())};
  if(tid && isNull(hd1) && isNull(pizhu)){
	 $.blockUI({message:'<h6><img src="../common/common/images/ztree/loading.gif" /> 系统正在处理中，请稍候！</h6>',css:{border:'none',padding:'15px',backgroundColor:'#000', '-webkit-border-radius':'10px', '-moz-border-radius':'10px', opacity:.5, color:'#fff' 
        }}); 
	$.post('update_leave.htm',params,function(data){
      if(data == "SUCCESS") {
		$('#zgrid').jqGrid("delRowData",tid);
		alert("操作成功！");
        dlg.dialog("close");
	  }
	 else if(data == "PARAM_EMPTY") alert("请填写完整后再提交！");
	 else alert("更新操作失败！");
	},'text');
  }else alert("请填写处理信息后再确认！");
};

function isNull(str){
  if (str == "") return false;
  var reg = /^[ ]+$/;
  return !reg.test(str);
}
$.getScript("common/utils.js");