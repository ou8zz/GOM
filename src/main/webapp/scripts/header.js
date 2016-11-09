//国际化JS全局变量
var lang="zh_CN";

<!--点击发送报表-->
function sendReport() {
	$.blockUI({message:'<h6><img src="../images/ztree/loading.gif" /> 系统正在处理中，请稍候！</h6>',css:{border:'none',padding:'15px',backgroundColor:'#000', '-webkit-border-radius':'10px', '-moz-border-radius':'10px', opacity:.5, color:'#fff' }}); 
	document.location.href = "../gom_logout.htm?report=send";
}

<!--点击发送语言切换请求-->
function changeLocale(l) {
	$.post('../changeLocale.htm',{lang:l}, function(data) {
		window.location.reload();
	}, 'json');
}