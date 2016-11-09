var errMsg = new Array();
var tcheck = '';
errMsg[0] = {
    1: '<s></s><i>请输入中文名称</i>',
	2: '<s></s><i>中文名称字数过多或不足，2~5字符</i>',
    3: '<s></s><i>该中文名称已存在！</i>',
	4: '<s></s><i>中文名称不能为空</i>',
	5: '<s></s><i>请输入英文名称</i>',
	6: '<s></s><i>字数过多或不足，4~15字符</i>',
	7: '<s></s><i>该英文名称已存在！</i>',
	8: '<s></s><i>英文名称不能为空</i>'
};
function onEvent() {
$('#cname').focus(function() {
  $('#ok_cname').remove(); 
  if ($('#c_title').attr("class") != "inp_error") {
	 $('#c_title').html(errMsg[0][1]);
	 $('#c_title').attr("class", "inp_warning");
	 }
});
$('#cname').blur(function() {
  if ($('#cname').val().length <= 0) {
	$('#c_title').html('');
	$('#c_title').attr("class", "");
	}
	else {
	if (tcheck == $('#cname').val()) {
		return;
		}
	$('#c_title').html('<s></s><i>验证中文名称...</i>');
	if (fucCheckLength($('#cname').val()) < 4 || fucCheckLength($('#cname').val()) > 10) {
		$('#c_title').html(errMsg[0][2]);
		$('#c_title').attr("class", "inp_error");
		}
	else if (isNull($('#cname').val())) {
		$('#c_title').html(errMsg[0][4]);
		$('#c_title').attr("class", "inp_error");
		}
	else {
		tcheck = $('#cname').val();
		$.post('check_group.htm', {'cname': $.trim(tcheck),'type':'DEPARTMENT'}, 
			function (data) { 
			if ($.trim(data) == "FAILED") { 
				$('#c_title').html(errMsg[0][3]); 
				$('#c_title').attr("class", "inp_error"); 
				} else { 
					$('#ok_cname').remove(); 
					$('#c_title').html('');
					okTip('#cname','cname');} 
		});
		}
	}
});

$('#ename').focus(function() {
  $('#ok_title').remove();
  if ($('#e_title').attr("class") != "inp_error") {
	 $('#e_title').html(errMsg[0][5]);
	 $('#e_title').attr("class", "inp_warning");
	 }
});
$('#ename').blur(function() {
	$('#ok_ename').remove(); 
  if ($('#ename').val().length <= 0) {
	$('#e_title').html('');
	$('#e_title').attr("class", "");
	}
	else {
	if (tcheck == $('#ename').val()) {
		return;
		}
	$('#e_title').html('<s></s><i>验证英文名称...</i>');
	if (fucCheckLength($('#ename').val()) < 4 || fucCheckLength($('#ename').val()) > 15) {
		$('#e_title').html(errMsg[0][6]);
		$('#e_title').attr("class", "inp_error");
		}
	else if (isNull($('#ename').val())) {
		$('#e_title').html(errMsg[0][8]);
		$('#e_title').attr("class", "inp_error");
		}
	else {
		tcheck = $('#ename').val();
		$.post('check_group.htm', {'ename': $.trim(tcheck),'type':'DEPARTMENT'}, 
			function (data) { 
			if ($.trim(data) == "FAILED") { 
				$('#e_title').html(errMsg[0][7]); 
				$('#e_title').attr("class", "inp_error"); 
				} else { 
					$('#e_title').html('');
					okTip('#ename','ename');} 
		});
		}
	}
});
}
function fucCheckLength(strTemp) {
    var i, sum;
    sum = 0;
    for (i = 0; i < strTemp.length; i++) {
        if ((strTemp.charCodeAt(i) >= 0) && (strTemp.charCodeAt(i) <= 255))
            sum = sum + 1;
        else
            sum = sum + 2;
    }
    return sum;
}
function isNull(str){
  if ( str == "" ) return true;
  var reg = /^[ ]+$/;
  return reg.test(str);
}
function okTip(obj,str) {
 $(obj).after('<span id="ok_' + str + '"><img src="../common/common/images/accept.png" height="16" width="16"></span>');
}