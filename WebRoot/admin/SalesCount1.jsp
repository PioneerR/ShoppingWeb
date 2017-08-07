<%@ page import="stat.StatService"%>
<%@ page import="stat.ProductStatItem"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	List<ProductStatItem> items = StatService.getProductsBySaleCount(); 
	String imgName = (String)request.getAttribute("imgName");
	//从servlet转发至jsp只能用request.setAttribute()存储数据，且由于不同的页面，所拥有的的request对象是不同的
	//因此必须让两个页面都拥有同一个request对象，才可以用request.getAttribute()获得存储的数据
	//通常在jsp与jsp之间都是用可以用session.setAttribute()进行传递数据，也可以用request.setAttribute()传递数据
	//但是在servlet到jsp时，若request对象不同，导致无法传递，除非将servlet的request以及response对象传递给jsp
	//这样servlet与jsp就拥有了同一套request对象，也就可以取出存储的数据
	//System.out.println("aaa"+imgName);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>产品销售统计</title>
		<style type="text/css">
			table
			{
			 	border-collapse:collapse;
			 	text-align:center;	 	
			}	
			th,td{
				text-align:center;
				border:3px solid #fff1cc;
			}
			a{
				text-decoration: none;
			}
		</style>
	</head>
	<body>
		<table align="center" width="200px">
			<tr style="background-color:#fff1cc">
				<td>产品名称</td>
				<td>销售总量</td>
			</tr>
			<%
				for(int i=0;i<items.size();i++)
				{
					ProductStatItem p=items.get(i);
			%>
			<tr>
				<td><%= p.getProductName() %></td>
				<td><%= p.getTotalSalesCount() %></td>
			</tr>	
			<%
				}
			%>
		</table>		
		<img src="/Gouwu/admin/images/stat/<%= imgName %>" />
		<!-- request.getContextPath()返回站点根目录 -->		
	</body>
</html>