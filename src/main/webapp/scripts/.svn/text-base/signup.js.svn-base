$(document).ajaxStop($.unblockUI);
$(function(){
   $("input:radio[name='documents']").change(
    function(){
      switch($(this).val()){
        case 'PIDCard':$('#idcard').addClass('isIdCardNo'); break;
        default:$('#idcard').removeClass('isIdCardNo'); break;
      }
    });
  //$("#cell").mask("99 999 9999 9999");
  $.validator.addMethod("password", function(value, element) {
		var result = this.optional(element) || value.length >= 6 && /\d/.test(value) && /[a-z]/i.test(value);
		if (!result) {
			element.value = "";
			var validator = this;
			setTimeout(function() {
				validator.blockFocusCleanup = true;
				element.focus();
				validator.blockFocusCleanup = false;
			}, 1);
		}
		return result;
	}, "你的密码必须不少于6个字母或数字组合");
	
	$("#birthday").datepicker({changeMonth:true,changeYear:true,maxDate:"-18Y"});
    $.validator.addMethod("telephone", function(value, element) {  
        var v=value.replace(/\s+/g,"");
		return this.optional(element) || /^(\+?86-?)?((\([1,2]{1}\d{1}\)?\d{4}-?\d{4})|(\([3-9]{1}\d{2}\)?\d{4}-?\d{3,4}))$/.test(v);
	}, "格式：(86)138-1760-1860");
	
    //添加英文名字验证方法
    $.validator.addMethod("isEname", function(value, element) {  
        var v=value.replace(/\s+/g,"");
		return this.optional(element) || /^[a-zA-Z][a-zA-Z0-9_]{3,16}$/.test(v);
	}, "用户名必须是字母或数字或下划线");
    
	$.validator.messages.required = "";
	$("#userForm").validate({
		rules:{
			ename:{
				required:true,
				minlength:4,
				isEname:true,
				remote:"chk_user.htm"
				},
			cell:{
				required:true,
				remote:"chk_user.htm"
				},
			accountNo : {
				minlength:16
				}
		},
		invalidHandler: function(e, validator) {
			var errors = validator.numberOfInvalids();
			if (errors) {
				var message = errors == 1 ? '高亮显示的栏位为空，请填写完后再提交' : '你有 ' + errors + ' 栏位为空或有误.  请按错误提示来更正';
				$("div.error span").html(message);
				$("div.error").show();
			} else {
				$("div.error").hide();
			}
		},
		onkeyup:false,
		submitHandler:function(form) {
			$("div.error").hide();
			var pwd_crypt = $.md5($.trim($('#pwd').val()));
			$('#pwd').attr("value",pwd_crypt);
			$('#idcard').attr("value",$("#idcard").val().replace(/\s+/g,""));
			$('#cell').attr("value",$("#cell").val().replace(/\s+/g,""));
			$.blockUI({message:'<h6><img src="images/ztree/loading.gif" /> 系统正在处理中，请稍候！</h6>',css:{border:'none',padding:'15px',backgroundColor:'#000', '-webkit-border-radius':'10px', '-moz-border-radius':'10px', opacity:.5, color:'#fff'}});
			form.submit();
		},
		messages: {
			ename:{
				required: "",
				minlength: "英文名长度必须大于4位",
				remote:$.validator.format("{0} 英文名已存在，请选择其他名称注册")	
			},
			repwd:{
				required: "",
				equalTo: "输入的两次密码须一致"	
			},
			cell:{
				required: "",
				remote:$.validator.format("{0} 手机号已存在，请更换其他号码注册")	
			},
			accountNo:{
				minlength:$.validator.format("银行帐号长度应该大于16位")	
			}
			
		},
		debug:true
	});
	
  $("div.buttonSubmit").hoverClass("buttonSubmitHover");
  if ($.browser.safari) {
    $("body").addClass("safari");
  }
  
  var jcrop_api,boundx,boundy,pw,ph,numFlag,tmp_name;
  $('#thumbnail').hide();
  $('#idScanImage').uploadify({
  'uploader':'common/uploadify.swf',
  'script':'upload.htm',
  'cancelImg':'images/cancel.png',
  'fileExt':'*.jpg',
  'fileDesc':'只允许上传(.JPG)',
  'sizeLimit':102400,
  'buttonImg':'images/browse.jpg',
  'displayData':'speed',
  'expressInstall':'common/expressInstall.swf',
  'auto':true,
  'onComplete':function(event,ID,fileObj,response,data) {
	  var obj = $.parseJSON(response);
	  $('#thumbnail').show();
	  $('#tmp_portrait').attr("src", "uploads/images/"+obj.fileName);
	  $('#idScan_tmp').attr("src","uploads/images/"+obj.fileName);
	  tmp_name=obj.fileName;
	  $('#preview').removeClass().addClass("idScan_preview");
	  numFlag=1; pw=450; ph=270;
	  $('#tmp_portrait').Jcrop({onChange:updatePreview,onSelect:updatePreview,aspectRatio:5/3},function(){var bounds=this.getBounds();boundx=bounds[0];boundy=bounds[1];jcrop_api=this;});
	  jcrop_api.setImage("uploads/images/"+obj.fileName);
  },
  'onError':function(event, queueID, fileObj) {
	  alert("文件:" + fileObj.name + "上传失败！");
  }
  });
  
  $('#portraitImage').uploadify({
  'uploader':'common/uploadify.swf',
  'script':'upload.htm',
  'cancelImg':'images/cancel.png',
  'fileExt':'*.jpg;*.png',
  'fileDesc':'只允许上传(.JPG,.PNG)',
  'sizeLimit':102400,
  'buttonImg':'images/browse.jpg',
  'displayData':'speed',
  'expressInstall':'common/expressInstall.swf',
  'auto':true,
  'onComplete':function(event,ID,fileObj,response,data) {
	  var obj = $.parseJSON(response);
	  $('#thumbnail').show();
	  $('#tmp_portrait').attr("src", "uploads/images/"+obj.fileName);
	  $('#idScan_tmp').attr("src","uploads/images/"+obj.fileName);
	  tmp_name=obj.fileName;
	  $('#preview').removeClass().addClass("portrait_preview");
	  numFlag=2; pw=80; ph=100;
	  $('#tmp_portrait').Jcrop({boxWidth:670,boxHeight:670,onChange:updatePreview,onSelect:updatePreview,aspectRatio:4/5},function(){var bounds=this.getBounds();boundx=bounds[0];boundy=bounds[1];jcrop_api=this;});
	  jcrop_api.setImage("uploads/images/"+obj.fileName);
  },
  'onError':function(event, queueID, fileObj) {
	  alert("文件:" + fileObj.name + "上传失败！");
  }
  });
  
function updatePreview(coords){
 $('#zw').val(coords.w);
 $('#zh').val(coords.h);
 $('#x').val(coords.x);
 $('#y').val(coords.y);
  if(parseInt(coords.w) > 0){
	 var rx=pw/coords.w;
	 var ry=ph/coords.h;
  $('#idScan_tmp').css({width:Math.round(rx*boundx)+'px', height:Math.round(rx*boundy)+'px', marginLeft:'-'+Math.round(rx*coords.x)+'px',marginTop:'-'+Math.round(ry*coords.y)+'px'});}};
  
$('#crop_submit').click(function(){
  if(parseInt($('#x').val())){
	  $.post('crop.htm', {w:pw,h:ph,'zw':$('#zw').val(),'zh': $('#zh').val(),'x':$('#x').val(),'y': $('#y').val(),'oriName':tmp_name}, function(data) { 
			if(data.result == "SUCCESS") {
				if(numFlag == 1) {$('#idScan').val(data.fileName);$('#sfz img').remove();$('#sfz').append('<img src="uploads/images/'+data.fileName +'" alt="身份证扫描件" title="身份证扫描件"/>');}
			else{$('#portrait').val(data.fileName);$('#touxian img').remove();$('#touxian').append('<img src="uploads/images/'+data.fileName +'" alt="头像" title="头像"/>');}
			$('#idScan_tmp').attr("src","");
			$('#tmp_portrait').attr("src","");
			$('#thumbnail').hide();
			alert("裁剪图片成功！");
			jcrop_api.release();
		} else { alert("生成略缩头像失败");} 
		},'json');
  }else{alert("要先在图片上划一个选区再单击确认剪裁的按钮哦！");	}
}); 

});

$.fn.hoverClass = function(classname) {
	return this.hover(function() {
		$(this).addClass(classname);
	}, function() {
		$(this).removeClass(classname);
	});
};