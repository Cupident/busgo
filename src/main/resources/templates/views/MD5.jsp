<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'MD5.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="../../js/md5.js"></script><!-- 引入MD5加密方法js -->
<style type="text/css">
body{
  background-color:CCCCCF;
}

#MD5{
  width:170px;
}

div{
position: absolute;
	top:60px;
	left: 60px;
}

input{
height:35px;
 width:245px;
}
td{
 
   padding:5px;
}
</style>

  </head>
  
  <body>
  <div>
    <table>
     <tr>
       <td>明文：</td>
       <td><input id="pwd" type="text" ></td>
     </tr>
     <tr>
       <td>DES密文：</td>
       <td><input type="text" readonly="readonly" ></td>
     </tr>
     <tr>
       <td>MD5密文(32):</td>
       <td><input id="md5miwen" type="text" readonly="readonly"></td><!-- readonly="readonly" 只读不可修改 -->
     </tr>
       <tr>
       <td></td>
       <td><input type="button" value="加密" onClick="MD5()" ></td>
     </tr>
     
    </table>
   </div> 
  </body>
  <script type="text/javascript">
function MD5(pwd){


var a=document.getElementById("pwd").value; 
if(a==""){
     document.getElementById("md5miwen").value="请输入明文";/* 投放到显示框 */
}else{


  var password= hex_md5(a);
  /*   alert(password);//输出 看一下效果.
   console.log(a);
    console.log(password);
    alert(a); */
    document.getElementById("md5miwen").value=password;/* 投放到显示框 */
//赋值回给 密码input 或 ajax请求.

/* d41d8cd98f00b204e9800998ecf8427e 空字符串 */
}

   }  
   
  </script>
</html>
