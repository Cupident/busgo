//����һ��ȫ�ֵı��������ڱ�����֤��
var code;
function createCode() {
	// ����Ĭ��codeΪ���ַ���
	code = '';
	// ���ó��ȣ����￴����������������4
	var codeLength = 4;
	var codeV = document.getElementById('code');
	// ��������ַ�
	var random = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D',
			'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q',
			'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
	// ѭ��codeLength �����õ�4����ѭ��4��
	for ( var i = 0; i < codeLength; i++) {
		// �����������Χ,������Ϊ0 ~ 36
		var index = Math.floor(Math.random() * 36);
		// �ַ���ƴ�� ��ÿ��������ַ� ����ƴ��
		code += random[index];
	}
	// ��ƴ�Ӻõ��ַ�����ֵ��չʾ��Value
	codeV.value = code;
}

// ���ô˴���ԭ����ÿ�ν������չʾһ���������֤�룬��������Ϊ��
window.onload = function() {
	createCode();
	show();
}

// ��������ж��Ƿ�== �Ĵ��룬�������
function loginindex() {
	var oValue = document.getElementById('input').value.toUpperCase();
	if (oValue == 0) {
		$.messager.alert('��ʾ', '��������֤�룡', 'info');
	} else if (oValue != code) {
		$.messager.alert('��ʾ', '��֤�벻��ȷ�����������룡', 'info');
		oValue = ' ';
		createCode();
	} else {
		var name = $("#userName").val();
		var pwd = $("#password").val();
		if ((name == null || name == '') || (pwd == null || pwd == '')) {
			$.messager.alert('��ʾ', '�˻��������벻��Ϊ�գ�', 'info');
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
						alert("��¼��ת����ҳ��");
						index();
					} else {

						alert("��¼ʧ��");
						$.messager.alert("��¼ʧ��");
					}
				},
				statusCode : {
					500 : function() {
						alert("���ϵ�¼ʧ��");
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
	var a = new Array("��", "һ", "��", "��", "��", "��", "��");
	var week = new Date().getDay();
	var str = "  ����" + a[week];

	var date = new Date(); // ���ڶ���
	var now = "";
	now = date.getFullYear() + "��"; // ��Ӣ�ľ�����
	now = now + (date.getMonth() + 1) + "��"; // ȡ�µ�ʱ��ȡ���ǵ�ǰ��-1�����ȡ��ǰ��+1�Ϳ�����
	now = now + date.getDate() + "��";
	now = now + date.getHours() + "ʱ";
	now = now + date.getMinutes() + "��";
	now = now + date.getSeconds() + "��";
	now = now + str;
	document.getElementById("nowDiv").innerHTML = now; // div��html��now����ַ���
	setTimeout("show()", 1000); // ���ù�1000�������1�룬����show����
}
