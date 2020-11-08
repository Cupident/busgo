<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div style="padding:10px 10px 10px 10px">
	<form id="content" method="post">
		<table cellpadding="5">
			<tr>
				<td>站点名称:</td>
				<td><input class="easyui-textbox" type="text" name="stopName"
					data-options="required:true,panelHeight:'auto'" style="width: 300px;" />
				</td>
			</tr>
			<tr>
				<td>站点方向:</td>
				<td>
				<select class="easyui-combobox" name="stopDirection" data-options="method:'post',height:25, required:true,panelHeight:'auto'"
					style="width:300px;">
						<option value="上行">上行</option>
						<option value="下行">下行</option>
				</select>
				</td>
			</tr>
			<tr>
				<td>站点类型:</td>
				<td>
					<select class="easyui-combobox" name="stopType"style="width:300px;" data-options="method:'post',height:25, required:true">
						<option value="大型站点">大型站点</option>
						<option value="中型站点">中型站点</option>
						<option value="小型站点">小型站点</option>
						<option value="微型站点">微型站点</option>
					</select>
				</td>				
			</tr>			
			<tr>
				<td>站点限速:</td>
				<td><input class="easyui-textbox" type="text" name="stopSpeed"
					data-options="required:true" style="width: 300px;" />
				</td>				
			</tr>			
			<tr>
				<td>所属省:</td>
				<td>
	            	<input id="stopProvince" name="stopProvinceid" class="easyui-combobox"
					data-options="method:'post',height:25, required:true"
					style="width: 97px" />
	            
	            	<input id="stopCity" name="stopCityid"class="easyui-combobox"
					data-options="method:'post',height:25, required:true"
					style="width: 97px" />
	            
	            	<input id="stopArea" name="stopAreaid"class="easyui-combobox"
					data-options="method:'post',height:25, required:true"
					style="width: 97px" />
	            </td>
			</tr>
			<tr>
				<td>站点描述:</td>
				<td><input class="easyui-textbox" type="text" name="stopText"
					data-options="required:true" style="width: 300px;" />
				</td>
			</tr>
			<tr>
				<td>站点状态</td>
				<td style="width:150px;">
					<input name="stopStatus" type="radio" value="1"/>正在运行
					<input name="stopStatus" type="radio" value="0"/>空闲
				</td>				
			</tr>
			<tr>
				<td>是否虚拟</td>
				<td style="width:150px;">
					<input name="stopXuni" type="radio" value="1"/>是
					<input name="stopXuni" type="radio" value="0"/>否
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
	function submitForm() {
		if (!$('#content').form('validate')) {
			$.messager.alert('提示', '表单还未填写完成!');
			return;
		}
		$.ajax({
			type : "post",
			url : "/busStop/save",
			data : $("#content").serialize(),//序列化表单
			success : function(data) {
				if (data.status == 200) {
					$.messager.alert('提示', '新增站点成功！');
					$("#addStop").window('close');
					$("#stopList").datagrid("reload");
					clearForm();
				} else {
					$.messager.alert('提示', '新增站点失败!');
				}
			},
			statusCode : {
				500 : function() {
					$.messager.alert('提示', '新增站点失败!');
				}
			}
		});
	}
	function clearForm() {
		$('#content').form('reset');
	}
	//省市县三级连查
	$('#stopProvince').combobox({
		url : "/busStop/province",
		valueField : 'provinceId',
		textField : 'province',
		editable : false,
		onSelect : function(province) {
			$('#stopCity').combobox({
				url : "/busStop/city?provinceId=" + province.provinceId,
				valueField : 'cityId',
				textField : 'city',
				editable : false,
				onSelect : function(city) {
					$('#stopArea').combobox({
						url : "/busStop/area?cityId=" + city.cityId,
						valueField : 'areaId',
						textField : 'area',
						editable : false,
					});
				}
			});
		}
	});

</script>