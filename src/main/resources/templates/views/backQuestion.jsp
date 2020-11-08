<%@page import="com.suny.pojo.Question"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

<title>提问列表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="../css/style/askQ.css" type="text/css"></link>
<script type="text/javascript" src="../js/jQ/jquery-1.12.4.js"></script>
<script type="text/javascript" src="../../js/askQ.js"></script>
</head>
<script type="text/javascript">
	function changePage() {
		var page = $
		{
			uiPage.pageNum
		}
		+1;
		var pages = $
		{
			uiPage.pages
		}
		;

		if (pages >= page) {
			window.location.href = "/quesback/pageback?page=" + page;
		} else {
			alert("最后一页");
		}
		;
	}
	function changepage1() {
		var page = $
		{
			uiPage.pageNum
		}
		-1;
		var pages = $
		{
			uiPage.pages
		}
		;

		if (page == 0) {
			alert("已经是一页");
		} else {
			window.location.href = "/quesback/pageback?page=" + page;
		}
		;
	}
	function get(bId) {
		$.ajax({
			type : "post",
			url : "/quesback/bid",
			data : {
				"bId" : bId
			},
			success : function(data) {
				var back = data;
				$("#td1").html(back.bId);
				$("#td2").html(back.backName);
				$("#td3").html(back.backquestion);
			}

		})

	}
</script>

<body>
	<!--列表模块-->
	<div id="bigdiv">
		<div id="listBox" style="width: 50%;height:auto;">
			<div
				style="width: 100%;height:15px;border-bottom:solid;border-bottom-color:#009DE7; ">
				<img src="../img/return.png" id="return"
					onclick="window.location.href='/info/limit'"></img>
			</div>

			<table align="center">
				<tr>
					<td><h3>用户名</h3></td>
					<td><h3>反馈内容</h3>
					</td>
					<td>
						<h3>发布时间</h3></td>

				</tr>
				<c:forEach items="${questionback}" var="questionback">
					<tr onclick="get('${questionback.bId}')">
						<td style="width: 40%;height: 35px">${questionback.backName}</td>
						<td style="width: 30%;height: 35px">${questionback.backquestion}</td>
						<td style="width: 40%;height: 35px"><fmt:formatDate
								value="${questionback.bDate}" pattern="yyyy年MM月dd日 " /></td>
					</tr>

				</c:forEach>
			</table>

			<div style="height: 6%"></div>
			<div id="page" align="center" style="width: 100%;height: 20px">
				<a><input type="button" value="上一页" onclick="changepage1()">
				</a><a><span id="changePage">&nbsp;${uiPage.pageNum}&nbsp;</span> </a><a><input
					type="button" value="下一页" onclick="changePage()"> </a>
			</div>
			<div style="height: 3%"></div>
		</div>
		<!--展示模块  -->
		<div id="queHead" style="width: 47%;height:70%;">
			<div style="width: 50%;height:30%";>
				<span id="ask">反馈详情</span>
			</div>
			<div id="ques" style="margin-left:100px;">
				<div id="back">
					<h3 id="td1"></h3>
					<p id="td2">用户名：</p>
					<p id="td3">反馈内容：</p>
				</div>
				<span style="height: 20px"></span>
			</div>
		</div>
	</div>

</body>
</html>
