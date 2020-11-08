<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>汽车管理系统</title>
<link rel="stylesheet" type="text/css"
	href="/js/jquery-easyui-1.4.1/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css"
	href="/js/jquery-easyui-1.4.1/themes/icon.css" />
<script type="text/javascript"
	src="/js/jquery-easyui-1.4.1/jquery.min.js"></script>
<script type="text/javascript"
	src="/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="/js/jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="../../js/jquery.form.js"></script>
</head>
<body>
	<div>
		<table class="easyui-datagrid" id="busList" style="width: 100%"
			title="bus列表"
			data-options="singleSelect:false,collapsible:true,pagination:true,url:'/busCar/listBymany',method:'post',pageSize:10,toolbar:toolbar,pageList:[2,5,10]">
			<thead>
				<tr>
					<th data-options="field:'carId',checkbox:true" style="width: 3%"></th>
					<th
						data-options="field:'_operate',align:'center',formatter:formatOper"
						style="width: 10%;">操作栏</th>
					<th data-options="field:'number',align:'center'" style="width: 10%">车牌</th>
					<th
						data-options="field:'comName',align:'center',formatter:formattercomName"
						style="width: 10%">公司</th>
					<th
						data-options="field:'carname',align:'center',formatter:formattercarname"
						style="width: 10%">车队</th>
					<th data-options="field:'type',align:'center'" style="width: 10%">车辆类型</th>
					<th
						data-options="field:'setnum',align:'center',formatter:formatSetNum"
						style="width: 10%">荷载人数</th>
					<th
						data-options="field:'drName',align:'center',formatter:formatterdrName"
						style="width: 10%">车主</th>
					<th
						data-options="field:'drTel',align:'center',formatter:formatterdrTel"
						style="width: 10%">车主电话</th>
					<th
						data-options="field:'status',align:'center',formatter:formatStatus"
						style="width: 5%">状态</th>
				</tr>
			</thead>
		</table>
	</div>
	<div id="addBus" class="easyui-window" title="新增车辆信息"
		data-options="modal:true,closed:true,iconCls:'icon-save',href:'${pageContext.request.contextPath}/to/addBus'"
		style="width: 70%; height: 30%; padding: 3%;">The window
		content.</div>

	<div id="checkBus" class="easyui-window" title="车辆详细情况"
		data-options="modal:true,closed:true,iconCls:'icon-save',href:'${pageContext.request.contextPath}/to/checkBus'"
		style="width: 780px; height: 440px; padding: 10px;">The window
		content.</div>
	<div id="updateBus" class="easyui-window" title="编辑车辆信息"
		data-options="modal:true,closed:true,iconCls:'icon-save',href:'${pageContext.request.contextPath}/to/updateBus '"
		style="width: 780px; height: 440px; padding: 10px;">The window
		content.</div>
	<div id="Teamload" class="easyui-window" title="导入车辆信息"
		data-options="modal:true,closed:true,iconCls:'icon-save'"
		style="width: 400px; height: 300px; padding: 10px;">
		<form method="POST" enctype="multipart/form-data" id="form1"
			action="busTeam/upload">
			<table>
				<tr>
					<td>上传文件:</td>
					<td><input id="upfile" type="file" name="upfile"></td>
				</tr>
				<tr>

					<td><input type="button" value="ajax方式提交" id="btn" name="btn">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<script type="text/javascript">
		function formattercomName(val, row, index) {
			return row.busTeam.busCompany.comName;
		}
		function formattercarname(val, row, index) {
			return row.busTeam.carname;
		}
		function formattercarname(val, row, index) {
			return row.busTeam.carname;
		}
		function formatterdrName(val, row, index) {
			return row.busDriver.drName;
		}
		function formatterdrTel(val, row, index) {
			return row.busDriver.drTel;
		}
		/*选择标签的id  */
		function getSelectionsIds() {
			var userList = $("#busList");
			var sels = userList.datagrid("getSelections");
			console.log(sels);
			var ids = [];
			for (var i = 0; i < sels.length; i++) {
				ids.push(sels[i].carId);
			}
			ids = ids.join(",");
			console.log(ids);
			return ids;
		}

		//导入excel文件
		$(document).ready(function() {
			$('#btn').click(function() {
				if (checkData()) {
					$('#form1').ajaxSubmit({
						url : '/busCar/ajaxUpload',
						dataType : 'text',
						success : resutlMsg,
						error : errorMsg
					});
					function resutlMsg(msg) {
						alert("倒入成功");
						$("#Teamload").window('close');
					}
					function errorMsg() {
						alert("导入excel出错！");
					}
				}
			});
		});

		//JS校验form表单信息  
		function checkData() {
			var fileDir = $("#upfile").val();
			var suffix = fileDir.substr(fileDir.lastIndexOf("."));
			if ("" == fileDir) {
				alert("选择需要导入的Excel文件！");
				return false;
			}
			if (".xls" != suffix && ".xlsx" != suffix) {
				alert("选择Excel格式的文件导入！");
				return false;
			}
			return true;
		}

		//打开检查页面  
		function check(index) {
			$("#checkBus").window({
				onLoad : function() {
					/* var data = $("#busList").datagrid("getSelections")[0];
					$("#busCom1").textbox("setValue",data.busTeam.busCompany.comName);
					$("#busTeam1").textbox("setValue",data.busTeam.carname);
					$("#busNumber1").textbox("setValue",data.number);
					$("#busType1").textbox("setValue",data.type); */
					//回显数据
					var data = $("#busList").datagrid("getSelections")[0];
					$("#content").form("load", {
						busCom1 : data.busTeam.busCompany.comName,
						busTeam1 : data.busTeam.carname,
						busNumber1 : data.number,
						busType1 : data.type,
						drName1 : data.busDriver.drName,
						drTel1 : data.busDriver.drTel
					});
				}
			}).window('open');
		}

		//打开修改页面
		function update(index) {
			$('#busList').datagrid('selectRow', index);// 关键在这里
			var data = $('#busList').datagrid('getSelected');
			$("#updateBus").window({
				onLoad : function() {
					//回显数据
					$("#content").form("load", {
						busCom : data.busTeam.busCompany.comName,
						busTeam : data.busTeam.carname,
						busNumber : data.number,
						busType : data.type,
						drName : data.busDriver.drName,
						drTel : data.busDriver.drTel,
						carId : data.carId
					});
					//下拉框设置初始值
					$("#busTeam1").val(data.busTeam.busId);
					$("#busCom1").val(data.busTeam.busCompany.comId);
					$("#drName1").val(data.busDriver.drId);
				}
			}).window('open');
		}
		//自定义操作列
		function formatOper(val, row, index) {
			var str = "";
			str += '<a href="javascript:void(0);" onclick="update(' + index
					+ ')">修改</a>';
			str += '  ';
			str += '<a href="javascript:void(0);" onclick="check(' + row.carId
					+ ')">查看</a>';
			return str;
		}

		function formatSetNum(val, row) {
			if (val == 23) {
				return "微型客车（22人）";
			} else if (val == 32) {
				return "中型客车（32人）";
			} else if (val == 55) {
				return "大型客车（55人）";
			}

		}
		function formatStatus(val, row) {
			if (val == 1) {
				return "空闲";
			} else if (val == 0) {
				return "正在运行";
			} else {
				return "未知";
			}
		}

		var toolbar = [
				{
					text : '车主姓名：<input id = "serach1"  style="width:40px;"/>',
				},
				{
					text : '车牌号码：<input id = "serach2"  style="width:40px;"/>',
				},
				{
					text : '所属公司：<input id = "serach3"  style="width:40px;"/>',
				},
				{
					text : '所属车队：<input id = "serach4"  style="width:40px;"/>',
				},
				{
					text : '搜索',
					iconCls : 'icon-search',
					handler : function() {
						var drName = $("#serach1").val();
						var number = $("#serach2").val();
						var comName = $("#serach3").val();
						var carname = $("#serach4").val();

						$("#busList").datagrid("load", {
							"drName" : drName,
							"number" : number,
							"comName" : comName,
							"carname" : carname
						});
					}
				},
				{
					text : '重置',
					iconCls : 'icon-search',
					handler : function() {
						$('#serach1').val('');
						$('#serach2').val('');
						$('#serach3').val('');
						$('#serach4').val('');
					}
				},
				{
					text : '新增',
					iconCls : 'icon-add',
					handler : function() {
						$('#addBus').window('open');
					}
				},
				{
					text : '删除',
					iconCls : 'icon-cancel',
					handler : function() {
						var ids = getSelectionsIds();
						if (ids.length == 0) {
							$.messager.alert('提示', '未选中用户!');
							return;
						}
						$.messager
								.confirm(
										'确认',
										'确定删除ID为 ' + ids + ' 的车辆吗？',
										function(r) {
											if (r) {
												$
														.post(
																"/busCar/delete",
																{
																	'ids' : ids
																},
																function(data) {
																	if (data.status == 200) {
																		$.messager
																				.alert(
																						'提示',
																						'删除车辆成功!',
																						undefined,
																						function() {
																							$(
																									"#busList")
																									.datagrid(
																											"reload");
																						});
																	}
																});
											}
										});
					}
				},
				'-',
				{
					text : '导入',
					iconCls : 'icon-add',
					handler : function() {
						$("#Teamload").window('open');
					}
				},
				'-',
				{
					text : '导出',
					iconCls : 'icon-remove',
					handler : function() {
						var optins = $("#busList").datagrid("getPager").data(
								"pagination").options;
						var page = optins.pageNumber;
						var rows = optins.pageSize;
						$("<form>")
								.attr(
										{
											"action" : "${pageContext.request.contextPath}/busCar/export/excel",
											"method" : "POST"
										}).appendTo("body").submit();
					} /*  .append("<input type='text' name='page' value='"+page+"'/>")
					 	.append("<input type='text' name='rows' value='"+rows+"'/>") */
				} ];

		function timestampToTime(timestamp) {
			var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
			var Y = date.getFullYear() + '-';
			var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1)
					: date.getMonth() + 1)
					+ '-';
			var D = date.getDate() + ' ';
			var h = date.getHours() + ':';
			var m = date.getMinutes() + ':';
			var s = date.getSeconds();
			return Y + M + D;
		}
	</script>
</body>
</html>