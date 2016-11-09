var colNames_cn = ['ID','部门ID','职务ID','角色ID','英文名称','中文名称','职员类别','部门','职务','角色'];
var colNames_tw = ['ID','部門ID','職務ID','角色ID','英文名稱','中文名稱','職員類別','部門','職務','角色'];
var caption = {zh: "用户职务配置", "zh_CN": "用户职务配置", "zh_TW": "用戶職務配置"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

var dptSelect;
var pstSelect;
$(function(){
$.fn.zTree.init($("#menu"), setting);
$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});

//Grid caption位置 选择框：部门和职务
dptSelect = "<select id='dptId' onchange='javascript:changecap(this)';><option value=''>选择部门</option>"+$("#content_main").find("#department").html()+"</select>";
pstSelect = "<select id='pstId' onchange='javascript:changecap(this)';><option value=''>选择职务</option>"+$("#content_main").find("#position").html()+"</select>";

//根据条件?gid=DEPARTMENT.id   ?gid=POSITION.id    
initGrid("../get_users_config.htm", dptSelect, pstSelect);

//配置对话框
$("#content_main").dialog({
   autoOpen:false,
   modal:true,
   resizable:true,
   width:350,
   buttons: {
	  "修改":editUser,
	  "取消": function() {$(this).dialog('close')}
	  }});
}); 

//选择下拉框事件
var changecap = function(obj) {
	$("#zgrid").GridUnload();
	initGrid("../get_users_config.htm?" + obj.id + "=" + obj.value, dptSelect, pstSelect);
	$("#cap").find("#"+obj.id).val(obj.value);
};

var initGrid = function(url, dptSelect, pstSelect) {
	$("#zgrid").jqGrid({
	    url:url,
	    datatype:'json',
		mtype:'GET',
		height:'auto',
		caption: caption[lang] + " <span id='cap'>"+dptSelect + pstSelect+"</span>",
	    colNames: colNames[lang],
	    colModel:[ 
		  {name:'id',index:'id',hidden:true},
		  {name:'dptId',index:'dptId',hidden:true},
		  {name:'pstId',index:'pstId',hidden:true},
		  {name:'roleId',index:'roleId',hidden:true},
		  {name:'ename',index:'ename',width:158,align:"center",sortable:false},
		  {name:'cname',index:'cname',width:158,sortable:false}, 
		  {name:'type',index:'type',width:158,formatter:employeeType,sortable:false,stype:'select',searchoptions:{value:"FIELDWORK:实习;TRAINING_PERIOD:试用期;QUALIFIED:正式员工"}},
		  {name:'department',index:'department',sortable:false}, 
		  {name:'position',index:'position',width:138,sortable:false}, 
		  {name:'role',index:'role',width:158,sortable:false}
		  ],
		rowNum:10,
	    rowList:[10,20,30],
		pager:'#zpager',
		viewrecords:true,
		rownumWidth:35,
		sortname:'ename',
		sortorder:'desc',
		grouping:true,
	   	groupingView: {
	   		groupField:['department'], 
	   		groupColumnShow:[false],
	   		groupText:['<b>{0} - {1} 条</b>']
		},
		prmNames:{search:'search'},
		jsonReader:{root:'list',repeatitems:false}
	});
	$('#zgrid').jqGrid('navGrid','#zpager',{add:false,editfunc:editDlg,del:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"Let's go!", multipleSearch:true},{});
};

//编辑弹出窗
var editDlg = function() {
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
   dlg.find('#department').val(rd.dptId);
   dlg.find('#position').val(rd.pstId);
   dlg.find('#role').val(rd.roleId);
   dlg.find('#cname').html(rd.cname);
   dlg.find('#ename').html(rd.ename);
   dlg.find('#types').html(rd.type);
   dlg.dialog('open');
  }
};

//提交
var editUser = function() {
  var dlg = $('#content_main');
  var params = {id:$.trim(dlg.find("#id").val()),
		  dptId:$.trim(dlg.find("#department").val()),
		  pstId:$.trim(dlg.find("#position").val()),
		  roleId:$.trim(dlg.find("#role").val())
  };
  
	$.post('save_userConfig.htm',params,function(data){
      if(data.result == "SUCCESS") {
    	  dlg.find('#department').val(params.dptId);
    	  dlg.find('#position').val(params.pstId);
    	  dlg.find('#role').val(params.roleId);
    	  var dr = {dptId:params.dptId,
    			pstId:params.pstId,
    			roleId:params.roleId,
        		department:dlg.find("#department>option:selected").text(),
        		position:dlg.find("#position>option:selected").text(),
        		role:dlg.find("#role>option:selected").text()};
	    $("#zgrid").jqGrid("setRowData", params.id, dr, {color:"#FF0000"});
		alert("更新成功！");
        dlg.dialog("close");
	  }
	 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
	 else alert("更新操作失败！");
	},'json');
};
