$(function(){
$.fn.zTree.init($("#menu"), setting, zNodes);
$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
onEvent();
$("#zgrid").jqGrid({
    url:'ajax_group.htm?type=POSITION',
    datatype:'json',
	mtype:'GET',
	height:300,
	width:450,
    colNames:['ID','中文名称','英文名称'],
    colModel:[ 
	  {name:'id',index:'id',width:1,hidden:true},
	  {name:'cname',index:'cname',width:80}, 
	  {name:'ename',index:'ename',width:100}],
	rowNum:10,
    rowList:[10,20,30],
	pager:'#zpager',
	viewrecords:true,
	rownumbers:true, 
	rownumWidth:35,
	sortname:'ename',
	sortorder:'desc',
	prmNames:{search:'search'},
	jsonReader:{root:'list',repeatitems:false},
    caption:'职务管理'
});

$('#zgrid').jqGrid('navGrid','#zpager',{addfunc:addGroupDlg,editfunc:updateGroupDlg,delfunc:delGroupDlg,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"Let's go!", multipleSearch:true},{});

//配置对话框
$("#content_main").dialog({
   autoOpen:false,
   modal:true,
   resizable:true,
   width:450,
   buttons: {
      "新增":addGroup,
	  "修改":updateGroup,
	  "取消": function() {$(this).dialog('close')}
	  }
 });

$("#gConsole").dialog({
   autoOpen:false,
   modal:true,
   resizable:true,
   width:180,
   buttons: {
      "删除":delGroup,
	  "取消": function() {$(this).dialog('close')}
	  }
 }); 
}); 

var addGroupDlg = function() {
  var dlg = $("#content_main");
  var panel = dlg.siblings(".ui-dialog-buttonpane");
  dlg.find("input").removeAttr("disabled").val("");
  panel.find("button:not(:contains('取消'))").hide();
  panel.find("button:contains('新增')").show();
  
  dlg.find("#id").val('');
  dlg.find("#cname").val('');
  dlg.find("#ename").val('');
  
  dlg.dialog("option","title","新增职务").dialog('open');
};

var updateGroupDlg = function() {
  var dlg = $("#content_main");
  var panel = dlg.siblings(".ui-dialog-buttonpane");
  dlg.find("input").removeAttr("disabled");
  panel.find("button:not(:contains('取消'))").hide();
  panel.find("button:contains('修改')").show();
  
  var selectrow = $("#zgrid").jqGrid("getGridParam", "selrow");
  if(selectrow) {
   var rd = $('#zgrid').jqGrid("getRowData", selectrow);
   dlg.dialog("option","title","编辑 － " + rd.cname);
   dlg.find('#id').val(rd.id);
   dlg.find('#cname').val(rd.cname);
   dlg.find('#ename').val(rd.ename);
   dlg.dialog('open');
  }else {alert("请先选择需要编辑的行！"); return false;}
};

var delGroupDlg = function() {
  var dlg = $("#gConsole");
  var panel = dlg.siblings(".ui-dialog-buttonpane");
  panel.find("button:not(:contains('取消'))").hide();
  panel.find("button:contains('删除')").show();
  dlg.dialog("option","title","删除职务").dialog('open');
}

var addGroup = function() {
var dlg = $('#content_main');
$.post('save_group.htm',{'cname':$.trim(dlg.find('#cname').val()),'ename':$.trim(dlg.find('#ename').val()),'type':'POSITION'},function(data){
if(data.result == "SUCCESS") {
  var dataRow = {id:data.g.id,cname:$.trim(dlg.find("#cname").val()),ename:$.trim(dlg.find("#ename").val())};
  var srcrowid = $("#zgrid").jqGrid("getGridParam","selrow");
  if(srcrowid) $("#zgrid").jqGrid("addRowData", dataRow.id, dataRow, "before", srcrowid);
  else {$("#zgrid").jqGrid("addRowData", dataRow.id, dataRow, "first");}
  alert(dlg.find('#cname').val() + " － 新增成功！");
  dlg.dialog("close");
}
else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
else alert("新增职务时发生错误！");
},'json');
};

var updateGroup = function() {
  var dlg = $('#content_main');
  var params = {id:$.trim(dlg.find("#id").val()),cname:$.trim(dlg.find("#cname").val()),ename:$.trim(dlg.find("#ename").val()),'type':'POSITION'};
	$.post('save_group.htm',params,function(data){
      if(data.result == "SUCCESS") {
        var dr = {cname:params.cname,ename:params.ename};
	    $("#zgrid").jqGrid("setRowData", params.id, dr, {color:"#FF0000"});
		alert(dr.cname + " －  更新成功！");
        dlg.dialog("close");
	  }
	 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
	 else alert("更新操作失败！");
	},'json');
};

var delGroup = function() {
  var dlg = $("#gConsole");
  var tid = $("#zgrid").jqGrid('getGridParam','selrow');
  if(tid != null) {
    var rd = $('#zgrid').jqGrid("getRowData", tid);
    $.getJSON('remove_group.htm',{'id':$.trim(rd.id),'ename':$.trim(rd.ename)},function(data){
	  if(data.result=="SUCCESS") {
	    $('#zgrid').jqGrid("delRowData",tid);
		dlg.dialog("close");
		alert("职务删除成功！");
	  }else alert("职务删除操作失败！");
	});
  }else alert("请选择需要删除的条目！");
};

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
		$.post('check_group.htm', {'id':$('#id').val(),'cname': $.trim(tcheck),'type':'POSITION'}, 
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
		$.post('check_group.htm', {'id':$('#id').val(),'ename': $.trim(tcheck),'type':'POSITION'}, 
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