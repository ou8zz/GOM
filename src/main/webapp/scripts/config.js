$(function(){
	$.fn.zTree.init($("#menu"), setting, app_tree);
	var dlg = $("#content");
	dlg.find("#user").show();
	dlg.find("#basic").hide();
	dlg.find("#entrant").hide();
	dlg.find("#depture").hide();
	dlg.find("#upload").hide();
	dlg.find("#leave").hide();
});

function jump(va) {
	var dlg = $("#content");
	dlg.find("#user").hide();
	dlg.find("#basic").hide();
	dlg.find("#entrant").hide();
	dlg.find("#depture").hide();
	dlg.find("#upload").hide();
	dlg.find("#leave").hide();
	dlg.find(va).show();
}