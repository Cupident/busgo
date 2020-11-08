<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div style="padding:10px 10px 10px 10px">
	<form id="content" method="post">
		<table cellpadding="5">

			<tr>
				<td>车队名</td>
				<td><input id="carname" name="carname" type="text"
					data-options="method:'post',height:25, required:true"
					style="width: 230px" />
				</td>
			</tr>
			<tr>
				<td>司机名字</td>
				<td><input id="busdriver" class="easyui-combobox"
					name="administratorId"
					data-options="method:'post',height:25, required:true"
					style="width: 230px" />
				</td>
			</tr>
			<tr>
				<td>公司名称</td>
				<td><input id="busCom" name="comNumber" class="easyui-combobox"
					data-options="method:'post',height:25, required:true"
					style="width: 230px" />
				</td>
			</tr>
			<tr>
				<td>线路名称</td>
				<td><input id="lineId" name="lineId" class="easyui-textbox" 
					data-options="method:'post',height:25,required:true" 
					style="width: 230px;" />
				</td>
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
	/* 映射   将administratorId映射为drId 的值 */
	function formatteradministratorId(val, row, index) {
		return row.busDriver.drId;
	}
	function submitForm() {
		if (!$('#content').form('validate')) {
			$.messager.alert('提示', '表单还未填写完成!');
			return;
		}
		$.ajax({
			type : "post",
			url : "/busTeam/save",
			data : $("#content").serialize(),
			success : function(data) {
				if (data.status == 200) {
					$.messager.alert('提示', '新增车队成功！');
					$('#TeamAdd').window('close');
					$('#busTeam').datagrid("reload");

					clearForm();
				} else {
					$.messager.alert('提示', '新增车队失败!');
				}
			},
			statusCode : {
				500 : function() {
					$.messager.alert('提示', '新增车队失败!');
				}
			}
		});
	}
	function clearForm() {
		$('#content').form('reset');
	}
	//combobox获取值 公司
	$('#busCom').combobox({
		url : "/company/all",
		valueField : 'comNumber',
		textField : 'comName',
		editable : false,
		onSelect : function(rec) {
			$('#carname').combobox({
				url : "/busTeam/allById?comNumber=" + rec.comNumber,
				valueField : 'carname',
				textField : 'carname',
				editable : false,
			});
		}
	});

	/* 获得司机名  */
	$('#busdriver').combobox({
		url : "/busDriver/driver",
		valueField : 'drId',
		textField : 'drName',
		editable : false,
		onSelect : function() {
		}
	});
	
	/* 获得线路名  */
	$('#lineId').combobox({
		url : "/busLine/line",
		valueField : 'lineId',
		textField : 'lineName',
		editable : false,
		onSelect : function() {
		}
	});
</script>