<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 	<style type="text/css">
        div{
            width:100%;
            margin: 0 auto;
        }
    </style>
<head>
<meta http-equiv="Content-Type" content="multipart/form-data;charset=utf-8"/>
<title>失物招领</title>
<link rel="stylesheet" type="text/css" href="/js/jquery-easyui-1.4.1/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="/js/jquery-easyui-1.4.1/themes/icon.css" />
<script type="text/javascript" src="/js/jquery-easyui-1.4.1/jquery.min.js"></script>
<script type="text/javascript" src="/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script type="text/javascript" src="/js/jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="/js/common.js"></script>

    <script type="text/javascript" charset="utf-8" src="${path}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${path}/ueditor/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="${path}/ueditor/lang/zh-cn/zh-cn.js"></script>
</head>
<body>
	<div>
    <table class="easyui-datagrid" id="infoList" style="width: 100%" title="信息列表" 
	       data-options="singleSelect:false,collapsible:true,pagination:true,url:'/info/searchLostFound',method:'post',pageSize:10,toolbar:toolbar,pageList:[2,5,10]">
	    <thead>
	        <tr>
	        	<th data-options="field:'iId',checkbox:true"style="width:3%"></th>
	        	<th data-options="field:'_operate',align:'center',formatter:formatOper" style="width:10%;">操作栏</th>
	        	<th data-options="field:'title',align:'center'"style="width:10%">信息名称</th>
	        	<th data-options="field:'author',align:'center'"style="width:10%">作者</th>
	            <th data-options="field:'tel',align:'center'"style="width:10%">联系方式</th>
	            <th data-options="field:'time',align:'center',formatter:formattertime"style="width:10%">发布时间</th>
	            <th data-options="field:'type',align:'center'"style="width:10%">信息类型</th>
	            <th data-options="field:'status',align:'center',formatter:formatStatus"style="width:7%">信息状态</th>	          
	                   
	        </tr>
	    </thead>
	</table>
	</div>
<div id="addInfo" class="easyui-window" title="发布信息" data-options="modal:true,closed:true,iconCls:'icon-save',href:'${pageContext.request.contextPath}/to/addLostfound'" style="width:800px;height:600px;padding:10px;">
        The window content.
</div>

<!-- 编辑弹出框，回显，修改功能 -->
<div id="updateInfo" class="easyui-window" title="编辑信息" style="width:800px;height:600px"   
        data-options="iconCls:'icon-save',closed:true,modal:true,href:'${pageContext.request.contextPath}/to/updateLost'">   
</div>

<script type="text/javascript">
function formattertime(val,row,index){
	return timestampToTime(row.time);
}

/*选择信息管理界面标签的id  */
function getSelectionsIds(){
	var userList = $("#infoList");
	var sels = userList.datagrid("getSelections");
	var ids = [];
	for(var i=0;i<sels.length;i++){
		ids.push(sels[i].lineId);
	}
	ids = ids.join(",");
	console.log(ids);
	return ids;
}
//自定义操作列
        function formatOper(val, row, index) {
            var str = "";
            str += '<a href="javascript:void(0);" onclick="updateLost(' + index + ')">编辑</a>';
            str += '  ';
            str += '<a href="javascript:void(0);" onclick="deleteInfo(' + row.iId + ')">删除</a>';
            return str;
        }

/*自定义删除  */
	function deleteInfo(id){
    	$.messager.confirm('确认','确定删除ID为 '+id+' 的信息吗？',function(r){
    	    if (r){
            	$.post("/info/delete",{'id':id}, function(data){
        			if(data.status == 200){
        				$.messager.alert('提示','删除信息成功!',undefined,function(){
        					$("#infoList").datagrid("reload");
        				});
        			}
        		});
    	    };
    	});
    }

function formatStatus(val,row){
	if(val == 1){
		return "已发布";
	}else{
		return "未发布";
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
    text:'信息名称：<input id = "infoName" style="width:60px;"/>',
},{
    text:'搜索',
    iconCls:'icon-search',
    handler:function(){
    	var infoName = $("#infoName").val();
	    $("#infoList").datagrid("load",{infoName : infoName});
   }
},{
    text:'重置',
    handler:function(){
    	$('#infoName').val('');
    }
},{
     /* 编辑    回显数据 */
	text:'发布信息',
    
    handler:function(){
    	$("#addInfo").window("open");
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
        return Y+M+D+h+m+s;    
    }
    
    /* ------------------------------------------------分割线--------------------------------------------------------- */
 


	function updateLost(index){
    	$("#infoList").datagrid("selectRow",index);//获得你点的行的infomation信息
    	var data = $("#infoList").datagrid("getSelected");
       
        	$("#updateInfo").window({
        		onLoad :function(){       		
        			//回显数据,使用映射获得每一个对象的属性值     		
        			$("#updateLostFound").form("load",
        			{cata:data.cata,
        			title:data.title,
        			image:data.pic,
        			author:data.author,
        			tel:data.tel,
        			type:data.type,
        			shuju:data.content,
        			content:data.content,
        			iId:data.iId
        			});
        		/* 	$("#title").val(data.title);
        			$("#image").val(data.pic);
        			$("#author").val(data.author);
        			$("#tel").val(data.tel);
        			$("#type").val(data.type);
        			$("#editor").val(data.content); */
        			
        		}
        	}).window("open");
        }
       
</script>
</body>
</html>