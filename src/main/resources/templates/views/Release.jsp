<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<jsp:include page="/WEB-INF/views/head_top.jsp"></jsp:include>
<title>My JSP 'left.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<meta http-equiv="Content-Type"
	content="multipart/form-data;charset=utf-8" />
<title>信息发布</title>
<link rel="stylesheet" type="text/css"
	href="/js/jquery-easyui-1.4.1/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css"
	href="/js/jquery-easyui-1.4.1/themes/icon.css" />
<script type="text/javascript"
	src="/js/jquery-easyui-1.4.1/jquery.min.js"></script>
<script type="text/javascript"
	src="/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="/js/jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript" charset="utf-8"
	src="${path}/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${path}/ueditor/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8"
	src="${path}/ueditor/lang/zh-cn/zh-cn.js"></script>

<style type="text/css">
a {
	color: blue;
	height: 25px;
}

#west div {
	height: 40px;
}

li {
	cursor: pointer;
	width: 60px;
}

ul li {
	list-style: none;
	height: 20px;
	
}
</style>

</head>

<body>
	<div class="easyui-layout" data-options="fit:true"
		style="height: 100%;width:1500px">


		<div id="west" data-options="region:'west',split:true" title="运营管理"
			style="width:250px;">
			<ul>
				<li><span>加油站</span></li>
				<li><span>公交充值</span></li>
				<li><span>景点</span></li>
				<li><span>宾馆</span></li>
				<li><span>旅行社</span></li>
				<li><span>本地美食</span></li>
				<li><span>本地饭店</span></li>
				<li><span>交通新闻</span></li>
				<li><span>路况信息</span></li>
				<li><span>商场</span></li>
				<li><span>饭店</span></li>
				<li><span>乘车通告</span></li>
				<li><span>企业新闻</span></li>
			</ul>
		</div>


		<div data-options="region:'center',title:'信息发布',iconCls:'icon-ok'"
			style="height:100%;width:50%">

			<table class="easyui-datagrid" id="infoList" style="width: 100%"
				title="信息列表"
				data-options="singleSelect:false,collapsible:true,pagination:true,url:'/info/selectByCata',method:'post',pageSize:10,toolbar:toolbar,pageList:[2,5,10]">
				<thead>
					<tr>
						<th data-options="field:'iId',checkbox:true" style="width:3%"></th>
						<th
							data-options="field:'_operate',align:'center',formatter:formatOper"
							style="width:10%;">操作栏</th>
						<th data-options="field:'title',align:'center'" style="width:10%">信息名称</th>
						<th data-options="field:'author',align:'center'" style="width:10%">作者</th>
						<th data-options="field:'tel',align:'center'" style="width:10%">联系方式</th>
						<th
							data-options="field:'time',align:'center',formatter:formattertime"
							style="width:10%">发布时间</th>
						<th data-options="field:'type',align:'center'" style="width:10%">信息类型</th>
						<th
							data-options="field:'status',align:'center',formatter:formatStatus"
							style="width:7%">信息状态</th>

					</tr>
				</thead>
			</table>
		</div>
	</div>

	<div id="addInfo" class="easyui-window" title="发布信息"
		data-options="modal:true,closed:true,iconCls:'icon-save',href:'${pageContext.request.contextPath}/to/addInfo'"
		style="width:900px;height:600px;padding:10px;"></div>
	<!-- 编辑弹出框，回显，修改功能 -->
	<div id="updateInfomation" class="easyui-window" title="编辑信息"
		style="width:850px;height:600px"
		data-options="iconCls:'icon-save',closed:true,modal:true,href:'${pageContext.request.contextPath}/to/updateInfomation'">
	</div>


</body>
<script>

//js控制CSS样式转变
	 $(document).ready(function(){

$("ul li").click(function() {
   $(this).css("background","#6666FF").siblings().css("background","#ffffff");
   $(this).css("color","white").siblings().css("color","black");/* 点击变色,点击另一个恢复原色 */
   });
});


	/* function li(){
		alert(this.innerHTML);
	} */
	
	var cataa = '';
	function formattertime(val,row,index){
		return timestampToTime(row.time);
	}
/* 点击获得分类信息 */
	$('ul li span').click(function() {
		var cata = this.innerHTML;
		cataa = cata;
	    $("#infoList").datagrid("load",{cata : cata});	   
	 
	});
	
	

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
        
    function updateLost(index){
    	$("#infoList").datagrid("selectRow",index);//获得你点的行的infomation信息
    	var data = $("#infoList").datagrid("getSelected");
       
        	$("#updateInfo").window({
        		onLoad :function(){       		
        			//回显数据,使用映射获得每一个对象的属性值     		
        			$("#updateInfoma").form("load",
        			{cata:data.cata,
        			title:data.title,
        			image:data.pic,
        			author:data.author,
        			tel:data.tel,
        			type:data.type,
        			shuju:data.content,
        			content:data.content,
        			iId:data.iId,
        			contentArea:data.content
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
    	
    	/* var cata = $("#infoList").datagrid("cata"); */
    
	    $("#infoList").datagrid("load",{infoName : infoName,cata:cataa});
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
    
    
    
    function updateLost(index){
    	$("#infoList").datagrid("selectRow",index);//获得你点的行的infomation信息
    	var data = $("#infoList").datagrid("getSelected");
       
        	$("#updateInfomation").window({
        		onLoad :function(){       		
        			//回显数据,使用映射获得每一个对象的属性值     		
        			$("#updateInfomation").form("load",
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
</html>
