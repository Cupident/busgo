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
<title>信息修改页面</title>
<meta http-equiv="Content-Type"
	content="multipart/form-data;charset=utf-8" />
<script type="text/javascript" charset="utf-8"
	src="${path}/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${path}/ueditor/ueditor.all.min.js">
	
</script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8"
	src="${path}/ueditor/lang/zh-cn/zh-cn.js"></script>

<style type="text/css">
div {
	width: 100%;
}
</style>
</head>
<body>
	<form id="content" method="post" enctype="multipart/form-data">
		<div id="divdiv">
			<table cellpadding="5">
				<tr>
					<td>标题：</td>
					<td><input class="easyui-textbox" type="text" id="title"
						name="title" data-options="required:true" style="width: 150px;" />
					</td>
					<td>标题图：</td>
					<td><input id="imgfile" type="file" name="imgfile" accept="image/*"
						style="width: 150px;" /></td>
					<td>栏目</td>
					<td><select class="easyui-combobox" name="cata"
						data-options="method:'post',height:25, required:true"
						style="width:200px;">
							<option value="加油站">加油站</option>
							<option value="公交充值">公交充值</option>
							<option value="景点">景点</option>
							<option value="宾馆">宾馆</option>
							<option value="旅行社">旅行社</option>
							<option value="本地美食">本地美食</option>
							<option value="本地饭店">本地饭店</option>
							<option value="交通新闻">交通新闻</option>
							<option value="路况信息">路况信息</option>
							<option value="商场">商场</option>
							<option value="饭店">饭店</option>
							<option value="乘车通告">乘车通告</option>
							<option value="企业新闻">乘企业新闻</option>
					</select></td>
					<td><input id="iId" type="hidden" name="iId" /></td>

					<td><input id="shuju" name="shuju" type="hidden"
						style="width: 150px;" /></td>
				</tr>
				<tr>
					<td>联系人：</td>
					<td><input class="easyui-textbox" type="text" id="authoe"
						name="author" data-options="required:true" style="width: 150px;" />
					</td>
					<td>联系电话：</td>
					<td><input class="easyui-textbox" type="text" id="tel"
						name="tel"
						data-options="required:true,validType:'mobileTelephone',prompt:'请输入正确的手机号码。'"
						style="width: 150px;" /></td>
				</tr>
			</table>
			<script id="editor1" name="content" type="text/plain"
				style="width:700px;height:250px;"></script>

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
			var ue = UE.getEditor('editor1'
			// 	    ,{
			// 	    toolbars: [[
			// 	    'fontfamily',
			// 	    'fontsize',
			// 	    'italic',
			// 	    'forecolor',
			// 	    'bold'
			// 	    ]],
			// 	    elementPathEnabled:false
			// 	    }
			);
		});

		var a = 0;
		$("#divdiv").hover(function() {
			if (a == 0) {
				setContent();
				a = 1;
			}
		});

		$
				.extend(
						$.fn.validatebox.defaults.rules,
						{
							mobileTelephone : {
								validator : function(value) {
									var cmccMobile = /^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
									var tel = /^\d{3,4}?\d{7,8}$/;
									return tel.test(value)
											|| (value.length == 11 && cmccMobile
													.test(value));
								},
								message : "请正确填写您的联系电话."
							},
						});

		//向富文本框中回显数据
		function setContent(isAppendTo) {//isAppendTo

			var ddd = $("#shuju").val();

			UE.getEditor('editor1').setContent(ddd, isAppendTo);
		}

		function submitForm() {
			/* if (!$('#content').form('validate')) {
				$.messager.alert('提示', '表单还未填写完成!');
				return;
			} */
			var ddd = $("#content").serialize();
			//ajax 请求上传文件
			var form = new FormData(document.getElementById("content"));
			$.ajax({
				url : '/info/updateLost',
				data : form,
				type : 'post',
				processData : false,
				contentType : false,
				success : function(data) {
					if (data.status == 200) {
						$.messager.alert('提示', '编辑成功！');
						$("#updateInfomation").window("close");
						$("#infoList").datagrid("reload");
					} else {
						$.messager.alert('提示', '编辑失败!');
					}
				},
				statusCode : {
					500 : function() {
						$.messager.alert('提示', '编辑失败!');
					}
				}
			});
		}
	</script>

</body>
</html>
