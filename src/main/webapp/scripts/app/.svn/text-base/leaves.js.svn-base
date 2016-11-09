var colNames_cn = ['ID','traceId','顺序','节点','意见','工号','类别','交接','部门','中文名','姓名','职务','开始时间','结束时间','天数','事因','假期联系方式','工作代理人','代理人部门','代理人职务','代理人中文名','代理人工号','直接主管','申请日期','mailAddress'];
var colNames_tw = ['ID','traceId','順序','節點','意見','工號','類別','交接','部門','中文名','姓名','職務','開始時間','結束時間','天數','事因','假期聯系方式','工作代理人','代理人部門','代理人職務','代理人中文名','代理人工號','直接主管','申請日期','mailAddress'];
var caption = {zh: "待处理请假清单", "zh_CN": "待处理请假清单", "zh_TW": "待處理請假清單"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

// unblock when ajax activity stops 
$(document).ajaxStop($.unblockUI);
$(function(){
$.fn.zTree.init($("#menu"), setting);
$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
$('#startDate').focus(function(){WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d'});});
$('#endDate').focus(function(){WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startDate\');}'});});
$('#agentDpt').change(function(){
if($(this).val()){
$.post('../dpt_users.htm',{'dpt':$(this).val(),'type':'POSITION','ismgr':false},function(data){
	var option = "";
	$.each(data, function(i,val){option += "<option value='" + val.ename + "'>" + val.ename + "</option>";});
	$('#agent').append(option);
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
	  {name:'nodeOrder',index:'nodeOrder',hidden:true},
	  {name:'nodeCode',index:'nodeCode',hidden:true},
	  {name:'opinion',index:'opinion',hidden:true},
	  {name:'jobNo',index:'jobNo',hidden:true},
	  {name:'type',index:'type',hidden:true},
	  {name:'handOver',index:'handOver',hidden:true},
	  {name:'cdepartment',index:'cdepartment',width:60,sortable:false},
	  {name:'cname',index:'cname',hidden:true},
	  {name:'ename',index:'ename',width:60},
	  {name:'cposition',index:'cposition',width:60,sortable:false},
	  {name:'startDate',index:'startDate',width:90,sortable:false},
	  {name:'endDate',index:'endDate',width:90,sortable:false},
	  {name:'days',index:'days',width:40,sortable:false},
	  {name:'event',index:'event',width:180,sortable:false},
	  {name:'contact',index:'contact',width:100,sortable:false},
	  {name:'agent',index:'agent',width:80,sortable:false},
	  {name:'agentDpt',index:'agentDpt',hidden:true},
	  {name:'agentPst',index:'agentPst',hidden:true},
	  {name:'agentCname',index:'agentCname',hidden:true},
	  {name:'agentJobNo',index:'agentJobNo',hidden:true},
	  {name:'recipient',index:'recipient',hidden:true},
	  {name:'applyDate',index:'applyDate',hidden:true},
	  {name:'relationAddr',index:'relationAddr',hidden:true}],
	rowNum:10,
    rowList:[10],
	pager:'#zpager',
	viewrecords:true,
	rownumbers:true, 
	rownumWidth:32,
	sortname:'applyDate',
	sortorder:'desc',
	prmNames:{search:'search'},
	jsonReader:{root:'list',repeatitems:false}
});

$('#zgrid').jqGrid('navGrid','#zpager',{add:false,editfunc:updateLeaveDlg,del:false,search:false},{},{},{},{},{closeOnEscape:true});

//配置对话框
$('#content_main').dialog({
   autoOpen:false,
   modal:true,
   resizable:true,
   width:630,
   buttons: {
      "确定":updateLeave,
	  "取消": function() {$(this).dialog('close')}
	  }
 });
});

var updateLeaveDlg = function() {
  var dlg = $('#content_main');
  var rd;
  var selectrow = $("#zgrid").jqGrid("getGridParam", "selrow");
  if(selectrow) rd = $('#zgrid').jqGrid("getRowData", selectrow);
  else {alert("请先选择需要审核的行！"); return false;}
  dlg.find('table.gom_tb').empty().append('<tr class="tb_bg"><th rowspan="2" scope="col" width="16%">申请人</th><td scope="col" width="22%">部门</td><td scope="col" width="22%">姓名</td><td scope="col" width="15%">工号</td><td scope="col" width="25%">职务</td></tr><tr><td>'+rd.cdepartment+'</td><td>'+rd.ename+'('+rd.cname+')</td><td>'+rd.jobNo+'</td><td>'+rd.cposition+'</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr class="tb_bg"><th rowspan="2">请假日期</th><td>开始时间</td><td>结束时间</td><td>天数</td><td>假期联系方式</td></tr><tr><td>'+rd.startDate+'</td><td>'+rd.endDate+'</td><td>'+rd.days+'</td><td>'+rd.contact+'</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th class="tb_bg">请假类型</th><td>'+leaveType(rd.type)+'</td><td class="tb_bg">事因</td><td colspan="2">'+rd.event+'</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr><th class="tb_bg">工作交接</th><td colspan="4">'+rd.handOver+'</td></tr><tr><td colspan="5">&nbsp;</td></tr><tr class="tb_bg"><th rowspan="2">代理人</th><td>部门</td><td>姓名</td><td>工号</td><td>职务</td></tr><tr><td>'+rd.agentDpt+'</td><td>'+rd.agent+'('+rd.agentCname+')</td><td>'+rd.agentJobNo+'</td><td>'+rd.agentPst+'</td></tr><tr class="tmp"><td colspan="5">&nbsp;</td></tr><tr class="tmp"><td colspan="5"><table class="trace" width="100%"><thead><tr><th width="20%">审批流程</th><th width="25%">到达时间</th><th width="45%">审批意见</th><th width="10%">附件</th></tr></thead><tbody></tbody><tfoot></tfoot></table></td></tr><tr class="onlypifu"><td colspan="5">&nbsp;</td></tr><tr><th rowspan="3">处理</th><td style="text-align:center">意见</td><td colspan="3" id="shenpi"></td></tr><tr class="tmp baobei"><td style="text-align:center">向上级报备</td><td colspan="3"><input type="checkbox" name="reported" id="reported" tabindex="4" onchange="javascript:getDpts(this)"/></td></tr><tr><td style="text-align:center">批注</td><td colspan="3"><input type="text" name="opinion" id="opinion" class="inpw" tabindex="7" maxlength="30"/></td></tr>');
  
  $.post('get_departure_traces.htm',{processId:rd.id,type:'LEAVE'},function(data){
	  if(data.result == 'SUCCESS') {
		  dlg.find("table.trace tbody,table.trace tfoot").empty();
	      var task = data.traces;
    	  var trace = '<tr><td colspan="4"><span><img src="../images/trace/start.png" alt="start"/><h6>任务开始</h6></span>';
	       for(var i in task) {
	    	  var time = "";
	     	  var att = "";
	     	  var opinion = "";
	    	  if(!isEmpty(task[i].deliverTime) && task[i].deliverTime != undefined) time = task[i].deliverTime;
	    	  if(!isEmpty(task[i].opinion) && task[i].opinion != undefined) opinion = task[i].opinion;
	    	  if(!isEmpty(task[i].attachment) && task[i].attachment != undefined) att ="<a href='download.htm?file=" + task[i].attachment + "&name=" + rd.ename + "的交接文档'>下载</a>";
			  trace += "<img class='arrow' src='../images/trace/" + task[i].arrow + "'/><span><img src='../images/trace/" + task[i].icon + "'/><h6>" + task[i].nodeName + "(" + task[i].actor + ")</h6></span>";
		      dlg.find("table.trace tbody").append("<tr><td>" + task[i].nodeName + "("+task[i].actor+")"+"</td>" +
	    	  	"<td>"+time+"</td><td>"+opinion+"</td><td>"+att+"</td></tr>");
	       }
	       dlg.find("table.trace tfoot").append(trace+"</td></tr>");
	    }
  },'json');
  
  dlg.find('#id').val(rd.id);
  dlg.find('#traceId').val(rd.traceId);
  dlg.find('#nodeCode').val(rd.nodeCode);
  dlg.find('#nodeOrder').val(rd.nodeOrder);
  dlg.find('#relationAddr').val(rd.relationAddr);
  dlg.find('#agent').val(rd.agent);
  dlg.find('#agentDpt').val(rd.agentDpt);
  dlg.find('#agentJobNo').val(rd.agentJobNo);
  dlg.find('#agentPst').val(rd.agentPst);
  dlg.find('#agentCname').val(rd.agentCname);
  dlg.find('#recipient').val(rd.recipient);
  dlg.find('#ename').val(rd.ename);
  dlg.find('#cname').val(rd.cname);
  dlg.find('#jobNo').val(rd.jobNo);
  dlg.find('#cdepartment').val(rd.cdepartment);
  dlg.find('#cposition').val(rd.cposition);
  dlg.find('#startDate').val(rd.startDate);
  dlg.find('#endDate').val(rd.endDate);
  dlg.find('#days').val(rd.days);
  dlg.find('#handOver').val(rd.handOver);
  dlg.find('#contact').val(rd.contact);
  dlg.find('#event').val(rd.event);
  dlg.find('#orOpinion').val(rd.opinion);
  dlg.find('#applyDate').val(rd.applyDate);
  dlg.find('#type').val(rd.type);
  
   if(rd.agent && rd.agent != "&nbsp;" && rd.agent==$('#tmp_user').val()){
	  dlg.find('#shenpi').empty().append('<label>同意</label><input name="approval" type="radio" value="APPROVAL" tabindex="1" class="inp"/><label>不同意</label><input name="approval" type="radio" value="REVOKE" tabindex="2"/>');
	  dlg.dialog("option","title","你是否同意 － <span style='color:#000'>" + rd.ename + "</span> 的假期职务代理人请求");
	  dlg.find('tr.tmp').hide();
	  dlg.find('tr.onlypifu').show();
	  dlg.dialog('open');
  }else{
	    dlg.find('tr.tmp').show();
		dlg.find('tr.onlypifu').hide();
	    if(rd.nodeCode=="Manager") dlg.find('tr.baobei').hide();
		else{dlg.find('tr.baobei').show();}
	    dlg.find('#shenpi').empty().append('<label>批准</label><input name="approval" type="radio" value="APPROVAL" tabindex="1" class="inp"/><label>驳回</label><input name="approval" type="radio" value="REVOKE" tabindex="2" class="inp"/><label>拒绝</label><input name="approval" type="radio" value="REJECT" tabindex="3"/>');
		dlg.dialog("option","title","审核 － <span style='color:#000'>" + rd.ename + "</span> 的请假单");
		dlg.dialog('open');
  }
};

var updateLeave = function() {
  var dlg = $('#content_main');
  var tid = $("#zgrid").jqGrid('getGridParam','selrow');
  if(tid && !isEmpty(dlg.find('input[name=approval]:radio').val()) && !isEmpty(dlg.find('#opinion').val())){
	 $.blockUI({message:'<h6><img src="../images/ztree/loading.gif" /> 系统正在处理中，请稍候！</h6>',css:{border:'none',padding:'15px',backgroundColor:'#000', '-webkit-border-radius':'10px', '-moz-border-radius':'10px', opacity:.5, color:'#fff'}});
	 $.ajax({url:'edit_leave.htm',type:'POST',data:dlg.find('#leaveForm').serialize(),dataType:'json',cache:false,success:function(data){
	      if(data.result == "SUCCESS") {
	        $('#zgrid').jqGrid("delRowData",tid);
			alert("操作成功！");
	        dlg.dialog("close");
		  }
		 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		 else alert("操作失败！");}
		});
  }else alert("请填写处理信息后再提交！");
};

function getDpts(obj){
  if($(obj).attr("checked")){
	$.post('../departments.htm',function(data){
		var option ='<select id="recipientDpt" name="recipientDpt" class="elr_boder" onchange="javascript:getMgrs(this)" tabindex="5"><option value="">-请选择-</option>';
		$.each(data, function(i,val){option+="<option value='"+val.id+"'>"+val.cname+"</option>";});
		$('select.elr_boder').remove();
		$(option+'</select>').insertAfter('#reported');
	},'json');
  }else{$('select.elr_boder,select.s_tag').remove();}
}

function getMgrs(obj){
if($(obj).val()){
$.post('../dpt_users.htm',{'dpt':$(obj).val(),'type':'POSITION','ismgr':true},function(data){
	var option = '<select id="superior" name="superior" tabindex="6" class="s_tag"><option value="">-请选择-</option>';
	$.each(data, function(i,val){option += "<option value='" + val.ename + "'>" + val.ename + "</option>";});
	$('select.s_tag').remove();
	$(option+'</select>').insertAfter($(obj));
},'json');
}else alert("先选择上级主管所属部门！");
}