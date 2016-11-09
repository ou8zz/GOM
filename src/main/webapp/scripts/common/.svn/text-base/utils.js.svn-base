function leaveType(cellvalue, options, rowObject){
	var tmp;
	if(cellvalue=="CASUAL") tmp="事假";
	else if(cellvalue=="SICK") tmp="病假";
	else if(cellvalue=="LEAVE_IN_LIEU") tmp="调休";
	else if(cellvalue=="ANNUAL") tmp="年假";
	else if(cellvalue=="MARRIAGE") tmp="婚假";
	else if(cellvalue=="MATERNITY") tmp="产假";
	else if(cellvalue=="BEREAVEMENT") tmp="丧假";
	return tmp;
}

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
function getProjects(choice) {
  $.get('get_project.htm',{parent:true},function(data){
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
function frequencyPeriod(cellvalue, options, rowObject){var tmp; if(cellvalue=="DAY") tmp="日"; else if(cellvalue=="WEEK") tmp="周"; else if(cellvalue=="MONTH") tmp="月"; else if(cellvalue=="QUARTER") tmp="季度"; else if(cellvalue=="YEAR") tmp="年"; return tmp;}
//分配类型grid格式化
function assignTypefmt(cellvalue, options, rowObject){var tmp;if(cellvalue=="PERSON") tmp="个人";else if(cellvalue=="DEPARTMENT") tmp="部门";return tmp;}
//工作类型grid格式化
function taskTypefmt(cellvalue, options, rowObject){var tmp;if(cellvalue=="REGULAR") tmp="固定";else if(cellvalue=="PLAN") tmp="计划";else if(cellvalue=="TEMPORARY") tmp="临时";return tmp;}
//NODE枚举格式化
function nodefmt(cellvalue){var tmp;if(cellvalue=="DEPARTMENT") tmp="部门";else if(cellvalue=="ALLOCATION") tmp="分配人";else if(cellvalue=="EXECUTOR") tmp="执行人";return tmp;}
/**计算责任百分比*@parent 父责任比重*@parent 子责任比重*/
function getPercent(parent, child) {parent = parseFloat(parent); child = parseFloat(child); if(isNaN(parent) || isNaN(child)){return "-"; } return child <= 0 ? "0":(Math.round(parent*child)/100.00);} 
//资产类型格式化
function assetTypefmt(cellvalue, options, rowObject){var tmp;if(cellvalue=="COMPUTER") tmp="计算机";else if(cellvalue=="CONSUMABLES") tmp="办公耗材";else if(cellvalue=="DAILY_OFFICE") tmp="办公日用品";return tmp;}
//资产状态格式化
function assetStatefmt(cellvalue, options, rowObject){var tmp;if(cellvalue=="IN_SHELF_LIFE") tmp="保修期内";else if(cellvalue=="OUT_SHELF_LIFE") tmp="过保修期";else if(cellvalue=="AVAILABLE") tmp="可使用";else if(cellvalue=="UNAVAILABLE") tmp="不可用";else if(cellvalue=="DAMAGE") tmp="已损坏";else if(cellvalue=="REPAIRCING") tmp="报修中";return tmp;}
//申领状态格式化
function applyStatefmt(cellvalue, options, rowObject){var tmp;if(cellvalue=="TRIAL") tmp="待审";else if(cellvalue=="AGREE") tmp="同意";else if(cellvalue=="REJECT") tmp="拒绝";else if(cellvalue=="CONFIRM") tmp="归还确认";else if(cellvalue=="HOMING") tmp="归位";else if(cellvalue=="USING") tmp="使用中";else if(cellvalue=="DAMAGED") tmp="被损坏";return tmp;}
//日志类型
function logTypeFmt(cellvalue, options, rowObject){var tmp; if(cellvalue=="SYSTEM") tmp="系统日志"; else if(cellvalue=="NEW") tmp="新增功能"; else if(cellvalue=="UPDATE") tmp="更新日志"; else if(cellvalue=="DEBUG") tmp="调试日志"; return tmp;}
//异常类型
function fmtAbnormalType(cellvalue, options, rowObject){var tmp; if(cellvalue=="SERVER") tmp="服务器故障";else if(cellvalue=="POWER") tmp="电力故障"; else if(cellvalue=="TASK") tmp="工作冲突"; return tmp;}