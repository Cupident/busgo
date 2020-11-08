<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>车队管理页面</title>
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

<script type="text/javascript" src="../../js/jquery.form.js"></script></head>
</head>
<body>

	<!-- 首页车队管理 -->
	<div>
		<table class="easyui-datagrid" id="busTeam"
			data-options="singleSelect:false,pagination:true,url:'/busTeam/listjoin',method:'post',pageSize:10,toolbar:toolbar,pageList:[10,15,20]">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th
						data-options="field:'_operate',width:120,align:'center',formatter:formatOper">操作栏</th>
					<th data-options="field:'busId',width:60,align:'center',">ID</th>
					<th data-options="field:'carname',width:60,align:'center'">车队名</th>
					<th
						data-options="field:'comName',align:'center',formatter:formattercomiName">公司</th>
					<th
						data-options="field:'drName',width:80,align:'center',formatter:formatterdriverName">车队队长</th>
					<th
						data-options="field:'lineName',align:'center',formatter:formatterLine">线路</th>
				</tr>
			</thead>
		</table>
	</div>


	<!-- 选项卡界面 -->
	<!-- 移入 移出操作界面 -->

	<div id="win" class="easyui-window" title="My Window"
		style="width:1200px;height:500px"
		data-options="iconCls:'icon-save',modal:true,closed:true,toolbar:toolbar2">
		<div id="tt" class="easyui-tabs" style="height: 500px;width:1100px">

			<div data-options="title:'本队车辆显示'" style="width: 100%;height:80%,">
				<table class="easyui-datagrid" id="busList"
					style="width: 100%,height:80%"
					data-options="singleSelect:false,collapsible:true,pagination:true,toolbar:toolbar1,method:'post',pageSize:10,pageList:[2,5,10]">
					<thead>
						<tr>
							<th data-options="field:'car',checkbox:true" style="width:3%"></th>
							<th data-options="field:'carId'" style="width:5%">车辆ID</th>

							<th data-options="field:'number',align:'center'"
								style="width:10%">车牌</th>
							<th
								data-options="field:'status',align:'center',formatter:formatStatus"
								style="width:10%">状态</th>
							<th
								data-options="field:'comName',align:'center',formatter:formatterTcomName"
								style="width:10%">公司</th>
							<th
								data-options="field:'carname',align:'center',formatter:formattercarname"
								style="width:10%">车队</th>
							<th data-options="field:'type',align:'center'" style="width:10%">车辆类型</th>
							<th
								data-options="field:'setnum',align:'center',formatter:formatSetNum"
								style="width:10%">荷载人数</th>
							<th
								data-options="field:'drName',align:'center',formatter:formatterTdriverName"
								style="width:10%">司机</th>
							<th
								data-options="field:'drTel',align:'center',formatter:formatterdriverTel"
								style="width:10%">车主电话</th>
							<th
								data-options="field:'_operate',width:120,align:'center',formatter:formatMove">操作栏</th>
						</tr>
					</thead>

				</table>
			</div>
			<div data-options="title:'外队车辆显示'" style="width: 100%;height:80%">
				<table class="easyui-datagrid" id="busList1"
					style="width: 100%,height:80%"
					data-options="singleSelect:false,collapsible:true,pagination:true,method:'post',toolbar:toolbar2,pageSize:10,pageList:[10,15,20]">
					<thead>
						<tr>
							<th data-options="field:'carId',checkbox:true" style="width:3%"></th>

							<th data-options="field:'number',align:'center'"
								style="width:10%">车牌</th>
							<th
								data-options="field:'status',align:'center',formatter:formatStatus"
								style="width:10%">状态</th>
							<th
								data-options="field:'comName',align:'center',formatter:formatterTcomName"
								style="width:10%">公司</th>
							<th
								data-options="field:'carname',align:'center',formatter:formattercarname"
								style="width:10%">车队</th>
							<th data-options="field:'type',align:'center'" style="width:10%">车辆类型</th>
							<th
								data-options="field:'setnum',align:'center',formatter:formatSetNum"
								style="width:10%">荷载人数</th>
							<th
								data-options="field:'drName',align:'center',formatter:formatterTdriverName"
								style="width:10%">司机</th>
							<th
								data-options="field:'drTel',align:'center',formatter:formatterdriverTel"
								style="width:10%">车主电话</th>
							<th
								data-options="field:'_operate',width:120,align:'center',formatter:formatJoin">操作栏</th>
						</tr>

					</thead>

				</table>
			</div>

		</div>
	</div>




	<div id="TeamAdd" class="easyui-window" title="添加车队信息"
		data-options="modal:true,closed:true,iconCls:'icon-save',href:'${pageContext.request.contextPath}/to/addTeam'"
		style="width:800px;height:400px;padding:10px;">The window
		content.</div>

	<div id="TeamUpdate" class="easyui-window" title="编辑车队信息"
		data-options="modal:true,closed:true,iconCls:'icon-save',href:'${pageContext.request.contextPath}/to/updateTeam'"
		style="width:800px;height:600px;padding:10px;">The window
		content.</div>
	<div id="Teamload" class="easyui-window" title="导入车队信息"
		data-options="modal:true,closed:true,iconCls:'icon-save'"
		style="width:400px;height:200px;padding:10px;">
		<form method="POST" enctype="multipart/form-data" id="form1"
			action="busTeam/upload">
			<table>
				<tr>
					<td>上传文件:</td>
					<td><input id="upfile" type="file" name="upfile">
					</td>
				</tr>
				<tr>
                       <td></td>
					<td><input type="button" value="上传" id="btn" name="btn">
					</td>
				</tr>
			</table>
		</form>


	</div>





	<!-- -------------------------js文件操作设置-------------------------- -->
	<script type="text/javascript">

//导入excel文件
		 $(document).ready(function(){  
                $('#btn').click(function(){  
                    if(checkData()){  
                        $('#form1').ajaxSubmit({    
                            url:'/busTeam/upload',  
                            dataType: 'text',  
                            success: resutlMsg,  
                            error: errorMsg  
                        });   
                        function resutlMsg(msg){  
                            alert("导入excel成功！");     
                            $("#upfile").val("");  
                        }  
                        function errorMsg(){   
                            alert("导入excel出错！");      
                        }  
                    }  
                });  
             });  

    	     
    	    //JS校验form表单信息  
             function checkData(){  
                var fileDir = $("#upfile").val();  
                var suffix = fileDir.substr(fileDir.lastIndexOf("."));  
                if("" == fileDir){  
                    alert("选择需要导入的Excel文件！");  
                    return false;  
                }  
                if(".xls" != suffix && ".xlsx" != suffix ){  
                    alert("选择Excel格式的文件导入！");  
                    return false;  
                }  
                return true;  

     	     }
 
/* *//* 公司名字映射 */
function formattercomiName(val,row,index){
	if(row.busCompany != null){
	    return row.busCompany.comName;
	}else{
	    return "暂无";
	 }	
} 
function formatterLine(val,row,index){
console.log(row);
	if(row.busLine != null){
	    return row.busLine.lineName;
	}else{
	    return "暂无";
	 }	
} 
 
/* 选项卡内部表格映射 */


/* 车载人数映射 */
function formatSetNum(val,row){
/* console.log(row); */
	if(val == 23){
	return "微型客车（22人）";
	}else if(val == 32){
	return "中型客车（32人）";
	}else if(val==55){
	return "大型客车（55人）";
	}
	
}

/* 车辆状态映射 */
function formatStatus(val,row){

	if(val == 1){
		return "空闲";
	}else if(val == 0){
		return "正在运行";
	}else{
		return "未知";
	}
}
/* 车队名字映射 */
function formattercarname(val,row,index){
/*  console.log(row);  */
	if(row.busTeam != null){
	    return row.busTeam.carname;
	}else{
	    return "暂无";
	 }	
	 console.log(row);
}
/* 公司名字映射 */
function formatterTcomName(val,row,index){
	if(row.busTeam != null){
	    return row.busTeam.busCompany.comName;
	}else{
	    return "暂无";
	 }	
}  

/* 车司机名字映射 */
function formatterTdriverName(val,row,index){
	if(row.busDriver != null){
	    return row.busDriver.drName;
	}else{
	    return "";
	 }	
}
/* 司机电话映射 */
function formatterdriverTel(val,row,index){
	if(row.busDriver != null){
	    return row.busDriver.drTel;
	}else{
	    return "";
	 }
	
}

/* 司机名字映射 */
function formatterdriverName(val,row,index){
	if(row.busDriver != null){
	    return row.busDriver.drName;
	}else{
	    return "";
	 }
	
}

/* 车队id映射 */
 function formatterteamId(val,row,index){
	return row.busTeam.busCar.teamId;
} 



/*选择车队标签的id  */
function getSelectionsTeamIds(){
	var userList = $("#busTeam");
	var sels = userList.datagrid("getSelections");
	var idss = [];
	for(var i in sels){
		idss.push(sels[i].busId);
	}
	idss = idss.join(",");
	return idss;
}
/*选择本车队车辆标签的id  */
function getSelectionsInCarIds(){
	var userList = $("#busList");
	var sels = userList.datagrid("getSelections");
	var idsm = [];
	for(var i in sels){
		idsm.push(sels[i].carId);
	}
	idsm = idsm.join(",");
	return idsm;
}
/*选择不在本车队车辆标签的id  */
function getSelectionscarIds(){
	var userList = $("#busList1");
	var sels = userList.datagrid("getSelections");
	var ids = [];
	for(var i in sels){
		ids.push(sels[i].carId);
	}
	ids = ids.join(",");
	return ids;
}


//定义全局变量车队id
var busIdId = 0;

//打开管理界面
    function manageTeam(busId){
    	$("#win").window('open').dialog('setTitle',"管理"+busId+'车队');
    	 $("#busList").datagrid({
    		url:"/busTeam/listByTeam",
    		queryParams:{
    			busId:busId
    		}
    	}); 
    	busIdId = busId;
    	$("#busList1").datagrid({
    		url:"/busTeam/listNotInTeamByTeam",
    		queryParams:{
    			busId:busId
    		}
    	});
    	
    } 
 
 
//自定义操作列
function formatOper(val, row, index) {
            var str = "";
          /*  console.log(row); */
            str += '<a href="javascript:void(0);" onclick="manageTeam('+row.busId+')">管理</a>';
            
            return str; 
        }
function formatMove(val, row, index) {
            var str = "";
          /*   console.log(row); */
            str += '<a href="javascript:void(0);" onclick="moveTeam(' + row.carId + ')">移出车队</a>';
            return str;
                
        }
//选项卡第二页 ：  加入车队
function formatJoin(val, row, index) {
            var str = "";
            str += '<a href="javascript:void(0);" onclick="joinTeam('+row.carId +')">加入车队</a>';
            return str;
           
        }
        
        
        
        
        
//选项卡第一个       
var toolbar1 = [{
    text:'车主：<input id = "drName" style="width:60px;"/>',
},{
    text:'搜索',
    iconCls:'icon-search',
    handler:function(){
    	var drName = $("#drName").val();
    	url:"/busTeam/listByTeam";
	    $("#busList").datagrid("load",
	    {"drName" : drName,
	    "busId":busIdId});
   }
},{
    text:'重置',
    handler:function(){
    	$('#drName').val('');
    }
},{
    text:'移出车队',
    iconCls:'icon-cancel',
    handler:function(){
    	var idsm = getSelectionsInCarIds();
    	if(idsm.length == 0){
    		$.messager.alert('提示','未选中车辆!');
    		return ;
    	}
    	$.messager.confirm('确认','确定移出为  的车辆吗？',function(r){
    	    if (r){
            	$.post("/busTeam/move",{"carId":idsm,}, function(data){
        			if(data.status == 200){
        				$.messager.alert('提示','移出车队成功!',undefined,function(){
						$("#busList1").datagrid("reload");
			     		$("#busList").datagrid("reload");
        				});
        			}else{
        				$.messager.alert('提示','移出车队失败!',undefined,function(){
						$("#busList1").datagrid("reload");
			     		$("#busList").datagrid("reload");
        				});
        			}
        		});
    	    }
    	});
    }
},];
 
 var toolbar2 = [{
    text:'车牌：<input id = "number2" style="width:60px;"/>',
},{
    text:'车队：<input id = "carname2" style="width:60px;"/>',
},{
    text:'车主：<input id = "drName2" style="width:60px;"/>',
},{
    text:'搜索',
    iconCls:'icon-search',
    handler:function(){
    	var number = $("#number2").val();
    	var carname = $("#carname2").val();
    	var drName = $("#drName2").val();
	    $("#busList1").datagrid("load",{"number": number,
	                "carname" : carname,
	                "drName" : drName,
	                "busId":busIdId});
   }
},{
    text:'重置',
    handler:function(){
    	$('#number2').val('');
    	$('#carname2').val('');
    	$('#drName2').val('');
    }
},{
    text:'加入车队',
    iconCls:'icon-add',
    handler:function(){
    	var ids = getSelectionscarIds();
    	if(ids.length == 0){
    		$.messager.alert('提示','未选中车辆!');
    		return ;
    	}
    	$.messager.confirm('确认','确定加入为 '+busIdId+' 的车队吗？',function(r){
    	    if (r){
            	$.post("/busTeam/join",{"carId":ids,"teamId":busIdId}, function(data){
        			if(data.status == 200){
        				$.messager.alert('提示','加入车队成功!',undefined,function(){
						$("#busList1").datagrid("reload");
			     		$("#busList").datagrid("reload");
        				});
        			}else{
        				$.messager.alert('提示','加入车队失败!',undefined,function(){
						$("#busList1").datagrid("reload");
			     		$("#busList").datagrid("reload");
        				});
        			}
        		});
    	    }
    	});
    }
},];
 

/* 移出车队 */
function moveTeam(row){
/* console.log(row); */

	
			$.ajax({
			type : "post",
			url : "/busTeam/move",
			data :{"carId":row},
			success : function(data) {
			
			
				if (data.status == 200) {
					$.messager.alert('提示', '车辆移出成功！');
					
					$("#busList").datagrid("reload");
						$("#busList1").datagrid("reload");//刷新
					
				} else {
					$.messager.alert('提示', '车辆移出失败!');
				}
			},

		});

}
//加入车队
function joinTeam(carId){
/* console.log("busIdId"+busIdId); */
			$.ajax({
			type : "post",
			url : "/busTeam/join",
			data :{"carId":carId,"teamId":busIdId},
			success : function(data) {
				if (data.status == 200) {
					$.messager.alert('提示', '车辆入队成功！');
					$("#busList1").datagrid("reload");
			     	$("#busList").datagrid("reload");
				} else {
					$.messager.alert('提示', '车辆入队失败!');
				}
			},

		});

}
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 /*选择车队标签的id  */
function getSelectionsIds(){
	var userList = $("#busList");
	var sels = userList.datagrid("getSelections");
	console.log(sels);
	var ids = [];
	for(var i=0;i<sels.length;i++){
		ids.push(sels[i].carId);
	}
	ids = ids.join(",");
	/* console.log(ids); */
	return ids;
	
}
 
/*  车队管理 */
/* 搜索框查询 */
var toolbar = [{
    text:'车队名称：<input id = "carname" style="width:60px;"/>',
},{
    text:'公司名称：<input id = "comName" style="width:60px;"/>',
},{
    text:'搜索',
    iconCls:'icon-search',
    handler:function(){
    	var carname = $("#carname").val();
    	var comName = $("#comName").val();
	    $("#busTeam").datagrid("load",{"carname" : carname,"comName" : comName});
   }
},{
    text:'重置',
    handler:function(){
    	$('#carname').val('');
    	$('#comName').val('');
    }
},{
    text:'新增',
    iconCls:'icon-add',
    handler:function(){
    	$("#TeamAdd").window('open');
    }
},{
    text:'编辑',
    iconCls:'icon-edit',
    handler:function(){
    var idss = getSelectionsTeamIds();
    	if(idss.length == 0){
    		$.messager.alert('提示','未选中车队!');
    		return ;
    	}
    	if(idss.indexOf(',')>0){
    		$.messager.alert('提示','同时只能修改一个车队!');
    		return ;
    	}
    	
    	$.messager.confirm('确认','确定修改ID为 '+idss+' 的车队吗？',function(r){
    	     if (r){
    	           	 $("#TeamUpdate").window({
    	   onLoad: function (){
    	   var data = $("#busTeam").datagrid("getSelections")[0];
    	/*    console.log() */
    	 //回显数据
    	   $("#content").form("load",{
    	   	busId:data.busId,
    	    carname:data.carname,
    	   	administratorId:data.busDriver.drName,
    	    comNumber:data.busCompany.comName,
    	   lineName:data.busLine.lineName
    	   });
    	   
    	   	//下拉框设置初始值
			
			$("#drName1").val(data.busDriver.drId);
			$("#comNumber1").val(data.busCompany.comNumber);
			 $("#lineName1").val(data.busLine.lineId); 
			 
    	  }
    	  
    	 }).window('open');
    	     }
    	
    	})
    	  
 
    	}
    	
},{
    text:'删除',
    iconCls:'icon-cancel',
    handler:function(){
    	var idss = getSelectionsTeamIds();
    	if(idss.length == 0){
    		$.messager.alert('提示','未选中车队!');
    		return ;
    	}
    	$.messager.confirm('确认','确定删除ID为 '+idss+' 的车队吗？',function(r){
    	    if (r){
            	$.post("${pageContext.request.contextPath}/busTeam/delete",{'ids':idss}, function(data){
        			if(data.status == 200){
        				$.messager.alert('提示','删除车队成功!',undefined,function(){
        					$("#busTeam").datagrid("reload");
        				});
        			}
        		});
    	    }
    	});
    }
},
{
    text:'导入',
    iconCls:'icon-add',
    handler:function(){
    	$("#Teamload").window('open');
    }
},{
    text:'导出',
    iconCls:'icon-remove',
    handler:function(){
    	var optins = $("#busTeam").datagrid("getPager").data("pagination").options;
    	var page = optins.pageNumber;
    	var rows = optins.pageSize;
    	$("<form>").attr({
    		"action":"${pageContext.request.contextPath}/busTeam/export/excel",
    		"method":"POST"
    	}).appendTo("body").submit();
    }   /*  .append("<input type='text' name='page' value='"+page+"'/>")
    	.append("<input type='text' name='rows' value='"+rows+"'/>") */
}];

//日期格式
function timestampToTime(timestamp) {
        var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
        var Y = date.getFullYear() + '-';
        var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        var D = date.getDate() + ' ';
        var h = date.getHours() + ':';
        var m = date.getMinutes() + ':';
        var s = date.getSeconds();
        return Y+M+D;    
    }
	
</script>
</body>
</html>