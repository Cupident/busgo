
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'uploadTeam.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  <script type="text/javascript" src="../../js/jQ/jquery-1.12.4.js"></script>

  <script type="text/javascript" src="../../js/jquery-easyui-1.4.1/jquery.min.js"></script>
  <script type="text/javascript" src="../../js/jquery.form.js"></script></head>

    <script type="text/javascript">

			 $(document).ready(function(){  
                $('#btn').click(function(){  
                    if(checkData()){  
                        $('#form1').ajaxSubmit({    
                            url:'busTeam/ajaxUpload',  
                            dataType: 'text',  
                            success: resutlMsg,  
                            error: errorMsg  
                        });   
                        function resutlMsg(msg){  
                            alert(msg);     
                            $("#upfile").val("");  
                        }  
                        function errorMsg(){   
                            alert("导入excel出错！");      
                        }  
                    }  
                });  
             });  

    	     
    	    //JS校验form表单信息  
             function checkData(){  
                var fileDir = $("#upfile").val();  
                var suffix = fileDir.substr(fileDir.lastIndexOf("."));  
                if("" == fileDir){  
                    alert("选择需要导入的Excel文件！");  
                    return false;  
                }  
                if(".xls" != suffix && ".xlsx" != suffix ){  
                    alert("选择Excel格式的文件导入！");  
                    return false;  
                }  
                return true;  

     	     }
     /* 	     复选框选择多个值 */
     	     function show(){
    obj = document.getElementsByName("test");
    check_val = [];
    for(k in obj){
        if(obj[k].checked)
            check_val.push(obj[k].value);
    }
    alert(check_val);
}
    </script> 
  </head>
  
  <body>
  
  	<form method="POST"  enctype="multipart/form-data" id="form1" action="busTeam/ajaxUpload">
 	 	<table>
 	 	 <tr>
 	 	 	<td>上传文件: </td>
 	 	 	<td> <input id="upfile" type="file" name="upfile"></td>
 	 	 </tr>
  		<tr>
 	 	 	
 	 	 	<td><input type="button" value="ajax方式提交" id="btn" name="btn" ></td> 
 	 	 </tr>
  		</table>	
	</form>
	<input type="checkbox" name="test" value="1"/><span>1</span><input type="checkbox" name="test" value="2"/><span>2</span><input type="checkbox" name="test" value="3"/><span>3</span><input type="checkbox" name="test" value="4"/><span>4</span><input type="checkbox" name="test" value="5"/><span>5</span><input type='button' value='提交' onclick="show()"/>
  </body>
</html>
