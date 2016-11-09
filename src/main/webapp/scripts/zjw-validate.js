$.fn.extend({validate:function(element,msg,len,chkUrl){$(this).focus(function(){$('#ok_'+ this.name).remove();$(element).html("<s></s><i>"+msg[0]+"</i>").addClass("tip_info").removeClass("inp_error");});
$(this).blur(function() {var tvalue=$.trim($(this).val());var tkey = this.name;
if(tvalue.length <= 0) {$(element).html('').addClass('');}
else {$(element).html('<s></s><i>正在验证...</i>');
if(checkLength(tvalue) < len[0] || checkLength(tvalue) > len[1]) {$(element).html("<s></s><i>"+msg[1]+"</i>").addClass("inp_error");}
else if(isNull($(this).val())) {$(element).html("<s></s><i>"+msg[2]+"</i>").addClass("inp_error");}
else if(chkUrl){$.get(chkUrl+tkey+'='+tvalue,function(data){if($.trim(data)=="FAILED"){$(element).html("<s></s><i>"+msg[3]+"</i>").addClass("inp_error");}else{$('#ok_'+tkey).remove();$(element).html('');okTip(tkey);}});}}//end else
});//end blur
 }//end validate
}); //end extend

function checkLength(strTemp) {var i, sum;sum = 0; for(i = 0; i < strTemp.length; i++) {
if((strTemp.charCodeAt(i) >= 0) && (strTemp.charCodeAt(i) <= 255))sum = sum + 1; else sum = sum + 2;} return sum; }
function isNull(str){if(str == "") return true;var reg = /^[ ]+$/;return reg.test(str);}
function okTip(obj) {$('#'+obj).after('<span id="ok_' + obj + '"><img src="../common/scripts/common/images/accept.png" height="16" width="16"></span>');}