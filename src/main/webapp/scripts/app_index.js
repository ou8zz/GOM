var videos = new Array();
$(function(){
	$.fn.zTree.init($("#menu"), setting);
	
	//初始化日历
	initial();
	
	//默认加载主页内容
	index_task();

	//时间控件
	$('#startTime').focus(function(){WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d'});});
	$('#endTime').focus(function(){WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startTime\');}'});});
	
	//主窗口隐藏
	$("#content_main").dialog({autoOpen:false, modal:true, resizable:true, width:500, buttons: {"取消": function() {$(this).dialog('close')}}}); 
	//异常弹出窗口
	$("#isAbnormal").dialog({autoOpen:false, modal:true, resizable:true, width:400, buttons: {"提交": subAbnormal, "取消": function() {$(this).dialog('close')}}}); 
	//视频播放弹出窗口
	$("#play_video").dialog({autoOpen:false, modal:true, resizable:true, width:'auto', close:function(){flowplayer("player", "../common/flowplayer.swf")}, buttons: {"关闭": function() {$(this).dialog('close')}}});
	
	//创建任务窗口
//	$("#google_task").dialog({autoOpen:false, modal:true, resizable:true, width:'auto', buttons: {"提交": saveCalendar, "关闭": function() {$(this).dialog('close')}}});
	//Google登录
//	$("#google_login").dialog({autoOpen:false, modal:true, resizable:true, width:'auto', buttons: {"登录": googleLogin, "关闭": function() {$(this).dialog('close')}}});

//	var parmes = {
//			accountType:'HOSTED_OR_GOOGLE',
//			Email:'sqegom@gmail.com',
//			Passwd:'service11',
//			service:'cl',
//			source:'SQESERVICE'
//	};
//	$.post('https://www.google.com/accounts/ClientLogin', parmes, function(data){
//		alert("login google success!");
//	});
	//默认首页为日历
//	$("#t_tab").find("#t_thead").empty().append("<th width='100%'>"+$("#calendar").html()+"</th>");
	
	//查找到所有部门遍历到department_SELECT
	$.post('../departments.htm',function(data){
		 var option = $("#rep_dpt, #in_dpt");
		 option.empty();
		 option.append("<option value=''>-请选择部门-</option>");
		 $.each(data, function(i, d){ option.append("<option value='"+d.id+"'>"+d.cname+"</option>"); });
	},'json');
	
	//选择部门 加载此部门下面的非Employee职位的用户
	$('#rep_dpt').change(function(){
		 var ad = $(this).val();
		 var opt = $('#reporter').empty();
		 if(ad){
			$.post('../dpt_users.htm',{'dpt':ad,'type':'DEPARTMENT', ismgr:true},function(data){
				$.each(data, function(i,val){opt.append("<option value='" + val.ename + "'>" + val.ename + "</option>");});
			},'json');
		 } else alert("请先选择部门！");
	});
	
	//选择部门 加载此部门下面的非Employee职位的用户
	$('#in_dpt').change(function(){
		 var ad = $(this).val();
		 var opt = $('#indirect').empty();
		 if(ad){
			$.post('../dpt_users.htm',{'dpt':ad,'type':'DEPARTMENT', ismgr:true},function(data){
				$.each(data, function(i,val){opt.append("<option value='" + val.ename + "'>" + val.ename + "</option>");});
			},'json');
		 } else alert("请先选择部门！");
	});
	
	//查询上次登出是否异常
	$.post('../app/login_abnormal.htm', function(data){
		if(data == "SUCCESS") {	//是异常
			$("#isAbnormal").dialog("option","title","<span style='color:red'>糟糕！您上次退出时出现了异常！</span>").dialog('open');
		}
	},'json');
	
});

//提交异常申请
var subAbnormal = function() {
	var dlg = $("#isAbnormal");
	$.post('../app/save_abnormal.htm', dlg.find("#abnormalForm").serialize(), function(data) {
		if (data.result == "SUCCESS") {
			alert("提交成功！");
			dlg.dialog("close");
		}  
		else alert("操作失败！");
	}, 'json');
};

//选择菜单栏
var dispose = function(type, pid) {
	var tab = $("#t_tab");
	tab.show();
	$("#index_calendar").hide();
	switch (type) {
	//日历
	case 'index': 
		tab.find("#t_thead, #t_body, #t_foot").empty();
		tab.hide();
		$("#index_calendar").show();
		index_task();
		break;

	case 'leave': 
		$.get('../app/get_leaves.htm',function(data){
			 var num = 0;
			 tab.find("#t_thead").empty().append("<th width='20%'>部门</th><th width='20%'>职务</th><th width='20%'>中文名</th><th width='20%'>请假开始</th><th width='20%'>天数</th>");
			 var body = tab.find("#t_body").empty();
			 if(data != null) {
				 $.each(data.list, function(i, l){
					 num = i+1;
					 body.append("<tr onclick=select(this,'leaves.htm')><td>" + l.cdepartment + "</td><td>" + l.cposition + "</td><td>" + l.cname + "</td><td>" + l.startDate + "</td><td>" + l.days + "</td></tr>");
				 });
				 //这句当鼠标移动到TR上变成一个手的图标
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 tab.find("#t_foot").empty().append("<tr class='tr_con'><td colspan='5'>共 <b>" + num + "</b> 条记录</td></tr>");
		},'json');
		break;
		
	case 'entry': 
		$.get('../app/get_users.htm',function(data){
			 var num = 0;
			 tab.find("#t_thead").empty().append("<th width='20%'>部门</th><th width='20%'>职务</th><th width='20%'>工号</th><th width='20%'>英文名</th><th width='20%'>中文名</th>");
			 var body = tab.find("#t_body").empty();
			 if(data != null) {
				 $.each(data.list, function(i, e){
					 num = i+1;
					 body.append("<tr onclick=select(this,'approved_entrant.htm')><td>" + e.cdepartment + "</td><td>" + e.cposition + "</td><td>" + e.jobNo + "</td><td>" + e.ename + "</td><td>" + e.cname + "</td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 tab.find("#t_foot").empty().append("<tr class='tr_con'><td colspan='5'>共 <b>" + num + "</b> 条记录</td></tr>");
		},'json');
		break;
		
	case 'departure': 
		$.get('../app/get_departures.htm',function(data){
			 var num = 0;
			 tab.find("#t_thead").empty().append("<th width='20%'>部门</th><th width='20%'>职务</th><th width='20%'>工号</th><th width='20%'>英文名</th><th width='20%'>中文名</th>");
			 var body = tab.find("#t_body").empty();
			 if(data != null) {
				 $.each(data.list, function(i, d){
					 num = i+1;
					 body.append("<tr onclick=select(this,'departures.htm')><td>" + d.userDpt + "</td><td>" + d.userPst + "</td><td>" + d.jobNo + "</td><td>" + d.ename + "</td><td>" + d.cname + "</td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 tab.find("#t_foot").empty().append("<tr class='tr_con'><td colspan='5'>共 <b>" + num + "</b> 条记录</td></tr>");
		},'json');
		break;
		
	case 'video': 
		$.get('../app/get_video.htm',function(data){
			 var num = 0;
			 tab.find("#t_thead").empty().append("<th width='20%'>版本</th><th width='20%'>标题</th><th width='20%'>创建日期</th><th width='20%'>上传者</th><th width='20%'>播放</th>");
			 var body = tab.find("#t_body").empty();
			 if(data.video != null) {
				 $.each(data.video, function(i, d){
					 num = i+1;
					 videos[i] = "{url:'../uploads/swf/"+d.attachment+"'}";
					 body.append("<tr><td>" + d.version + "</td><td>" + d.title + "</td><td>" + d.createDate + "</td><td>" + d.uploadEname + "</td><td><a href=javascript:playVideo('"+d.attachment+"');>播放</a></td></tr>");
				 });
				 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
			 }
			 tab.find("#t_foot").empty().append("<tr class='tr_con'><td colspan='5'>共 <b>" + num + "</b> 条记录</td></tr>");
		},'json');
		break;
		
	default:
		alert("no data!");
		break;
	}

};

//点击弹出会议详细
function meetingDetail(title, number, time, host, notes, locale, participants, explain) {
	var dlg = $("#content_main");
	/** 会议基本信息 * */
	dlg.find('#cont,#describe,#describe,#staff,#parti,#explain').empty();
	dlg.find('#cont').prepend("<b>编号：</b>" + number + "<p><b>会议主题</b>：" + title + "<em>时间：" + time + "</em></p>");
	dlg.find('#describe').prepend("<span><b>地点：</b>" + locale + "</span>");
	dlg.find('#staff').prepend("<label>会议主持人/记录人：</label>" + host + " / " + notes + "");
	dlg.find('#parti').prepend("<label>参会人员：</label>" + participants);
	dlg.find('#explain').prepend("<label>说明：</label>" + explain);
	dlg.dialog("open");
}

//点击TR触发radio选中事件
function select(obj, url) {
	$(obj).parent().children('tr').removeClass("ui-state-highlight")
	$(obj).addClass("ui-state-highlight");
	//window.location=url;
}


//点击播放视频文件
function playVideo(attachment) {
	var dlg = $("#play_video");
	dlg.dialog("option", "title", "正在播放");
	
//	var vvs = $.parseJSON(videos);
	
	//检查是否存在此文件，如果有则播放文件，否则提示没有该文件
	$.post('../find_file.htm',{fileName:attachment},function(data){
		if(data.result == "SUCCESS") {
			
			//改变视频
			$("#player").attr("href", "../uploads/swf/" + attachment);
			
			//初始化播放器
			flowplayer("player", "../common/flowplayer.swf", 
					{
					  clip: {
					        // these two configuration variables does the trick
					        autoPlay: false,
					        autoBuffering: true // <- do not place a comma here
					    },
					    
					    //播放列表
						//playlist: vvs,
					
						plugins: { // load one or more plugins
					    	controls: { // load the controls plugin
					    	 
						        //菜单工具条flash
						        url: '../common/flowplayer.controls.swf',
						
						        // now the custom options of the Flash object
						        playlist: false,

						        //backgroundColor: '#aedaff',
						        tooltips: { // this plugin object exposes a 'tooltips' object
						            buttons: true,
						            fullscreen: '点击进入全屏',
						            pause: '点击暂停',
						            play: '点击播放',
						            previous: '上一个',
						            next: '下一个',
						            mute: '静音',
						            unmute: '开启音量'
						        }
					    	}
						},
						//当暂停时执行操作
						onPause: function() { },
						//当完成播放后执行操作
						onFinish: function() { }
					});
			dlg.dialog("open");
		} else alert("文件不存在！");
	},'json');
}

//Google任务操作弹出窗口
var addGoogleTask = function() {
	var dlg = $("#google_task");
	
	//如果没有登录google帐号则弹出登录窗口
	$.post('../app/get_login_google.htm', function(data) {
		if(data.result != "SUCCESS") {
			$('#google_login').dialog("option", "title", "Google帐号登录");
			$('#google_login').dialog('open'); 
		} else {
			dlg.dialog("option", "title", "添加任务");
			dlg.dialog('open');
		}
	}, 'json');
	
};

//如果Google用户没有登录或已经登录操作
var googleLogin = function() {
	var dlg = $("#google_login");
	var email = dlg.find("#email").val();
	var pwd = dlg.find("#pwd").val();
	
	if(isEmpty(email) && isEmpty(pwd)) {alert("请输入Google邮箱和密码"); return false};
	
	$.post('../app/get_login_google.htm', {email:email, pwd:pwd}, function(data) {
		if(data.result == "SUCCESS") {
			alert("登录成功 ");
			dlg.dialog('close');
			$("#google_task").dialog("option", "title", "添加任务");
			$("#google_task").dialog('open');
		} else if(data.result == "FAILED") {
			alert("数据不完整！");
		} else 
			alert("登录操作失败，可能连接网络问题！");
	}, 'json');
};

//操作Google日历任务
var saveCalendar = function () {
	var dlg = $("#google_task");
	
	if (dlg.find('#googleForm').valid()) { 
		$.post('../app/save_calendar.htm', dlg.find('#googleForm').serialize(), function(data) {
			if(data.result == "SUCCESS") {
				alert("操作成功 ");
				dlg.dialog('close');
			} else if(data.result == "FAILED") {
				alert("数据不完整");
			} else 
				alert("操作失败");
		}, 'json');
	}
};

//主页面加载会议和今日需要做内容
function index_task() {
	$.get('../app/get_meetings.htm',{pid:''},function(data){
		 var thead = $("#t_meeting").find("#t_body").empty();
		 var me = "";
		 if(data != null) {
			 $.each(data.list, function(i, m){
				 me += m.time.split(" ")[0] + " 请:" + m.participants + " 于: " + m.time.split(" ")[1] + " 到：" + m.locale + " 参加会议;<br/>" + " 会议主题：" + m.title + "<br/> 说明：" + m.explain + "<hr />";
			 });
			 thead.append("<th width='100%'><marquee onmouseover='this.stop();' onmouseout='this.start();' direction='up' behavior='scroll' scrolldelay='30' scrollamount='3' width='100%' height='380' ><div id='logs_main'>" + me + "</div></marquee></th>");
		 }
	}, 'json');
	
	$.get('../app/get_tasks.htm',{state:'InProgress'},function(data){
		 var num = 0;
		 var t_task = $("#t_task");
		 t_task.find("#t_thead").empty().append("<tr><th width='100%' colspan='4'><b style='float:left;color:blue'>今日需要做</b></th></tr>").append("<tr><th width='20%'>开始</th><th width='20%'>结束</th><th width='20%'>工时(pt.)</th><th width='40%'>主旨</th></tr>");
		 var body = t_task.find("#t_body").empty();
		 if(data != null) {
			 $.each(data.list, function(i, t){
				 num = i+1;
				 $("#t_task").append("<tr onclick=select(this,'my_task.htm')><td>" + t.expectedStart.split(" ")[1] + "</td><td>" + t.expectedEnd.split(" ")[1] + "</td><td>" + t.expectedHours + "</td><td>" + t.taskTitle + "</td></tr>");
			 });
			 body.find("tr").hover(function(){$(this).addClass("choose");},function (){$(this).removeClass("choose");});
		 }
		 t_task.find("#t_foot").empty().append("<tr class='tr_con'><td colspan='4'>共 <b>" + num + "</b> 条记录</td></tr>");
	},'json');
}

var f = function(url, params, thead, tfoot) {
	$.get('../app/get_users.htm',function(data){
		 var num = 0;
		 tab.find("#t_thead").empty().append("<th width='20%'>部门</th><th width='20%'>职务</th><th width='20%'>工号</th><th width='20%'>英文名</th><th width='20%'>中文名</th>");
		 var body = tab.find("#t_body").empty();
		 if(data != null) {
			 $.each(data.list, function(i, t){
				 num = i+1;
				 body.append("<tr class='tr_con'><td>" + e.cdepartment + "</td><td>" + e.cposition + "</td><td>" + e.jobNo + "</td><td>" + e.ename + "</td><td>" + e.cname + "</td></tr>");
			 });
		 }
		 tab.find("#t_foot").empty().append("<tr class='tr_con'><td colspan='4'>共 <b>" + num + "</b> 条记录</td></tr>");
	},'json');
};


//生成日历
var lunarInfo = new Array(
0x04bd8,0x04ae0,0x0a570,0x054d5,0x0d260,0x0d950,0x16554,0x056a0,0x09ad0,0x055d2,
0x04ae0,0x0a5b6,0x0a4d0,0x0d250,0x1d255,0x0b540,0x0d6a0,0x0ada2,0x095b0,0x14977,
0x04970,0x0a4b0,0x0b4b5,0x06a50,0x06d40,0x1ab54,0x02b60,0x09570,0x052f2,0x04970,
0x06566,0x0d4a0,0x0ea50,0x06e95,0x05ad0,0x02b60,0x186e3,0x092e0,0x1c8d7,0x0c950,
0x0d4a0,0x1d8a6,0x0b550,0x056a0,0x1a5b4,0x025d0,0x092d0,0x0d2b2,0x0a950,0x0b557,
0x06ca0,0x0b550,0x15355,0x04da0,0x0a5b0,0x14573,0x052b0,0x0a9a8,0x0e950,0x06aa0,
0x0aea6,0x0ab50,0x04b60,0x0aae4,0x0a570,0x05260,0x0f263,0x0d950,0x05b57,0x056a0,
0x096d0,0x04dd5,0x04ad0,0x0a4d0,0x0d4d4,0x0d250,0x0d558,0x0b540,0x0b6a0,0x195a6,
0x095b0,0x049b0,0x0a974,0x0a4b0,0x0b27a,0x06a50,0x06d40,0x0af46,0x0ab60,0x09570,
0x04af5,0x04970,0x064b0,0x074a3,0x0ea50,0x06b58,0x055c0,0x0ab60,0x096d5,0x092e0,
0x0c960,0x0d954,0x0d4a0,0x0da50,0x07552,0x056a0,0x0abb7,0x025d0,0x092d0,0x0cab5,
0x0a950,0x0b4a0,0x0baa4,0x0ad50,0x055d9,0x04ba0,0x0a5b0,0x15176,0x052b0,0x0a930,
0x07954,0x06aa0,0x0ad50,0x05b52,0x04b60,0x0a6e6,0x0a4e0,0x0d260,0x0ea65,0x0d530,
0x05aa0,0x076a3,0x096d0,0x04bd7,0x04ad0,0x0a4d0,0x1d0b6,0x0d250,0x0d520,0x0dd45,
0x0b5a0,0x056d0,0x055b2,0x049b0,0x0a577,0x0a4b0,0x0aa50,0x1b255,0x06d20,0x0ada0,
0x14b63);

var solarMonth = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
var Gan = new Array("甲","乙","丙","丁","戊","己","庚","辛","壬","癸");
var Zhi = new Array("子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥");
var Animals = new Array("鼠","牛","虎","兔","龙","蛇","马","羊","猴","鸡","狗","猪");
var solarTerm = new Array("小寒","大寒","立春","雨水","惊蛰","春分","清明","谷雨","立夏","小满","芒种","夏至","小暑","大暑","立秋","处暑","白露","秋分","寒露","霜降","立冬","小雪","大雪","冬至")
var sTermInfo = new Array(0,21208,42467,63836,85337,107014,128867,150921,173149,195551,218072,240693,263343,285989,308563,331033,353350,375494,397447,419210,440795,462224,483532,504758)
var nStr1 = new Array('日','一','二','三','四','五','六','七','八','九','十')
var nStr2 = new Array('初','十','廿','卅','　')
var monthName = new Array("JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC");

//国历节日 *表示放假日
var sFtv = new Array(
"0101*元旦",
"0214 情人节",
"0308 妇女节",
"0312 植树节",
"0315 消费者权益日",
"0401 愚人节",
"0501*劳动节",
"0504 青年节",
"0512 护士节",
"0601 儿童节",
"0701 建党节 香港回归纪念",
"0714 初伏",
"0724 中伏",
"0801 建军节",
"0813 末伏",
"0909 毛泽东逝世纪念",
"0910 教师节",
"0928 孔子诞辰",
"1001*国庆节",
"1024 联合国日",
"1112 孙中山诞辰纪念",
"1220 澳门回归纪念",
"1225 圣诞节",
"1226 毛泽东诞辰纪念")

//农历节日 *表示放假日
var lFtv = new Array(
"0101*春节",
"0102*初二",
"0115 元宵节",
"0505*端午节",
"0707 七夕情人节",
"0715 中元节",
"0815*中秋节",
"0909 重阳节",
"1208 腊八节",
"1223 小年",
"0100*除夕")

var wFtv = new Array(
"0520 母亲节", "0630 父亲节")

function lYearDays(y) {
   var i, sum = 348
   for(i=0x8000; i>0x8; i>>=1) sum += (lunarInfo[y-1900] & i)? 1: 0
   return(sum+leapDays(y))
}

function leapDays(y) {
   if(leapMonth(y))  return((lunarInfo[y-1900] & 0x10000)? 30: 29)
   else return(0)
}

function leapMonth(y) {
   return(lunarInfo[y-1900] & 0xf)
}

function monthDays(y,m) {
   return( (lunarInfo[y-1900] & (0x10000>>m))? 30: 29 )
}

function Lunar(objDate) {

   var i, leap=0, temp=0
   var baseDate = new Date(1900,0,31)
   var offset   = (objDate - baseDate)/86400000

   this.dayCyl = offset + 40
   this.monCyl = 14

   for(i=1900; i<2050 && offset>0; i++) {
      temp = lYearDays(i)
      offset -= temp
      this.monCyl += 12
   }

   if(offset<0) {
      offset += temp;
      i--;
      this.monCyl -= 12
   }

   this.year = i
   this.yearCyl = i-1864

   leap = leapMonth(i)
   this.isLeap = false

   for(i=1; i<13 && offset>0; i++) {
      if(leap>0 && i==(leap+1) && this.isLeap==false)
         { --i; this.isLeap = true; temp = leapDays(this.year); }
      else
         { temp = monthDays(this.year, i); }

      if(this.isLeap==true && i==(leap+1)) this.isLeap = false

      offset -= temp
      if(this.isLeap == false) this.monCyl ++
   }

   if(offset==0 && leap>0 && i==leap+1)
      if(this.isLeap)
         { this.isLeap = false; }
      else
         { this.isLeap = true; --i; --this.monCyl;}

   if(offset<0){ offset += temp; --i; --this.monCyl; }

   this.month = i
   this.day = offset + 1
}

function solarDays(y,m) {
   if(m==1)
      return(((y%4 == 0) && (y%100 != 0) || (y%400 == 0))? 29: 28)
   else
      return(solarMonth[m])
}
function cyclical(num) {
   return(Gan[num%10]+Zhi[num%12])
}

function calElement(sYear,sMonth,sDay,week,lYear,lMonth,lDay,isLeap,cYear,cMonth,cDay) {

      this.isToday    = false;
      this.sYear      = sYear;
      this.sMonth     = sMonth;
      this.sDay       = sDay;
      this.week       = week;
      this.lYear      = lYear;
      this.lMonth     = lMonth;
      this.lDay       = lDay;
      this.isLeap     = isLeap;
      this.cYear      = cYear;
      this.cMonth     = cMonth;
      this.cDay       = cDay;

      this.color      = '';

      this.lunarFestival = '';
      this.solarFestival = '';
      this.solarTerms    = '';

}

function sTerm(y,n) {
   var offDate = new Date( ( 31556925974.7*(y-1900) + sTermInfo[n]*60000  ) + Date.UTC(1900,0,6,2,5) )
   return(offDate.getUTCDate())
}

function calendar(y,m) {
	
   var sDObj, lDObj, lY, lM, lD=1, lL, lX=0, tmp1, tmp2
   var lDPOS = new Array(3)
   var n = 0
   var firstLM = 0

   sDObj = new Date(y,m,1)

   this.length    = solarDays(y,m)
   this.firstWeek = sDObj.getDay()

//alert(this.firstWeek);alert(this.length);
   for(var i=0;i<this.length;i++) {

      if(lD>lX) {
         sDObj = new Date(y,m,i+1)
         lDObj = new Lunar(sDObj)
         lY    = lDObj.year
         lM    = lDObj.month
         lD    = lDObj.day
         lL    = lDObj.isLeap
         lX    = lL? leapDays(lY): monthDays(lY,lM)

         if(n==0) firstLM = lM
         lDPOS[n++] = i-lD+1
      }

      this[i] = new calElement(y, m+1, i+1, nStr1[(i+this.firstWeek)%7],
                               lY, lM, lD++, lL,
                               cyclical(lDObj.yearCyl) ,cyclical(lDObj.monCyl), cyclical(lDObj.dayCyl++) )

//	 if((i+this.firstWeek)%14==7)   this[i].color = "green";//'#FF5F07'
      if((i+this.firstWeek)%7==0)   this[i].color = "#FF5F08";//'#FF5F07'	 
      if((i+this.firstWeek)%14==6) {this[i].color = "green";}//'#FF5F07'
      if((i+this.firstWeek)%14==13) {this[i].color = "#FF5F08";}//'#FF5F07'
   }

   tmp1=sTerm(y,m*2  )-1
   tmp2=sTerm(y,m*2+1)-1
   this[tmp1].solarTerms = solarTerm[m*2]
   this[tmp2].solarTerms = solarTerm[m*2+1]
   if(m==3) {this[tmp1].color = "#FF5F08";}//清明节

   for(i in sFtv)
      if(sFtv[i].match(/^(\d{2})(\d{2})([\s\*])(.+)$/))
         if(Number(RegExp.$1)==(m+1)) {
			var fes = isLeg(RegExp.$4, y);
			if(fes == "") continue;
            this[Number(RegExp.$2)-1].solarFestival += fes + ' '
            if(RegExp.$3=='*') this[Number(RegExp.$2)-1].color = '#FF5F08'
         }

   for(i in wFtv)
      if(wFtv[i].match(/^(\d{2})(\d)(\d)([\s\*])(.+)$/))
         if(Number(RegExp.$1)==(m+1)) {
            tmp1=Number(RegExp.$2)
            tmp2=Number(RegExp.$3)
            this[((this.firstWeek>tmp2)?7:0) + 7*(tmp1-1) + tmp2 - this.firstWeek].solarFestival += RegExp.$5 + ' '
         }

   for(i in lFtv)
   
      if(lFtv[i].match(/^(\d{2})(.{2})([\s\*])(.+)$/)) {
         tmp1=Number(RegExp.$1)-firstLM
         if(tmp1==-11) tmp1=1
         if(tmp1 >=0 && tmp1<n) {
            tmp2 = lDPOS[tmp1] + Number(RegExp.$2) -1
            if( tmp2 >= 0 && tmp2<this.length && this[tmp2].isLeap!=true) {
               this[tmp2].lunarFestival += RegExp.$4 + ' '
               if(RegExp.$3=='*'){
					this[tmp2].color = '#FF5F08'
				}
            }
         }
      }
		

	  

   /*if((this.firstWeek+12)%7==5)
      this[12].solarFestival += '黑色星期五 '*/
	  
   if(y==tY && m==tM) {
   		this[tD-1].isToday = true;
   }

}

function cDay(d){
   var s;

   switch (d) {
      case 10:
         s = '初十'; break;
      case 20:
         s = '二十'; break;
         break;
      case 30:
         s = '三十'; break;
         break;
      default :
         s = nStr2[Math.floor(d/10)];
         s += nStr1[d%10];
   }
   return(s);
}

var cld;

function drawCld(SY,SM) {
   var i,sD,s,size;
   cld = new calendar(SY,SM);
	if(SY == "undefined")debugger;
//   if(SY>1874 && SY<1909) yDisplay = '光绪' + (((SY-1874)==1)?'元':SY-1874)
//   if(SY>1908 && SY<1912) yDisplay = '宣统' + (((SY-1908)==1)?'元':SY-1908)
//   if(SY>1911 && SY<1950) yDisplay = '民国' + (((SY-1911)==1)?'元':SY-1911)
//   if(SY>1949) yDisplay = '共和国' + (((SY-1949)==1)?'元':SY-1949)

   GZ.innerHTML = '&nbsp;&nbsp;农历' + cyclical(SY-1900+36) + '年 &nbsp;<span class=smlb>&nbsp;【</spzn><span class=smlb>'+Animals[(SY-4)%12]+'</span><span class=smlb>】</span>';

   //YMBG.innerHTML = "&nbsp;" + SY + "<BR>&nbsp;" + monthName[SM];


   for(i=0;i<42;i++) {

      //sObj=$('SD'+ i);
      //lObj=$('LD'+ i);
      
      sObj = document.getElementById("SD" + i);
      lObj = document.getElementById("LD" + i);

      sObj.style.background = '';
      lObj.style.background = '';

      sD = i - cld.firstWeek;
	  if(sD == "undefined" || sD == undefined) debugger;
	  
      if(sD>-1 && sD<cld.length) {
         sObj.innerHTML = sD+1;
if(sObj.innerHTML == "undefined" || sObj.innerHTML == undefined || sObj.innerHTML.indexOf("und") != -1) {
			debugger;
		}
         if(cld[sD].isToday){
         		sObj.style.background = '#DEFDFD';
         		lObj.style.background = '#91DAE3';
         }

         sObj.style.color = cld[sD].color;

         if(cld[sD].lDay==1)
            lObj.innerHTML = '<b>'+(cld[sD].isLeap?'闰':'') + cld[sD].lMonth + '月' + (monthDays(cld[sD].lYear,cld[sD].lMonth)==29?'小':'大')+'</b>';
         else
            lObj.innerHTML = cDay(cld[sD].lDay);

         s=cld[sD].lunarFestival;
         if(s.length>0) {
            if(s.length>5) s = s.substr(0, 3)+'…';
            s  = "<span style='color:#FF5F07'>"+s+"</span>";//s.fontcolor('blue');s.fontcolor('FF5F07');
         }else {
            s=cld[sD].solarFestival;
            if(s.length>0) {
               size = (s.charCodeAt(0)>0 && s.charCodeAt(0)<128)?8:4;
               if(s.length>size+1) s = s.substr(0, size-1)+'…';
               s = "<span style='color:blue'>"+s+"</span>";//s.fontcolor('0168EA');
            }
            else {
               s=cld[sD].solarTerms;
               if(s.length>0) s = s = "<span style='color:green'>"+s+"</span>";//s.fontcolor('44D7CF');
            }
         }
         if(s.length>0) lObj.innerHTML = s;

      }
      else {
         sObj.innerHTML = ' ';
         lObj.innerHTML = ' ';
      }
	
   }
	var sss = "";

}

function changeCld() {
   var y,m;
   y = CLD.SY.selectedIndex+1900;
   m = CLD.SM.selectedIndex;
   drawCld(y,m);
}

function pushBtm(K) {
   switch (K){
      case 'YU' :
         if(CLD.SY.selectedIndex>0) CLD.SY.selectedIndex--;
         break;
      case 'YD' :
         if(CLD.SY.selectedIndex<149) CLD.SY.selectedIndex++;
         break;
      case 'MU' :
         if(CLD.SM.selectedIndex>0) {
            CLD.SM.selectedIndex--;
         }
         else {
            CLD.SM.selectedIndex=11;
            if(CLD.SY.selectedIndex>0) CLD.SY.selectedIndex--;
         }
         break;
      case 'MD' :
         if(CLD.SM.selectedIndex<11) {
            CLD.SM.selectedIndex++;
         }
         else {
            CLD.SM.selectedIndex=0;
            if(CLD.SY.selectedIndex<149) CLD.SY.selectedIndex++;
         }
         break;
      default :
         CLD.SY.selectedIndex=tY-1900;
         CLD.SM.selectedIndex=tM;
   }
   changeCld();
}

var Today = new Date();
var tY = Today.getFullYear();
var tM = Today.getMonth();
var tD = Today.getDate();

var width = "130";
var offsetx = -256;
var offsety = -105;
if(!document.all)offsety = -10;
var x = 0;
var y = 0;
var snow = 0;
var sw = 0;
var cnt = 0;

var dStyle;
document.onmousemove = mEvn;

// function $(sId){
// 	return document.getElementById(sId);
// }

function mOvr(event, v) {
   var s,festival;
   //var sObj=$('SD'+ v);
   var sObj = document.getElementById('SD'+ v);
   var d=sObj.innerHTML-1;

   if(sObj.innerHTML!='' && d>=0) {
      sObj.style.cursor = 'pointer';
     
      if(cld[d].solarTerms == '' && cld[d].solarFestival == '' && cld[d].lunarFestival == '') {
    	  festival = ''; 
      }
      else {
    	  festival = '<div style="width:130px;background-color:#0978A6;"><b><font style="font-SIZE:12px; color:#FFF">'+cld[d].solarTerms + ' ' + cld[d].solarFestival + ' ' + cld[d].lunarFestival+'</font></b></div>'; 
      }

      x = fPointerX(event);
		y = fPointerY(event);
		if (snow == 0) {
			dStyle.left = x + offsetx + "px";
			dStyle.top	= y + offsety + "px";
			dStyle.visibility = "visible";
			snow = 1;
		}
		
      s= '<div style="width:130px;background-color:#DCEDF5;position:absolute;z-index:2">' +
      '<font COLOR="#000000" STYLE="font-size:12px;">'+cld[d].sYear+' 年 '+cld[d].sMonth+' 月 '+cld[d].sDay+' 日<br>星期'+cld[d].week+'<br>'+
      '<font color="02346F">农历'+(cld[d].isLeap?'闰 ':' ')+cld[d].lMonth+' 月 '+cld[d].lDay+' 日</font><br>'+
      '<font color="02346F">'+cld[d].cYear+'年 '+cld[d].cMonth+'月 '+cld[d].cDay + '日</font>'+
      '</font>'+ festival +'</div>';
      
      //$("detail").innerHTML = s;
		document.getElementById("detail").innerHTML = s;
		
		
	}
}

function mOut(event) {
	if ( cnt >= 1 ) { sw = 0 }
	if ( sw == 0 ) { snow = 0;	dStyle.visibility = "hidden";}
	else cnt++;
}

function mEvn(e) {
	var event = window.event || e;
	x = fPointerX(event);
	y = fPointerY(event);
	if (snow){
		dStyle.left = x + offsetx + "px";
		dStyle.top	= y + offsety + "px";
	}
}


function fPointerX(event) {
	var doc = document;
    return event.pageX || (event.clientX +
      (doc.documentElement.scrollLeft || doc.body.scrollLeft));
}


function fPointerY(event) {
	var doc = document;
    return event.pageY || (event.clientY +
      (doc.documentElement.scrollTop || doc.body.scrollTop));
}

function changeTZ() {
   CITY.innerHTML = CLD.TZ.value.substr(6);
   setCookie("TZ",CLD.TZ.selectedIndex);
}

function setCookie(name, value) {
	var today = new Date()
	var expires = new Date()
	expires.setTime(today.getTime() + 1000*60*60*24*365)
	document.cookie = name + "=" + escape(value)	+ "; expires=" + expires.toGMTString()
}

function getCookie(Name) {
   var search = Name + "="
   if(document.cookie.length > 0) {
      offset = document.cookie.indexOf(search)
      if(offset != -1) {
         offset += search.length
         end = document.cookie.indexOf(";", offset)
         if(end == -1) end = document.cookie.length
         return unescape(document.cookie.substring(offset, end))
      }
      else return ""
   }
}

var CLD;
var GZ;
function initial() {
	addCal();
   //CLD = $("CLD");
   //GZ = $("GZ");
   CLD = document.getElementById("CLD");
   GZ = document.getElementById("GZ");
   
   //dStyle = $("detail").style;
   
   dStyle = document.getElementById("detail").style;
   
   CLD.SY.selectedIndex=tY-1900;
   CLD.SM.selectedIndex=tM;
   if(!document.all){
		offsety = -160;
   }
   drawCld(tY,tM);
}
function isLeg(fes, y){
	y = y - 0;
	switch(fes){
		case "元旦":
			if(y>1911 && y<1950){
				
			}else if(y>1949){
				fes = "新年";
			}else{
				fes = "";
			}
			break;
		case "情人节":
			break;		
		case "妇女节":
			if(y<1911) fes = "";
			break;
		case "植树节":
			if(y<1979) fes = "";
			break;
		case "消费者权益日":
			if(y<1988) fes = "";
			break;
		case "愚人节":
			if(y<1564) fes = "";
			break;
		case "劳动节":
			if(y<1890) fes = "";
			break;
		case "青年节":
			if(y<1950) fes = "";
			break;
		case "护士节":
			if(y<1912) fes = "";
			break;
		case "儿童节":
			break;
		case "建党节 香港回归纪念":
			if(y<1911) fes = "";
			else if(y>1920 && y<1997) fes = "建党节";
			else fes = "中共建党纪念日/香港回归纪念日";
			break;
		case "建军节":
			break;
		case "父亲节":
			break;
		case "毛泽东逝世纪念":
			if(y<1976) fes = "";
			break;
		case "教师节":
			if(y<1985) fes = "";
			break;
		case "孔子诞辰":
			break;
		case "国庆节":
			if(y<1949) fes = "";
			break;
		case "联合国日":
			if(y<1945) fes = "";
			break;
		case "孙中山诞辰纪念":
			if(y<1966) fes = "";
			break;
		case "澳门回归纪念":
			if(y<1999) fes = "";
			break;
		case "初伏":
			if(y!=2009) fes = "";
			break;
		case "中伏":
			if(y!=2009) fes = "";
			break;
		case "末伏":
			if(y!=2009) fes = "";
			break;
		case "圣诞节":
			break;
		case "毛泽东诞辰纪念":
			if(y<1893) fes = "";
			break;
	}
	return fes;
}

//加载日历
function addCal() {
	var gNum;
	var str = "";
	for(i=0;i<6;i++) {
		str+=' <tr> ';
	   for(j=0;j<7;j++) {
		  gNum = i*7+j;
		  str+='<td class="cal_day_NO" id="SD' + gNum +'" onMouseOver="mOvr(event, ' + gNum +')" onMouseOut="mOut(event)" width="57" style="BACKGROUND: none transparent scroll repeat 0% 0%; cursor : default; COLOR: #ff5f08" TITLE="";';
		  if(j == 0){
				str+=' class="aorange"';
		  }else if(j == 6){
			 if(i%2==1) str+=' class="aorange"';
			 else str+=' class="agreen"';
		  }else{
			str+=' class="one"';
		  }
		  str+=' TITLE=""> </td>';
	   }
	   str+='</tr><tr><td colspan="7" style="line-height:1px;">&nbsp;</td></tr><tr> ';
	   for(j=0;j<7;j++) {
		  gNum = i*7+j;
		  str+='<td class="cal_day_jr" id="LD' + gNum +'" onMouseOver="mOvr(event,' + gNum +')" onMouseOut="mOut()" width="57" class="bs" TITLE="" style="BACKGROUND: none transparent scroll repeat 0% 0%; cursor : default; COLOR: #666666"> </td>';
	   }
	   str+='</tr><tr><td colspan="7" style="line-height:3px;">&nbsp;</td></tr>';
	}
	//document.getElementById("caid").innerHTML="aa";
	$("#caid").html(str);
}