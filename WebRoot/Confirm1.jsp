<%@page import="java.util.Iterator"%>
<%@ page import="client.Cart"%>
<%@ page import="client.CartItem"%>
<%@ page import="java.util.List"%>
<%@ page import="user.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	User u=(User)session.getAttribute("user");
	if(u == null)
	{
		response.sendRedirect("UserLogin1.jsp");
		return;
	}
	
	Cart c=(Cart)session.getAttribute("cart");
	if(c == null)
	{
		c=new Cart();
		session.setAttribute("cart", c);
	}
	
	String [] ids=request.getParameterValues("check");
	System.out.println(ids[0]);
	
	//List<CartItem> items=c.getItems();
	//Iterator<CartItem> it=items.iterator();
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>确认订单明细</title>
		<style type="text/css">
			td{
				text-align:center;
				border:3px solid #fff1cc;
			}
			a{
				text-decoration: none;
			}
		</style>
	</head>
	<body>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		<form action="Order1.jsp" method="post">
		<input type="hidden" name="action" value="confirm"/>
		<table style="border:3px solid #fff1cc;border-collapse:collapse;width:50% ">
			<tr style="background-color:#fff1cc;">
				<th>产品Id</th>
				<th>产品名称</th>
				<th>购买数量</th>
				<th>单价</th>
				<th>总价</th>
			</tr>
			<%
				//while(it.hasNext())
				//{
					//CartItem ci=it.next();
				for(int i=0;i<ids.length;i++)
				{
					int id=Integer.parseInt(ids[i]);
					CartItem ci=c.getItemByPid(id);	
			%>
			<tr>
				<td><%= ci.getProduct().getId() %></td>
				<td><%= ci.getProduct().getName() %></td>
				<td><%= ci.getCount() %></td>
				<td><%= ci.getProduct().getNormalPrice() %></td>
				<td><%= ci.getProduct().getNormalPrice()*ci.getCount() %></td>
			</tr>
			<%
				}
			%>
			<tr>
				<td colspan="6" style="text-align:right; ">
					收货地址：<%= u.getAddress() %><br>
					联系方式：<%= u.getPhone() %><br>
					<input type="submit" name="confirm" value="提交订单" />
				</td>
			</tr>
		</table>
		</form>
	</body>
</html>