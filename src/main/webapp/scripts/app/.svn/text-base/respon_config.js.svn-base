var colNames_cn = ['ID','英文名','中文名','职务','职员类别','性别','部门'];
var colNames_tw = ['ID','英文名','中文名','職務','職員類別','性別','部門'];
var caption = {zh: "主管分配责任列表", "zh_CN": "主管分配责任列表", "zh_TW": "主管分配責任列表"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

var notAssign;
var parentResp;	//全局保存用户父责任tr列表
$(function(){
	$.fn.zTree.init($('#menu'), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
    
	//显示所有用户信息
	$("#zgrid").jqGrid({
	    url:'get_respon.htm',
	    datatype:'json',
		mtype:'POST',
		width:793,
		height:'auto',
		caption: caption[lang],
	   	colNames: colNames[lang],
	    colModel:[ 
		  {name:'id',index:'id',hidden:true},
		  {name:'ename',index:'ename',width:150,align:"center",sortable:false},
		  {name:'cname',index:'cname',width:150,sortable:false}, 
		  {name:'position',index:'position',width:193,sortable:false,search:false},
		  {name:'type',index:'type',width:150,formatter:employeeType,sortable:false,stype:'select',searchoptions:{value:"FIELDWORK:实习;TRAINING_PERIOD:试用期;QUALIFIED:正式员工"}},
		  {name:'gender',index:'gender',width:150,formatter:genderType,sortable:false,stype:'select',searchoptions:{value:"M:先生;F:女士"}},
		  {name:'department',index:'department',hidden:true,width:0}
		  ],
		rowNum:10,
	    rowList:[10,20,30],
		pager:'#zpager',
		viewrecords:true,
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
	$('#zgrid').jqGrid('navGrid','#zpager',{add:false,editfunc:editDlg,del:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"搜索", multipleSearch:true},{});

	//配置对话框
	$("#content_main").dialog({autoOpen:false,modal:true,resizable:true,width:793,buttons:{"关闭":function(){$(this).dialog('close')}}});
	
	//选择下拉根据parentId show出子责任(添加用户责任)
	$('#resNoUser').change(function() {
		var pid = $(this).val();
		if(isEmpty(pid)) {alert("请先选择要添加的主责任"); return false;}
	   	else {
			$.post('get_responsibilitys.htm', {pid:$(this).val(),onlyf:false}, function(data){
				var shtm="";
				var fhtm=$('#edit_tb tbody').empty();
				$.each(data, function(i, r){
					if(pid == r.parentId) shtm+="<tr><td><i>&nbsp;&nbsp;&nbsp;</i><i class='ui-icon ui-icon-radio-off'></i><span>"+r.funcode+"</span>&nbsp;&nbsp;<select onChange='javascript:getChildren(this);' id='parent"+i+"' name='node'>"+notAssign+"</select><select onChange='javascript:getRespon(this);' id='child"+i+"' name='responId'><option value='"+r.id+"'>"+r.funcode+ "&nbsp;&nbsp;" + r.name + "</option></select></td><td>"+r.name+"</td><td><input class='son' name='expected' id='expected"+i+"'></td><td>"+r.explanation+"</td></tr>";
					else fhtm.append("<tr><td width='40%'><i class='ui-icon treeclick ui-icon-triangle-1-s'></i><span>"+r.funcode+"</span><input type='hidden' value='0.0' id='parent0' name='node'><input type='hidden' value='"+r.id+"' id='child0' name='responId'></td><td width='15%'>"+r.name+"</td><td width='10%'><input class='father' name='expected' id='expected0'></td><td width='35%'>"+r.explanation+"</td></tr>");
				});
				fhtm.append(shtm);
			},'json');
		}
	});
	
//提交用户责任配置
$('#userSubmit').click(function() {
	var dlg = $('#content_main');
	if(countExpect(dlg.find(":input.son").serializeArray()) != 100 && isEmpty(dlg.find(":input.father").serializeArray())) {
		dlg.find("#edit_tb tfoot").html("<tr class='tr_con'><td colspan='4'><b style='color:red'>子责任比重分配有误,要求设置满足100</b></td></tr>").show().fadeOut(8000);
		return false;
	}else if(countExpect(dlg.find(":input.father").serializeArray()) != 100 && isEmpty(dlg.find(":input.son").serializeArray())) {
		dlg.find("#edit_tb tfoot").html("<tr class='tr_con'><td colspan='4'><b style='color:red'>父责任比重分配有误,要求设置满足100</b></td></tr>").show().fadeOut(8000);
		return false;
	}else {
		var fdata = dlg.find('#responForm').serializeArray();
		if(fdata){
			$.post('save_responsibilities.htm',{rpts:toJson(fdata,3),userId:dlg.find('#uid').val()},function(data){
				if(data){
					getUserRespons(dlg.find('#uid').val());
					alert("成功为员工分配职责，请调整父责任以满足相加等于100%");
					dlg.find("#edit_tb tbody").empty();
				}
			},'json');
		}
	}
});

  //用户编辑自己已有的责任(show出责任)
  $("#resUser").change(function() {
    var dlg = $("#content_main");
	var tbody = dlg.find("#edit_tb tbody");
	dlg.find("#ups").attr("checked", false);
	var tmp_option = $(this).find("option:selected").text();
	if($(this).val()) {
	  $.post('get_responsibilitys.htm', {node:$(this).val(),uid:dlg.find('#uid').val()}, function(data){
	    tbody.empty().append("<tr class='tr_con'><td colspan='5'><i class='ui-icon treeclick ui-icon-triangle-1-s'></i><b style='color:blue'>"+tmp_option+"</b>&nbsp;子责任</td></tr>");
		$.each(data, function(i, r){
			tbody.append("<tr><td width='20%'><input type='hidden' name='node' value='"+r.node+"'/><i>&nbsp;&nbsp;&nbsp;</i><i class='ui-icon ui-icon-radio-off'></i>"+r.funcode+"<input type='hidden' name='id' value='"+r.responId+"'/></td><td width='25%'>"+r.name+"</td><td width='15%'><input name='expected' value='"+r.expected+"' class='son'/></td><td width='40%'>"+r.explanation+"</td> </tr>");
		});
		},'json');
		}
	});
	
//显示父责任
$("#ups").change(function() {
	if($(this).attr("checked")) {
		var dlg = $("#content_main");
		var tbody = dlg.find("#edit_tb tbody").empty();
		$("#edit_main").find("#resNoUser, #resUser").val('');
		tbody.append(parentResp);
	}
});
	
}); 

//查看和编辑用户责任
var editDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("#edit_tb tbody").empty();
	  dlg.find("#ups").attr("checked", false);
	 var selectrow = $("#zgrid").jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	   var rd = $('#zgrid').jqGrid("getRowData", selectrow);
	   dlg.dialog("option","title","编辑 <b style='color:#00f'>"+rd.department + " " + rd.ename + "</b> 的责任");
	   dlg.find('#uid').val(rd.id);
	   dlg.find("input:[name=respid]").attr("checked", false);
	   getUserRespons(rd.id);
	  }
 
  dlg.dialog('open');
}; 

function getChildren(obj) {
	if($(obj).val()){
		$.post('get_responsibilitys.htm', {pid:$(obj).val(),isf:true}, function(data){
			var option = '';
			$.each(data, function(j, r){option+="<option value="+r.id+">"+r.funcode+"&nbsp;&nbsp;"+r.name+"</option>";});
			$(obj).next().empty().append(option);
		},'json');
	}
}
function getRespon(obj) {
	if($(obj).val()){
		$.post('get_responsibilitys.htm', {pid:$(obj).val(),onlyf:true}, function(data){
			$(obj).parent().next().empty().append(data.name);
			$(obj).prev().prev().empty().append(data.funcode);
			$(obj).parent().next().next().next().empty().append(data.explanation);
		},'json');
	}
}

function getUserRespons(userId){
  var dlg = $("#content_main");
  var pResId="";
  $.post('get_responsibilitys.htm',{uid:userId},function(data){
    var resUser = dlg.find("#resUser").empty().append("<option value=''>-请选择-</option>");
	var res_body = dlg.find("#tree_tb tbody").empty();
	var parentPer = 0;
	var actual = 0;
	parentResp = "";
	
	if(isEmpty(data)) res_body.append("<tr class='tr_con'><td colspan='6'><b style='color:red'>该用户没有相关责任 !</b></td></tr>");
	else {			
	$.each(data, function(i, r){
		var ico = "";
		if(/^[0-9]*[1-9][0-9]*$/.test(r.node)) {
			parentPer = r.expected;
			actual = r.expected;
			pResId += r.id + ",";
			ico += "<i class='ui-icon treeclick ui-icon-triangle-1-s'></i>";
			resUser.append("<option value="+r.node+">"+r.funcode + "&nbsp;&nbsp;" + r.name+"</option>");
			parentResp += "<tr><td><input type='hidden' name='id' value='"+r.responId+"'/>" + ico +r.funcode+"</td><td><input type='hidden' name='node' value='"+r.node+"'/>"+r.name+"</td><td><input name='expected' value='"+r.expected+"' class='father'></td><td>"+r.explanation+"</td></tr>";
		}else{
			actual=getPercent(parentPer,r.expected);
			ico += "<i>&nbsp;&nbsp;&nbsp;</i><i class='ui-icon ui-icon-radio-off'></i>";
		}
		
		res_body.append("<tr><td>"+ico+r.funcode+"</td><td>"+r.name+"</td><td>"+r.expected+"</td><td>"+actual+"</td><td>"+r.explanation+"</td> </tr>");
	});
   }
  },'json');
  
  setTimeout(function(){
	  notAssign="";	
	  $.post('not_assign_respons.htm',{ids:pResId.substring(0,pResId.length-1)},function(data){
		  notAssign="<option value=''>-请选择-</option>";
		  $.each(data, function(i,val){notAssign+="<option value='"+val.id+"'>" + val.funcode + "&nbsp;&nbsp;" + val.name + "</option>";});
		  dlg.find('#resNoUser').empty().append(notAssign);
	  },'json');
  },150);
}