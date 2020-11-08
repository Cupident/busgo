//设置一个全局的变量，便于保存验证码
var code;
function createCode() {
	// 首先默认code为空字符串
	code = '';
	// 设置长度，这里看需求，我这里设置了4
	var codeLength = 4;
	var codeV = document.getElementById('code');
	// 设置随机字符
	var random = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D',
			'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q',
			'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
	// 循环codeLength 我设置的4就是循环4次
	for ( var i = 0; i < codeLength; i++) {
		// 设置随机数范围,这设置为0 ~ 36
		var index = Math.floor(Math.random() * 36);
		// 字符串拼接 将每次随机的字符 进行拼接
		code += random[index];
	}
	// 将拼接好的字符串赋值给展示的Value
	codeV.value = code;
}

// 设置此处的原因是每次进入界面展示一个随机的验证码，不设置则为空
window.onload = function() {
	createCode();
	show();
}

// 下面就是判断是否== 的代码，无需解释
function loginindex() {
	var oValue = document.getElementById('input').value.toUpperCase();
	if (oValue == 0) {
		$.messager.alert('提示', '请输入验证码！', 'info');
	} else if (oValue != code) {
		$.messager.alert('提示', '验证码不正确，请重新输入！', 'info');
		oValue = ' ';
		createCode();
	} else {
		var name = $("#userName").val();
		var pwd = $("#password").val();
		if ((name == null || name == '') || (pwd == null || pwd == '')) {
			$.messager.alert('提示', '账户名和密码不能为空！', 'info');
			return;
		} else {
			$.ajax({
				type : "post",
				url : "/user/login",
				data : {
					'userName' : name,
					'password' : pwd
				},
				success : function(data) {

					if (data.status == 200) {
						alert("登录到转发的页面");
						index();
					} else {

						alert("登录失败");
						$.messager.alert("登录失败");
					}
				},
				statusCode : {
					500 : function() {
						alert("故障登录失败");
					}
				}
			})
		}
	}
}

function index() {
	window.location.href = "/info/limit";
}

function show() {
	var a = new Array("日", "一", "二", "三", "四", "五", "六");
	var week = new Date().getDay();
	var str = "  星期" + a[week];

	var date = new Date(); // 日期对象
	var now = "";
	now = date.getFullYear() + "年"; // 读英文就行了
	now = now + (date.getMonth() + 1) + "月"; // 取月的时候取的是当前月-1如果想取当前月+1就可以了
	now = now + date.getDate() + "日";
	now = now + date.getHours() + "时";
	now = now + date.getMinutes() + "分";
	now = now + date.getSeconds() + "秒";
	now = now + str;
	document.getElementById("nowDiv").innerHTML = now; // div的html是now这个字符串
	setTimeout("show()", 1000); // 设置过1000毫秒就是1秒，调用show方法
}
