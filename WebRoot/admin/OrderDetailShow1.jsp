<%@ page import="order.SalesOrder"%>
<%@ page import="order.OrderMgr"%>
<%@ page import="order.SalesItem"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	request.setCharacterEncoding("utf8");
	int orderId=Integer.parseInt(request.getParameter("id"));
	SalesOrder so=OrderMgr.getInstance().loadById(orderId);
	List<SalesItem> items=OrderMgr.getInstance().getSalesItems(so);

%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>订单明细</title>
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
		<script type="text/javascript">
			function showProductInfo(descr) 
			{
				document.getElementById("productInfo").innerHTML=
					                "<font size=3 color=red>" + descr + "</font>";
			}
		</script>
	</head>
	<body>
		<span>订单管理 &#187 订单明细</span><br><br>
		<span style="margin-right:50px;">用户姓名：<%= so.getUser().getUsername() %></span>
		<span>收货地址：<%= so.getAddress() %></span>
		<table border=1 width=100% >
			<tr style="background-color:#fff1cc">
				<th id="productInfo" >商品名称</th>
				<th>会员价格</th>
				<th>购买数量</th>
				<th>订单总价</th>
			</tr>
			<%
				for(int i=0;i<items.size();i++)
				{
					SalesItem si=items.get(i);
			%>
			<tr>
				<td onmouseover="showProductInfo('<%=si.getProduct().getDescribe()%>')"><%= si.getProduct().getName() %></td>
				<td><%= si.getUnitPrice() %></td><!-- unitprice就是会员价格 -->
				<td><%= si.getCount() %></td>
				<td><%= si.getUnitPrice()*si.getCount() %></td>
			</tr>
			<%
				}
			%>
		</table>
	</body>
</html>