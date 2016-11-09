var edus = new Array();
var cc = 1;
var flg=false;
$(function(){
$("#next_item").click(function() {
  var edu = new Object();
  edu.id=$('#id').val();
  edu.idScan=$('#idScan').val();
  edu.startDate=$('#startDate').val();
  edu.endDate=$('#endDate').val();
  edu.school=$('#school').val();
  edu.major=$('#major').val();
  edu.ed=$('#ed').val();
  edu.idno=$('#idno').val();
  
  if(edu.startDate&&edu.endDate&&edu.school&&edu.major&&edu.ed&&edu.idno) {
	  addRow(edu);
	  $('#id').val('');
	  $('#idScan').val('');
	  $('#startDate').val('');
	  $('#endDate').val('');
	  $('#school').val('');
	  $('#major').val('');
	  $('#ed').val('');
	  $('#idno').val('');
	 }
});

$("#userSubmit").click(function() {
  var edu = new Object();
  edu.id=$('#id').val();
  edu.idScan=$('#idScan').val();
  edu.startDate=$('#startDate').val();
  edu.endDate=$('#endDate').val();
  edu.school=$('#school').val();
  edu.major=$('#major').val();
  edu.ed=$('#ed').val();
  edu.idno=$('#idno').val();
  
  if(edu.startDate&&edu.endDate&&edu.school&&edu.major&&edu.ed&&edu.idno){
	  if(isEmpty(edu.id)) edu.id=0;
	  edus.push(edu);
	}
	
  if(edus.length>0) {
	$('#edus').attr("value",$.toJSON(edus));
    flg=true;
  }
});
	$.validator.messages.required = "不能为空";
	$("#eduForm").validate({
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
			if(flg) form.submit();
			if(edus.length>0) {
			   $('#startDate').attr("value","");
			   $('#endDate').attr("value","");
			   $('#school').attr("value","");
			   $('#major').attr("value","");
			   $('#ed').attr("value","");
			   $('#idno').attr("value","");
			}
		},
		debug:true
	});
	
  $("div.buttonSubmit").hoverClass("buttonSubmitHover");
  if ($.browser.safari) {
    $("body").addClass("safari");
  }
  
  $('#idScanImg').uploadify({
  'uploader':'common/uploadify.swf',
  'script':'upload.htm',
  'cancelImg':'images/cancel.png',
  'fileExt':'*.jpg;*.gif;*.png',
  'fileDesc':'只允许上传(.JPG,.PNG)',
  'sizeLimit':1024000,
  'buttonImg':'images/browse.jpg',
  'displayData':'speed',
  'expressInstall':'common/expressInstall.swf',
  'auto':true,
  'onComplete':function(event,ID,fileObj,response,data) {
	  var obj = $.parseJSON(response);
	  $('#idScan').attr("value",obj.fileName);
  },
  'onError':function(event, queueID, fileObj) {
	  alert("文件:" + fileObj.name + "上传失败！");
  }
  });
  
//学历开始时间不能大于结束时间
$("#startDate").datepicker({defaultDate: "+1w", changeMonth: true, changeYear: true,numberOfMonths: 3,onClose: function( selectedDate ) {$("#endDate").datepicker( "option", "minDate", selectedDate );}});
$("#endDate").datepicker({defaultDate: "+1w", changeMonth: true, changeYear: true,numberOfMonths: 3,onClose: function( selectedDate ) {$("#startDate").datepicker( "option", "maxDate", selectedDate );}});
	  
$('tbody tr:odd').addClass("t_even");
$('tbody tr').mouseover(function(){$(this).addClass("t_over");}).mouseout(function(){$(this).removeClass("t_over");});
});

$.fn.hoverClass = function(classname) {
	return this.hover(function() {
		$(this).addClass(classname);
	}, function() {
		$(this).removeClass(classname);
	});
};

function addRow(edu){
if(isEmpty(edu.id)) edu.id=0;
cc++;
edus.push(edu);
$("tbody").append('<tr><td>'+cc+'</td><td>'+edu.startDate+'</td><td>'+edu.endDate+'</td><td>'+edu.school+'</td><td>'+edu.major+'</td><td>'+edu.ed+'</td><td><a href="javascript:void(0);" onClick="delRow(this)">删除</a></td></tr>');
$('tbody tr:odd').addClass("t_even");$('tbody tr').mouseover(function(){$(this).addClass("t_over");}).mouseout(function(){$(this).removeClass("t_over");});
}
function delRow(obj){
$(obj).parents("tr").remove();
var nedu =$.grep(edus,function(cur,i){return cur["id"]!=$(obj).parents("tr td:first").text();});
edus.splice(0,edus.length);
edus=nedu;
}