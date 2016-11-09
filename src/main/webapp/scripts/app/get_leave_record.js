var colNames_cn = ['ID','类别','事因','开始时间','结束时间','天数','假期联系方式','代理部门','代理人','交接情况','申请日期'];
var colNames_tw = ['ID','類別','事因','開始時間','結束時間','天數','假期聯系方式','代理部門','代理人','交接情況','申請日期'];

var caption = {zh: "", "zh_CN": "请假历史记录", "zh_TW": "請假歷史記錄"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
$.fn.zTree.init($("#menu"), setting);
$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});

$("#zgrid").jqGrid({
    url:'get_leave_record.htm',
    datatype:'json',
	mtype:'GET',
	height:260,
	width:793,
	caption: caption[lang],
   	colNames: colNames[lang],
    colModel:[ 
	  {name:'id',index:'id',hidden:true},
	  {name:'type',index:'type',width:50,formatter:leaveType},
	  {name:'event',index:'event',width:90},
	  {name:'startDate',index:'startDate',width:100},
	  {name:'endDate',index:'endDate',width:100},
	  {name:'days',index:'days',width:50},
	  {name:'contact',index:'contact',width:90},
	  {name:'agentDepart',index:'agentDepart',width:50},
	  {name:'agent',index:'agent',width:60},
	  {name:'handOver',index:'handOver',width:108},
	  {name:'applyDate',index:'applyDate',width:100},],
	rowNum:10,
    rowList:[10,20,30],
	pager:'#zpager',
	viewrecords:true,
	rownumbers:true, 
	rownumWidth:25,
	sortname:'applyDate',
	sortorder:'asc',
	prmNames:{search:'search'},
	jsonReader:{root:'list',repeatitems:false}
});

$('#zgrid').jqGrid('navGrid','#zpager',{add:false,edit:false,del:false,view:true},{},{},{},{},{closeOnEscape:true});
});