var isIE=true;
var imgUp="images/arrowUp.gif";
var imgDn="images/arrowDn.gif";

function expandIt(head,fExpandOnly)//head fExpandOnly没有进行var定义，都是全局变量
{
	//想获得对象，那么在执行语句外不能加""，否则就不是执行语句，而是一整个字符串了
	//var parent="document.getElementByName("+head+"Parent)";
	
	var child=document.getElementById(head+"Child");
	//getElementById在ie以及Firefox都适用
	//head+字符串就是字符串，不需要"'"+head+"Child'"
	//getElementByName不支持ie浏览器，且似乎只支持input标签-------待检测
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


