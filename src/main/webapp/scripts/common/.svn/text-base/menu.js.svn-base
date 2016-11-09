//var setting = {data:{key:{title:"t"},simpleData:{enable:true}}};

//全局JS国际化
$(function(){lang = $("#locale").val();});

var setting = {
		data: {
			simpleData:{enable:true}
		}, 
		view: {
			showLine:true, 
			dblClickExpand:true
		},
		async: {
			enable: true,
			url:"../get_left_tree.htm",
			autoParam:["id", "name=n",  "level=lv"],
			otherParam:{"otherParam":"noParam"},
			dataFilter: filter
		}
};

function filter(treeId, parentNode, childNodes) {
	if (!childNodes) return null;
	for (var i=0, l=childNodes.length; i<l; i++) {
		childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
	}
	return childNodes;
}

var zNodes =[{id:1, pId:0, name:"组管理", t:"System of Group Manager",open:true},{id:11, pId:1, name:"部门",t:"maintain Deparment", "url":"group.htm","target":"_self"},{id:12, pId:1, name:"职务", t:"maintain Position","url":"position.htm","target":"_self"},{id:13, pId:1, name:"角色", t:"maintain Role","url":"role.htm","target":"_self"},{id:2, pId:0, name:"用户管理", t:"manager the system user", "url":"user.htm","target":"_self"},{id:3, pId:0, name:"系统配置", t:"config the system parameter", open:true},{id:31, pId:3, name:"系统参数",t:"init paramter of system", "url":"config.htm","target":"_self"}];

var app_tree = [
{id:1, pId:0, name:"任务中心", t:"task center of user",open:true},
  {id:11, pId:1, name:"待批请假",t:"the leave waitting for approve", "url":"leaves.htm","target":"_self"},
  {id:12, pId:1, name:"入职审核", t:"审核新入职员工资料","url":"entrants.htm","target":"_self"},
  {id:13, pId:1, name:"开设邮箱", t:"为新员工开设邮箱","url":"entrant_mail.htm","target":"_self"},
  {id:14, pId:1, name:"分配职责", t:"为新职员分配职责","url":"responsibilities.htm","target":"_self"},
  {id:15, pId:1, name:"流程管理",t:"The process manage", "url":"process.htm","target":"_self"},
  {id:16, pId:1, name:"责任管理", t:"员工责任管理","url":"mgr_responsibility.html","target":"_self"},
  {id:17, pId:1, name:"我的职责", t:"user responsibility","url":"responsibility.html","target":"_self"},
  {id:18, pId:1, name:"责任调整", t:"user responsibility","url":"respon_config.htm","target":"_self"},
{id:2, pId:0, name:"私人秘书", t:"personal secretary",open:true},
  {id:21, pId:2, name:"请假", t:"user leave",open:true},
    {id:211, pId:21, name:"申请", t:"user for leave","url":"leave.htm","target":"_self"},
    {id:212, pId:21, name:"回执", t:"receipt for leave","url":"get_leave.htm","target":"_self"},
    {id:213, pId:21, name:"记录", t:"receipt for leave","url":"get_leave_record.html","target":"_self"},
  {id:22, pId:2, name:"离职", t:"user departure",open:true},
    {id:221, pId:22, name:"申请", t:"user for departure","url":"departure.htm","target":"_self"},
	{id:222, pId:22, name:"回执", t:"user for departure","url":"get_departure.htm","target":"_self"},
	{id:223, pId:22, name:"离职审核", t:"user for departure","url":"departures.htm","target":"_self"},
  {id:23, pId:2, name:"个人资料", t:"update user information"},
    {id:231, pId:23, name:"基本信息", t:"user basic information","url":"edit_user.htm","target":"_self"},
	{id:232, pId:23, name:"教育经历", t:"Education for user","url":"education.html","target":"_self"},
	{id:233, pId:23, name:"联络地址", t:"list of address for user","url":"address.html","target":"_self"},
	{id:234, pId:23, name:"修改密码", t:"update user password","url":"update_pwd.html","target":"_self"},
{id:3, pId:0, name:"工作管理", t:"WorkTask management",open:true},
	{id:31, pId:3, name:"工作任务", t:"Work Task","url":"get_task.html","target":"_self"},
	{id:32, pId:3, name:"工作命令", t:"Task Distribution","url":"workorder.html","target":"_self"},
	{id:33, pId:3, name:"追踪执行", t:"Monitoring the implementation","url":"approval_task.html","target":"_self"},
	{id:34, pId:3, name:"我的任务", t:"My Task","url":"get_usertask.html","target":"_self"},
	{id:35, pId:3, name:"固定工作", t:"Fixed Task","url":"fixed_task.htm","target":"_self"},
{id:4, pId:0, name:"资产管理", t:"Asset Management",open:true},	
	{id:41, pId:4, name:"产品", t:"Product","url":"get_products.html","target":"_self"},
	{id:42, pId:4, name:"项目", t:"Project","url":"get_projects.html","target":"_self"}

];
//判断字符是否以sub_str结尾，如果是则返回true，反之false
function endWith(str, sub_str){
 if(str == null || sub_str == null) return false;
 if(str.length < sub_str.length) return false;
 else if(str == sub_str) return true;
 else if(str.substring(str.length-sub_str.length) == sub_str) return true;
 else return false;
}
/**
* 将一组对象转换成Json数组
* list  接受Jquery $('form').serializeArray() 的数组形式
* num  每组对象有几个属性
* return 返回转换好的JSON对象数组
*/
function toJson(list, num) {
	var params="[{";
	var j=0;
	$.each(list, function(i, field){
		j++;
		if(field.name != "undefined" && field.name != "" && field.name != "userSubmit"){
			if(i>0 && i%num==0) params+="},{"+field.name+":'"+field.value+"',";
			else {if(j%num==0) params+=field.name+":'"+field.value + "'";else params+=field.name+":'"+field.value + "',";}
		}
	});
	return params+="}]";
}
/**
* 查询指定部门的管理层人员
* choice 要追加的select对象
* obj 指定部门对象，且部门为ID
*/
function getMgrs(choice, obj) {
	if($(obj).val()){
		$.post('../dpt_users.htm',{'dpt':$(obj).val(),'type':'POSITION','ismgr':true},function(data){
			var option = "";
			$.each(data, function(i,val){option += "<option value='" + val.ename + "'>" + val.ename + "</option>";});
			$(choice).empty().append(option);
		},'json');
	}
}
/**
* 查询所在部门的所有职员
* choice 要追加的select对象
* obj 指定部门对象，且部门为ID
*/
function getUsers(choice,obj) {
	if($(obj).val()){
		$(choice).empty();
		$.post('../dpt_users.htm',{'dpt':$(obj).val(),'type':'DEPARTMENT','ismgr':false},function(data){
			$.each(data, function(i,val){$(choice).append("<option value='" + val.ename + "'>" + val.ename + "</option>");});
		},'json');
	}
}

/**
* 查询所有部门清单
* choice 要追加的select对象
*/
function getDpts(choice) {
  $.post('../departments.htm',function(data){
	  var dpt ="<option value=''>-选择部门-</option>";
	  $.each(data, function(i,val){dpt += "<option value='" + val.id + "'>" + val.cname + "</option>";});
	  $(choice).empty().append(dpt);
  },'json');
}

/** 选择产品product显示下拉框 */
function getProducts(choice) {
  $.get('get_product.htm',function(data){
    var product = choice.empty().append("<option value=''>请选择产品</option>");
	$.each(data, function(i,val){product.append("<option value='" + val.id + "'>" + val.productName + "</option>");});
  },'json');
}
/** 选择项目project显示下拉框 */
function getProjects(choice, parentId) {
  $.get('get_project.htm',{pid:parentId},function(data){
	  var project = "<option value=''>选择项目</option>";
	  $.each(data, function(i,val){project+="<option value='" + val.id + "'>" + val.projectName + "</option>";});
	  $(choice).empty().append(project);
  },'json');
}
//计算比重总计
function countExpect(arr) {var sum = 0; $.each(arr, function(i, field){if(/^\+?[0-9]*$/.test(field.value)) sum = sum + Number(field.value);}); return sum;}
//婚姻状况
function fmtMarital(cellvalue, options, rowObject){var tmp;if(cellvalue=="SINGLE") tmp="未婚";else if(cellvalue=="MARRIED") tmp="已婚";else if(cellvalue=="DIVOCED") tmp="离异";else if(cellvalue=="WIDOWED") tmp="丧偶";else if(cellvalue=="SEPARATED") tmp="分居";return tmp;}
//户籍类型
function censusType(cellvalue, options, rowObject){var tmp;if(cellvalue=="COUNTRYSIDE") tmp="农村";else if(cellvalue=="TOWN") tmp="城镇";else if(cellvalue=="GANGAOTAIBAO") tmp="港澳台胞";else if(cellvalue=="FOREIGNER") tmp="外籍"; return tmp;}
//性别
function genderType(cellvalue, options, rowObject){var tmp;if(cellvalue=="M") tmp="先生";else if(cellvalue=="F") tmp="女士";return tmp;}
//判断是否为空,如果是返回true，反之false
function isEmpty(str){if (str == "") return true; var reg = /^[ ]+$/; return reg.test(str);}
//假期类型
function leaveType(cellvalue, options, rowObject){ var tmp; if(cellvalue=="CASUAL") tmp="事假"; else if(cellvalue=="SICK") tmp="病假"; else if(cellvalue=="LEAVE_IN_LIEU") tmp="调休"; else if(cellvalue=="ANNUAL") tmp="年假"; else if(cellvalue=="MARRIAGE") tmp="婚假"; else if(cellvalue=="MATERNITY") tmp="产假"; else if(cellvalue=="BEREAVEMENT") tmp="丧假"; return tmp;}
//地址类型
function addrType(cellvalue, options, rowObject){var tmp; if(cellvalue=="PRESENT") tmp="现居住址"; else if(cellvalue=="FAMILY") tmp="家庭住址"; else if(cellvalue=="S_P_F") tmp="家庭与现居同一"; else if(cellvalue=="CENSUS") tmp="户籍地址"; else if(cellvalue=="EMERGENCY") tmp="紧急联络"; else if(cellvalue=="S_C_P") tmp="户籍与现居同一"; else if(cellvalue=="S_C_F") tmp="户籍与家庭同一"; else if(cellvalue=="C_P_F") tmp="户籍现居家庭同一"; return tmp;}
//雇员类型
function employeeType(cellvalue, options, rowObject){var tmp; if(cellvalue=="FIELDWORK") tmp="实习"; else if(cellvalue=="TRAINING_PERIOD") tmp="试用期"; else if(cellvalue=="QUALIFIED") tmp="正式员工"; return tmp;}
//周期类型
function frequencyPeriod(cellvalue, options, rowObject){var tmp; if(cellvalue=="DAY") tmp="日"; else if(cellvalue=="WEEK") tmp="周"; else if(cellvalue=="MONTH") tmp="月"; return tmp;}
/**
*计算责任百分比
*@parent 父责任比重
*@parent 子责任比重
*/
function getPercent(parent, child) {parent = parseFloat(parent); child = parseFloat(child); if(isNaN(parent) || isNaN(child)){return "-"; } return child <= 0 ? "0":(Math.round(parent*child)/100.00);} 