$(function(){
	$("#zipcode,#zipcode2").mask("999999");
	$("#userSubmit").click(function() {
	   if(isEmpty($('#id').val())) $('#id').val(0);
	});
	$.validator.messages.required = "不能为空";
	$("#addrForm").validate({
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
			$("div.error,#userSubmit").hide();
			if($('#addr_to_co').val() == "on") $('#addrs').val("[{id:'"+$('#id').val()+"',addrType:'"+$('#addrType').val()+"',contact:'"+$('#contact').val()+"',relation:'"+$('#relation').val()+"',cell:'"+$('#cell').val()+"',phone:'"+$('#phone').val()+"',address:'"+$('#address').val()+"',zipcode:'"+$('#zipcode').val()+"'}]");
			else $('#addrs').val(toJson($('#addrForm').serializeArray(),8));
			$('#addrsForm').submit();
		},
		debug:true
	});
	
  $("div.buttonSubmit").hoverClass("buttonSubmitHover");
  if($.browser.safari) {
    $("body").addClass("safari");
  }
  
  $.validator.addMethod("familyRequired", function(value, element) {
		if($("#addr_to_co").is(":checked")) {
			$('#addrType').attr("value","S_P_F");
			return $(element).parents(".family").length;
		}
		return !this.optional(element);
	}, "");
    // toggle optional family address
  var familyDiv = $("div.subDiv");
  var toggleCheck = $("input.toggleCheck");
  toggleCheck.is(":checked")?familyDiv.hide():familyDiv.show();
  $("input.toggleCheck").click(function() {
      if(this.checked == true) {
        familyDiv.slideUp("medium");
        $("form").valid();
      } else {
        familyDiv.slideDown("medium");
      }
  });
});

$.fn.hoverClass = function(classname) {
	return this.hover(function() {
		$(this).addClass(classname);
	}, function() {
		$(this).removeClass(classname);
	});
};