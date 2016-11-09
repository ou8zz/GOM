
var colNames_cn = ['ID','userId','TRACEID','意见','nodeOrder','NodeName','NodeCode','账号','mailAddr','接收人工号','接收人职务','交接情况','申请人工号','DPTID','申请人','中文名','就职部门','职务','离职原因','入职日期','离职日期','接收人部门','工作接收人','工资发放日期'];
var colNames_tw = ['ID','userId','TRACEID','意見','nodeOrder','NodeName','NodeCode','賬號','mailAddr','接收人工號','接收人職務','交接情況','申請人工號','DPTID','申請人','中文名','就職部門','職務','離職原因','入職日期','離職日期','接收人部門','工作接收人','工資發放日期'];

var caption = {zh: "待审核离职单", "zh_CN": "待审核离职单", "zh_TW": "待審核離職單"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(document).ajaxStop($.unblockUI);
$(function(){
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	$.fn.zTree.init($("#menu"), setting);
	$('#exitDate,#salaryDate').datepicker({changeMonth:true,changeYear:true,minDate:1});
	$('#recipientDpt').change(function(){
		if($(this).val()){
			$('#recipient').empty();
			$.post('../dpt_users.htm',{'dpt':$(this).val(),'type':'DEPARTMENT','ismgr':false},function(data){
				var option = "";
				$.each(data, function(i,val){
					option += "<option value='" + val.ename + "'>" + val.ename + "</option>";
				});
				$('#recipient').append(option);
			},'json');
		}else alert("请先选择部门！");
	});
	
	$('input[name=approval]:radio').change(function(){
		if($(this).val() == "APPROVAL" && $('#nodeDtr').val()==$('#zhijiezhuguan').val()){
			$('div.receiver').show();
			$.post('../departments.htm',function(data){
				$('#recipientDpt').empty();
				var deps = "<option value=''>请选择部门</option>";
				$.each(data, function(i, it) {deps += "<option value='"+it.id+"'>"+it.cname+"</option>";});
				$('#recipientDpt').append(deps);
			},'json');
		}else $('div.receiver').hide();
	});
	
	$('#res_submit').click(function() {
		if(countExpect($(":input.expected").serializeArray()) == 100) {
			$.post('save_responsibilities.htm',{rpts:toJson($('#responsibilityForm').serializeArray(),2)},function(data){
				if(data.result == 'SUCCESS') {alert("更新成功");}
				else alert("更新失败");
			},'json');
		}else {
			$("#error_msg").text("比重计算必须为100%，请正确分配比重").show().fadeOut(8000);
			return false;
		}
    });
	
	$('#son_zeren').change(function(){
		if($('#son_zeren').attr('checked')!=undefined){
			$("#receiverManRes").empty();
			$.get('get_responsibility.htm', {ename:$('#recevier').val(),isf:true}, function(data){
				var repos_fu = "<tr><td colspan='4'>调整 <b style='color:#693'>"+ $('#recevier').val() +"</b> 的主责任比重<span style='float:right;color:red'>注意：所有主责任相加须等于100%(不能大于或小于100%)</span></td></tr>";
				$.each(data, function(i,val){
					repos_fu += "<tr class='nob_t_b'><td class='nobo primary'><span>"+ val.funcode +"</span><i class='ui-icon treeclick ui-icon-triangle-1-s'></i></td><td class='nobo'><input type='hidden' id='id_" + val.id + "' name='id' value='"+val.responId+"'/>"+val.name+"</td><td class='all'><input style='width:80px' class='expected' type='text' id='expected_" + val.node + "' name='expected' value='"+val.expected+"'/></td><td class='all'>"+val.explanation+"</td></tr>";
				});
			$("#receiverManRes").append(repos_fu);
			},'json');
		}
	});
	
	$('#receiveresp').change(function(){
		if($('#receiveresp').attr('checked')!=undefined){
			$.get('copy_responsibility.htm', {recevier:$('#recevier').val(),firer:$('#userId').val()}, function(data){
				if(isEmpty(data)){
					alert("已经复制过，或者所有责任都相同不需要复制，根据需要调整比重即可。");
				}else {
					var st="";
					var ft="";
					var ii = 1;
					var tmp="";
					$.each(data, function(n,val){
						if(/^\+?[0-9]*$/.test(val.node)) {
							if(ii == 1) tmp = val.node;
							ft+="<option value='"+val.node+"'>"+val.funcode+ "&nbsp;&nbsp;" + val.name+"</option>";
						}else st += "<tr><td class='secondary'><span>"+ val.funcode +"</span><i class='ui-icon treeclick ui-icon-radio-off'></i></td><td><input type='hidden' id='id_" + val.id + "' name='id' value='"+val.responId+"'/>"+val.name+"</td><td><input class='expected' type='text' id='expected_" + val.node + "' name='expected' value='"+val.expected+"'/></td><td>"+val.explanation+"</td></tr>";
					});
					$("#receiverManRes").empty().append(st);
					$("#father_zeren").append(ft);
					$('#father_zeren option:eq('+tmp+')').attr('selected','selected');
				}
			$('#receiveresp').attr('disabled', 'disabled');
			},'json');
		}
	});

	//文档上传
	$('#attachments').uploadify({
		  'uploader':'../common/uploadify.swf',
		  'script':'../upload.htm',
		  'cancelImg':'../images/cancel.png',
		  'fileExt':'*.docx;*.doc',
		  'fileDesc':'只允许上传(.doc, .docx)',
		  'sizeLimit':1024000,
		  'buttonImg':'../images/browse.jpg',
		  'displayData':'speed',
		  'expressInstall':'../expressInstall.swf',
		  'auto':true,
		  'onComplete':function(event,ID,fileObj,response,data) {
			  var obj = $.parseJSON(response);
			  $('#attachment').val(obj.fileName);
		  },
		  'onError':function(event, queueID, fileObj) {
			  alert("文件:" + fileObj.name + "上传失败！");
		  }
	});
	
	$("#zgrid").jqGrid({
    url:'get_departures.htm',
    datatype:'json',
	mtype:'GET',
	height:260,
	width:790,
	caption: caption[lang],
   	colNames: colNames[lang],
    colModel:[ 
	  {name:'id',index:'id',hidden:true},
	  {name:'userId',index:'userId',hidden:true},
	  {name:'traceId',index:'traceId',hidden:true},
	  {name:'opinion',index:'opinion',hidden:true},
	  {name:'nodeOrder',index:'nodeOrder',hidden:true},
	  {name:'nodeName',index:'nodeName',hidden:true},
	  {name:'nodeCode',index:'nodeCode',hidden:true},
	  {name:'accountNo',index:'accountNo',hidden:true},
	  {name:'toMailAddr',index:'toMailAddr',hidden:true},
	  {name:'recipientJobNo',index:'recipientJobNo',hidden:true},
	  {name:'recipientPst',index:'recipientPst',hidden:true},
	  {name:'handover',index:'handover',hidden:true},
	  {name:'jobNo',index:'jobNo',hidden:true},
	  {name:'dptId',index:'dptId',hidden:true},
	  {name:'ename',index:'ename',width:70,search:false},
	  {name:'cname',index:'cname',width:60,search:false},
	  {name:'userDpt',index:'userDpt',width:60,search:false},
	  {name:'userPst',index:'userPst',width:60,search:false},
	  {name:'reason',index:'reason',width:180},
	  {name:'entryDate',index:'entryDate',width:80,search:false},
	  {name:'exitDate',index:'exitDate',width:80,search:false},
	  {name:'recipientDpt',index:'recipientDpt',hidden:true},
	  {name:'recipient',index:'recipient',width:80},
	  {name:'salaryDate',index:'salaryDate',width:100,searchoptions:{dataInit:function(elem){$(elem).datepicker({changeMonth:true,changeYear:true,minDate:1});}}  
	 }],
	rowNum:10,
    rowList:[10],
	pager:'#zpager',
	viewrecords:true,
	rownumbers:true, 
	rownumWidth:20,
	sortname:'id',
	sortorder:'desc',
	prmNames:{search:'search'},
	jsonReader:{root:'list',repeatitems:false},
});
$('#zgrid').jqGrid('navGrid','#zpager',{add:false,editfunc:updateDepartureDlg,del:false},{},{},{},{caption:"查找", Find:"搜索", multipleSearch:true},{closeOnEscape:true});
//配置对话框
$("#content_main").dialog({
   autoOpen:false,
   modal:true,
   resizable:true,
   width:710,
   buttons: {
      "确定":updateDeparture,
	  "取消": function() {$(this).dialog('close')}
	  }
 });
}); <!-- end global-->

var updateDepartureDlg = function() {
  var rd;
  var selectrow = $("#zgrid").jqGrid("getGridParam", "selrow");
  if(selectrow) rd = $('#zgrid').jqGrid("getRowData", selectrow);
  else {alert("请先选择需要审核的行！"); return false;}
  var dlg = $("#content_main");
  $("input:radio[name='approval']").attr('checked','');
  dlg.find('dd.dismissal').hide();
  dlg.find('dd.payday').hide();
  dlg.find('div.receiver').hide();
  dlg.find('#reason').val('');
  dlg.find('div.zeren').hide();
  dlg.find('div.attachment').hide();
  dlg.find('fieldset.account').hide();
  dlg.find('#departureForm,#responsibilityForm,#accountForm')[0].reset();
  
  $('#departurer,#reasons,#receiver,#jiesuan').empty();
  dlg.find('#id').val(rd.id);
  dlg.find('#userId').val(rd.userId);
  dlg.find('#traceId').val(rd.traceId);
  dlg.find('#nodeCode').val(rd.nodeCode);
  dlg.find('#recevier').val(rd.recipient);
  dlg.find('#nodeOrder').val(rd.nodeOrder);
  dlg.find('#opinion').val(rd.opinion);
  dlg.find('#ename').val(rd.ename);
  dlg.find('#cname').val(rd.cname);
  dlg.find('#userDpt').val(rd.userDpt);
  dlg.find('#userPst').val(rd.userPst);
  dlg.find('#entryDate').val(rd.entryDate);
  dlg.find('#exitDate').val(rd.exitDate);
  dlg.find('#salaryDate').val(rd.salaryDate);
  dlg.find('#toMailAddr').val(rd.toMailAddr);
  dlg.find('#dptId').val(rd.dptId);
  dlg.find('#recipientJobNo').val(rd.recipientJobNo);
  dlg.find('#recipientPst').val(rd.recipientPst);
  dlg.find('#jobNo').val(rd.jobNo);
  dlg.find('#handover').val(rd.handover);
  
  /** 基本信息 **/
  dlg.find('#departurer').prepend("<b>" + rd.cname + "</b>(" + rd.ename + ")<span>" + rd.userDpt + "</span><span>" + rd.userPst + "</span><p>入职日期：" + rd.entryDate + "<em>申请离职日期：" + rd.exitDate + "</em></p>");
  dlg.find('#reasons').prepend("<label>离职原因：</label><p>" + rd.reason + "</p>");
  dlg.find('#receiver').prepend("<label>工作接收人：</label>" + rd.recipientDpt + " / " + rd.recipient + "");
  dlg.find('#jiesuan').prepend("<label>工资结算：</label>" + rd.accountNo + "(" + rd.salaryDate + "将汇入此账号)");
  
  /** 离职流程 **/
  $.post('get_departure_traces.htm',{processId:rd.id,type:'DEPARTURE'},function(data){
	  if(data.result == 'SUCCESS') {
		  dlg.find("table.trace tbody,table.trace tfoot").empty();
	      var task = data.traces;
    	  var trace = '<tr><td colspan="4"><span><img src="../images/trace/start.png" alt="start"/><h6>任务开始</h6></span>';
	       for(var i in task) {
	    	  var time = "";
	     	  var att = "";
	     	  var opinion = "";
			  if(!isEmpty(task[i].nodeCode) && task[i].nodeCode != undefined && task[i].nodeCode == "Director") $('#nodeDtr').val(task[i].actor);
	    	  if(!isEmpty(task[i].deliverTime) && task[i].deliverTime != undefined) time = task[i].deliverTime;
	    	  if(!isEmpty(task[i].opinion) && task[i].opinion != undefined) opinion = task[i].opinion;
	    	  if(!isEmpty(task[i].attachment) && task[i].attachment != undefined) att = "<a href='download.htm?file="+task[i].attachment+"&name=" + task[i].actor + "的离职交接档'>下载</a>";
			  var cindex = task[i].arrow.indexOf("_");
			  trace += "<img class='arrow' src='../images/trace/" + task[i].arrow + "'/><span><img src='../images/trace/" + task[i].icon + "'/><h6>" + task[i].nodeName + "(" + task[i].actor + ")</h6></span>";
		      dlg.find("table.trace tbody").append("<tr class='nob_t_b'><td class='nobo'>" + task[i].nodeName + "("+task[i].actor+")"+"</td>" +
	    	  	"<td class='nobo'>"+time+"</td><td class='all'>"+opinion+"</td><td class='all'>"+att+"</td></tr>");
	       }
	       dlg.find("table.trace tfoot").append(trace+"</td></tr>");
	    }
  },'json');
  
  /** 根据不同的审核人员配置不同的选择框 Director **/
  if(rd.nodeCode == "Personnel"){dlg.find('dd.dismissal').show();dlg.dialog("option","title", "审核 <b style='color:#F00'>"+rd.ename + "</b> 的离职申请");}
  else if(rd.nodeCode == "Receiver") {dlg.find('div.attachment').show();dlg.find('dd.tonggou').hide();dlg.dialog("option","title", "主管指定你与<b style='color:#F00'>"+rd.ename + "</b>交接工作");}
  else if(rd.nodeCode=="Financial") {dlg.find('dd.payday').show();dlg.find('dd.tonggou').hide();dlg.dialog("option","title", "确定离职人 <b style='color:#F00'>"+rd.ename + "</b> 的工资结算日期");}
  else if(rd.nodeCode=="Adjustment") {
	  dlg.dialog("option","title", "调整 <b style='color:#F00'>"+rd.ename + "</b> 工作接收人的职责");
	  dlg.find('fieldset.shenpi').hide();
	  dlg.find('div.zeren').show();
	  dlg.find("#fireManRes").empty();
	  //get fire man responsibility
	  $.get('get_responsibility.htm', {uid:rd.userId}, function(data){
		  var repos = "";
		  $.each(data, function(i,val){
			  var main_css = "nobo secondary'><span>"+ val.funcode + "</span><i class='ui-icon ui-icon-radio-off'></i>";
			  if(/^\+?[0-9]*$/.test(val.node)) main_css="nobo primary '><span>"+ val.funcode + "</span><i class='ui-icon treeclick ui-icon-triangle-1-s'></i>";
			  repos += "<tr class='nob_t_b'><td class='"+ main_css + "</td><td class='nobo'>"+val.name+"</td><td class='all'>"+val.expected+"</td><td class='all'>"+val.explanation+"</td></tr>";
			});
		dlg.find("#fireManRes").append(repos);
	},'json');
	
	setTimeout(function(){
		dlg.find("#father_zeren,#receiverManRes").empty();
		$.get('get_responsibility.htm', {ename:rd.recipient,isf:true}, function(data){
		  var repos_fs = "<option value=''>请选择</option>";
		  var repos_fu = "<tr><td colspan='4'>调整 <b style='color:#693'>"+ rd.recipient +"</b> 的主责任比重<span style='float:right;color:red'>注意：所有主责任相加须等于100%(不能大于或小于100%)</span></td></tr>";
		  $.each(data, function(i,val){
			  repos_fs += "<option value='"+val.node+"'>"+val.funcode+ "&nbsp;&nbsp;" + val.name+"</option>";
			  repos_fu += "<tr class='nob_t_b'><td class='nobo primary'><span>"+ val.funcode +"</span><i class='ui-icon treeclick ui-icon-triangle-1-s'></i></td><td class='nobo'><input type='hidden' id='id_" + val.id + "' name='id' value='"+val.responId+"'/>"+val.name+"</td><td class='all'><input style='width:80px' class='expected' type='text' id='expected_" + val.node + "' name='expected' value='"+val.expected+"'/></td><td class='all'>"+val.explanation+"</td></tr>";
			});
		dlg.find("#father_zeren").append(repos_fs);
		dlg.find("#receiverManRes").append(repos_fu);
		},'json');
	},150);
  }else if(rd.nodeCode=="Technology"){
	  dlg.find('fieldset.shenpi').hide();
	  dlg.find('fieldset.account').show();
	  dlg.find('#transferMail').empty().append("将离职人 <b>"+rd.ename+"</b> 的邮件设置成转发到工作接收人 <b>"+ rd.recipient+"</b> 的邮箱");
	  dlg.dialog("option","title", "锁定或注销离职人 <b style='color:#F00'>"+rd.ename + "</b> 的公司系统、邮箱或其他所有相关帐号");
  }else{dlg.dialog("option","title", "审核 <b style='color:#F00'>"+rd.ename + "</b> 的离职申请");}
  
  dlg.dialog('open');
};

//提交离职流程
var updateDeparture = function() {
	var rdt;
	var dlg = $('#content_main');
	var selectrow = $("#zgrid").jqGrid("getGridParam", "selrow");
    if(selectrow) rdt = $('#zgrid').jqGrid("getRowData", selectrow);
	var approval = $.trim(dlg.find("input[name=approval]:checked").val());
	if(!dlg.find('#salaryDate').val()) dlg.find('#salaryDate').val('1986-12-28');
	if(rdt.nodeCode=="Director") {
		if(isEmpty(approval) || isEmpty(dlg.find('#reason').val())){dlg.find('dd.submit_msg').text("通过否和意见均不能为空").show().fadeOut(8000);}
		else {
			if(approval == "APPROVAL") {
				if(isEmpty(dlg.find('#recipientDpt').val()) || isEmpty(dlg.find('#recipient').val())) dlg.find('dd.submit_msg').text("接收人部门或个人未选择").show().fadeOut(8000);
				else {
					var jsdpt = dlg.find('#recipientDpt').find('option:selected').text();
					dlg.find('#recipientDpt').val(jsdpt);
					saveDeparture($('#departureForm').serialize() + "&recipientDpt=" + $.trim(jsdpt),selectrow,dlg);
				}
			}else saveDeparture($('#departureForm').serialize(),selectrow,dlg);
		}
	}else if(rdt.nodeCode=="Personnel"){
		if(isEmpty(approval) || isEmpty(dlg.find('#reason').val()) || isEmpty(dlg.find('#exitDate').val())){dlg.find('dd.submit_msg').text("通过否、离职日期和意见均不能为空").show().fadeOut(8000);}
		else saveDeparture($('#departureForm').serialize() + "&recipient=" + rdt.recipient, selectrow , dlg);
	}else if(rdt.nodeCode=="Receiver"){
		if(isEmpty(dlg.find('#reason').val()) || isEmpty(dlg.find('#attachment').val())){dlg.find('dd.submit_msg').text("意见和交接文档均不能为空").show().fadeOut(8000);}
		else saveDeparture($('#departureForm').serialize(),selectrow,dlg);
	}else if(rdt.nodeCode=="Financial"){
		if(isEmpty(dlg.find('#salaryDate').val()) || isEmpty(dlg.find('#reason').val())){dlg.find('dd.submit_msg').text("末资结算日期和说明均不能为空").show().fadeOut(8000);}
		else saveDeparture($('#departureForm').serialize(),selectrow,dlg);
	}else if(rdt.nodeCode=="Adjustment"){saveDeparture($('#departureForm').serialize() + "&reason=调整工作接收人职责比重",selectrow,dlg);}
	else if(rdt.nodeCode=="Technology"){
		 $.blockUI({message:'<h6><img src="../common/common/images/ztree/loading.gif" /> 系统正在处理中，请稍候！</h6>',css:{border:'none',padding:'15px',backgroundColor:'#000', '-webkit-border-radius':'10px', '-moz-border-radius':'10px', opacity:.5, color:'#fff' 
        }}); 
		saveDeparture($('#departureForm').serialize() + "&recipientDpt=" + rdt.recipientDpt + "&recipient=" + rdt.recipient + "&" + $('#accountForm').serialize(),selectrow,dlg);}
};

function saveDeparture(params,sd,dlg) {
	$.post('edit_departure.htm',params, function(data){
		if(data.result == "SUCCESS") {
		$('#zgrid').jqGrid("delRowData",sd);
		alert("操作成功！");
        dlg.dialog("close");
	  }
	},'json');
}

function getSon(obj) {
	if(obj.value){
		$("#receiverManRes").empty();
		$.get('get_responsibility.htm', {ename:$('#recevier').val(),node:obj.value}, function(data){
			var repos_s = "<tr><td colspan='4'>调整 <b style='color:#693'>"+ $(obj).find('option:selected').text() +"</b> 的子责任比重<span style='float:right;color:red'>注意：5个相加须等于100%(不能大于或小于100%)</span></td></tr>";
			$.each(data, function(i,val){
				repos_s += "<tr><td class='secondary'><span>"+ val.funcode +"</span><i class='ui-icon ui-icon-radio-off'></i></td><td><input type='hidden' id='id_" + val.id + "' name='id' value='"+val.responId+"'/>"+val.name+"</td><td><input class='expected' type='text' id='expected_" + val.node + "' name='expected' value='"+val.expected+"'/></td><td>"+val.explanation+"</td></tr>";
					});
				$("#receiverManRes").append(repos_s);
			},'json');
		}//end if
}