$(function(){
var count=1;
var click_count=0;
var es=$("input[type!='submit']");
es.focus(function(){$(this).parents('dd').addClass('highlight');});
es.blur(function(){$(this).parents('dd').removeClass('highlight');}); 
																																																																
//$("#rand_next").click(function() {$('#rand_img').attr("src","rand_code.htm?"+Math.random());});

$("#loginForm").validate({rules:{userName:{required:true},password:{required:true},code:{required:true}},
onkeyup:false,
submitHandler:function() {
	click_count++;
	$("div.error").hide();
	var pwd_crypt = $.md5($.trim($('#password').val()));
	//if(count>=2) $("#rand_code").show(); else $("#rand_code").hide();
	if(count<=5 && click_count == 1){
		var params = {'ajax':true, 'j_username':$('#userName').val(),'j_password':pwd_crypt,'num':count++,'code':$('#code').val(),_spring_security_remember_me:Boolean($("input[name=j_remember]:checked").val())};
		$.post('gom_login.htm', params,function(data){
		    if(data == null) {alert("此账号无法登录，请联络系统管理员！"); return false;}
		    count=data.c+1;
		    if(data.result=="SUCCESS") {self.location=data.url;}
		    else if(data.result == "PARAM_EMPTY") {
			    if(data.msg) alert(data.msg);
			    //if(count>=2)
			    $('#rand_img').attr("src","rand_code.htm?"+Math.random());
		    }
		    else if(data.result == "FAILED") {
		    	if(data.msg) alert(data.msg);
		    	else alert("登录操作失败！");
		    }
		    else alert("此账号无法登录，请联络系统管理员");
		    click_count=0;
		},'json');
	} else {
		alert("你的帐户已被锁定，请30分钟后再登录。");
	}
},
//messages:{userName:{required:"&nbsp;用户名不能空"},password:{required:"&nbsp;密码不能空"},code:{required:"&nbsp;验证码不能为空"}},
messages:{userName:{required:""},password:{required:""},code:{required:""}},
debug:true
});

$("#loginForm").submit(function() {
	var uname = $('#userName').val();
	var pwd = $('#password').val();
	var code = $('#code').val();
	if(uname == null || uname == "") {
		alert("用户名不能为空！");
		return false;
	}
	if(pwd == null || pwd == "") {
		alert("密码不能为空！");
		return false;
	}
	if(code == null || code == "") {
		alert("验证码不能为空！");
		return false;
	}
});

//日志列表
$.get('get_logs.htm', function(data){
	var main = $("#logs_main");
    if(data != null && data.logs != null) {
    	main.empty();
    	var sp = "";
    	$.each(data.logs, function(i, l) {
    		if(l.type == "SYSTEM") {
    			sp += "<span class='sp'>"+l.logger+"</span><br />";
    			sp += "<span class='sp'>"+l.dated+"</span><br />";
    		} else {
    			sp += "<span class='sp'>"+l.dated.split(" ")[0]+"</span><br />";
    		}
    		sp += l.message + "<p />";
    	});
    	main.append(sp);
    } 
    else {
    	alert("唉呀，不好拉，数据出错拉！"); 
    	return false;
    }
}, 'json');

});

/**发送验证码*/
function sendCode(){
	var f = $("#loginForm");
	var ename = $.trim(f.find("#userName").val());
	var pwd = $.trim(f.find('#password').val());
	if(!isEmpty(ename) && !isEmpty(pwd)) {
		$.post("send_security.htm",{ename:ename, pwd:$.md5($.trim(pwd))}, function(data){
			if(data.result == "SUCCESS") {
				alert("发送验证码成功");
				$("#scode").attr({"onclick":"javascript:alert('请不要重复此操作！');"});
				window.setTimeout(function() {$("#scode").attr({"onclick":"javascript:sendCode();"});}, 10000);
			} else if(data.result == "FAILED") {
				alert("验证错误，请检查用户名或密码！");
			} else {
				alert("验证码发送失败，请验证用户数据完整性！");
			}
		},'json');
	}
	else alert("请输入正确的用户名和密码");
}
