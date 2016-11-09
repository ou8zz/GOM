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
$('option').remove('.choice');
if(ad){
$.get('get_agents.htm',{'ename':ad},function(data){
 if(data.result=="SUCCESS"){
  var option = "";
  $.each(data.agents, function(i,val){
	  option += "<option class='choice' value='" + val.ename + "'>" + val.ename + "</option>";
	});
  $('#agent').append(option);
}else alert("代理人部门选择有误！");
},'json');
}else alert("请先选择代理人部门！");
});

$.get('get_receipt.htm',function(data){
      if(data != null) {
		$('#type').val(data.type);
		$('#leaveType').val(data.type);
		$('#comment').val(data.comment);
		$('#processInstanceId').val(data.processInstanceId);
		$('#sessionId').val(data.sessionId);
		$('#taskId').val(data.taskId);
		$('#event').val(data.event);
		$('#startDate').val(data.startDate);
		$('#endDate').val(data.endDate);
		$('#days').val(data.days);
		$('#contact').val(data.contact);
		$('#agentDepart').val(data.agentDepart);
		var option = "<option class='choice' value='" + data.agent + "'>" + data.agent + "</option>";
		$('#agent').append(option);
		$('#user').val(data.applicant.ename);
		$('#agent').val(data.agent);
		$('#handOver').val(data.handOver);
		$('#pifu').after("<p>" + data.comment + "</p>");
	  }
	 else {$('#pifu').after('<p style="color:red">您的申请正在审核中，请注意查收你的邮件。</p>'); $('#lf,#lfsub').hide();}
	},'json');

var msg_cn = {event:"输入请假事因",startDate:"开始日期不能为空",endDate:"结束日期不能为空",days:{required:"输入请假天数",number:"天数只能为数字"},contact:"输入假期联系方式",handOver:"交待或交接项不能为空",agentDepart:"代理人所在部门不能空",agent:"请选择代理人"};
var msg_tw = {event:"輸入請假事因",startDate:"開始日期不能為空",endDate:"結束日期不能為空",days:{required:"輸入請假天數",number:"天數只能為數字"},contact:"輸入假期聯系方式",handOver:"交待或交接項不能為空",agentDepart:"代理人所在部門不能空",agent:"請選擇代理人"};

var validator = $("#leaveForm").validate({
		rules:{
			event:"required",
			startDate:"required",
			endDate: "required",
			days:{required:true,number:true},
			contact:"required",
			handOver:"required",
			agentDepart:"required",
			agent:"required"
		},
		messages:{
			event:"输入请假事因",
			startDate:"开始日期不能为空",
			endDate:"结束日期不能为空",
			days:{required:"输入请假天数",number:"天数只能为数字"},
			contact:"输入假期联系方式",
			handOver:"交待或交接项不能为空",
			agentDepart:"代理人所在部门不能空",
			agent:"请选择代理人"
		},
		// the errorPlacement has to take the table layout into account
		errorPlacement:function(error, element) {
			if (element.is(":radio"))
				error.appendTo(element.parent().parent().next().next());
			else if (element.is(":checkbox") )
				error.appendTo(element.next() );
			else error.appendTo(element.parent().parent());
		},
		// specifying a submitHandler prevents the default submit, good for the demo
		submitHandler:function() {
			var errors = validator.numberOfInvalids();
			if(!errors){
				$.blockUI({message:'<h6><img src="../images/ztree/loading.gif" /> 系统正在处理中，请稍候！</h6>',css:{border:'none',padding:'15px',backgroundColor:'#000', '-webkit-border-radius':'10px', '-moz-border-radius':'10px', opacity:.5, color:'#fff' 
        }}); 	
  $.ajax({data:$("form").serialize(),type:'POST',url:'save_receipt.htm',dataType:'text',cache:false,
	success:function(data){if(data == "SUCCESS"){alert("重新申请成功，请待审批！");self.location="index.html";}else {alert("申请失败，稍候再试！");}}
  });
			}
		},
		// set this class to error-labels to indicate valid fields
		success:function(label) {
			// set   as text for IE
			label.html(" ").addClass("checked");
		}
	});
});