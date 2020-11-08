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

<style type="text/css">
a {
	color: white;
	height: 25px;
}

#west div {
	height: 40px;
	background-color:000666;
	margin:2px;
}

div a {
	line-height: 45px;
}
div img {
	line-height: 45px;
}
</style>

</head>

<body>
	<div class="easyui-layout" data-options="fit:true"
		style="height: 100%;width:1500px">


		<div id="west" data-options="region:'west',split:true" title="系统管理"
			style="width:250px;background-color:003366">
			<div onclick="changeTabs('角色管理','url')"
				style="text-align: center; cursor: pointer;">
				<a>角色管理</a>
			</div>
			<div onclick="changeTabs('用户管理','url')"
				style="text-align: center; cursor: pointer;">
				<a>用户管理</a>
			</div>

			<div onclick="changeTabs('区域管理','url')"
				style="text-align: center; cursor: pointer;">
				<a>区域管理</a>
			</div>
			<div onclick="changeTabs('字典管理','url')"
				style="text-align: center; cursor: pointer;">
				<a>字典管理</a>
			</div>
			<div onclick="changeTabs('接口管理','url')"
				style="text-align: center; cursor: pointer;">
				<a>接口管理</a>
			</div>
			<div onclick="changeTabs('字符加密','http://localhost:8080/to/MD5')"
				style="text-align: center; cursor: pointer;">
				<img src="../../img/jmi.png"></img> <a>  字符加密</a>
			</div>
			
		</div>

		<!-- 选项卡显示界面 -->
		<div data-options="region:'center',title:'信息显示',iconCls:'icon-ok'"
			style="height:100%;width:100%">
			<div id="tt" class="easyui-tabs" style="height: 100%;width:100%">
			</div>
		</div>
	</div>

</body>
<script>
//点击选项卡实现选项卡显示 连接到相应地址显示信息
	function changeTabs(title, url) {
		var bol = $("#tt").tabs("exists", title);
		if (bol) {
			$("#tt").tabs("select", title);
		} else {
			/*    链接 */
			var content = '<iframe scrolling="auto" frameborder="0"  src="'
					+ url + '" style="width:100%;height:100%;"></iframe>';
			$('#tt').tabs('add', {
				title : title,
				content : content,
				closable : true,
				tools : [ {
					iconCls : 'icon-mini-refresh',
					handler : function() {
						alert('refresh');
					}
				} ]

			});
		}
	}

   //js控制CSS样式转变
	$(document).ready(function() {
		$("#west div").mouseover(function() {
			$(this).css("background-color", "0066FF");
		}).mouseout(function() {
			$(this).css("background-color", "000666");
		})
	})
	
	
	
</script>
</html>
