$(function(){
	$.fn.zTree.init($("#menu"), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
			
	/**发送验证码*/
	$("#sendsecurity").click(function() {
		$.post("../send_security.htm", function(data){
			if(data.result == "SUCCESS") {
				alert("发送验证码成功");
				$("#sendsecurity").attr({"disabled":"disabled"});
				var secs = 30; //倒计时的秒数 
				for(var i=secs;i>=0;i--) { 
					window.setTimeout('use('+i+')', (secs-i)*1000);
				} 
			}
		},'json');
	});
	
	/** 修改密码 */
	$("#sub").click(function() {
		var t = /^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){6,19}$/;
		var oldPwd = $("#pwd").val();
		var newPwd = $("#npwd").val();
		var repeatPwd = $("#rpwd").val();
		var security = $("#security").val();
		
		if(!vali(oldPwd, newPwd, repeatPwd, security)) return false;
		else {
			$.post("save_pwd.htm", {oldPwd:$.md5($.trim($('#pwd').val())), newPwd:$.md5($.trim($('#npwd').val())), security:$.trim($('#security').val())}, function(data) {
			if(data.result=="PARAM_EMPTY") $('#errors').text("新旧密码均不能为空").show().fadeOut(8000);
			else if(data.result=="INPWD") $('#errors').text("原始密码错误").show().fadeOut(8000);
			else if(data.result=="INVALID") $('#errors').text("验证码错误").show().fadeOut(8000);
			else if(data.result=="SUCCESS"){$('#errors').text("修改密码成功！").show().fadeOut(8000); dlg.find('#pwdForm')[0].reset();}
			else $('#errors').text("通信错误，请稍后在试！").show().fadeOut(8000);
		   },'json');	
		}	
	});
}); 

//var rmsg_cn = {"新旧密码均不能为空", "原始密码错误", "验证码错误", "修改密码成功"};
//var rmsg_tw = {"新舊密碼均不能為空", "原始密碼錯誤", "驗證碼錯誤", "修改密碼成功"};

//var msg_cn = {"新旧密码均不能为空", "请输入6位以上密码", "新密码不能和原密码相同", "请输入一个安全的密码", "两次密码必须相同", "请输入验证码"};
//var msg_tw = {"新舊密碼均不能為空", "請輸入6位以上密碼", "新密碼不能和原密碼相同", "請輸入一個安全的密碼", "兩次密碼必須相同", "請輸入驗證碼"};


function vali(oldPwd, newPwd, repeatPwd, security) {
	var t = /^[\w.~!@#$%^&*]{6,19}$/;
	if(oldPwd.length < 1 || newPwd.lenth < 1 || repeatPwd.length < 1) {
		$("#errors").text("新旧密码均不能为空").show().fadeOut(8000);
		return false;
	}
	if(newPwd.length < 5) {
		$("#errors").text("请输入6位以上密码").show().fadeOut(8000);
		return false;
	} else if(oldPwd == newPwd) {
		$("#errors").text("新密码不能和原密码相同").show().fadeOut(8000);
		return false;
	} else if(!t.test(newPwd)) {
		$("#errors").text("请输入一个安全的密码").show().fadeOut(8000);
		return false;
	}
	if(newPwd != repeatPwd) {
		$("#errors").text("两次密码必须相同").show().fadeOut(8000);
		return false;
	}
	if(security.length < 1) {
		$("#errors").text("请输入验证码").show().fadeOut(8000);
		return false;
	}
	return true;
}

/**
 * 发送邮件定时按纽
 * @param i
 */
function use(i) {
	document.getElementById('sendsecurity').value= i+"发送邮件验证码";
	if(i==0){ 
		$("#sendsecurity").removeAttr("disabled"); 
		$("#sendsecurity").val("发送邮件验证码");
	}
}
