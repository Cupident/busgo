<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>发布信息</title>
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
 <form id="content" method="post" enctype="multipart/form-data">
<div>
		<table cellpadding="5">
			<tr>
				<td>标题：</td>
				<td><input class="easyui-textbox" type="text" name="title"
					data-options="required:true" style="width: 150px;" />
				</td>
				<td>标题图：</td>

				<td><input id="file" type="file" name="file"
					 style="width: 150px;" />
				</td>

					<td><input id="imgfile" type="file" name="imgfile"
						accept="image/*" style="width: 150px;" /></td>

				<td>栏目</td>
				<td>
					<select class="easyui-combobox" name="cata" data-options="method:'post',height:25, required:true"
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
				</select>
				</td>
			</tr>
			<tr>
				<td>联系人：</td>
				<td><input class="easyui-textbox" type="text" name="author"
					data-options="required:true" style="width: 150px;" />
				</td>
				<td>联系电话：</td>
				<td><input class="easyui-textbox" type="text" name="tel"
					data-options="required:true,validType:'mobileTelephone',prompt:'请输入正确的手机号码。'" style="width: 150px;" />
				</td>
				
			</tr>
			
		</table>
	
    <script id="editor" name="content" type="text/plain" style="width:700px;height:250px;"></script>
</div>
</form>
	<div style="padding:5px" align="center">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="submitForm()">提交</a> <a href="javascript:void(0)"
			class="easyui-linkbutton" onclick="clearForm()">重置</a>
	</div>

<script type="text/javascript">

    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
     //var ue = UE.getEditor('editor');
    
    //这种方法解决只能初始化一次，第二次点击富文本框无法出现的问题，
      jQuery(function($) {
	    UE.delEditor("editor");
	    var ue = UE.getEditor("editor");
	});
	

	$.extend($.fn.validatebox.defaults.rules,
  { 
	 mobileTelephone :{
      validator : function(value) {
       var cmccMobile = /^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
       var tel = /^\d{3,4}?\d{7,8}$/;
       return tel.test(value) || (value.length == 11 && cmccMobile.test(value));
      },
      message : "请正确填写您的联系电话."
     },
     });
     
	
	function submitForm() {
		if (!$('#content').form('validate')) {
			$.messager.alert('提示', '表单还未填写完成!');
			return;
		}

		//ajax 请求上传文件
			var form = new FormData(document.getElementById("content"));
			$.ajax({
				url : '/info/addInfomation',
				data : form,
				type : 'post',
				processData : false,
				contentType : false,
			success : function(data) {
				if (data.status == 200) {
					$.messager.alert('提示', '发布成功！');
					$("#addInfo").window("close");
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
	
    function isFocus(e){
        alert(UE.getEditor('editor').isFocus());
        UE.dom.domUtils.preventDefault(e)
    }
    function setblur(e){
        UE.getEditor('editor').blur();
        UE.dom.domUtils.preventDefault(e)
    }
    function insertHtml() {
        var value = prompt('插入html代码', '');
        UE.getEditor('editor').execCommand('insertHtml', value)
    }
    function createEditor() {
        enableBtn();
        UE.getEditor('editor');
    }
    function getAllHtml() {
        alert(UE.getEditor('editor').getAllHtml())
    }
    function getContent() {
        var arr = [];
        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getContent());
        alert(arr.join("\n"));
    }
    function getPlainTxt() {
        var arr = [];
        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getPlainTxt());
        alert(arr.join('\n'))
    }
    function setContent(isAppendTo) {
        var arr = [];
        arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
        UE.getEditor('editor').setContent('欢迎使用ueditor', isAppendTo);
        alert(arr.join("\n"));
    }
    function setDisabled() {
        UE.getEditor('editor').setDisabled('fullscreen');
        disableBtn("enable");
    }

    function setEnabled() {
        UE.getEditor('editor').setEnabled();
        enableBtn();
    }

    function getText() {
        //当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
        var range = UE.getEditor('editor').selection.getRange();
        range.select();
        var txt = UE.getEditor('editor').selection.getText();
        alert(txt)
    }

    function getContentTxt() {
        var arr = [];
        arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
        arr.push("编辑器的纯文本内容为：");
        arr.push(UE.getEditor('editor').getContentTxt());
        alert(arr.join("\n"));
    }
    function hasContent() {
        var arr = [];
        arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
        arr.push("判断结果为：");
        arr.push(UE.getEditor('editor').hasContents());
        alert(arr.join("\n"));
    }
    function setFocus() {
        UE.getEditor('editor').focus();
    }
    function deleteEditor() {
        disableBtn();
        UE.getEditor('editor').destroy();
    }
    function disableBtn(str) {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            if (btn.id == str) {
                UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
            } else {
                btn.setAttribute("disabled", "true");
            }
        }
    }
    function enableBtn() {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
        }
    }

    function getLocalData () {
        alert(UE.getEditor('editor').execCommand( "getlocaldata" ));
    }

    function clearLocalData () {
        UE.getEditor('editor').execCommand( "clearlocaldata" );
        alert("已清空草稿箱")
    }
</script>
</body>
</html>
