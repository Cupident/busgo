<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>失物招领</title>
    <meta http-equiv="Content-Type" content="multipart/form-data;charset=utf-8"/>
    <script type="text/javascript" charset="utf-8" src="${path}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${path}/ueditor/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="${path}/ueditor/lang/zh-cn/zh-cn.js"></script>

    <style type="text/css">
        div{
            width:100%;
        }
    </style>
</head>
<body>
 <form id="updateLostFound" method="post" enctype="multipart/form-data">
<div>
		<table cellpadding="5">
			<tr>
				<td>标题：</td>
				<td><input class="easyui-textbox" type="text" id="title" name="title"
					data-options="required:true" style="width: 150px;" />
				</td>
				<td>标题图：</td>
					<td><input id="imgfile" type="file" name="imgfile" accept="image/*"
						style="width: 150px;" /></td>
				<td><input id="iId" type="hidden" name="iId" />
				</td>
				<td><input id="cata" type="hidden" name="cata" />
				</td>
				
				
				<td><input id="shuju" name="shuju" type="hidden"
					 style="width: 150px;" />
				</td>
			</tr>
			<tr>
				<td>联系人：</td>
				<td><input class="easyui-textbox" type="text" id="authoe" name="author"
					data-options="required:true" style="width: 150px;" />
				</td>
				<td>联系电话：</td>
				<td><input class="easyui-textbox" type="text" id="tel" name="tel"
					data-options="required:true,validType:'mobileTelephone',prompt:'请输入正确的手机号码。'" style="width: 150px;" />
				</td>
				<td>信息类型</td>
				<td>
					<input id="type" name="type" checked="checked" type="radio" value="失物"/>失物
					<input id="type" name="type" type="radio" value="招领"/>招领
				</td>
			</tr>
			
		</table>
	
    <script id="editor1" name="content" type="text/plain" style="width:700px;height:250px;"></script>
</div>
</form>
	<div style="padding:5px" align="center">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="submitForm()">提交</a> <a href="javascript:void(0)"
			class="easyui-linkbutton" onclick="clearForm()">重置</a>
	</div>
	<button onclick="setContent()">写入内容</button>

<script type="text/javascript">
     //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
     //var ue = UE.getEditor('editor');
    
    //这种方法解决只能初始化一次，第二次点击富文本框无法出现的问题，
     jQuery(function($) {
	    UE.delEditor("editor1");
	    var ue = UE.getEditor("editor1");
	});   

		  var a = 0;
	$("#divdiv").hover(function(){
	if(a == 0){
   		setContent();
   		a = 1;
   		}
	});
		
	$.extend($.fn.validatebox.defaults.rules,{ 
	 mobileTelephone :{
      validator : function(value) {
       var cmccMobile = /^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
       var tel = /^\d{3,4}?\d{7,8}$/;
       return tel.test(value) || (value.length == 11 && cmccMobile.test(value));
      },
      message : "请正确填写您的联系电话."
     },
     });
     
		//向富文本框中回显数据
	function setContent(isAppendTo) {//isAppendTo
        
        var ddd = $("#shuju").val();
              
        UE.getEditor('editor1').setContent(ddd, isAppendTo);
        //alert(arr.join("\n"));
    }
	
	function submitForm() {
		 var ddd = $("#updateLostFound").serialize();
		//ajax 请求上传文件
			var form = new FormData(document.getElementById("updateLostFound"));
			$.ajax({
				url : '/info/updateLost',
				data : form,
				type : 'post',
				processData : false,
				contentType : false,
				success : function(data) {
						if (data.status == 200) {
							$.messager.alert('提示', '成功！');
							$("#updateInfo").window("close");
							$("#infoList").datagrid("reload");
						} else {
							$.messager.alert('提示', '发布失败!');
						}
					},
					statusCode : {
						500 : function() {
							$.messager.alert('提示', '发布失败!');
						}
					}
			});
	}
	
</script>

</body>
</html>
