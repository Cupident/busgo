<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>汽车管理系统</title>
<link rel="stylesheet" type="text/css" href="/js/jquery-easyui-1.4.1/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="/js/jquery-easyui-1.4.1/themes/icon.css" />
<script type="text/javascript" src="/js/jquery-easyui-1.4.1/jquery.min.js"></script>
<script type="text/javascript" src="/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script type="text/javascript" src="/js/jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
</head>
<body>
	<div>
    <table class="easyui-datagrid" id="stopList" style="width: 100%" title="站点列表" 
	       data-options="singleSelect:false,collapsible:true,pagination:true,url:'/busStop/search',method:'post',pageSize:10,toolbar:toolbar,pageList:[2,5,10]">
	    <thead>
	        <tr>
	        	<th data-options="field:'stopId',checkbox:true"style="width:3%"></th>
	        	<th data-options="field:'stopName',align:'center'"style="width:10%">站牌名称</th>
	            <th data-options="field:'stopDirection',align:'center'"style="width:10%">站点方向</th>
	            <th data-options="field:'stopType',align:'center'"style="width:10%">站点类型</th>
	            <th data-options="field:'stopSpeed',align:'center'"style="width:10%">限速</th>
	            <th data-options="field:'area',align:'center',formatter:formatterareaName"style="width:7%">所属县</th>
	            <th data-options="field:'city',align:'center',formatter:formattercityName"style="width:7%">所属市</th>
	            <th data-options="field:'province',align:'center',formatter:formatterprovinceName"style="width:7%">所属省</th>
	            <th data-options="field:'stopStatus',align:'center',formatter:formatStatus"style="width:10%">状态</th>
	            <th data-options="field:'stopText',align:'center'"style="width:10%">站点描述</th>
	            <th data-options="field:'stopXuni',align:'center',formatter:formatXuNi,"style="width:9%">是否虚拟</th>
	           
	        
	        </tr>
	    </thead>
	</table>
	</div>
<div id="addStop" class="easyui-window" title="新增站点信息" data-options="modal:true,closed:true,iconCls:'icon-save',href:'${pageContext.request.contextPath}/to/addStop'" style="width:450px;height:400px;padding:10px;">
        The window content.
</div>

<div id="updateStop" class="easyui-window" title="编辑站点信息" data-options="modal:true,closed:true,iconCls:'icon-save',href:'${pageContext.request.contextPath}/to/updateStop'" style="width:500px;height:600px;padding:10px;">
        The window content.
</div>
<script type="text/javascript">
function formatterareaName(val,row,index){
	return row.hatArea.area;
}
function formattercityName(val,row,index){
	return row.hatArea.hatCity.city;
}
function formatterprovinceName(val,row,index){
	return row.hatArea.hatCity.hatProvince.province;
}

function formatSetNum(val,row){
	if(val == 23){
	return "微型客车（22人）";
	}else if(val == 32){
	return "中型客车（32人）";
	}else if(val==55){
	return "大型客车（55人）";
	}
	
}
function formatStatus(val,row){
	if(val == 0){
		return "停用";
	}else{
		return "正在运行";
	}
}

function formatXuNi(val,row){
	if(val == 0){
		return "否";
	}else{
		return "是";
	}
}
/*选择标签的id  */
function getSelectionsIds(){
	var userList = $("#stopList");
	var sels = userList.datagrid("getSelections");
	var ids = [];
	for(var i in sels){
		ids.push(sels[i].stopId);
	}
	ids = ids.join(",");
	return ids;
}

var toolbar = [{
    text:'站点名称：<input id = "stopName" style="width:60px;"/>',
},{
    text:'搜索',
    iconCls:'icon-search',
    handler:function(){
    	var stopName = $("#stopName").val();
	    $("#stopList").datagrid("load",{stopName : stopName});
   }
},{
    text:'重置',
    handler:function(){
    	$('#stopName').val('');
    }
},{
     /* 编辑    回显数据 */
	text:'编辑',
    iconCls:'icon-edit',
    handler:function(){
    	var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','必须选择一个站点才能编辑!');
        		return ;
        	}
        	if(ids.indexOf(",") > 1){
        		$.messager.alert('提示','只能站点一个商品!');
        		return ;
        	}else{
        	
        	$("#updateStop").window({
        		onLoad :function(){
        			//回显数据,使用映射获得每一个对象的属性值，因为有级联关系
        			var stop = $("#stopList").datagrid("getSelections")[0]; 	    			
        			$("#updateStop").form("load",
        			{stopId:stop.stopId,
        			stopName:stop.stopName,
        			stopDirection:stop.stopDirection,
        			stopType:stop.stopType,
        			stopSpeed:stop.stopSpeed,
        			
        			stopProvince:stop.hatArea.hatCity.hatProvince.province,
        			stopCity:stop.hatArea.hatCity.city,
        			stopArea:stop.hatArea.area,
        			/* stopProvinceid:stop.hatArea.hatCity.hatProvince.provinceId,
        			stopCityid:stop.hatArea.hatCity.cityId,
        			stopAreaid:stop.hatArea.areaId, */
        			
        			stopText:stop.stopText,
        			stopStatus:stop.stopStatus,
        			stopXuni:stop.stopXuni
        			}      			
        			);
        		}
        	}).window("open");
        }
       }
},{
    text:'新增',
    iconCls:'icon-add',
    handler:function(){
    	$('#addStop').window('open');
    }
},{
    text:'删除',
    iconCls:'icon-cancel',
    handler:function(){
    	var ids = getSelectionsIds();
    	if(ids.length == 0){
    		$.messager.alert('提示','未选中站点!');
    		return ;
    	}
    	$.messager.confirm('确认','确定删除ID为 '+ids+' 的站点吗？',function(r){
    	    if (r){
            	$.post("${pageContext.request.contextPath}/busStop/delete",{'ids':ids}, function(data){
        			if(data.status == 200){
        				$.messager.alert('提示','删除站点成功!',undefined,function(){
        					$("#stopList").datagrid("reload");
        				});
        			}
        		});
    	    }
    	});
    }
},'-',{
    text:'导出',
    iconCls:'icon-remove',
    handler:function(){
    	
    	$("<form>").attr({
    		"action":"${pageContext.request.contextPath}/busStop/excel",
    		"method":"POST"
    	}).appendTo("body").submit();
    }
}];

function timestampToTime(timestamp) {
        var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
        var Y = date.getFullYear() + '-';
        var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        var D = date.getDate() + ' ';
        var h = date.getHours() + ':';
        var m = date.getMinutes() + ':';
        var s = date.getSeconds();
        return Y+M+D;    
    }

</script>
</body>
</html>