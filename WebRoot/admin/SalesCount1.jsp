<%@ page import="stat.StatService"%>
<%@ page import="stat.ProductStatItem"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	List<ProductStatItem> items = StatService.getProductsBySaleCount(); 
	String imgName = (String)request.getAttribute("imgName");
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
		<img src="<%=request.getContextPath() %>/admin/images/stat/<%= imgName %>" />
		<!-- request.getContextPath()返回站点根目录 -->		
	</body>
</html>