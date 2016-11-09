$(function(){
$.fn.zTree.init($("#menu"), setting);
$("#cell").mask("(99)999-9999-9999");
$('#thumbnail').hide();
var jcrop_api,boundx,boundy,pw,ph,numFlag,tmp_name;
$('#idScanImage').uploadify({
  'uploader':'../common/uploadify.swf',
  'script':'../upload.htm',
  'cancelImg':'images/cancel.png',
  'fileExt':'*.jpg;*.png',
  'fileDesc':'只允许上传(.JPG,.PNG)',
  'sizeLimit':102400,
  'buttonImg':'../images/browse.jpg',
  'displayData':'speed',
  'expressInstall':'../common/expressInstall.swf',
  'auto':true,
  'onComplete':function(event,ID,fileObj,response,data) {
	  var obj = $.parseJSON(response);
	  $('#thumbnail').show();
	  $('#tmp_portrait').attr("src", "../uploads/images/"+obj.fileName);
	  $('#idScan_tmp').attr("src","../uploads/images/"+obj.fileName);
	  tmp_name=obj.fileName;
	  $('#preview').removeClass().addClass("idScan_preview");
	  numFlag=1; pw=450; ph=270;
	  $('#tmp_portrait').Jcrop({onChange:updatePreview,onSelect:updatePreview,aspectRatio:5/3},function(){var bounds=this.getBounds();boundx=bounds[0];boundy=bounds[1];jcrop_api=this;});
	  jcrop_api.setImage("../uploads/images/"+obj.fileName);
  },
  'onError':function(event, queueID, fileObj) {
	  alert("文件:" + fileObj.name + "上传失败！");
  }
});

$('#portraitImage').uploadify({
  'uploader':'../common/uploadify.swf',
  'script':'../upload.htm',
  'cancelImg':'images/cancel.png',
  'fileExt':'*.jpg;*.png',
  'fileDesc':'只允许上传(.JPG,.PNG)',
  'sizeLimit':102400,
  'buttonImg':'../images/browse.jpg',
  'displayData':'speed',
  'expressInstall':'../common/expressInstall.swf',
  'auto':true,
  'onComplete':function(event,ID,fileObj,response,data) {
	  var obj = $.parseJSON(response);
	  $('#thumbnail').show();
	  $('#tmp_portrait').attr("src", "../uploads/images/"+obj.fileName);
	  $('#idScan_tmp').attr("src","../uploads/images/"+obj.fileName);
	  tmp_name=obj.fileName;
	  $('#preview').removeClass().addClass("portrait_preview");
	  numFlag=2; pw=80; ph=100;
	  $('#tmp_portrait').Jcrop({onChange:updatePreview,onSelect:updatePreview,aspectRatio:4/5},function(){var bounds=this.getBounds();boundx=bounds[0];boundy=bounds[1];jcrop_api=this;});
	  jcrop_api.setImage("../uploads/images/"+obj.fileName);
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
		$('#idScan_tmp').css({width:Math.round(rx*boundx)+'px', height:Math.round(ry*boundy)+'px', marginLeft:'-'+Math.round(rx*coords.x)+'px',marginTop:'-'+Math.round(ry*coords.y)+'px'});
	}
}
	
$('#crop_idScan').click(function(){
	if(parseInt($('#x').val())){
		$.post('../crop.htm', {w:pw,h:ph,'zw':$('#zw').val(),'zh': $('#zh').val(),'x':$('#x').val(),'y': $('#y').val(),'oriName':tmp_name},function(data){if(data.result == "SUCCESS"){
			if(numFlag == 1) {$('#idScan').val(data.fileName);$('#sfz img').remove();$('#sfz').append('<img src="../uploads/images/'+data.fileName +'" alt="身份证扫描件" title="身份证扫描件"/>');}
			else{$('#portrait').val(data.fileName);$('#touxian img').remove();$('#touxian').append('<img src="../uploads/images/'+data.fileName +'" class="grid_3 omega" alt="头像" title="头像"/>');}
			$('#idScan_tmp').attr("src","");
			$('#tmp_portrait').attr("src","");
			$('#thumbnail').hide();
			alert("裁剪图片成功！");
			jcrop_api.release();
			}else{alert("生成略缩图失败");}
		},'json');
	}else{alert("要先在图片上划一个选区再单击确认剪裁的按钮哦！");}
});

var msg_cn = {cell:"为方便联系，请填写手机号",phone:"固定电话留一个",privateMail:{required:"私人邮箱留个以防公司邮箱出问题", email:"邮箱格式有误"},telExt:{required:"输入公司分配的分机号",number:"输入有误，分机号只能为数字"},bank:"输入开户行名称",accountNo:"确认银行账号正确",idScan:"请上传身份证扫描件",portrait:"请上传个人头像"};
var msg_tw = {cell:"為方便聯系，請填寫手機號",phone:"固定電話留一個",privateMail:{required:"私人郵箱留個以防公司郵箱出問題", email:"郵箱格式有誤"},telExt:{required:"輸入公司分配的分機號",number:"輸入有誤，分機號只能為數字"},bank:"輸入開戶行名稱",accountNo:"確認銀行賬號正確",idScan:"請上傳身份證掃描件",portrait:"請上傳個人頭像"};

var oldform = $("#userForm").serialize();

$('#userForm').validate({
		rules:{
			cell:"required",
			phone:"required",
			privateMail:{required:true,email:true},
			telExt:{required:true,number:true},
			bank:"required",
			accountNo:{required:true,number:true},
			idScan:"required",
			portrait:"required"
		},
		messages:{
			cell:{required:"为方便联系，请填写手机号", mobileCN:"正确格式:(86)138-1760-1860"},
			phone:{required:"固定电话留一个", phoneCN:"正确格式：86(21)1760-1860"},
			privateMail:{required:"私人邮箱留个以防公司邮箱出问题", email:"邮箱格式有误"},
			telExt:{required:"输入公司分配的分机号",number:"输入有误，分机号只能为数字"},
			bank:"输入开户行名称",
			accountNo:{required:"确认银行账号正确",number:"银行账号只能为数字"},
			idScan:"请上传身份证扫描件",
			portrait:"请上传个人头像"
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
			if(oldform == $("#userForm").serialize()) return false;	//是否有修改
			$.ajax({data:$("form").serialize(),type:'POST',url:'update_user.htm',dataType:'text',cache:false,success:function(data){if(data == "SUCCESS"){oldform = $("#userForm").serialize();alert("更新基本资料成功！");}else {alert("更新资料失败！");}} });
		},
		debug:false
	});

});<!-- end global -->