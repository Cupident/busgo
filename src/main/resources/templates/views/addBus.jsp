<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div style="padding:10px 10px 10px 10px">
	<form id="content" method="post">
		<table cellpadding="5">
			<tr>
				<td>所属公司:</td>
				<td><input id="busCom" name="busCom" class="easyui-combobox"
					data-options="method:'post',height:25, required:true"
					style="width: 230px" /></td>
				<td>所属车队:</td>
				<td><input id="busTeam" name="busTeam" class="easyui-combobox"
					data-options="method:'post',height:25, required:true"
					style="width: 230px" /></td>
			</tr>

			<tr>
				<td>车牌号:</td>
				<td><input class="easyui-textbox" type="text" name="busNumber"
					data-options="required:true" style="width: 230px;" /></td>
				<td>车辆品牌:</td>
				<td><input id="busType" name="busType" class="easyui-combobox"
					data-options="method:'post',height:25, required:true"
					style="width: 230px" /></td>
			</tr>
			<tr>
				<td>车主名称:</td>
				<td><input class="easyui-textbox" name="drName"
					data-options="validType:'length[0,150]',required:true"
					style="width: 230px;"></input></td>
				<td>车主电话:</td>
				<td><input class="easyui-textbox" name="drTel"
					data-options="validType:'length[0,150]',required:true"
					style="width: 230px;"></input></td>
			</tr>
		</table>
	</form>
	<div style="padding:5px" align="center">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="submitForm()">提交</a> <a href="javascript:void(0)"
			class="easyui-linkbutton" onclick="clearForm()">重置</a>
	</div>
</div>
<script type="text/javascript">
	function submitForm() {
		if (!$('#content').form('validate')) {
			$.messager.alert('提示', '表单还未填写完成!');
			return;
		} else {
		
			$.ajax({
				type : "post",
				url : "/busCar/save",
				data : $("#content").serialize(),
				success : function(data) {
					console.log(data);
					if (data.status == 200) {
						$.messager.alert('提示', '新增车辆成功！');
						$('#addBus').window("close");
						$('#busList').datagrid("reload");
						clearForm();
					} else {
						$.messager.alert('提示', 's新增车辆失败!');
					}
				},
				statusCode : {
					500 : function() {
						$.messager.alert('提示', '500新增车辆失败!');
					}
				}
			});
		}
	}
	function clearForm() {
		$('#content').form('reset');
	}
	//combobox获取值
	$('#busCom').combobox({
		url : "/company/all",
		valueField : 'comId',
		textField : 'comName',
		editable : false,
		onSelect : function(rec) {
			$('#busTeam').combobox({
				url : "/busTeam/allById?com_number=" + rec.comNumber,
				valueField : 'busId',
				textField : 'carname',
				editable : false,
			});
		}
	});
	$('#busType').combobox({
		url : "/busCar/all",
		valueField : 'type',
		textField : 'type',
		editable : false,
	});
</script>