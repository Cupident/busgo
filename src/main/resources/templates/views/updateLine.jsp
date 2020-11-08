<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div style="padding:10px 10px 10px 10px">
	<form id="content" method="post">
		<table cellpadding="5">
			<tr>
				<td>线路名称</td>
				<td><input class="easyui-textbox" type="text" id="lineName"
					name="lineName" data-options="required:true" style="width: 230px;" />
				</td>
				<td>所属公司:</td>
				<td><input id="busCom" name="busCom" class="easyui-combobox"
					data-options="panelHeight:'auto',method:'post',height:25, required:true "
					style="width: 230px" />
					<input type="hidden" id="busCom1" name="busCom1">
					</td>
			</tr>
			<tr>
				<td>线路类型</td>
				<td><input id="lineType" name="lineType" id="lineType"
					class="easyui-combobox"
					data-options="method:'post',height:25, required:true,panelHeight:'auto'"
					style="width: 230px" />
					<input type="hidden" id="lineType1" name="lineType1">
				</td>
				<td>状态:</td>
				<td><select id="status" name="status" class="easyui-combobox"
					data-options="panelHeight:'auto'">
						<option value="1">启用</option>
						<option value="0">禁用</option>
				</select></td>
			</tr>
			<tr>
				<td>上行长度(KM):</td>
				<td><input class="easyui-textbox" type="text" name="upLength"
					data-options="required:true" style="width: 230px;" /></td>
				<td>下行长度(KM):</td>
				<td><input class="easyui-textbox" type="text" name="downLength"
					data-options="required:true" style="width: 230px;" />
			</tr>
			<tr>
				<td>上行首班车时间:</td>
				<td><input id="upStarttime" name="upStarttime"
					class="easyui-timespinner" style="width:130px;" required="required"
					 data-options="showSeconds:true" />
				</td>
				<td>上行末班车时间:</td>
				<td><input id="upOvertime" name="upOvertime"
					class="easyui-timespinner" value="20:30" style="width:80px;"
					required="required" data-options="showSeconds:true" />
				</td>
			</tr>
			<tr>
				<td>下行首班车时间:</td>
				<td><input id="downStarttime" name="downStarttime"
					class="easyui-timespinner" style="width:80px;" required="required"
					value="06:30" data-options="showSeconds:true" />
				</td>
				<td>下行末班车时间:</td>
				<td><input id="downOvertime" name="downOvertime"
					class="easyui-timespinner" value="20:30" style="width:80px;"
					required="required" data-options="showSeconds:true" />
				</td>
			</tr>
			<tr>
				<td><input id="lineId" name="lineId" type="hidden"/></td>
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
				url : "/busLine/update",
				data : $("#content").serialize(),
				success : function(data) {
					if (data.status == 200) {
						$.messager.alert('提示', '修改线路成功！');
						$('#updateLine').window("close");
						$('#lineList').datagrid("reload");
						clearForm();
					} else {
						$.messager.alert('提示', 's新增线路失败!');
					}
				},
				statusCode : {
					500 : function() {
						$.messager.alert('提示', '500新增线路失败!');
					}
				}
			});
		}
	}
	function clearForm() {
		$('#content').form('reset');
	}

	//combobox获取值公司
	$('#busCom').combobox({
		url : "/company/all",
		valueField : 'comNumber',
		textField : 'comName',
		editable : false,
		onSelect : function(rec) {
			 $("#busCom1").val(rec.comNumber);
		}
	});
	//combobox获取类型
	$('#lineType').combobox({
		url : "/busLine/alltype",
		valueField : 'lineType',
		textField : 'lineType',
		editable : false,
	});
</script>