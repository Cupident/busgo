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
<jsp:include page="/WEB-INF/views/head_top.jsp"></jsp:include>
<title>信息列表</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="../css/style/askQ.css" type="text/css"></link>

<script type="text/javascript" src="../../js/jQ/jquery-1.12.4.js"></script>
<script type="text/javascript" src="../../js/askQ.js"></script></head>


<body>
	<!--列表模块-->
<div id="bigdiv">
	<div id="listBox" style="width: 50%;height:auto;">
		<div
			style="width: 100%;height:15px;border-bottom:solid;border-bottom-color:#009DE7; ">
			<img src="../img/return.png"  id="return" onclick="window.location.href='/info/limit'"></img>
		</div>
		&nbsp;
		<h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;提问列表</h3>
		<span id="a"><span id="bule">.</span>已审核 </span> <span id="b"><span
			id="red">.</span>未审核</span>

		<table align="center">
			<c:forEach items="${infolist}" var="infomation">
				<tr>
					<td style="width: 50%;height: 35px" onclick="get('${infomation.iId}')" >${infomation.title}</td>
					<td style="width: 30%;height: 35px"><fmt:formatDate
							value="${infomation.time}" pattern="yyyy年MM月dd日 E" />
					</td>
				</tr>
			</c:forEach>
		</table>
		<div style="height: 6%"></div>
		<div id="page" align="center" style="width: 100%;height: 20px">
			<a><input type="button" value="上一页" onclick="changepage1()">
			</a><a><span id="changePage">&nbsp;${uiPage.pageNum}&nbsp;</span> </a><a><input
				type="button" value="下一页" onclick="changePage()"> </a>
		</div>
		<div style="height: 3%"> <input type="hidden" id="hi" value="${cata}"></div>
	</div>
	<!--展示模块  -->
	<div id="queHead" style="width: 47%;height:auto;">
		<div style="width: 50%;height:30px";>
			<span id="ask">信息详情</span>
		</div>
		<div id="ques">
			<h4>标题</h4>
			<p id="user"style="width: 80%"></p>
			<p id="text" style="padding-left:7%;">具体内容</p>
			<p><img src="${infomation.pic}"></p>
			<img src="${infomation.time}">
			<span style="height: 20px"></span>
		</div>
		<div align="center">
			<span id="aut"> 作者: </span> <span id="iphone">&nbsp;&nbsp;联系电话：</span>
		</div>
		<div style="height:20px;"></div>
	</div>
</div>

</body>
<script type="text/javascript">
	function changePage(){
		var page = ${uiPage.pageNum}+1;
		var pages = ${uiPage.pages};
		var cata = $("#hi").val();
		if(pages>=page){
			window.location.href = "/info/all?page="+page+"&cata="+cata;
		}else{
			alert("最后一页");
		};	
	}
	function changepage1(){
		var page = ${uiPage.pageNum}-1;
		var pages = ${uiPage.pages};
		var cata = $("#hi").val();
		if(page==0){		
			alert("已经是一页");
		}else{
			window.location.href =  "/info/all?page="+page+"&cata="+cata;
		};
	}

  	function get(iId){
  		$.ajax({
			type : "post",
			url : "/info/id",
			data : {"iId":iId},
			success : function(data) {
				var info = data;
				$("#ques>h4").html(info.title);
				$("#user").html("用户名"+info.author+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;发布时间"+timestampToTime(info.time));
				$("#text").html(info.content);
				$("#aut").html("作者"+info.author);
				$("#iphone").html("手机号"+info.tel);					
			},
			statusCode : {
				500 : function() {
					$.messager.alert('提示', '查看新闻失败');
				}
			}
		})
  	}
/*编写时间戳转换方法  */
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
</html>
