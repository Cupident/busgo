	function showTime() {
	
		var a = new Array("��", "һ", "��", "��", "��", "��", "��");
		var week = new Date().getDay();
		var str = "  ����" + a[week];
		
		var date = new Date(); //���ڶ���
		var now = "";
		now = date.getFullYear() + "-"; //��Ӣ�ľ�����
		now = now + (date.getMonth() + 1) + "-"; //ȡ�µ�ʱ��ȡ���ǵ�ǰ��-1�����ȡ��ǰ��+1�Ϳ�����
		now = now + date.getDate() + " ";
		now = now + date.getHours() + ":";
		now = now + date.getMinutes() + ":";
		now = now + date.getSeconds() + " ";

		now = now + str;

		document.getElementById("realtime").innerHTML = now; //div��html��now����ַ��� 
		setTimeout("showTime()", 1000); //���ù�1000�������1�룬����show����

	}
	
	



		
