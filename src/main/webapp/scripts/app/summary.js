
$(function(){
	$.fn.zTree.init($("#menu"), setting);

	//默认加载出勤
	selectedUser();
	
	$("#user_main").dialog({
		   autoOpen:false,
		   modal:true,
		   resizable:true,
		   width:450,
		   buttons: {
			  "确定": selectedUser,
			  "取消": function() {$(this).dialog('close')}}
		});
}); 

var dispose = function(type, pid) {
	var tab = $("#t_tab");
	switch (type) {
	case 'attendance': 
		//加载出勤
		selectedUser();
		break;
	
	case 'plan': 
		$("#rctype").html("计划预览");
		$.post('get_summary.htm',{type: type, pid:pid},function(data){
			 tab.find("#t_thead").empty().append("<tr><th>任务标题</th><th>工作类型</th><th>预计工时</th><th>完成比例(%)</th><th>开始时间 </th><th>结束时间</th></tr>");
			 var body = tab.find("#t_body").empty();
			 if(data.plan != null) {
				 $.each(data.plan, function(i, t){
					 var start = " ";
					 var end = " ";
					 if(t.actualStart != undefined) start = t.actualStart;
					 if(t.actualEnd != undefined) end = t.actualEnd;
					 body.append("<tr onclick=select(this)><td>" + t.taskTitle + "</td><td>" + taskTypefmt(t.taskType) + "</td><td>" + t.expectedHours + "</td><td>" + t.completedRate + "</td><td>" + start + "</td><td>" + end + "</td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 tab.find("#t_foot").empty().append("<tr class='tr_con'><td colspan='6'><b>" + data.page + "</b></td></tr>");
		},'json');
		break;

	case 'doing': 
		$("#rctype").html("需要做预览");
		$.post('get_summary.htm',{type: type, pid:pid},function(data){
			 tab.find("#t_thead").empty().append("<tr><th>任务标题</th><th>工作类型</th><th>预计工时</th><th>完成比例(%)</th><th>开始时间 </th><th>结束时间</th></tr>");
			 var body = tab.find("#t_body").empty();
			 if(data.plan != null) {
				 $.each(data.plan, function(i, t){
					 var start = " ";
					 var end = " ";
					 if(t.actualStart != undefined) start = t.actualStart;
					 if(t.actualEnd != undefined) end = t.actualEnd;
					 body.append("<tr onclick=select(this)><td>" + t.taskTitle + "</td><td>" + taskTypefmt(t.taskType) + "</td><td>" + t.expectedHours + "</td><td>" + t.completedRate + "</td><td>" + start + "</td><td>" + end + "</td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 tab.find("#t_foot").empty().append("<tr class='tr_con'><td colspan='6'><b>" + data.page + "</b></td></tr>");
		},'json');
		break;
		
	case 'daily': 
		$("#rctype").html("日报预览");
		$.post('get_summary.htm',{type: type, pid:pid},function(data){
			 tab.find("#t_thead").empty().append("<tr><td colspan='6'><b class='bts'>对公司的贡献</b></td></tr>").append("<tr><th>任务标题</th><th>工作类型</th><th>工时</th><th>完成比例(%)</th><th>开始时间 </th><th>结束时间</th></tr>");
			 var body = tab.find("#t_body").empty();
			 if(data.plan != null) {
				 $.each(data.plan, function(i, t){
					 var start = " ";
					 var end = " ";
					 if(t.actualStart != undefined) start = t.actualStart;
					 if(t.actualEnd != undefined) end = t.actualEnd;
					 body.append("<tr onclick=select(this)><td>" + t.taskTitle + "</td><td>" + taskTypefmt(t.taskType) + "</td><td>" + t.expectedHours + "</td><td>" + t.completedRate + "</td><td>" + start + "</td><td>" + end + "</td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 if(data.doing != null) {
				 body.append("<tr><td colspan='6'>&nbsp;</td></tr>");
				 body.append("<tr><td colspan='6'><b class='bts'>需要做</b></td></tr>");
				 body.append("<tr><th>任务标题</th><th>工作类型</th><th>预计工时</th><th>完成比例(%)</th><th>开始时间 </th><th>结束时间</th></tr>");
				 $.each(data.doing, function(i, t){
					 var start = " ";
					 var end = " ";
					 if(t.actualStart != undefined) start = t.actualStart;
					 if(t.actualEnd != undefined) end = t.actualEnd;
					 body.append("<tr onclick=select(this)><td>" + t.taskTitle + "</td><td>" + taskTypefmt(t.taskType) + "</td><td>" + t.expectedHours + "</td><td>" + t.completedRate + "</td><td>" + start + "</td><td>" + end + "</td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 if(data.help != null) {
				 body.append("<tr><td colspan='6'>&nbsp;</td></tr>");
				 body.append("<tr><td colspan='6'><b class='bts'>需要帮忙</b></td></tr>");
				 body.append("<tr><th>任务标题</th><th>工作类型</th><th>预计工时</th><th>完成比例(%)</th><th>开始时间 </th><th>结束时间</th></tr>");
				 $.each(data.help, function(i, t){
					 var start = " ";
					 var end = " ";
					 if(t.actualStart != undefined) start = t.actualStart;
					 if(t.actualEnd != undefined) end = t.actualEnd;
					 body.append("<tr onclick=select(this)><td>" + t.taskTitle + "</td><td>" + taskTypefmt(t.taskType) + "</td><td>" + t.expectedHours + "</td><td>" + t.completedRate + "</td><td>" + start + "</td><td>" + end + "</td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 if(data.daytask != null) {
				 body.append("<tr><td colspan='6'>&nbsp;</td></tr>");
				 body.append("<tr><td colspan='6'><b class='bts'>每日要做</b></td></tr>");
				 body.append("<tr><th>任务标题</th><th>工作类型</th><th>预计工时</th><th>完成比例(%)</th><th>开始时间 </th><th>结束时间</th></tr>");
				 $.each(data.daytask, function(i, t){
					 var start = " ";
					 var end = " ";
					 if(t.actualStart != undefined) start = t.actualStart;
					 if(t.actualEnd != undefined) end = t.actualEnd;
					 body.append("<tr onclick=select(this)><td>" + t.taskTitle + "</td><td>" + taskTypefmt(t.taskType) + "</td><td>" + t.expectedHours + "</td><td>" + t.completedRate + "</td><td>" + start + "</td><td>" + end + "</td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 tab.find("#t_foot").empty();
		},'json');
		break;
		
	case 'weekly': 
		$("#rctype").html("周报预览");
		$.post('get_summary.htm',{type: type, pid:pid},function(data){
			 tab.find("#t_thead").empty().append("<tr><td colspan='6'><b class='bts'>对公司的贡献</b></td></tr>").append("<tr><th>任务标题</th><th>工作类型</th><th>工时</th><th>完成比例(%)</th><th>开始时间 </th><th>结束时间</th></tr>");
			 var body = tab.find("#t_body").empty();
			 if(data.plan != null) {
				 $.each(data.plan, function(i, t){
					 var start = " ";
					 var end = " ";
					 if(t.actualStart != undefined) start = t.actualStart;
					 if(t.actualEnd != undefined) end = t.actualEnd;
					 body.append("<tr onclick=select(this)><td>" + t.taskTitle + "</td><td>" + taskTypefmt(t.taskType) + "</td><td>" + t.expectedHours + "</td><td>" + t.completedRate + "</td><td>" + start + "</td><td>" + end + "</td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 if(data.doing != null) {
				 body.append("<tr><td colspan='6'>&nbsp;</td></tr>");
				 body.append("<tr><td colspan='6'><b class='bts'>需要做</b></td></tr>");
				 body.append("<tr><th>任务标题</th><th>工作类型</th><th>预计工时</th><th>完成比例(%)</th><th>开始时间 </th><th>结束时间</th></tr>");
				 $.each(data.doing, function(i, t){
					 var start = " ";
					 var end = " ";
					 if(t.actualStart != undefined) start = t.actualStart;
					 if(t.actualEnd != undefined) end = t.actualEnd;
					 body.append("<tr onclick=select(this)><td>" + t.taskTitle + "</td><td>" + taskTypefmt(t.taskType) + "</td><td>" + t.expectedHours + "</td><td>" + t.completedRate + "</td><td>" + start + "</td><td>" + end + "</td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 if(data.help != null) {
				 body.append("<tr><td colspan='6'>&nbsp;</td></tr>");
				 body.append("<tr><td colspan='6'><b class='bts'>需要帮忙</b></td></tr>");
				 body.append("<tr><th>任务标题</th><th>工作类型</th><th>预计工时</th><th>完成比例(%)</th><th>开始时间 </th><th>结束时间</th></tr>");
				 $.each(data.help, function(i, t){
					 var start = " ";
					 var end = " ";
					 if(t.actualStart != undefined) start = t.actualStart;
					 if(t.actualEnd != undefined) end = t.actualEnd;
					 body.append("<tr onclick=select(this)><td>" + t.taskTitle + "</td><td>" + taskTypefmt(t.taskType) + "</td><td>" + t.expectedHours + "</td><td>" + t.completedRate + "</td><td>" + start + "</td><td>" + end + "</td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 if(data.meeting != null) {
				 body.append("<tr><td colspan='6'>&nbsp;</td></tr>");
				 body.append("<tr><td colspan='6'><b class='bts'>会议记录</b></td></tr>");
				 body.append("<tr><th>会议主题</th><th>时间</th><th>主持人</th><th>记录人</th><th>参会人员</th><th>地点</th></tr>");
				 $.each(data.meeting, function(i, m){
					 body.append("<tr onclick=select(this)><td>" + m.title + "</td><td>" + m.time + "</td><td>" + m.host + "</td><td>" + m.notes + "</td><td><div class='tolong_100'>" + m.participants + "</div></td><td>" + m.locale + "</td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 if(data.imgs != null) {
				 body.append("<tr><td colspan='6'>&nbsp;</td></tr>");
				 body.append("<tr><td colspan='6'><b class='bts'>统计图表</b></td></tr>");
				 body.append("<tr><th>贡献(日期格式：年份-周数)</th><th colspan='5'></th></tr>");
				 body.append("<tr><td colspan='6'><img src='../" + data.imgs.contribution_img + "' alt='c' /></td></tr>");
				 
				 body.append("<tr><th>计划(日期格式：年份-周数)</th><th colspan='5'></th></tr>");
				 body.append("<tr><td colspan='6'><img src='../" + data.imgs.plan_img + "' alt='c' /></td></tr>");
				 
				 body.append("<tr><th>实际(日期格式：年份-周数)</th><th colspan='5'></th></tr>");
				 body.append("<tr><td colspan='6'><img src='../" + data.imgs.practical_img + "' alt='c' /></td></tr>");
				 
				 body.append("<tr><th>请假(日期格式：年份-周数)</th><th colspan='5'></th></tr>");
				 body.append("<tr><td colspan='6'><img src='../" + data.imgs.leave_img + "' alt='c' /></td></tr>");

				 body.append("<tr><th>调休(日期格式：年份-周数)</th><th colspan='5'></th></tr>");
				 body.append("<tr><td colspan='6'><img src='../" + data.imgs.lieu_img + "' alt='c' /></td></tr>");
				 
				 body.append("<tr><th>迟到(日期格式：年份-周数)</th><th colspan='5'></th></tr>");
				 body.append("<tr><td colspan='6'><img src='../" + data.imgs.late_img + "' alt='c' /></td></tr>");
				 
				 body.append("<tr><th>早退(日期格式：年份-周数)</th><th colspan='5'></th></tr>");
				 body.append("<tr><td colspan='6'><img src='../" + data.imgs.early_img + "' alt='c' /></td></tr>");
				 
				 body.append("<tr><th>延误(日期格式：年份-周数)</th><th colspan='5'></th></tr>");
				 body.append("<tr><td colspan='6'><img src='../" + data.imgs.delay_img + "' alt='c' /></td></tr>");
				 
			 }
			 tab.find("#t_foot").empty();
		},'json');
		break;
		
	case 'monthly': 
		$("#rctype").html("月报预览");
		$.post('get_summary.htm',{type: type, pid:pid},function(data){
			 tab.find("#t_thead").empty().append("<tr><td colspan='6'><b class='bts'>对公司的贡献</b></td></tr>").append("<tr><th>任务标题</th><th>工作类型</th><th>工时</th><th>完成比例(%)</th><th>开始时间 </th><th>结束时间</th></tr>");
			 var body = tab.find("#t_body").empty();
			 if(data.plan != null) {
				 $.each(data.plan, function(i, t){
					 var start = " ";
					 var end = " ";
					 if(t.actualStart != undefined) start = t.actualStart;
					 if(t.actualEnd != undefined) end = t.actualEnd;
					 body.append("<tr onclick=select(this)><td>" + t.taskTitle + "</td><td>" + taskTypefmt(t.taskType) + "</td><td>" + t.expectedHours + "</td><td>" + t.completedRate + "</td><td>" + start + "</td><td>" + end + "</td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 if(data.doing != null) {
				 body.append("<tr><td colspan='6'>&nbsp;</td></tr>");
				 body.append("<tr><td colspan='6'><b class='bts'>需要做</b></td></tr>");
				 body.append("<tr><th>任务标题</th><th>工作类型</th><th>预计工时</th><th>完成比例(%)</th><th>开始时间 </th><th>结束时间</th></tr>");
				 $.each(data.doing, function(i, t){
					 var start = " ";
					 var end = " ";
					 if(t.actualStart != undefined) start = t.actualStart;
					 if(t.actualEnd != undefined) end = t.actualEnd;
					 body.append("<tr onclick=select(this)><td>" + t.taskTitle + "</td><td>" + taskTypefmt(t.taskType) + "</td><td>" + t.expectedHours + "</td><td>" + t.completedRate + "</td><td>" + start + "</td><td>" + end + "</td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 if(data.help != null) {
				 body.append("<tr><td colspan='6'>&nbsp;</td></tr>");
				 body.append("<tr><td colspan='6'><b class='bts'>需要帮忙</b></td></tr>");
				 body.append("<tr><th>任务标题</th><th>工作类型</th><th>预计工时</th><th>完成比例(%)</th><th>开始时间 </th><th>结束时间</th></tr>");
				 $.each(data.help, function(i, t){
					 var start = " ";
					 var end = " ";
					 if(t.actualStart != undefined) start = t.actualStart;
					 if(t.actualEnd != undefined) end = t.actualEnd;
					 body.append("<tr onclick=select(this)><td>" + t.taskTitle + "</td><td>" + taskTypefmt(t.taskType) + "</td><td>" + t.expectedHours + "</td><td>" + t.completedRate + "</td><td>" + start + "</td><td>" + end + "</td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 if(data.meeting != null) {
				 body.append("<tr><td colspan='6'>&nbsp;</td></tr>");
				 body.append("<tr><td colspan='6'><b class='bts'>会议记录</b></td></tr>");
				 body.append("<tr><th>会议主题</th><th>时间</th><th>主持人</th><th>记录人</th><th>参会人员</th><th>地点</th></tr>");
				 $.each(data.meeting, function(i, m){
					 body.append("<tr onclick=select(this)><td>" + m.title + "</td><td>" + m.time + "</td><td>" + m.host + "</td><td>" + m.notes + "</td><td><div class='tolong_100'>" + m.participants + "</div></td><td>" + m.locale + "</td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 if(data.imgs != null) {
				 body.append("<tr><td colspan='6'>&nbsp;</td></tr>");
				 body.append("<tr><td colspan='6'><b class='bts'>统计图表</b></td></tr>");
				 body.append("<tr><th>贡献(日期格式：天数)</th><th colspan='5'></th></tr>");
				 body.append("<tr><td colspan='6'><img src='../" + data.imgs.contribution_img + "' alt='c' /></td></tr>");
				 
				 body.append("<tr><th>计划(日期格式：天数)</th><th colspan='5'></th></tr>");
				 body.append("<tr><td colspan='6'><img src='../" + data.imgs.plan_img + "' alt='c' /></td></tr>");
				 
				 body.append("<tr><th>实际(日期格式：天数)</th><th colspan='5'></th></tr>");
				 body.append("<tr><td colspan='6'><img src='../" + data.imgs.practical_img + "' alt='c' /></td></tr>");
				 
				 body.append("<tr><th>请假(日期格式：天数)</th><th colspan='5'></th></tr>");
				 body.append("<tr><td colspan='6'><img src='../" + data.imgs.leave_img + "' alt='c' /></td></tr>");

				 body.append("<tr><th>调休(日期格式：天数)</th><th colspan='5'></th></tr>");
				 body.append("<tr><td colspan='6'><img src='../" + data.imgs.lieu_img + "' alt='c' /></td></tr>");
				 
				 body.append("<tr><th>迟到(日期格式：天数)</th><th colspan='5'></th></tr>");
				 body.append("<tr><td colspan='6'><img src='../" + data.imgs.late_img + "' alt='c' /></td></tr>");
				 
				 body.append("<tr><th>早退(日期格式：天数)</th><th colspan='5'></th></tr>");
				 body.append("<tr><td colspan='6'><img src='../" + data.imgs.early_img + "' alt='c' /></td></tr>");
				 
				 body.append("<tr><th>延误(日期格式：天数)</th><th colspan='5'></th></tr>");
				 body.append("<tr><td colspan='6'><img src='../" + data.imgs.delay_img + "' alt='c' /></td></tr>");
				 
			 }
			 tab.find("#t_foot").empty();
		},'json');
		break;
		
	case 'resp': 
		$("#rctype").html("管理责任预览");
		$.post('get_summary.htm',{type: type, pid:pid},function(data){
			 tab.find("#t_thead").empty().append("<tr><th>功能代码</th><th>主旨</th><th>比重(%)</th><th colspan='3'>说明</th></tr>");
			 var body = tab.find("#t_body").empty();
			 if(data.resp != null) {
				 $.each(data.resp, function(i, r){
					 body.append("<tr onclick=select(this)><td>" + r.funcode + "</td><td>" + r.name + "</td><td>" + r.expected + "</td><td colspan='3'>" + r.explanation + "</td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 tab.find("#t_foot").empty();
		},'json');
		break;
		
	case 'login': 
		$("#rctype").html("登录记录预览");
		$.post('get_summary.htm',{type: type},function(data){
			 tab.find("#t_thead").empty().append("<tr><th>日期</th><th>登入时间明细</th><th>登出时间</th></tr>");
			 var body = tab.find("#t_body").empty();
			 if(data.login != null) {
				 $.each(data.login, function(i, l){
					 var in_date = " ";
					 var out_date = " ";
					 if(l.loginTime != undefined) in_date = l.loginTime;
					 if(l.loginOut != undefined) out_date = l.loginOut;
					 body.append("<tr onclick=select(this)><td>" + in_date + "</td><td><div class='tolong_300'>" + l.loginTake + "</div></td><td>" + out_date + "</td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 tab.find("#t_foot").empty();
		},'json');
		break;
		
	default:
		alert("no data!");
		break;
	}

};

//点击TR触发radio选中事件
function select(obj, url) {
	$(obj).parent().children('tr').removeClass("ui-state-highlight")
	$(obj).addClass("ui-state-highlight");
}

//人员选择按纽弹出窗口
var userDlg = function () {
	var dlg = $("#user_main");
	var panel = dlg.siblings(".ui-dialog-buttonpane");
	panel.find("button:not(:contains('取消'))").hide();
	panel.find("button:contains('确定')").show();
	dlg.dialog("option","title","出勤人员选择");
	dlg.find("#user_dl").empty();
	
	//查找到所有部门遍历到department
	$.post('../departments.htm',function(data){
		 var user = "";
		 $.each(data, function(i, d){ 
			 user += "<label><input type='checkbox' onclick='getUser(this);' name='dpt' value='"+d.id+"' />"+d.cname+"</label>";
		 });
		 dlg.find("#dpt_dl").html(user);
		 dlg.find("#dpt_dl").find("input:checked").attr("checked", false);
		 dlg.dialog('open');
	},'json');
};

//从选中的部门当中拉出用户信息
var getUser = function(obj) {
	var user = $("#user_main").find('#user_dl');
	var id = obj.value;
	if(obj.checked){
		$.post('../dpt_users.htm',{'dpt':id,'type':'DEPARTMENT', ismgr:false, 'user':'true'},function(data){
			var du = "";
			$.each(data, function(i,u){
				du += "<label><input type='checkbox' checked='checked' name='puser' value='"+u.id+"' />"+u.cname+"</label>";
			});
			user.append("<div id='du"+id+"'>"+du+"</div>");
		},'json');
	 } 
	else user.find("#du"+id).empty();
};

//把选择的用户数据拉出来
var selectedUser = function () {
	var dlg = $("#content_main");
	var tab = $("#t_tab");
	var user = $("#user_main").find('#user_dl');
	var ids = new Array();
	var i=0;
	user.find("input[name=puser]:checked").each(function(){ ids[i++] = $(this).val(); });
	
	$("#rctype").html("出勤预览");
	$.post('get_summary.htm',{type: 'attendance', uids: ids},function(data){
		 tab.find("#t_thead").empty().append("出勤<input type='button' value='选择人员' onclick='userDlg()' />").append("<tr><th>工作号</th><th>用户</th><th>频率</th><th>工日</th><th>工时 </th><th>请假</th><th>补假</th><th>迟到</th><th>说明</th></tr>");
		 var body = tab.find("#t_body").empty();
		 if(data.attendance != null) {
			 $.each(data.attendance, function(i, a){
				 body.append("<tr onclick=select(this)><td>" + a.jobNo + "</td><td>" + a.ename + "</td><td>" + frequencyPeriod(a.range) + "</td><td>" + a.day + "</td><td>" + a.hours + "</td><td>" + a.leave + "</td><td>" + a.compensatory + "</td><td>" + a.late + "</td><td>本次统计日期从 " + a.des.split(" ")[0] + " 开始至今</td></tr>");
			 });
			 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
		 }
		 tab.find("#t_foot").empty();
		 $("#user_main").dialog('close');
	},'json');
	
};