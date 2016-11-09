var colNames_cn = ['ID','日期类别','统计项目','SWOT模式 ','中心目标','上管线','下管线','改善目标','统计模式','颜色S','颜色W','颜色O','颜色T','range','item','SWOT模式D','统计模式D','距离中心值','启用距离中心值','连续同一侧','启用连续同一侧','连续变化','启用连续变化','连续交错','启用连续交错','距中心2标准差','启用距中心2标准差','距中心1标准差','启用距中心1标准差','连续距中心1标准差内','启用连续距中心1标准差内','连续距中心1标准差外','启用连续距中心1标准差外','基准值','基准值S','基准值W','基准值O','基准值T'];
var colNames_tw = ['ID','日期类别','统计项目','SWOT模式 ','中心目標','上管線','下管線','改善目標','統計模式','顏色S','顏色W','顏色O','顏色T','range','item','SWOT模式D','統計模式D','距離中心值','啟用距離中心值','連續同一側','啟用連續同一側','連續變化','啟用連續變化','連續交錯','啟用連續交錯','距中心2標準差','啟用距中心2標準差','距中心1標準差','啟用距中心1標準差','連續距中心1標準差內','啟用連續距中心1標準差內','連續距中心1標準差外','啟用連續距中心1標準差外','基準值','基準值S','基準值W','基準值O','基準值T'];
var caption = {zh: "SWOT配置列表", "zh_CN": "SWOT配置列表 <select id='rangeType' onchange='changeRange(this);'><option value='DAY'>日</option><option value='WEEK'>周</option><option value='MONTH'>月</option><option value='YEAR'>年</option></select>", "zh_TW": "SWOT配置列表 <select id='rangeType' onchange='changeRange(this);'><option value='DAY'>日</option><option value='WEEK'>周</option><option value='MONTH'>月</option><option value='YEAR'>年</option></select>"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
	$.fn.zTree.init($("#menu"), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	
	//显示table
	initGrid("get_swotconfig.htm?range=DAY");
	
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:730,
		   buttons: {
			  "添加": addConfig,
			  "提交": editConfig,
			  "测试": testDlg,
			  "取消": function() {$(this).dialog('close')}}
		 });
	
	$("#gConsole").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:180,
		   buttons: {
		      "删除": delConfig,
			  "取消": function() {$(this).dialog('close')}
			  }
		 }); 
	
	//测试弹出窗口
	$("#test_g").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:420,
		   buttons: { "关闭": function() {$(this).dialog('close')} }
		 }); 
	
	
	//添加一个新按纽
//	$("#sc_tb").jqGrid('navButtonAdd','#sc_pg',{ caption: "", buttonicon:"ui-icon-check", title: "测试数据", onClickButton : testDlg});

	//改变SWOT模式时
	$(".datum").hide();
	$(".values").hide();
	$("#model").change(function() { show($(this).val()); });
	
	//改变统计模式时百分比添加%
	$("#method").change(function() { dsh($(this).val()); });
	
	//颜色文本显示
	$("#colorS").keyup(function(){ $("#scs").css("backgroundColor", $(this).val()); });
	$("#colorW").keyup(function(){ $("#scw").css("backgroundColor", $(this).val()); });
	$("#colorO").keyup(function(){ $("#sco").css("backgroundColor", $(this).val()); });
	$("#colorT").keyup(function(){ $("#sct").css("backgroundColor", $(this).val()); });

}); 

//改变日期类型
function changeRange(obj) {
	var va = $(obj).val();
	$("#sc_tb").GridUnload();
	initGrid("get_swotconfig.htm?range="+va);
	$("#rangeType").val(va);
}

//显示所有SWOT配置信息
function initGrid(url) {
	jQuery("#sc_tb").jqGrid({
	   	url:url, datatype: "json", height:350, width:793,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   	    {name:'range',index:'range',hidden:true, formatter:frequencyPeriod},
	   	    {name:'item',index:'item',width:50,align:"center", formatter:itemfmt},
	   	    {name:'model',index:'model',width:70,align:"center", formatter:modelfmt},
	   	    {name:'centerline',index:'centerline;',width:50,align:"center"},
	   	    {name:'upper',index:'upper;',width:40,align:"center"},
	   	    {name:'lower',index:'lower;',width:40,align:"center"},
	   	    {name:'improveTarget',index:'improveTarget',width:50,align:"center"},
	   	    {name:'method',index:'method',width:50,align:"center", formatter:methodfmt},
	   	    {name:'colorS',index:'colorS',width:40,align:"center"},
	   		{name:'colorW',index:'colorW',width:40,align:"center"},
	   		{name:'colorO',index:'colorO',width:40,align:"center"},
	   		{name:'colorT',index:'colorT',width:40,align:"center"},
	   		{name:'range',index:'range',hidden:true},
	   		{name:'item',index:'item',hidden:true},
	   		{name:'model',index:'model',hidden:true},
	   	    {name:'method',index:'method',hidden:true},
		   	{name:'distanceCenter',index:'distanceCenter',hidden:true},
		   	{name:'isDistanceCenter',index:'isDistanceCenter',hidden:true},
		   	{name:'continuousSameSide',index:'continuousSameSide',hidden:true},
		   	{name:'isContinuousSameSide',index:'isContinuousSameSide',hidden:true},
		   	{name:'continuousChange',index:'continuousChange',hidden:true},
	   		{name:'isContinuousChange',index:'isContinuousChange',hidden:true},
	   		{name:'continuousStaggered',index:'continuousStaggered',hidden:true},
	   		{name:'isContinuousStaggered',index:'isContinuousStaggered',hidden:true},
	   		{name:'distanceGtTwo',index:'distanceGtTwo',hidden:true},
	   		{name:'isDistanceGtTwo',index:'isDistanceGtTwo',hidden:true},
	   		{name:'distanceGtOne',index:'distanceGtOne',hidden:true},
	   		{name:'isDistanceGtOne',index:'isDistanceGtOne',hidden:true},
	   		{name:'continuousDistanceLtOne',index:'continuousDistanceLtOne',hidden:true},
	   		{name:'isContinuousDistanceLtOne',index:'isContinuousDistanceLtOne',hidden:true},
	   		{name:'continuousDistanceGtOne',index:'continuousDistanceGtOne',hidden:true},
	   		{name:'isContinuousDistanceGtOne',index:'isContinuousDistanceGtOne',hidden:true},
	   		{name:'datum',index:'datum',hidden:true},
	   		{name:'datumS',index:'datumS',hidden:true},
	   		{name:'datumW',index:'datumW',hidden:true},
	   		{name:'datumO',index:'datumO',hidden:true},
	   		{name:'datumT',index:'datumT',hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#sc_pg',
	   	sortname: 'id',
	    viewrecords:true,
	    grouping:false,
	   	groupingView:{groupField:['id']},
	    rownumbers:true,
	    sortorder: "asc",
		multiselect: false,
		jsonReader:{root:'list',repeatitems:false},
		afterInsertRow: function(rowid, aData){
			changebc(aData.colorS, rowid, "colorS");
			changebc(aData.colorW, rowid, "colorW");
			changebc(aData.colorO, rowid, "colorO");
			changebc(aData.colorT, rowid, "colorT");
	    }
	});
	
	$('#sc_tb').jqGrid('navGrid','#sc_pg',{addfunc:addDlg,editfunc:editDlg,delfunc:delDlg,search:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:false},{});
}

//字体颜色分辨
function changebc(str, rowid, type) {
	switch (str) {
		case 'green':
			jQuery("#sc_tb").jqGrid('setCell',rowid,type,'',{background:'green'});
		break;
		case 'red':
			jQuery("#sc_tb").jqGrid('setCell',rowid,type,'',{background:'red'});
		break;
		case 'blue':
			jQuery("#sc_tb").jqGrid('setCell',rowid,type,'',{background:'blue'});
		break;
		case 'yellow':
			jQuery("#sc_tb").jqGrid('setCell',rowid,type,'',{background:'yellow'});
		break;
	}
}

//测试按纽
var testDlg = function() {
	var dlg = $("#test_g");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	var selectrow = $("#sc_tb").jqGrid("getGridParam", "selrow");
	if(selectrow) {
		var rd = $('#sc_tb').jqGrid("getRowData", selectrow);
		dlg.dialog("option","title","测试SWOT配置");
		var params = paramfunc();
		var type = "improve";
		if(params.model != "IMPROVE") type = "stable";
		params.type = type;
		$.get('get_testswot.htm', params, function(data){
			if(data.result == "SUCCESS") {
				var tab ="<table class='trace_tab' width='200' border='0' cellspacing='0' cellpadding='0'>"
					+ " <tr><th>数据</th><th>SWOT</th></tr>";
				for(var i=0; i<25; i++) {
					var s = data.list[i];
					tab += "<tr class='nob_l_r bg'>";
						tab +=     "<td width='100' class='nob_l_r bg'>"+s.data+"</td>";
						tab +=     "<td width='100' class='nob_l_r bg' style='background-color:"+s.swot+"'></td>";
					tab += "</tr> ";
				}
				+ "</table>";
				
				var tab2 ="<table class='trace_tab' width='200' border='0' cellspacing='0' cellpadding='0'>"
					+ " <tr><th>数据</th><th>SWOT</th></tr>";
				for(var i=25; i<50; i++) {
					var s = data.list[i];
					tab2 += "<tr class='nob_l_r bg'>";
						tab2 +=     "<td width='100' class='nob_l_r bg'>"+s.data+"</td>";
						tab2 +=     "<td width='100' class='nob_l_r bg' style='background-color:"+s.swot+"'></td>";
					tab2 += "</tr> ";
				}
				+ "</table>";
	    	
				dlg.html("").append(tab).append(tab2);
				dlg.dialog('open');
			}
			else alert("操作失败！");
		},'json');
	}
}

//添加一条数据
var addDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('添加')").show();
	 dlg.dialog("option","title","添加新配置");
	 dlg.find('#id').val('');
	 dlg.find('#sid').val('');
	 dlg.find("#swotcForm")[0].reset();	//清空所有文本框值
	 $("#scs").css("backgroundColor",'');
	 $("#scw").css("backgroundColor",'');
	 $("#sco").css("backgroundColor",'');
	 $("#sct").css("backgroundColor",'');
	 dlg.dialog('open');
};
var addConfig = function() {
	var dlg = $('#content_main');
	var params = paramfunc();
	 
	// 验证方法
	if(isEmpty(params.centerline)) { alert("信息不完整"); return false; }
	
	//提交
	$.post('save_swotconfig.htm',params,function(data){
		if(data.result == "SUCCESS") {
			$("#sc_tb").jqGrid("addRowData", data.sc.id, data.sc, "first");
			alert("添加成功！");
	        dlg.dialog("close");
	    }
	    else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		else alert("添加操作失败！");
	},'json');
};

//修改一行数据
var editDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	 panel.find("button:not(:contains('取消'))").hide();
	 panel.find("button:contains('提交')").show();
	 panel.find("button:contains('测试')").show();
	  
	 var selectrow = $("#sc_tb").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	 var rd = $('#sc_tb').jqGrid("getRowData", selectrow);
	   dlg.dialog("option","title","编辑SWOT配置");
	   dlg.find('#id').val(rd.id);
	   dlg.find('#range').val(rd.range);
	   dlg.find('#item').val(rd.item);
	   dlg.find('#centerline').val(rd.centerline);
	   dlg.find('#upper').val(rd.upper);
	   dlg.find('#lower').val(rd.lower);
	   dlg.find('#datum').val(rd.datum);
	   dlg.find('#improveTarget').val(rd.improveTarget);
	   dlg.find('#model').val(rd.model);
	   dlg.find('#method').val(rd.method);
	   dlg.find('#distanceCenter').val(rd.distanceCenter);
	   dlg.find('#isDistanceCenter').attr("checked",true);
	   dlg.find('#continuousSameSide').val(rd.continuousSameSide);
	   dlg.find('#isContinuousSameSide').attr("checked",true);
	   dlg.find('#continuousChange').val(rd.continuousChange);
	   dlg.find('#isContinuousChange').attr("checked",true);
	   dlg.find('#continuousStaggered').val(rd.continuousStaggered);
	   dlg.find('#isContinuousStaggered').attr("checked",true);
	   dlg.find('#distanceGtTwo').val(rd.distanceGtTwo);
	   dlg.find('#isDistanceGtTwo').attr("checked",true);
	   dlg.find('#distanceGtOne').val(rd.distanceGtOne);
	   dlg.find('#isDistanceGtOne').attr("checked",true);
	   dlg.find('#continuousDistanceLtOne').val(rd.continuousDistanceLtOne);
	   dlg.find('#isContinuousDistanceLtOne').attr("checked",true);
	   dlg.find('#continuousDistanceGtOne').val(rd.continuousDistanceGtOne);
	   dlg.find('#isContinuousDistanceGtOne').attr("checked",true);
	   dlg.find('#datumS').val(rd.datumS);
	   dlg.find('#datumW').val(rd.datumW);
	   dlg.find('#datumO').val(rd.datumO);
	   dlg.find('#datumT').val(rd.datumT);
	   dlg.find('#colorS').val(rd.colorS);
	   dlg.find('#colorW').val(rd.colorW);
	   dlg.find('#colorO').val(rd.colorO);
	   dlg.find('#colorT').val(rd.colorT);
	   if(rd.isDistanceCenter == "false") dlg.find('#isDistanceCenter').attr("checked",false);
	   if(rd.isContinuousSameSide == "false") dlg.find('#isContinuousSameSide').attr("checked",false);
	   if(rd.isContinuousChange == "false") dlg.find('#isContinuousChange').attr("checked",false);
	   if(rd.isContinuousStaggered == "false") dlg.find('#isContinuousStaggered').attr("checked",false);
	   if(rd.isDistanceGtTwo == "false") dlg.find('#isDistanceGtTwo').attr("checked",false);
	   if(rd.isDistanceGtOne == "false") dlg.find('#isDistanceGtOne').attr("checked",false);
	   if(rd.isContinuousDistanceLtOne == "false") dlg.find('#isContinuousDistanceLtOne').attr("checked",false);
	   if(rd.isContinuousDistanceGtOne == "false") dlg.find('#isContinuousDistanceGtOne').attr("checked",false);
	   show(rd.model);
	   dsh(rd.method);
	   $("#scs").css("backgroundColor",rd.colorS);
	   $("#scw").css("backgroundColor",rd.colorW);
	   $("#sco").css("backgroundColor",rd.colorO);
	   $("#sct").css("backgroundColor",rd.colorT);
	   dlg.dialog('open');
	 }
};
var editConfig = function() {
	var dlg = $('#content_main');
	var params = paramfunc();
	 
	//提交
	$.post('save_swotconfig.htm',params,function(data){
      if(data.result == "SUCCESS") {
	    $("#sc_tb").jqGrid("setRowData", params.id, params, {color:"#FF0000"});
		alert("操作成功！");
        dlg.dialog("close");
	  }
	 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
	 else alert("操作失败！");
	},'json');  
};

//删除一条记录
var delDlg = function() {
	var dlg = $("#gConsole");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('删除')").show();
	dlg.dialog("option","title","删除").dialog('open');
};
var delConfig = function() {
	 var dlg = $("#gConsole");
	 var tid = jQuery("#sc_tb").jqGrid('getGridParam','selrow');
	 if(tid) {
	    $.post('del_swotconfig.htm',{'id':tid},function(data){
		  if(data.result=="SUCCESS") {
		    $('#sc_tb').jqGrid("delRowData",tid);
			dlg.dialog("close");
			alert("删除成功！");
		  } else alert("删除操作失败！");
		},'json');
	  } else alert("请选择需要删除的条目！");
};

//表单参数
var paramfunc = function() {
	var dlg = $('#content_main');
	var params = {id:$.trim(dlg.find("#id").val()),
			  range:$.trim(dlg.find("#range").val()),
			  centerline:$.trim(dlg.find("#centerline").val()),
			  upper:$.trim(dlg.find("#upper").val()),
			  lower:$.trim(dlg.find("#lower").val()),
			  datum:$.trim(dlg.find("#datum").val()),
			  improveTarget:$.trim(dlg.find("#improveTarget").val()),
			  item:$.trim(dlg.find("#item").val()),
			  model:$.trim(dlg.find("#model").val()),
			  method:$.trim(dlg.find("#method").val()),
			  distanceCenter:$.trim(dlg.find("#distanceCenter").val()),
			  isDistanceCenter:false,
			  continuousSameSide:$.trim(dlg.find("#continuousSameSide").val()),
			  isContinuousSameSide:false,
			  continuousChange:$.trim(dlg.find("#continuousChange").val()),
			  isContinuousChange:false,
			  continuousStaggered:$.trim(dlg.find("#continuousStaggered").val()),
			  isContinuousStaggered:false,
			  distanceGtTwo:$.trim(dlg.find("#distanceGtTwo").val()),
			  isDistanceGtTwo:false,
			  distanceGtOne:$.trim(dlg.find("#distanceGtOne").val()),
			  isDistanceGtOne:false,
			  continuousDistanceLtOne:$.trim(dlg.find("#continuousDistanceLtOne").val()),
			  isContinuousDistanceLtOne:false,
			  continuousDistanceGtOne:$.trim(dlg.find("#continuousDistanceGtOne").val()),
			  isContinuousDistanceGtOne:false,
			  datumS:$.trim(dlg.find("#datumS").val()),
			  datumW:$.trim(dlg.find("#datumW").val()),
			  datumO:$.trim(dlg.find("#datumO").val()),
			  datumT:$.trim(dlg.find("#datumT").val()),
			  colorS:$.trim(dlg.find("#colorS").val()),
			  colorW:$.trim(dlg.find("#colorW").val()),
			  colorO:$.trim(dlg.find("#colorO").val()),
			  colorT:$.trim(dlg.find("#colorT").val())
		};
		if (dlg.find("#isDistanceCenter").attr('checked')==true) params.isDistanceCenter = true;
		if (dlg.find("#isContinuousSameSide").attr('checked')==true) params.isContinuousSameSide = true;
		if (dlg.find("#isContinuousChange").attr('checked')==true) params.isContinuousChange = true;
		if (dlg.find("#isContinuousStaggered").attr('checked')==true) params.isContinuousStaggered = true;
		if (dlg.find("#isDistanceGtTwo").attr('checked')==true) params.isDistanceGtTwo = true;
		if (dlg.find("#isDistanceGtOne").attr('checked')==true) params.isDistanceGtOne = true;
		if (dlg.find("#isContinuousDistanceLtOne").attr('checked')==true) params.isContinuousDistanceLtOne = true;
		if (dlg.find("#isContinuousDistanceGtOne").attr('checked')==true) params.isContinuousDistanceGtOne = true;
		return params;			
}

//切换模式显示成%（百分比）
function dsh(va) {
	if(va == "PERCENTAGE") {
		$(".datum").find("dd").find("span").html("%");
	} else if(va == "STDEV") {
		$(".datum").find("dd").find("span").html("&nbsp;");
	}
}

//层显示方法
function show(va) {
	if(va == "STABLEA") {
		$(".datum").find("dd").find("span").html("%");
		$(".datum").show();
		$("#dd_method").hide();
		$("#method").val("PERCENTAGE");
		$(".values").hide();
		$("#dc").hide();
		$("#isdc").hide();
		$("#dd_improveTarger").hide();
	} else if(va == "STABLEB") {
		$(".datum").find("dd").find("span").html("&nbsp;");
		$(".datum").show();
		$("#dd_method").hide();
		$("#method").val("STDEV");
		$(".values").hide();
		$("#dc").hide();
		$("#isdc").hide();
		$("#dd_improveTarger").hide();
	} else if(va == "STABLEADVANCED") {
		$(".datum").hide();
		//$("#l_datum").hide();
		$("#dd_improveTarger").hide();
		$(".values").show();
		$("#dc").show();
		$("#isdc").show();
		$("#dd_method").hide();
	} else if(va == "IMPROVE") {
		$(".datum").hide();
		$(".values").hide();
		$("#dc").hide();
		$("#isdc").hide();
		$("#dd_method").show();
		$("#l_datum").show();
		$("#dd_improveTarger").show();
		
	}
}

//统计方式格式化
function methodfmt(cellvalue, options, rowObject){
	var tmp;
	if(cellvalue=="PERCENTAGE") tmp="百分比";
	else if(cellvalue=="STDEV") tmp="标准差";
	return tmp;
}

//SWOT模式格式化
function modelfmt(cellvalue, options, rowObject){
	//STABLEA("稳定模式A(百分比)"), STABLEB("稳定模式B(公差)"), STABLEADVANCED("进阶稳定模式"), IMPROVE("改善模式");
	var tmp;
	if(cellvalue=="STABLEA") tmp="稳定模式(%)";
	else if(cellvalue=="STABLEB") tmp="稳定模式";
	else if(cellvalue=="STABLEADVANCED") tmp="进阶稳定模式";
	else if(cellvalue=="IMPROVE") tmp="改善模式";
	return tmp;
}

//统计项目 格式化（贡献，计划，实际，请假，调休，迟到，早退，延误）
function itemfmt(cellvalue, options, rowObject){
	var tmp;
	if(cellvalue=="CONTRIBUTION") tmp="贡献";
	else if(cellvalue=="PLAN") tmp="计划";
	else if(cellvalue=="PRACTICAL") tmp="实际";
	else if(cellvalue=="LEAVE") tmp="请假";
	else if(cellvalue=="LIEU") tmp="调休";
	else if(cellvalue=="LATE") tmp="迟到";
	else if(cellvalue=="EARLY") tmp="早退";
	else if(cellvalue=="DELAY") tmp="延误";
	return tmp;
}
