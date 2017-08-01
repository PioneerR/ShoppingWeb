<%@page import="java.util.List"%>
<%@ page import="category.Category"%>
<%@ page import="category.CategoryService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	List<Category> categories=CategoryService.getInstance().getTopCategories();
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>CategoryListAJAX</title>
		<script type="text/javascript" src="script/TV20.js"></script>
		<script type="text/javascript">
			var req;//建立XMLHttpRequest对象
			var gKey;
			function init()
			{
				if(window.XMLHttpRequest)
				{
					req=new XMLHttpRequest();
					//IE5、IE6浏览器
				}
				else
				{
					req=new ActiveXObject("Microsoft.XMLHTTP");
					//IE5、IE6浏览器
				}				
			}
			
			function myLabelDblClick(key,parentKey)
			{
				if(findNode(key).subitems.length>0)
				return;
				
				init();
				gKey=key;
				var url="GetCategoryChilds2.jsp?id="+escape(key);
				req.open("GET", url, true);
				req.onreadystatechange()=callback;
				req.send(null);
			}
			
			function callback()
			{
				if(4==req.readyState)
				{
					if(200==req.status)
					{
						eval(req.responseText);
						var node=findNode(gKey)
						if(node.subitems.length>0)
						{
							node.refresh();
							node.open();
						}
					}	
				}
			}
			
			
			
		
		</script>
	</head>
	<body>
		<script type="text/javascript">
		<!--
		addListener("dblclick","myLabelDblClick");
		addNode(-1,0,"类别","images/top.gif");
		<%
			for(int i=0;i<categories.size();i++)
			{
				Category c=categories.get(i);	
		%>
				addNode(<%=c.getPid()%>,<%=c.getId()%>,"<%=c.getName()%>","images/top.gif");
		<%
			}		
		%>
		showTV();
		-->
		</script>
	</body>
</html>