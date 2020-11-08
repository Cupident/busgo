<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>线路管理</title>
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
</head>
<body>
	<div>
		<table class="easyui-datagrid" id="lineList" style="width: 100%"
			title="线路列表"
			data-options="singleSelect:false,collapsible:true,pagination:true,url:'/busLine/list',method:'post',pageSize:10,toolbar:toolbar,pageList:[2,5,10]">
			<thead>
				<tr>
					<th data-options="field:'lineId',checkbox:true" style="width:2%"></th>
					<th
						data-options="field:'_operate',align:'center',formatter:formatOper"
						style="width:18%;">操作栏</th>
					<th data-options="field:'lineName',align:'center'" style="width:8%">线路名称</th>
					<th
						data-options="field:'comName',align:'center',formatter:formattercomName"
						style="width:8%">所属公司</th>
					<th data-options="field:'lineType',align:'center'" style="width:7%">线路类型</th>
					<th data-options="field:'upLength',align:'center'" style="width:7%">上行线路长度(千米)</th>
					<th data-options="field:'downLength',align:'center'"
						style="width:8%">下行线路长度(千米)</th>

					<th
						data-options="field:'upStarttime',align:'center',formatter:formatterupStarttime"
						style="width:7%">上行首班车发车时间</th>
					<th
						data-options="field:'upOvertime',align:'center',formatter:formatterupStarttime"
						style="width:8%">上行末班车发车时间</th>
					<th
						data-options="field:'downStarttime',align:'center',formatter:formatterupStarttime"
						style="width:7%">下行首班车发车时间</th>
					<th
						data-options="field:'downOvertime',align:'center',formatter:formatterupStarttime"
						style="width:10%">下行末班车发车时间</th>

					<th
						data-options="field:'status',align:'center',formatter:formatStatus"
						style="width:5%">状态</th>
				</tr>
			</thead>
		</table>
	</div>
	<!--站点管理-->
	<div id="manageLine" class="easyui-window" title="线路详细情况"
		data-options="modal:true,closed:true,iconCls:'icon-save'"
		style="width:780px;height:440px;padding:10px;">
		<div id="cc" class="easyui-layout" style="width:100%;height:100% ">
			<div data-options="region:'west'" style="width: 58px; height: 457px;"
				class="panel-body panel-body-noheader layout-body">
				<div id="naDiv"
					style="padding-left: 15px; height: 30px; line-height: 50px;"></div>
				<!--上行下行  -->
				<div id="upDiv"
					style="padding-left: 15px; height: 30px; line-height: 30px; cursor: pointer; background-color: rgb(59, 170, 227);"
					onclick="walk(0)">上行</div>
				<div id="downDiv"
					style="padding-left: 15px; margin: 2px auto; height: 30px; line-height: 30px; cursor: pointer; background-color: rgb(202, 202, 202);"
					onclick="walk(1)">下行</div>
				<input id="lineId" type="hidden" name="lineId" value="">
			</div>
			<div data-options="region:'center',border:false"
				class="panel-body panel-body-noheader layout-body">
				<table class="easyui-datagrid" id="stopList" style="width: 100%"
					title="站点"
					data-options="singleSelect:false,collapsible:true,pagination:true,method:'post',
			pageSize:10,toolbar:'#tb',pageList:[2,5,10]">
					<thead>
						<tr>
							<th data-options="field:'stopId',checkbox:true" style="width:3%"></th>
							<th
								data-options="field:'_operate',align:'center',formatter:formatOperOper"
								style="width:18%;">操作栏</th>
							<th data-options="field:'stopName',align:'center'"
								style="width:15%">站牌名称</th>
							<th data-options="field:'stopType',align:'center'"
								style="width:10%">站点类型</th>
							<th data-options="field:'stopSpeed',align:'center'"
								style="width:10%">限制速度</th>
							<th
								data-options="field:'area',align:'center',formatter:formatterPCA"
								style="width:20%">所属省市区</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		<!--分配车辆-->
		<div id="distributionbus" class="easyui-window"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width:780px;height:440px;padding:10px;">
			<table class="easyui-datagrid" id="busList" style="width: 100%"
				title="车辆"
				data-options="singleSelect:false,collapsible:true,pagination:true,method:'post',
			pageSize:10,toolbar:'#tb1',pageList:[2,5,10]">
				<thead>
					<tr>
						<th data-options="field:'carId',checkbox:true" style="width:3%"></th>
						<th data-options="field:'number',align:'center'" style="width:15%">站牌名称</th>
				</thead>
			</table>
		</div>

		<!--管理站点上方的按钮  删除，保存-->
		<div id="tb" data-options="singleSelect:false">
			<a href="javascript:void(0);" class="easyui-linkbutton"
				onclick="deleteStops()" data-options="plain:true"
				style="background-color:#66B3FF">批量删除</a> <a id="save"
				href="javascript:void(0);" class="easyui-linkbutton"
				onclick="saveStops()" data-options="plain:true"
				style="background-color:#66B3FF; display: none">保存</a>
		</div>

		<!--加入车队-->
		<div id="tb1" data-options="singleSelect:false">
			<input id="serachCar" placeholder="请输入车辆检索" style="width:120px;" />
			<a href="javascript:void(0)" class="textbox-icon searchbox-button"
				onclick="serachCar()" tabindex="-1"
				style="width: 18px; height: 34px;"></a> <a
				href="javascript:void(0);" class="easyui-linkbutton"
				onclick="joinTeam()" data-options="plain:true"
				style="background-color:#66B3FF">加入车辆</a>
		</div>
		<!-- 管理站点   站点详情-->
		<div id="checkStop" class="easyui-window" title="线路详细情况"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width:780px;height:440px;padding:10px;">
			<form id="checkStopp" method="post"
				style="width:780px;height:440px;padding:10px;">
				<table cellpadding="10" ;align="center">
					<tr>
						<td>站点名称:</td>
						<td><input class="easyui-textbox" type="text"
							name="stopName1" id="stopName1" data-options="required:true"
							style="width: 300px;" /></td>
					</tr>
					<tr>
						<td>站点方向:</td>
						<td><input class="easyui-textbox" type="text"
							id="stopDirection1" name="stopDirection1"
							data-options="required:true" style="width: 300px;" />
						</td>
					</tr>
					<tr>
						<td>站点类型:</td>
						<td><input class="easyui-textbox" type="text" id="stopType1"
							name="stopType1" data-options="required:true"
							style="width: 300px;" />
						</td>
					</tr>
					<tr>
						<td>站点限速:</td>
						<td><input class="easyui-textbox" type="text" id="stopSpeed1"
							name="stopSpeed1" data-options="required:true"
							style="width: 300px;" /></td>
					</tr>
					<tr>
						<td>所属省市区:</td>
						<td><input id="stopProvince1" name="stopProvince1"
							class="easyui-textbox"
							data-options="method:'post',height:25, required:true"
							style="width: 97px" /> <input id="stopCity1" name="stopCity1"
							class="easyui-textbox"
							data-options="method:'post',height:25, required:true"
							style="width: 97px" /> <input id="stopArea1" name="stopArea1"
							class="easyui-textbox"
							data-options="method:'post',height:25, required:true"
							style="width: 97px" /></td>
					</tr>
					<tr>
						<td>站点描述:</td>
						<td><input class="easyui-textbox" type="text"
							name="stopText1" id="stopText1" data-options="required:true"
							style="width: 300px;" /></td>
					</tr>
					<tr>
						<td>站点状态</td>
						<td style="width:150px;"><input name="stopStatus"
							id="stopStatus1" type="radio" value="1" />正在运行 <input
							name="stopStatus1" type="radio" value="0" />空闲</td>
					</tr>
					<tr>
						<td>是否虚拟</td>
						<td style="width:150px;"><input name="stopXuni1" type="radio"
							id="stopXuni1" value="1" />是 <input name="stopXuni1"
							id="stopXuni1" type="radio" value="0" />否</td>
					</tr>
				</table>
				<div>
					<!--管理站点上方的按钮  删除，保存-->
					<div id="tb" data-options="singleSelect:false">
						<a id="closebutt" href="javascript:void(0);"
							class="easyui-linkbutton" onclick="closebutt()"
							data-options="plain:true" style="background-color:#66B3FF;">关闭</a>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!--小弹窗-->
	<div id="addLine" class="easyui-window" title="新增线路信息"
		data-options="modal:true,closed:true,iconCls:'icon-save',href:'${pageContext.request.contextPath}/to/addLine'"
		style="width:70%;height:50%;padding:3%;">The window content.</div>
	<div id="updateLine" class="easyui-window" title="编辑线路信息"
		data-options="modal:true,closed:true,iconCls:'icon-save',href:'${pageContext.request.contextPath}/to/updateLine '"
		style="width:70%;height:50%;padding:10px;">The window content.</div>
	<script type="text/javascript">
/* -------------------------映射---------------------------------------	 */
	/*区县映射*/
	function formatterPCA(val,row,index){
		var province = row.hatArea.hatCity.hatProvince.province;
		var city = row.hatArea.hatCity.city;
		var area =  row.hatArea.area;
		var pca = province+""+city+""+area;
		return pca;
	}
	/*公司名称映射  */
	function formattercomName(val,row,index){
	return row.busCompany.comName;
	}
	/*映射时间*/
	function formatterupStarttime(val,row){
	var now = new Date(val);
	var hh = now.getHours(); 
	var mm = now.getMinutes();
	if(hh>=0&&hh<=12){
	var time =hh+":"+mm;
		return time+" 上午";
	}else{
		hh-=12;
		var time =hh+":"+mm;
		return time+" 下午";
		}
	}
	/* 状态 */
	function formatStatus(val,row){
	if(val == 1){
		return "启用";
	}else if(val == 0){
		return "禁用";
	}else{
		return "未知";
	}
}
//------------------------自定义线路管理操作列
        function formatOper(val, row, index) {
            var str = "";
            str += '<a href="javascript:void(0);" onclick="update(' + index + ')">编辑</a>';
            str += '  ';
            str += '<a href="javascript:void(0);" onclick="updateLine(' + row.lineId + ')">禁用</a>';
             str += '  ';
            str += '<a href="javascript:void(0);" onclick="deleteLine(' + row.lineId+ ')">删除</a>';
             str += '  ';
            str += '<a href="javascript:void(0);" onclick="manage(' + row.lineId + ')">管理站点</a>';
             str += '  ';
            str += '<a href="javascript:void(0);" onclick="distributionbus(' + row.lineId+ ')">分配车辆</a>';
             str += '  ';
            str += '<a href="javascript:void(0);" onclick="checkssss(' + index + ')">查看线路</a>';
            return str;
        }
 //------------------------------自定义站点管理
 function formatOperOper(val, row, index) {
            var str = "";
            str += '<a href="javascript:void(0);" onclick="moveup(' + index + ')">上移</a>';
            str += '  ';
            str += '<a href="javascript:void(0);" onclick="movedown(' + index + ')">下移</a>';
             str += '  ';
             str += '<a href="javascript:void(0);" onclick="checkStop(' + index + ')">详情</a>';
             str += '  ';
            return str;
        }
/*选择线路管理界面标签的id  */
function getSelectionsIds(){
	var userList = $("#lineList");
	var sels = userList.datagrid("getSelections");
	var ids = [];
	for(var i=0;i<sels.length;i++){
		ids.push(sels[i].lineId);
	}
	ids = ids.join(",");
	return ids;
}
/*选择线路管理界面标签的id  */
function getstopListIds(){
	var userList = $("#stopList");
	var sels = userList.datagrid("getSelections");
	var ids = [];
	for(var i=0;i<sels.length;i++){
		ids.push(sels[i].stopId);
	}
	ids = ids.join(",");
	return ids;
}

/*选择线路管理界面标签的id  */
function getbusListIds(){
	var userList = $("#busList");
	var sels = userList.datagrid("getSelections");
	var ids = [];
	for(var i=0;i<sels.length;i++){
		ids.push(sels[i].carId);
	}
	ids = ids.join(",");
	return ids;
}
//打开车辆分配页面  
function distributionbus(lineId){

	$("#distributionbus").window('open').dialog('setTitle',"分配"+lineId+"车辆");
    	$("#busList").datagrid({
    		url:"/busCar/queryAllByOrder",
    	});   
    	
    	 nowlineId = lineId;
   	//选中 ----------------未完成
   	$.ajax({
			type : "post",
			url : "/busCar/queryByLineId",
			data :{"lineId":lineId},
			success : function(data) {
				
			}});
   	
	/* $("#busList").datagrid('selectRow',index-1);	 */
}
//车辆分配页面的搜索框
	function serachCar(){
		var number = $("#serachCar").val();
		$("#busList").datagrid({
    		url:"/busCar/queryAllByOrder",
    		queryParams:{
    			"number":number
    		}
    	}); 
	}
// 线路调用车辆

	function joinTeam(){
		var carIds = getbusListIds();
		if(carIds.length<0){
		$.messager.alert('提示','未选中车辆!');
		}else{
		$.messager.confirm('确认','确定添加ID为 '+carIds+' 的车辆吗？',function(r){
    	    if (r){
            	$.post("/busCar/joinTeam ",{"carIds":carIds,"lineId":nowlineId}, function(data){
        			if(data.status == 200){
        				$.messager.alert('提示','调用车队成功!',undefined,function(){
        				$("#distributionbus").window('close');
        				});
        			}else{
        				$.messager.alert('提示','调用车辆!');
        				$("#distributionbus").window('close');
        			};
        		});
    	    };
    	});
    	}
	}

//当前页面的线路id
	var nowlineId = 0; 
//打开管理界面
    function manage(lineId){
    	$("#manageLine").window('open').dialog('setTitle',"管理"+lineId+'线路');
    	$("#stopList").datagrid({
    		url:"/busLine/queryAllBylineId",
    		queryParams:{
    			lineId:lineId
    		}
    	});
    	nowlineId = lineId;
    }
//批量删除   从线路中移除站点
	function deleteStops(){
		var ids = getstopListIds();
    	if(ids.length == 0){
    		$.messager.alert('提示','未选中站点!');
    		return ;
    	}
    	$.messager.confirm('确认','确定移除停用ID为 '+ids+' 的站点吗？',function(r){
    	    if (r){
            	$.post("/busLineStop/deleteLineStop",{'lineId':nowlineId,'stopIds':ids}, function(data){
        			if(data.status == 200){
        				$.messager.alert('提示','停用线路成功!',undefined,function(){
        					$("#stopList").datagrid("reload");
        				});
        			};
        		});
    	    };
    	});
	}
 
//上行下行切换
	function walk(i){
		$("#stopList").datagrid({
    		url:"/busLine/queryAllBylineId",
    		queryParams:{
    			"lineId":nowlineId,
    			"i":i
    		}
    	});
	}
//上行下行切换颜色
	$(document).ready(function(){
		$("#upDiv").click(function(){
			$("#upDiv").css("background-color","rgb(59, 170, 227)");
			$("#downDiv").css("background-color","rgb(202, 202, 202)");
		});
		$("#downDiv").click(function(){
			$("#upDiv").css("background-color","rgb(202, 202, 202)");
			$("#downDiv").css("background-color","rgb(59, 170, 227)");
		});
	}); 
		
//信息下移
	function movedown(index){
		var row = $("#stopList").datagrid('getSelected');
		mysort(index,'down','stopList');
	}
//信息上移    
    function moveup(index){
		var row = $("#stopList").datagrid('getSelected');
		mysort(index,'up','stopList');
	}
//页面上下移动总方法
function mysort(index,type,gridname){
	$("#save").show();
	if('up'==type){
		if(index !=0){
			var toup = $('#'+gridname).datagrid('getData').rows[index];
			var todown = $('#'+gridname).datagrid('getData').rows[index-1];
			//互换位置
			$('#'+gridname).datagrid('getData').rows[index] = todown;
			$('#'+gridname).datagrid('getData').rows[index-1] = toup;
			//刷新一行
			$('#'+gridname).datagrid('refreshRow',index);
			$('#'+gridname).datagrid('refreshRow',index-1);
			//选中
			$('#'+gridname).datagrid('selectRow',index-1);
		}
	}else if('down' ==type){ 
		//获取总行数
		var rows = $('#'+gridname).datagrid('getRows').length;
		if(index != rows-1){
			var toup = $('#'+gridname).datagrid('getData').rows[index];
			var todown = $('#'+gridname).datagrid('getData').rows[index+1];
			//互换位置
			$('#'+gridname).datagrid('getData').rows[index] = todown;
			$('#'+gridname).datagrid('getData').rows[index+1] = toup;
			//刷新一行
			$('#'+gridname).datagrid('refreshRow',index);
			$('#'+gridname).datagrid('refreshRow',index+1);
			$('#'+gridname).datagrid('selectRow',index+1);
		}
	}
}    
    
 
//上行下行保存站点
	function saveStops(){
		var rows = $("#stopList").datagrid('getRows');//获取所有的数据行
		var total ="";
		//站牌的id数组
		for(var i = 0; i<rows.length;i++){
			total += rows[i]['stopId'];//
			if(i !=rows.length-1){
				total +=",";
			}
		}
		$.post("/busLineStop/updateIndex",{'lineId':nowlineId,'stopIds':total}, function(data){
        			if(data.status == 200){
        				$.messager.alert('提示','调整线路成功!',undefined,function(){
        					$("#stopList").datagrid("reload");
        				});
        			}else{
        				$.messager.alert('提示','调整线路成功!',undefined,function(){
        					$("#stopList").datagrid("reload");
        				});
        			}
        			
        			$("#save").hide();
        		});
	}
//  关闭查看页面
 function closebutt(){
 	$("#checkStop").window('close');
 }
//打开查看界面    详情   菜单
    function checkStop(index){
    	var data = $("#stopList").datagrid('getData').rows[index];
    	var stopId = data.stopId;
    	$("#checkStop").window('open').dialog('setTitle',stopId+'站点');
    	  $.ajax({
			type : "post",
			url : "/busStop/AllById",
			data :{"stopId":stopId},
			success : function(data) {
				 //站点名字
				$("#stopName1").textbox("setValue",data[0].stopName);
				//方向
				$("#stopDirection1").textbox("setValue",data[0].stopDirection);
				//类型
				$("#stopType1").textbox("setValue",data[0].stopType);
				//限速
				$("#stopSpeed1").textbox("setValue",data[0].stopSpeed);
				//区
				$("#stopArea1").textbox("setValue",data[0].hatArea.area);
				//市
				$("#stopCity1").textbox("setValue",data[0].hatArea.hatCity.city);
				//省
				$("#stopProvince1").textbox("setValue",data[0].hatArea.hatCity.hatProvince.province);
				//站点描述
				$("#stopText1").textbox("setValue",data[0].stopText);
				//站点状态
				$("#stopStatus1").textbox("setValue",data[0].stopStatus);
				//是否虚拟
				$("#stopXuni1").textbox("setValue",data[0].stopXuni); 
			},
		});  
    }  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  //打开修改页面
function update(index){
	$('#lineList').datagrid('selectRow',index);// 选中的行
	var data = $('#lineList').datagrid('getSelected');
	$("#updateLine").window({
		onLoad:function(){
			//回显数据
			$("#content").form("load",{
				busCom: data.busCompany.comName,
				downLength: data.downLength,
				downOvertime: timestampToTime(data.downOvertime),
				downStarttime:timestampToTime(data.downStarttime),
				lineId: data.lineId,
				lineName: data.lineName,
				lineType: data.lineType,
				status: data.status,
				upLength: data.upLength,
				upOvertime: timestampToTime(data.upOvertime),
				upStarttime: timestampToTime(data.upStarttime),
				lineId:data.lineId
				});
			//下拉框设置初始值
			 $("#busCom1").val(data.comNumber);
			}
		}).window('open');
	}  
    
 /*--------------------线路管理界面首页-----------------------------------  */   
/*自定义删除  */
	function deleteLine(ids){
    	$.messager.confirm('确认','确定删除ID为 '+ids+' 的线路吗？',function(r){
    	    if (r){
            	$.post("/busLine/delete",{'ids':ids}, function(data){
        			if(data.status == 200){
        				$.messager.alert('提示','删除线路成功!',undefined,function(){
        					$("#lineList").datagrid("reload");
        				});
        			}
        		});
    	    };
    	});
    }
/*自定义停用  */
	function updateLine(ids){
    	$.messager.confirm('确认','确定停用ID为 '+ids+' 的线路吗？',function(r){
    	    if (r){
            	$.post("/busLine/updateStatus",{'ids':ids}, function(data){
        			if(data.status == 200){
        				$.messager.alert('提示','停用线路成功!',undefined,function(){
        					$("#lineList").datagrid("reload");
        				});
        			};
        		});
    	    };
    	});
    }

//线路管理题头文本框
var toolbar = [{
    text:'线路名称：<input id = "serach1"  style="width:60px;"/>',
},{
    text:'所属公司：<input id = "serach2"  style="width:80px;"/>',
}, {
    text:'搜索',
    iconCls:'icon-search',
    handler:function(){
    	var lineName = $("#serach1").val();
    	var comName = $("#serach2").val();
    	 $("#lineList").datagrid("load",{
    			"lineName":lineName,
				"comName":comName
    	}); 
    }
},{
    text:'重置',
    iconCls:'icon-search',
    handler:function(){
    	$('#serach1').val('');
    	$('#serach2').val('');
    }
},{
    text:'新增',
    iconCls:'icon-add',
    handler:function(){
    	$('#addLine').window('open');
    }
},{
    text:'批量停用',
    iconCls:'icon-cancel',
    handler:function(){
    	var ids = getSelectionsIds();
    	if(ids.length == 0){
    		$.messager.alert('提示','未选中用户!');
    		return ;
    	}
    	$.messager.confirm('确认','确定停用ID为 '+ids+' 的线路吗？',function(r){
    	    if (r){
            	$.post("/busLine/updateStatus",{'ids':ids}, function(data){
        			if(data.status == 200){
        				$.messager.alert('提示','停用线路成功!',undefined,function(){
        					$("#lineList").datagrid("reload");
        				});
        			};
        		});
    	    };
    	});
    }
},{
    text:'批量删除',
    iconCls:'icon-cancel',
    handler:function(){
    	var ids = getSelectionsIds();
    	if(ids.length == 0){
    		$.messager.alert('提示','未选中用户!');
    		return ;
    	}
    	$.messager.confirm('确认','确定删除ID为 '+ids+' 的线路吗？',function(r){
    	    if (r){
            	$.post("/busLine/delete",{'ids':ids}, function(data){
        			if(data.status == 200){
        				$.messager.alert('提示','删除线路成功!',undefined,function(){
        					$("#lineList").datagrid("reload");
        				});
        			};
        		});
    	    };
    	});
    }
},'-',{
    text:'导出',
    iconCls:'icon-remove',
    handler:function(){
    	$("<form>").attr({
    		"action":"${pageContext.request.contextPath}/busLine/excel",
    		"method":"POST"
    	}).appendTo("body").submit();
    }}];
        
function timestampToTime(timestamp) {
        var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
        var Y = date.getFullYear() + '-';
        var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        var D = date.getDate() + ' ';
        var h = date.getHours() + ':';
        var m = date.getMinutes() + ':';
        var s = date.getSeconds();
        return h+m+s;    
    };

</script>
</body>
</html>