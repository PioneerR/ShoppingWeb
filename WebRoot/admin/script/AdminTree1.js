var isIE=true;
var imgUp="images/arrowUp.gif";
var imgDn="images/arrowDn.gif";

function expandIt(head,fExpandOnly)//head fExpandOnlyû�н���var���壬����ȫ�ֱ���
{
	//���ö�����ô��ִ������ⲻ�ܼ�""������Ͳ���ִ����䣬����һ�����ַ�����
	//var parent="document.getElementByName("+head+"Parent)";
	
	var child=document.getElementById(head+"Child");
	//getElementById��ie�Լ�Firefox������
	//head+�ַ��������ַ���������Ҫ"'"+head+"Child'"
	//getElementByName��֧��ie����������ƺ�ֻ֧��input��ǩ-------�����
	//alert(child);
	if(child.style.display=="block")
	{
		child.style.display="none";
	}
	else
	{
		child.style.display="block";
	}
	return false;
}


