var motto;
$(function(){
	$.fn.zTree.init($("#menu"), setting);
	
	//格言编辑器
	motto = KindEditor.create('textarea[name="motto_edit"]', {
		resizeType : 1,
		allowPreviewEmoticons : false,
		allowImageUpload : false,
		items : [
			'source', '|', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
			'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'indent', 'outdent', 
			'subscript', 'superscript', 'insertorderedlist', 'insertunorderedlist', '|', 'fullscreen']
	});
	
	//加载原有内容到编辑框
	motto.html($("#mottoText").val());
	
	//提交格言
	$("#motto_sub").click(function() {
		var dlg = $("#content");
		dlg.find("#mottoText").val(motto.html());
		if(dlg.find("#mottoText").val().length > 2000) {
			alert("超过最大长度限制！");
			return false;
		}
		if(!isEmpty(dlg.find("#mottoText").val())) {
			$.post('save_motto.htm', dlg.find("#mottoForm").serialize(), function(data) {
				if (data != null && data.result == "SUCCESS") {
					alert("操作成功！");
				} else if (data.result == "PARAM_EMPTY")
					alert("请填写完整后再提交！");
				else
					alert("操作失败");
			}, 'json');
		} else return false;
	});
}); 
