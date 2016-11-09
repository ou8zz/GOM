var colNames_cn = ['ID','功能代码','责任名称','预设比重','实际比重','分配说明'];
var colNames_tw = ['ID','功能代碼','責任名稱','預設比重','實際比重','分配說明'];
var caption = {zh: "我的职责清单", "zh_CN": "我的职责清单", "zh_TW": "我的職責清單"};
var colNames = {zh: colNames_cn, "zh_CN": colNames_cn, "zh_TW": colNames_tw};

$(function(){
	$.fn.zTree.init($("#menu"), setting);
	$.ajaxSetup({contentType:"application/x-www-form-urlencoded; charset=UTF-8"});
	
	//显示所有用户信息
	jQuery("#zgrid").jqGrid({
	   	url:'get_responsibility.htm?user=true',
	   	treedatatype: "xml",
	   	treeGridModel:'adjacency',
	   	mtype: "POST",
		height:'auto',
		width:793,
		caption: caption[lang],
	   	colNames: colNames[lang],
	   	colModel:[
	   	    {name:'id',index:'id',hidden:true},
	   		{name:'funcode',index:'funcode',width:123,sortable:false},
	   		{name:'name',index:'name',width:200,sortable:false},
	   		{name:'expected',index:'expected',width:100,sortable:false,align:'center'},
	   		{name:'actual',index:'actual',width:100,sortable:false,align:'center'},
			{name:'explanation',index:'explanation',width:270,sortable:false}
	   	],
	   	pager:'#zpager',
	   	sortname:'funcode',
	   	treeGrid: true,
	   	ExpandColumn:'funcode',
		prmNames:{search:'search'},
	   	ExpandColClick:true
	});
	
	$('#zgrid').jqGrid('navGrid','#zpager',{add:false,edit:false,del:false,view:true,search:false,alerttext:"请选择需要操作的数据行!@"},{},{},{},{caption:"查找", Find:"点击查找", multipleSearch:false},{});
}); 