var colNames_cn = ['ID','traceId','节点','意见','职务','工号','类别','交接','部门','姓名','职务','开始时间','结束时间','天数','事因','假期联系方式','工作代理人','代理人部门','个体意见','批注','mailAddress'];
var colNames_tw = ['ID','traceId','節點','意見','職務','工號','類別','交接','部門','姓名','職務','開始時間','結束時間','天數','事因','假期聯系方式','工作代理人','代理人部門','個體意見','批註','mailAddress'];

var caption = {zh: "", "zh_CN": "待处理请假清单", "zh_TW": "待處理請假清單"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

// unblock when ajax activity stops 
$(document).ajaxStop($.unblockUI);
$(function(){
$.fn.zTree.init($("#menu"), setting);
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
	caption: caption[lang],
   	colNames: colNames[lang],
    colModel:[ 
	  {name:'id',index:'id',hidden:true},
	  {name:'traceId',index:'traceId',hidden:true},
	  {name:'node',index:'node',hidden:true},
	  {name:'opinion',index:'opinion',hidden:true},
	  {name:'position',index:'position',hidden:true},
	  {name:'jobNo',index:'jobNo',hidden:true},
	  {name:'type',index:'type',hidden:true,formatter:leaveType},
	  {name:'handOver',index:'handOver',hidden:true},
	  {name:'cdepartment',index:'cdepartment',width:60,sortable:false},
	  {name:'ename',index:'ename',width:60},
	  {name:'cposition',index:'cposition',width:60,sortable:false},
	  {name:'startDate',index:'startDate',width:90,sortable:false,formatter:'date',formatoptions:{srcformat:'Y-m-d H:i:s',newformat:'m-d H:i'}},
	  {name:'endDate',index:'endDate',width:90,sortable:false,formatter:'date',formatoptions:{srcformat:'Y-m-d H:i:s',newformat:'m-d H:i'}},
	  {name:'days',index:'days',width:40,sortable:false},
	  {name:'event',index:'event',width:180,sortable:false},
	  {name:'contact',index:'contact',width:100,sortable:false},
	  {name:'agent',index:'agent',width:80,sortable:false},
	  {name:'agentDepart',index:'agentDepart',hidden:true},
	  {name:'opinion',index:'opinion',hidden:true},
	  {name:'comment',index:'comment',hidden:true},
	  {name:'relationAddr',index:'relationAddr',hidden:true}],
	rowNum:10,
    rowList:[10],
	pager:'#zpager',
	viewrecords:true,
	rownumbers:true, 
	rownumWidth:32,
	sortname:'ename',
	sortorder:'desc',
	prmNames:{search:'search'},
	jsonReader:{root:'list',repeatitems:false}
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
  
  $('p').remove();
  $('#comments').empty();
  if(rd.opinion && rd.opinion != "&nbsp;") dlg.find('#opinion').val(rd.opinion);
  if(rd.comment && rd.comment != "&nbsp;"){dlg.find('#comment').val(rd.comment); dlg.find('#comments').prepend("<p>" +rd.comment+ "</p>");}
  if(rd.relationAddr && rd.relationAddr != "&nbsp;") dlg.find('#addr').val(rd.relationAddr);
  dlg.find('#id').val(rd.id);
  dlg.find('#traceId').val(rd.traceId);
  dlg.find('#node').val(rd.node);
  dlg.find('#cdepartment').prepend("<p>" + rd.cdepartment + "</p>");
  dlg.find('#ename').prepend("<p>" + rd.ename + "</p>");
  dlg.find('#jobNo').prepend("<p>" +rd.jobNo+ "</p>");
  dlg.find('#position').val(rd.position);
  dlg.find('#cposition').prepend("<p>" +rd.cposition+ "</p>");
  dlg.find('#startDate').prepend("<p>" + rd.startDate + "</p>");
  dlg.find('#endDate').prepend("<p>" +rd.endDate+ "</p>");
  dlg.find('#days').prepend("<p>" +rd.days+ "</p>");
  dlg.find('#day').val(rd.days);
  dlg.find('#contact').prepend("<p>" +rd.contact+ "</p>");
  dlg.find('#type').prepend("<p>" +rd.type+ "</p>");
  dlg.find('#event').prepend("<p>" +rd.event+ "</p>");
  dlg.find('#handOver').prepend("<p>" +rd.handOver+ "</p>");
		
  if(rd.agent && rd.agent != "&nbsp;" && rd.agent==$('#user').val()){
	  $("#hd1").show();
	  $("#hd2").hide();
	  dlg.dialog("option","title","你是否同意 － <span style='color:#000'>" + rd.ename + "</span> 的假期职务代理人请求");
	  $('tr.whide').show();
	  dlg.find('#agent').val(rd.agent);
	  
	  getAgent(dlg,$.trim(rd.agent));
  }else{
	    $("#hd1").hide();
		$("#hd2").show();
		dlg.dialog("option","title","审核 － <span style='color:#000'>" + rd.ename + "</span> 的请假单");
		$("#hd1").hide();
		$("#hd2").show();
		if(rd.agent && rd.agent != "&nbsp;"){$('tr.whide').show();dlg.find('#agent').val(rd.agent);getAgent(dlg,$.trim(rd.agent));}
		else{$('tr.whide').hide();dlg.dialog('open');}
  }
};

var updateLeave = function() {
  var dlg = $('#leave_detail');
  var hd1 = dlg.find('#handler1').val();
  if(!hd1) hd1 = dlg.find('#handler2').val();
  dlg.find('#state').val(hd1);
  var tid = $("#zgrid").jqGrid('getGridParam','selrow');
  if(tid && isNull(hd1) && isNull($.trim(dlg.find('#pizhu').val()))){
	 $.blockUI({message:'<h6><img src="../images/ztree/loading.gif" /> 系统正在处理中，请稍候！</h6>',css:{border:'none',padding:'15px',backgroundColor:'#000', '-webkit-border-radius':'10px', '-moz-border-radius':'10px', opacity:.5, color:'#fff' 
        }}); 
	$.post('update_leave.htm',$('form').serialize(),function(data){
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

function getAgent(dlg,agent) {
$.get('get_agent.htm',{'agent':agent},function(data){
		dlg.find('#agent_dpt').prepend("<p>" +data.cdepartment+ "</p>");
		dlg.find('#agent_name').prepend("<p>" +data.ename+ "</p>");
		dlg.find('#agent_no').prepend("<p>" +data.jobNo+ "</p>");
		dlg.find('#agent_pst').prepend("<p>" +data.cposition+ "</p>");
		dlg.dialog('open');
	},'json');	
}
	
$.getScript("../scripts/common/utils.js");