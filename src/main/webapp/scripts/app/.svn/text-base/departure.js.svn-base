//var msg_cn = {"离职日期不能为空", "请选择审核人", "离职原因不能为空", "您确定要提交吗？"};
//var msg_tw = {"離職日期不能為空", "請選擇審核人", "離職原因不能為空", "您確定要提交嗎？"};

$(function(){
	//$('#recipientDpt').val($('#depart').val());
	//选择部门拉出所有这个部门下的主管和经
	$('#recipientDpt').change(function(){
		if($(this).val()){
			var opt = $('#recipient').empty();
			$.post('../dpt_users.htm',{'dpt':$(this).val(),'type':'POSITION','ismgr':true},function(data){
				$.each(data, function(i,val){opt.append("<option value='" + val.ename + "'>" + val.ename + "</option>");});
			},'json');
		}else alert("请先选择部门！");
	});

	$.fn.zTree.init($("#menu"), setting);
	$("#exitDate").datepicker({changeMonth:true,changeYear:true,minDate:$('#pdays').val()});
	
	//提交验证
	$("#departureForm").submit(function() {
		var form = $(this);
		var options = "";
		var err = $("#content").find("#err");
		if(isEmpty(form.find("#exitDate").val())) {
			err.html("离职日期不能为空");
			return false;
		} else err.html('');
		if(isEmpty(form.find("#recipient").val()) || form.find("#recipient").val() == null) {
			err.html("请选择审核人");
			return false;
		} else err.html('');
		if(isEmpty(form.find("#reason").val())) {
			err.html("离职原因不能为空");
			return false;
		} else err.html('');
		if(isEmpty(form.find("#recipientDpt").val()) || form.find("#recipientDpt").val() == "请选择") {
			err.html("请选择接收人部门");
			return false;
		} else {
			err.html('');
			options = form.find('#recipientDpt').html();
			var dpt = form.find('#recipientDpt').find("option:selected").text();  //获取Select选择的Text
			form.find('#recipientDpt').empty().append("<option selected>" + dpt + "</option>");
		}
		
		if(!confirm("您确定要提交吗？")) {
			form.find('#recipientDpt').empty().append(options);
			return false;
		}
	});
	
}); 