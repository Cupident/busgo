<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div style="padding:10px 10px 10px 10px">
	<form id="content" method="post">
		<table cellpadding="5">
			<tr>
				<td>所属公司:</td>
				<td><input id="busCom1" name="busCom1" class="easyui-combobox"
					data-options="method:'post',height:25, required:true"
					style="width: 230px" /></td>
				<td>所属车队:</td>
				<td><input id="busTeam1" name="busTeam1" class="easyui-combobox"
					data-options="method:'post',height:25, required:true"
					style="width: 230px" /></td>
			</tr>

			<tr>
				<td>车牌号:</td>
				<td><input class="easyui-textbox" type="text" name="busNumber1"
					data-options="required:true" style="width: 230px;" /></td>
				<td>车辆品牌:</td>
				<td><input id="busType1" name="busType1" class="easyui-combobox"
					data-options="method:'post',height:25, required:true"
					style="width: 230px" /></td>
			</tr>
			<tr>
				<td>车主名称:</td>
				<td><input class="easyui-textbox" name="drName1"
					data-options="validType:'length[0,150]',required:true"
					style="width: 230px;"></input></td>
				<td>车主电话:</td>
				<td><input class="easyui-textbox" name="drTel1"
					data-options="validType:'length[0,150]',required:true"
					style="width: 230px;"></input></td>
			</tr>
		</table>
	</form>
	
</div>
