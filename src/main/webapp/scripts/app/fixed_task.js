$(function(){
	$.fn.zTree.init($("#menu"), setting);
	initGrid("get_fixedTasks.htm?state=InProgress");

	//Form 验证字段内容
	$("#fixedForm").validate({  
		rules:{"taskTitle":{required:true,minlength:3},"frequency":{required:true},"hours":{required:true,number:true},"expectedStart":{required:true},"expectedEnd":{required:true},"describe":{required:true, minlength:5}},
	    onkeyup:false,
		messages:{taskTitle:{required:"任务标题不能为空！", minlength:"请至少输入3个以上字符！"},frequency:{required:"请选择频率周期！"},hours:{required:"时间不能为空！", number:"请正确合适的输入数字！"},expectedStart:{required:"开始时间不能为空！"},expectedEnd:{required:"结束时间不能为空！"},describe:{required:"任务描述不能为空！", minlength:"请至少输入5个以上字符！"}}
	});
	
$("#frequency").change(function() {
 if($(this).val()) {
	 var dlg = $('#content_main');
	 var tb_tmp = dlg.find('#period').empty();
	 dlg.find('dd.time').show();
	 if($(this).val() == "WEEK") {tb_tmp.append("<option value='1'>一</option><option value='2'>二</option><option value='3'>三</option><option value='4'>四</option><option value='5'>五</option><option value='6'>六</option><option value='7'>七</option>");dlg.find('dd.time label').empty().append("每周"); }
	 else if($(this).val() == "MONTH"){
		 tb_tmp.append("<option value='1'>1</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option><option value='25'>25</option><option value='26'>26</option><option value='27'>27</option><option value='28'>28</option><option value='29'>29</option><option value='30'>30</option><option value='31'>31</option>");
		 dlg.find('dd.time label').empty().append("每月");
	 }else dlg.find('dd.time').hide();
 }
});
	
	//配置对话框
	$("#content_main").dialog({autoOpen:false,modal:true,resizable:true,width:690,height:450,buttons:{"添加":addTask,"修改":editTask,"取消":function(){$(this).dialog('close')}}});
	
}); 

//任务添加弹出窗
var addTaskDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('添加')").show();
	 dlg.dialog("option","title","添加固定工作");
	 dlg.find('#fixedForm')[0].reset();
	 dlg.find('label.error').remove();
	 dlg.find('dd.time,dd.playStop').hide();
	 dlg.dialog('open');
};

//添加任务提交POST
var addTask = function() {
 var dlg = $('#content_main');
 if(dlg.find("#fixedForm").valid()){
	 $.post('save_fixedTask.htm',dlg.find("#fixedForm").serialize(),function(data){
	     if(data.result == "SUCCESS") {
	    	$("#zgrid").jqGrid("addRowData", data.ft.id, data.ft, "first");
			alert("添加固定工作成功！");
	        dlg.dialog("close");
		 }
	     else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		 else alert("添加固定工作失败！");
	 },'json');
 }
};

//编辑工作任务
var editTaskDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('修改')").show();
	 
	 var selectrow = $("#zgrid").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
		   var rd = $('#zgrid').jqGrid("getRowData", selectrow);
		   dlg.dialog("option","title","编辑 － " + rd.taskTitle);
		   dlg.find('#id').val(rd.id);
		   dlg.find('#taskTitle').val(rd.taskTitle);
		   if(rd.frequency) {
			   if(rd.frequency=='月') dlg.find('#frequency').val('MONTH');
			   else if(rd.frequency =='周')dlg.find('#frequency').val('WEEK');
			   else dlg.find('#frequency').val('DAY');
		   }
		   
		   if(rd.period){
			   if(rd.frequency=="周") {dlg.find('#period').empty().append("<option value='1'>一</option><option value='2'>二</option><option value='3'>三</option><option value='4'>四</option><option value='5'>五</option><option value='6'>六</option><option value='7'>七</option>");dlg.find('dd.time label').empty().append("每周");}
			   else if(rd.frequency=="月"){dlg.find('#period').empty().append("<option value='1'>1</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option><option value='25'>25</option><option value='26'>26</option><option value='27'>27</option><option value='28'>28</option><option value='29'>29</option><option value='30'>30</option><option value='31'>31</option>");
			   dlg.find('dd.time label').empty().append("每月");}
			   dlg.find('#period').val(rd.period);
		   }else dlg.find('dd.time').hide();
		   dlg.find('#hours').val(rd.hours);
		   dlg.find('#expectedStart').val(rd.expectedStart);
		   dlg.find('#expectedEnd').val(rd.expectedEnd);
		   dlg.find('#describe').val(rd.describe);
		   dlg.find("input[name=state][value="+rd.state+"]").attr("checked",true);
		   dlg.find('label.error').remove();
		   dlg.find('dd.playStop').show();
		   dlg.dialog('open');
	 }
};
//提交修改的工作
var editTask = function() {
  var dlg = $('#content_main');
  if(dlg.find("#fixedForm").valid()){
	  $.post('save_fixedTask.htm',dlg.find("#fixedForm").serialize(),function(data){
		  if(data.result == "SUCCESS") {
		    $("#zgrid").jqGrid("setRowData", data.ft.id, data.ft, {color:"#FF0000"});
			alert(data.ft.taskTitle + " －  更新成功！");
	        dlg.dialog("close");
		 }
		 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		 else alert("更新操作失败！");
	},'json');
	 }
};

/****停止工作****/
var stop = function() {
	var rd = $('#zgrid').jqGrid("getRowData", $("#zgrid").jqGrid("getGridParam", "selrow"));
	if(rd.state == "停止") { alert("该任务已经停止！"); return false; }
	var b = confirm("您确定要停止 - "+rd.taskTitle);
	if(b) {
		var tid = jQuery("#zgrid").jqGrid('getGridParam','selrow');
		if(tid) {
			var rd = $('#zgrid').jqGrid("getRowData", tid);
			$.post('edit_fixedTask.htm',{id:tid},function(data){
		    if(data.result == "SUCCESS") {
		        $("#zgrid").jqGrid("setRowData", tid, {state:'Suspended'}, {color:"#FF0000"});    
		    	alert("操作成功！");
			}
			else alert("操作失败！");
		  },'json');
		}
	}
};

var lang="zh_CN";
var colNames_cn = ['ID','state','任务标题','频率','周期','工时','开始时间','结束时间','任务描述'];
var colNames_tw = ['ID','state','任務標題','頻率','周期','工時','開始時間','結束時間','任務描述'];

var caption = {zh: "", "zh_CN": "固定工作管理  <select id='state' name='state' onchange='javascript:toSearch(this)'><option value=''>请选择</option><option value='InProgress'>运行</option><option value='Suspended'>停止</option></select>状态", "zh_TW": "固定工作管理  <select id='state' name='state' onchange='javascript:toSearch(this)'><option value=''>請選擇</option><option value='InProgress'>運行</option><option value='Suspended'>停止</option></select>狀態"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

var initGrid = function(url){
	jQuery("#zgrid").jqGrid({
	   	url:url,
		datatype: "json",
		height:350,
		width:793,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
			{name:'state',index:'state',hidden:true},
	   		{name:'taskTitle',index:'taskTitle',width:150},
			{name:'frequency',index:'frequency',width:60,sortable:false,formatter:frequencyPeriod},
			{name:'period',index:'period',width:60,sortable:false},
	   		{name:'hours',index:'hours',width:80,sortable:false},
	   		{name:'expectedStart',index:'expectedStart',width:80,sortable:false,formatter:'date',formatoptions:{srcformat:'H:i:s',newformat:'H:i'}},
	   		{name:'expectedEnd',index:'expectedEnd',width:80,sortable:false,formatter:'date',formatoptions:{srcformat:'H:i:s',newformat:'H:i'}},
	   		{name:'describe',index:'describe',sortable:false,width:250}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager:'#zpager',
	   	sortname:'taskTitle',
	    viewrecords:true,
	    rownumbers:true,
		rownumWidth:33,
		prmNames:{search:'search'},
		multiselect:false,
		jsonReader:{root:'list',repeatitems:false}
	}).jqGrid('navGrid','#zpager',{addfunc:addTaskDlg,addtitle:"添加",editfunc:editTaskDlg,edittitle:"编辑",delfunc:stop,deltitle:"停止",delicon:"ui-icon-power",view:true,search:false, alerttext:"请选择需要操作的数据行!"},{},{},{},{},{});
};

//选择下拉框事件
function toSearch(obj){
	var id = obj.id;
	var key = obj.value;
	$("#zgrid").GridUnload();
	initGrid("get_fixedTasks.htm?state=" + key);
	$("#"+id).val(key);
}
