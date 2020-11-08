<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="com.suny.pojo.Question"%>

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

<title>未处理信息列表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="../css/style/untreated.css" type="text/css"></link>
<script type="text/javascript" src="../../js/jQ/jquery-1.12.4.js"></script>
	<script type="text/javascript" src="../../js/askQ.js"></script>
<script type="text/javascript">
	function changePage() {
		var page = ${uiPage.pageNum}+1;
		var pages = ${uiPage.pages};
		if (pages >= page) {
			window.location.href = "/question/stQ?page=" + page;
		} else {
			alert("最后一页");
		}
		;
	}
	function changepage1() {
		var page = ${uiPage.pageNum}-1;
		var pages = ${uiPage.pages};
		if (page == 0) {
			alert("已经是一页");
		} else {
			window.location.href = "/question/stQ?page=" + page;
		}
		;
	}

	
function get(pId){
		
		/* 根据ID查问题具体内容 */
  		$.ajax({
			type : "post",
			url : "/question/byId",
			data : {"pId":pId},
			success : function(data) {
				var question = data;
				$("h4").html(question.askquestion);
				$("#h5").html("创建时间:"+timestampToTime(question.qDate));
				$("#h6").html(question.qDetails);
				$("#questionId").val(question.pId);
			},
			statusCode : {
				500 : function() {
					$.messager.alert('提示', '查看新闻失败');
				}
			}
		});
		
		
  	}
  	
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

</script>



<script type="text/javascript" src="../../js/jQ/jquery-1.12.4.js"></script>
<script type="text/javascript" >
$(document).ready(function() {
	$("tr").mouseover(function() {
		$(this).css("background-color", "CCCCCC");
     
	}).mouseout(function() {
		$(this).css("background-color", "white");
	})
})

</script>

</head>

<body>
	<!--列表模块-->
<div id="bigdiv">
	<div id="listBox" style="width: 50%;height:auto;">
		<div
			style="width: 100%;height:15px;border-bottom:solid;border-bottom-color:#009DE7; ">
			<img src="../img/return.png" id="return" onclick="window.location.href='/info/limit'"></img>
		</div>
		&nbsp;
		<h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;未处理信息列表</h3>

		<table align="center">


			<c:forEach items="${list}" var="question">
				<tr onclick="get('${question.pId}')">
					<td style="width: 30%;height: 35px">${question.askquestion}</td>
					<td style="width: 20%;height: 35px">未反馈</td>
					<td style="width: 50%;height: 35px"><fmt:formatDate
							value="${question.qDate}" pattern="yyyy年MM月dd日 " />
					</td>
				</tr>

			</c:forEach>

		</table>
		<div style="height:50%"></div>
		<div id="page" align="center" style="width: 100%;height: 20px">
			<a><input type="button" value="上一页" onclick="changepage1()">
			</a><a> &nbsp;  <span id="changePage">&nbsp;${uiPage.pageNum}&nbsp;</span>  &nbsp;  </a><a>
			<input type="button" value="下一页" onclick="changePage()"> </a>
		</div>

		<div style="height: 3%"></div>
	</div>
	<!--展示模块  -->
	<div id="queHead" style="width: 47%;height:40%;">
		<div style="width: 50%;height:50%">
			<span id="ask">详细信息展示</span>
		</div>
		<div id="ques">
			<h4>标题</h4>
			<p id="h5"></p>
			<p id="h6"></p>
			<span style="height: 20px"></span>
		</div>
	</div>
	
	<div id="queSub" style="width: 47%;height:47%;">
		<div id="boxHead">
			<span>信息ss输入</span>
		</div>
		<span></span>
		<textarea id="textarea" placeholder="回复内容" ></textarea>
		<div id="butt">
			<input type="button" value="回复" onclick=""/>
		</div>
	</div>
</div>	


</body>
</html>
