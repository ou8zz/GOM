var msg_cn = {event:"输入请假事因", type:"请假类型不能空", startDate:"开始日期不能为空", endDate:"结束日期不能为空", days:{required:"输入请假天数",number:"天数只能为数字"}, contact:"输入假期联系方式", handOver:"交待或交接项不能为空", agentDepart:"代理人所在部门不能空", agent:"请选择代理人", recipient:"选择直接主管" };
var msg_tw = {event:"輸入請假事因", type:"請假類型不能空", startDate:"開始日期不能為空", endDate:"結束日期不能為空", days:{required:"輸入請假天數",number:"天數只能為數字"}, contact:"輸入假期聯系方式", handOver:"交待或交接項不能為空", agentDepart:"代理人所在部門不能空", agent:"請選擇代理人", recipient:"選擇直接主管" };


// unblock when ajax activity stops 
$(document).ajaxStop($.unblockUI);
$(function(){
$.fn.zTree.init($("#menu"), setting);
$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});

$('#startDate').focus(function(){WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d'});});
$('#endDate').focus(function(){WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startDate\');}'});});

//选择部门拉出所有这个部门下的主管和经
$('#recipientDpt').change(function(){getMgrs('#recipient',this);});
$('#agentDpt').change(function(){getUsers('#agent',this);});

var validator = $("#leaveForm").validate({
		rules:{
			event:"required",
			type:"required",
			startDate:"required",
			endDate: "required",
			days:{required:true,number:true},
			contact:"required",
			handOver:"required",
			agentDepart:"required",
			agent:"required",
			recipient:"required"
		},
		messages:{
			event:"输入请假事因",
			type:"请假类型不能空",
			startDate:"开始日期不能为空",
			endDate:"结束日期不能为空",
			days:{required:"输入请假天数",number:"天数只能为数字"},
			contact:"输入假期联系方式",
			handOver:"交待或交接项不能为空",
			agentDepart:"代理人所在部门不能空",
			agent:"请选择代理人",
			recipient:"选择直接主管"
		},
		// the errorPlacement has to take the table layout into account
		errorPlacement:function(error, element) {
			if (element.is(":radio"))
				error.appendTo(element.parent().parent().next().next());
			else if (element.is(":checkbox") )
				error.appendTo(element.next());
			else error.appendTo(element.parent());
		},
		// specifying a submitHandler prevents the default submit, good for the demo
		submitHandler:function() {
			var errors = validator.numberOfInvalids();
			if (!errors) {
				if (!confirm("您确定要提交吗？")) return false;

				$.blockUI({message:'<h6><img src="../images/ztree/loading.gif" />系统正在处理中，请稍候！</h6>',css:{border:'none',padding:'15px',backgroundColor:'#000','-webkit-border-radius':'10px', '-moz-border-radius':'10px',opacity:.5, color:'#fff' }});
				
				if ($('#id').val()) {
					$.ajax({data:$("#leaveForm").serialize(),type:'POST',url:'edit_leave.htm',dataType:'json',cache:false,success:function(data){if(data.result == "SUCCESS"){alert("重新提交成功，请待审批！");self.location="get_leave.htm";}else {alert("重新申请失败，稍候再试！");self.location="leave.htm";}}});
				} else {
					$('#applyDate').val('1985-12-05 12:30:52');
					$.ajax({data:$("#leaveForm").serialize(),type:'POST',url:'save_leave.htm',dataType:'json',cache:false,success:function(data){if(data.result == "SUCCESS"){alert("请假成功，请待审批！");self.location="get_leave.htm";}else {alert("申请失败，稍候再试！");self.location="leave.htm";}}});
				}
			}
		},
		// set this class to error-labels to indicate valid fields
		success:function(label) {
			// set   as text for IE
			label.html(" ").addClass("checked");
		}
});

$('#tmp_user').uploadify({
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
});