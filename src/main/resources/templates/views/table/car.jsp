<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>车辆信息管理系统</title>
<link rel="stylesheet" type="text/css" href="/js/jquery-easyui-1.4.1/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="/js/jquery-easyui-1.4.1/themes/icon.css" />
<script type="text/javascript" src="/js/jquery-easyui-1.4.1/jquery.min.js"></script>
<script type="text/javascript" src="/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script type="text/javascript" src="/js/jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
</head>
<body>
	<div>
    <table class="easyui-datagrid" id="userList" title="会员列表" 
	       data-options="singleSelect:false,collapsible:true,pagination:true,url:'/user/list',method:'post',pageSize:10,toolbar:toolbar,pageList:[2,5,10]">
	    <thead>
	        <tr>
	        	<th data-options="field:'ck',checkbox:true"></th>
	        	<th data-options="field:'id',width:60,align:'center'">ID</th>
	            <th data-options="field:'userName',width:200,align:'center'">用户名</th>
	            <th data-options="field:'name',width:100,align:'center'">姓名</th>
	            <th data-options="field:'age',width:100,align:'center'">年龄</th>
	            <th data-options="field:'sex',width:80,align:'center',formatter:formatSet">性别</th>
	            <th data-options="field:'birthday',width:180,align:'center',formatter:formatBirthday">出生日期</th>
	            <th data-options="field:'created',width:200,align:'center',formatter:formatDate">创建日期</th>
	            <th data-options="field:'updated',width:200,align:'center',formatter:formatDate">更新日期</th>
	        </tr>
	    </thead>
	</table>
	</div>
<div id="userAdd" class="easyui-window" title="新增会员" data-options="modal:true,closed:true,iconCls:'icon-save',href:'${pageContext.request.contextPath}/to/toAddUser'" style="width:450px;height:500px;padding:10px;">
        The window content.
</div>

<div id="userAid" class="easyui-window" title="编辑会员" data-options="modal:true,closed:true,iconCls:'icon-save',href:'${pageContext.request.contextPath}/to/toAidUser'" style="width:500px;height:600px;padding:10px;">
        The window content.
</div>
<script type="text/javascript">
function formatDate(val,row){
	var now = new Date(val);
	return now.format("yyyy-MM-dd hh:mm:ss");
}
function formatBirthday(val,row){
	var now = new Date(val);
	return now.format("yyyy-MM-dd");
}
function formatSet(val,row){
	if(val == 1){
		return "男";
	}else if(val == 2){
		return "女";
	}else{
		return "未知";
	}
}
function getSelectionsIds(){
	var userList = $("#userList");
	var sels = userList.datagrid("getSelections");
	var ids = [];
	for(var i in sels){
		ids.push(sels[i].id);
	}
	ids = ids.join(",");
	return ids;
}


var toolbar = [{
    text:'新增',
    iconCls:'icon-add',
    handler:function(){
    	$('#userAdd').window('open');
    }
},{
    text:'编辑',
    iconCls:'icon-edit',
    handler:function(){
    var ids = getSelectionsIds();
    	if(ids.length == 0){
    		$.messager.alert('提示','未选中用户!');
    		return ;
    	}
    	if(ids.indexOf(',')>0){
    		$.messager.alert('提示','同时只能修改一个用户!');
    		return ;
    	}
    	
    	 $('#userAid').window({
    	   onLoad: function (){
    	   var data = $("#userList").datagrid("getSelections")[0];
    	   
    	  data.birthday= timestampToTime(data.birthday);//获得时间戳
    /* 	  var timestamp = (new Date()).valueOf(); //获得当前时间戳
    	  
    	 alert(timestamp);
    	 */
    	   $("#userAid").form("load",data);
    	  }
    	 }).window('open');
    	}
},{
    text:'删除',
    iconCls:'icon-cancel',
    handler:function(){
    	var ids = getSelectionsIds();
    	if(ids.length == 0){
    		$.messager.alert('提示','未选中用户!');
    		return ;
    	}
    	$.messager.confirm('确认','确定删除ID为 '+ids+' 的会员吗？',function(r){
    	    if (r){
            	$.post("${pageContext.request.contextPath}/user/delete",{'ids':ids}, function(data){
        			if(data.status == 200){
        				$.messager.alert('提示','删除会员成功!',undefined,function(){
        					$("#userList").datagrid("reload");
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
    	var optins = $("#userList").datagrid("getPager").data("pagination").options;
    	var page = optins.pageNumber;
    	var rows = optins.pageSize;
    	$("<form>").attr({
    		"action":"${pageContext.request.contextPath}/user/export/excel",
    		"method":"POST"
    	}).appendTo("body").submit();
    }   /*  .append("<input type='text' name='page' value='"+page+"'/>")
    	.append("<input type='text' name='rows' value='"+rows+"'/>") */
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