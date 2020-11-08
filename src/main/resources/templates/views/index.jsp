<%@page import="com.suny.pojo.Information"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
<title>首页</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<jsp:include page ="/WEB-INF/views/head_top.jsp"></jsp:include>

<!-- 引入EasyUI的样式文件-->
<link rel="stylesheet" type="text/css"
	href="/js/jquery-easyui-1.4.1/themes/default/easyui.css" />
<!-- 引入EasyUI的图标样式文件-->
<link rel="stylesheet" type="text/css"
	href="/js/jquery-easyui-1.4.1/themes/icon.css" />
<!-- 引入JQuery -->
<script type="text/javascript"
	src="/js/jquery-easyui-1.4.1/jquery.min.js"></script>
<!-- 引入EasyUI -->
<script type="text/javascript"
	src="/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<!-- 引入EasyUI的中文国际化js，让EasyUI支持中文 -->
<script type="text/javascript"
	src="/js/jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="/js/common.js"></script>

<link rel="stylesheet" href="../../css/style/index.css" type="text/css"></link>
<script type="text/javascript">
	

	$(function() {
		//新问题数量
		$.ajax({
			type : "post",
			url : "/question/newQ",
			success : function(data) {
				$("#newQ").html(data);
			}
		});
		//未处理问题
		$.ajax({
			type : "post",
			url : "/question/unQ",
			success : function(data) {
				$("#unQ").html(data);
			}
		});
		//新反馈

		$.ajax({
			type : "post",
			url : "/quesback/count",
			success : function(data) {
				$("#back").html(data);
			}
		});
		
		
		
	})
</script>
</head>
<body>
	<div class="easyui-layout"
	style="width:100%;height:100%;overflow-y:auto;background-color:#eee;">
	
	<!--订单管理  -->
	<div data-options="region:'north',split:true"
		style="height:20%;width:45%;border-radius:10px;padding:15px;"
		border="false">
		<h3>订单管理</h3>
	</div>
	<!--左边两个-->
	<div data-options="region:'center'"
		style="height:50%;width:50%;padding:15px;background:#eee;"
		border="false">
		<!-- 嵌套布局 -->
		<div class="easyui-layout" data-options="fit:true,plain:true"
			style="overflow:hidden;">
			<!--有问必答  -->
			<div data-options="region:'north'
				,split:true"
				style="border-radius:10px;height:40%;border-radius:10px;overflow:hidden;"
				colloapsible="false" border="false">
				<h3>有问必答</h3>
				
				<table id="qu">
					<tr></tr>
					<tr>
						<td id="newQ" style="font-size:24px;color:blue"></td>
						<td id="unQ" style="font-size:24px"></td>
						<td id="back" style="font-size:24px;color:green"></td>
					</tr>
					<tr height="100px" margin="center">
						<td><a href="/question/page"><input type="button" value="新提问" />
						</a></td>
						<td><a href="/question/stQ"><input type="button" value="未处理" />
						</a></td>
						<td><a href="/quesback/pageback"><input type="button" value="新反馈" />
						</a></td>
					</tr>
				</table>
			</div>
			<!-- 交通新闻 -->
			<div data-options="region:'south',split:true,"
				style="height:60%;width:50%;border-radius:10px;" border="false">
				<h3>交通新闻</h3>
				<!-- <a id="look" href="">查看更多>></a> -->

				<table id="ta">
					<c:forEach items="${list2}" var="list1">
					<tr>
						<td><span> △ </span><a href="/info/all?i_id=${list1.iId}&cata=${list1.cata}">${list1.title}</a>
						</td>
						<td><p><fmt:formatDate value="${list1.time}" pattern="yyyy年MM月dd日 E"/></p></td>
					</tr>
					</c:forEach>
				</table>

			</div>
		</div>
	</div>

	<!--  右边两个 -->
	<div data-options="region:'east',iconCls:'icon-reload',split:true"
		style="height:60%;width:50%;padding:15px;background:#eee;"
		border="false">

		<!-- 嵌套布局 -->
		<div class="easyui-layout" data-options="fit:true"
			style="height:50%;width:50%;">
			<!--交通信息  -->
			<div data-options="region:'north'
				,split:true"
				style="border-radius:10px;height:40%;border-radius:10px;overflow:hidden;"
				colloapsible="false" border="false">
				<h3>失物招领</h3>
				<!-- <a id="look" href="">查看更多>></a> -->
				<table id="ta">
					<c:forEach items="${list1}" var="list1">
					<tr>
						<td><span> △ </span><a href="/info/all?i_id=${list1.iId}&cata=${list1.cata}">${list1.title}</a>
						</td>
						<td><p><fmt:formatDate value="${list1.time}" pattern=" yyyy年MM月dd日 E"/></p></td>
					</tr>
					</c:forEach>
				</table>

			</div>
			<!-- 路况信息 -->
			<div data-options="region:'south',split:true,"
				style="height:60%;width:50%;border-radius:10px;" border="false"">
				<h3>路况信息</h3>
				<!-- <a id="look" href="">查看更多>></a> -->

				<table id="ta">
					<c:forEach items="${list3}" var="list1">
					<tr>
						<td><span> △ </span><a href="/info/all?i_id=${list1.iId}&cata=${list1.cata}">${list1.title}</a>
						</td>
						<td><p><fmt:formatDate value="${list1.time}" pattern=" yyyy年MM月dd日 E"/></p></td>
					</tr>
					</c:forEach>
				</table>

			</div>
		</div>
	</div>
	<div data-options="region:'south',split:true"
		style="height:20%;border-radius:10px;padding:15px;" border="false">
		<h3>统计图表敬请期待</h3>
	</div>

	
	

	</div>

</body>
</html>

