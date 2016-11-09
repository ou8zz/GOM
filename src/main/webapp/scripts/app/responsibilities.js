var colNames_cn = ['ID','traceId','nodeCode','nodeOrder','头像','部门','职务','工号','英文名','中文名','称谓','出生年月','户籍','民族','手机','身份证','身份证附件','开户行','入职日期','转正日期','婚姻','账号'];
var colNames_tw = ['ID','traceId','nodeCode','nodeOrder','頭像','部門','職務','工號','英文名','中文名','稱謂','出生年月','戶籍','民族','手機','身份證','身份證附件','開戶行','入職日期','轉正日期','婚姻','賬號'];
var caption = {zh: "新职员职责分配", "zh_CN": "新职员职责分配", "zh_TW": "新職員職責分配"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

// unblock when ajax activity stops 
$(document).ajaxStop($.unblockUI);
$(function(){
	$.fn.zTree.init($('#menu'), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	$('#responId').change(function(){
		var parentId=$(this).val();
		if(parentId){
			$('#node0,#node1,#node2,#node3,#node4').val(parentId);
			$.post('get_responsibilitys.htm',{'pid':parentId,'onlyf':true},function(data){
				$('#name').empty().append(data.name);
				$('#explanation').empty().append(data.explanation);
				
				$.post('get_responsibilitys.htm',{'pid':parentId,isf:true},function(datas){
					$.each(datas, function(n,val){
						$('#responId'+n).empty().append("<option value='"+val.id+"'>"+val.funcode+ "&nbsp;&nbsp;" +val.name+ "</option>");
						$('#explanation'+n).empty().append(val.explanation);
					});
				},'json');
			},'json');
		}else alert("选择主责任");
	});
	
	$('#node0,#node1,#node2,#node3,#node4').change(function(){
		var name = $(this).attr("id");
		var num = name.substring(name.length-1);
		if($(this).val()){
			$.post('get_responsibilitys.htm',{'pid':$(this).val(),isf:true},function(data){
				var option ='<option value="">请选择</option>';
				$.each(data, function(n,val){option += "<option value='"+val.id+"'>"+val.funcode+ "&nbsp;&nbsp;" +val.name+ "</option>";});
				$('#responId'+num).empty().append(option);
			},'json');
		}else alert("请先选择父责任");
	});
	
	$('#responId0,#responId1,#responId2,#responId3,#responId4').change(function(){
		var name = $(this).attr("id");
		var num = name.substring(name.length-1);
		if($(this).val()){
			$.post('get_responsibilitys.htm',{'pid':$(this).val(),onlyf:true},function(data){
				$('#explanation'+num).empty().append(data.explanation);
			},'json');
		}else alert("请先选择子责任");
	});
	
	$("span.error_msg").hide();
	$('#userSubmit').click(function() {
		if(countExpect($(":input.father").serializeArray()) != 100){
			$("span.error_msg").text("必须为整数，且父责任预设比重相加要等于100，请配置修改").show().fadeOut(8000);
			return false;
		}else if(countExpect($(":input.son").serializeArray()) != 100) {
			$("span.error_msg").text("必须为整数，且子责任预设比重相加要等于100，请配置修改").show().fadeOut(8000);
			return false;
		}else {
			$.post('save_responsibilities.htm',{rpts:toJson($('#responsibilityForm').serializeArray(),3),userId:$('#id').val()},function(data){
				var fhtml='';
				var shtml='';
				$.each(data, function(i,val){
					if(/^\+?[0-9]*$/.test(val.node)) fhtml+='<tr class="ftmp"><td class="first"><span>'+val.funcode+'</span><i class="ui-icon treeclick ui-icon-triangle-1-s"></i><input type="hidden" class="validate" name="id" value="'+val.responId+'"/><input type="hidden" name="node" value="'+val.node+'"/></td><td>'+val.name+'</td><td><input name="expected" class="inps father" tabindex="3" value=""/>'+val.expected+'</td><td>'+val.explanation+'</td></tr>';
					else shtml+='<tr class="ftmp"><td class="second"><span>'+val.funcode+'</span><i class="ui-icon ui-icon-radio-off"></i></td><td>'+val.name+'</td><td>'+val.expected+'</td><td>'+val.explanation+'</td></tr>';
					});
					fhtml+=shtml;
				$('#inputInfo').before(fhtml);
				$(":input.son,#expected").val("");
				alert("成功增加新职员职责，如果再次增加调整父职责，以满足相加等于100%");
			},'json');
		}
    });
	
	$("#entryDate,#fullDate,#startDate,#endDate").datepicker({changeMonth:true,changeYear:true});
	//显示所有用户信息
	$('#zgrid').jqGrid({
	   	url:'get_users.htm',
		datatype:'json',
		mtype:'GET',
		height:250,
		width:790,
		caption:caption[lang],
	   	colNames:colNames[lang],
	   	colModel:[
		    {name:'id',index:'id',hidden:true},
			{name:'traceId',index:'traceId',hidden:true},
			{name:'nodeCode',index:'nodeCode',hidden:true},
			{name:'nodeOrder',index:'nodeOrder',hidden:true},
			{name:'portrait',index:'portrait',hidden:true},
	   		{name:'cdepartment',index:'cdepartment',width:50},
			{name:'cposition',index:'cposition',width:50},
			{name:'jobNo',index:'jobNo',width:60},
	   		{name:'ename',index:'ename',width:60},
	   		{name:'cname',index:'cname',width:60},		
	   		{name:'gender',index:'gender',width:40,formatter:genderType},
			{name:'birthday',index:'birthday',width:85},
			{name:'censusType',index:'censusType',width:60,formatter:censusType},
			{name:'nation',index:'nation',width:60},
	   		{name:'cell',index:'cell',width:95},
			{name:'idcard',index:'idcard',width:140},
			{name:'idScan',index:'idScan',hidden:true},
			{name:'bank',index:'bank',hidden:true},
			{name:'entryDate',index:'entryDate',hidden:true},
			{name:'fullDate',index:'fullDate',hidden:true},
			{name:'marriage',index:'marriage',hidden:true,formatter:fmtMarital},
			{name:'accountNo',index:'accountNo',hidden:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager:'#zpager',
	    viewrecords:true,
	    rownumbers:true,
		rownumWidth:30,
		sortname:'ename',
		sortorder:'asc',
		prmNames:{search:'search'},
	    jsonReader:{root:'list',repeatitems:false},
		multiselect:false,
		cmTemplate:{sortable:false}
	});

$('#zgrid').jqGrid('navGrid','#zpager',{add:false,editfunc:editUserDlg,del:false,search:false,alerttext:"请选择需要操作的数据行!"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:true},{});
	
	//配置对话框
	$("#content_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:620,
		   buttons: {
			  "提交":editUser,
			  "取消":function() {$(this).dialog('close')}}
	 });
});

var editUserDlg = function() {
	 var dlg = $("#content_main");
	 var panel = dlg.siblings(".ui-dialog-buttonpane");
	 dlg.find("input").removeAttr("disabled");
	  
	 var selectrow = $('#zgrid').jqGrid("getGridParam", "selrow");
	 if(selectrow) {
	 var rd = $('#zgrid').jqGrid("getRowData", selectrow);
	 dlg.find('#entryForm')[0].reset();
	 dlg.dialog("option","title","分配新员工 <b style='color:blue'>" + rd.ename + "</b> 的职责");
	 
	 dlg.find('#id').val(rd.id);
	 dlg.find('#traceId').val(rd.traceId);
	 dlg.find('#nodeCode').val(rd.nodeCode);
	 dlg.find('#nodeOrder').val(rd.nodeOrder);
	 dlg.find('#ename').val(rd.ename);
	 
	 dlg.find('table.gom_tb').empty();
	 $.post('get_responsibilitys.htm',{uid:$('#id').val()},function(data){
		var resp='';
		$.each(data, function(i,val){
			if(/^\+?[0-9]*$/.test(val.node)) resp+='<tr class="ftmp"><td class="first "><span>'+val.funcode+'</span><i class="ui-icon treeclick ui-icon-triangle-1-s"></i><input class="validate" type="hidden" name="id" value="'+val.responId+'"/><input type="hidden" name="node" value="'+val.node+'"/></td><td>'+val.name+'</td><td><input name="expected" class="inps father" tabindex="3" value=""/>'+val.expected+'</td><td>'+val.explanation+'</td></tr>';
			else resp+='<tr class="ftmp"><td class="second"><span>'+val.funcode+'</span><i class="ui-icon ui-icon-radio-off"></i></td><td>'+val.name+'</td><td>'+val.expected+'</td><td>'+val.explanation+'</td></tr>';
		});
		dlg.find("tr.ftmp").remove();
		dlg.find('#inputInfo').before(resp);
	},'json');
			
	 var info = "<thead><tr><th colspan='5'>"+rd.cname+"（" + rd.ename +"）</th></tr></thead><tbody><tr><td colspan='4' scope='col'><ul><li>"+rd.gender+"</li><li>"+rd.birthday+"</li><li>"+rd.marriage+"</li><li>"+rd.nation+"</li><li class='last'>"+rd.cell+"</li></ul></td><td width='20%' rowspan='3' align='center' scope='col'><img src='../uploads/images/"+rd.portrait+"' border='0'/></td></tr><tr><th scope='col' width='20%'>就职部门</th><td width='20%'>"+rd.cdepartment+"</td><th width='20%'>职务</th><td width='20%'>"+rd.cposition+"</td></tr><tr><th>入职日期</th><td>"+rd.entryDate+"</td><th>转正日期</th><td>"+rd.fullDate+"</td></tr>";
	 
	 var edus="<tr><td colspan='6'><b>教育经历</b></td></tr><tr><th>时间</th><th>学校/机构</th><th>专业/项目</th><th>学历/职称</th><th>证书编号</th></tr>";
	 var showImg = "";
	 $.get('get_user_edu.htm',{'t':'EDU','id':rd.id,isgrid:false},function(data){$.each(data, function(i,val){
		 if(val.idScan) showImg="<a target='_blank' href='../uploads/images/"+val.idScan+"' class='nyroModal' title='"+val.ed+" 证书'>"+val.idno+"</a>";
		 else showImg = val.idno;
		 edus+="<tr><td>"+val.startDate+"~"+val.endDate+"</td><td>"+val.school+"</td><td>"+val.major+"</td><td>"+val.ed+"</td><td>"+showImg+"</td></tr>";});
	 },'json');
	 
	 setTimeout(function(){
		 var contacts="<tr><td colspan='5'><b>联系人</b></td></tr><tr><th>姓名</th><th>关系</th><th>手机</th><th>座机</th><th>地址</th></tr>";
		 $.get('get_user_edu.htm',{'t':'ADR','id':rd.id,isgrid:false},function(data){
			 $.each(data, function(n,value){contacts+="<tr><td>"+value.contact+"</td><td>"+value.relation+"</td><td>"+value.cell+"</td><td>"+value.phone+"</td><td>"+value.address+"</td></tr>";});
		dlg.find('table.gom_tb').append(info + edus + contacts + "</tbody>");
	 },'json');},160);
	 
	 setTimeout(function(){
		 var option ='<option value="">请选择</option>';
		 $.post('get_responsibilitys.htm?isf=true',function(data){$.each(data, function(n,val){option+='<option value="'+val.id+'">'+val.funcode+ '&nbsp;&nbsp;' +val.name+ '</option>';});
		 dlg.find('#responId,#node0,#node1,#node2,#node3,#node4').empty().append(option);
	 },'json');},160);
	 dlg.dialog('open');
	 }
};

var editUser = function() {
  var dlg = $('#content_main');
  if(countExpect(dlg.find(":input.validate").serializeArray()) > 0){
	  $.blockUI({message:'<h6><img src="../images/ztree/loading.gif" /> 系统正在处理中，请稍候！</h6>',css:{border:'none',padding:'15px',backgroundColor:'#000', '-webkit-border-radius':'10px', '-moz-border-radius':'10px', opacity:.5, color:'#fff' 
        }});
	  $.ajax({url:'edit_entrant.htm',type:'POST',data:dlg.find('#entryForm').serialize(),dataType:'json',cache:false,success:function(data){
	      if(data.result == "SUCCESS") {
	        var uid = $("#zgrid").jqGrid('getGridParam','selrow');
			$('#zgrid').jqGrid("delRowData",uid);
			alert("操作成功！");
	        dlg.dialog("close");
		  }
		 else if(data.result == "PARAM_EMPTY") alert("请填写完整后再提交！");
		 else alert("更新操作失败！");}
		});
  }else alert("请先增加新员工职责，最后再提交");
};