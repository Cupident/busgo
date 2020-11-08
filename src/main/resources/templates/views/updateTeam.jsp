<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div style="padding:10px 10px 10px 10px">
	<form id="content" method="post">
	    <table cellpadding="5">
			
			  <tr>
			    <td>车队名</td>
			    <td>
					<input id="carname" name="carname" type="text"
					data-options="method:'post',height:25, required:true"
					style="width: 230px" /></td>
			 </tr>
			  <tr>
			    <td>车队负责人</td>
			    <td>
					<input id="busdriver" class="easyui-combobox" name="administratorId"
					data-options="method:'post',height:25, required:true"
					style="width: 230px" /><input id="drName1" name="drName1"
					type="hidden" /></td>
			 </tr>
			  <tr>
			    <td>公司名称</td>
			    <td>
					<input id="busCom" name="comNumber" class="easyui-combobox"
					data-options="method:'post',height:25, required:true"
					style="width: 230px" /><input id="comNumber1" name="comNumber1"
					type="hidden" /></td>
			 </tr>
			  <tr>
			    <td>线路名称</td>
			    <td><input  id="lineName" name="lineName"  class="easyui-combobox"
					data-options="method:'post',height:25,required:true" 
					style="width: 230px;"/><input id="lineName1" name="lineName1"
					type="hidden" /> 
					</td>
			 </tr>
			 <tr>
			    <td><input name="busId" type="hidden" value=""/></td>
			 </tr>
		</table>
	</form>
	<div style="padding:5px">
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a>
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">重置</a>
	</div>
</div>
<script type="text/javascript">
/* alert($("#content").form('validate')); */
console.log($("#content").form('validate'));
	function submitForm(){
		if(!$("#content").form('validate')){
			$.messager.alert('提示','表单还未填写完成!');
			return ;
		}
		$.post("/busTeam/update",$("#content").serialize(), function(data){
			if(data.status == 200){
				$.messager.alert('提示','修改车队成功!');
				$("#TeamUpdate").window('close');
				$("#busTeam").datagrid("reload");
				clearForm();
			}else{
				$.messager.alert('提示','修改车队失败!');
			}
		});
	}
	function clearForm(){
		$('#content').form('reset');
	}
	
	//combobox获取值 公司
	 $('#busCom').combobox({
		url : "/company/all",
		valueField : 'comNumber',
		textField : 'comName',
		editable : false,
		onSelect : function(rec) {
/* 		console.log(rec); */
					$("#comNumber1").val(rec.comNumber);
			
			
		}
		
	});
	
		/* 获得司机名  */
	$('#busdriver').combobox({
				url : "/busDriver/driver",
				valueField : 'drId',
				textField : 'drName', 
				editable : false, 
				onSelect :function(rec){
			/* 	 console.log(rec); */
				$("#drName1").val(rec.drId);
				}
			});	 
			// 获得线路
			$('#lineName').combobox({
				url : "/busLine/line",
				valueField : 'lineId',
				textField : 'lineName', 
				editable : false, 
				onSelect :function(rec){
			
				$("#lineName1").val(rec.lineId);
				}
			});	 
</script>