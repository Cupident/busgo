<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

<title>智慧交通公共出行平台</title>
<link rel="shortcut icon" href="img/favicon.ico">

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>
<link rel="stylesheet" href="css/head_top.css" />
<script type="text/javascript" src="../../js/jQ/jquery-1.12.4.js"></script>
<script type="text/javascript" charset="GBK" src="/js/head_top.js"></script>

<body onload="showTime()">

		<div id="indexNorth" style=" width: 100%; height: 82px;" title="">
			<div class="navBox" id="showDiv">
				<div class="nav1Box">
					<img src="img/nav1.png">
				</div>
				<div id="topLimitMenu">

					<div class="nav2Box"
						style="cursor: pointer; color: rgb(255, 255, 255); background: rgb(42, 87, 154);"
						onclick="window.location.href='/info/limit'">
						<img src="img/nav2.png">
						<p>首页</p>
					</div>
					<div class="nav2Box" style="cursor:pointer;color: #ffffff;"
						onclick="">
						<img src="img/nav3.png">
						<p>位置定位</p>
					</div>
					<div class="nav2Box" style="cursor:pointer;color: #ffffff;"
						onclick="">
						<img src="img/nav4.png">
						<p>线路监控</p>
					</div>
					<div class="nav2Box" style="cursor:pointer;color: #ffffff;"
						onclick="window.location.href='/to/operation'">
						<img src="img/nav5.png">
						<p>运营管理</p>
					</div>
					<div class="nav2Box" style="cursor:pointer;color: #ffffff;"
						onclick="window.location.href='/to/Release'">
						<img src="img/nav6.png">
						<p>信息发布</p>
					</div>
					<div class="nav2Box" style="cursor:pointer;color: #ffffff;"
						onclick="window.location.href='/to/osoperation'">
						<img src="img/nav8.png">
						<p>系统管理</p>
					</div>
				</div>
				<div class="nav4Box">
					<div class="rightBox2" onclick="loginOut()">
						<img src="img/nav9.png">
						<p></p>
					</div>
					<div class="rightBox2" onclick="showMessage()">
						<img src="img/nav10.png"> <span class="num" id="messageNum">26</span>
					</div>
					<div class="rightBox" onclick="personalSet()">
						<img src="img/nav11.png">
						<p>
							<span id="accoutName">${uName}</span>
						</p>
					</div>
					<div class="rightBox3">
						<div id="realtime"></div>
						<!-- 2018-09-14 16:59:25 星期五 -->
					</div>
				</div>
			</div></div></div>
			
		</div>
		
			<div  style="background-color: #d4dadf;width:100%;height:21px" align="center">
				<img id="aaa" style="cursor:hand" src="img/up.png" onclick="yincang()">
			</div>

</body>
<script type="text/javascript">
	 $("#aaa").click(function(){//点击a标签
		    	
				if($("#indexNorth").is(":hidden")){//如果当前隐藏
				$("#indexNorth").show();//那么就显示div
				}else{//否则
				$("#indexNorth").hide();//就隐藏div
				}
		    });
</script>
</html>
