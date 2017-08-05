<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="client.CartItem"%>
<%@page import="client.Cart"%>
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
	
	List<CartItem> items=c.getItems();
	Iterator<CartItem> it=items.iterator();
	while(it.hasNext())
	{
		CartItem ci=it.next();
		int count=ci.getCount();
		//System.out.println(count);
	}
	//System.out.println(u.getAddress());
	
	int orderId=u.buy(c);
	//买完之后，返回订单号。购买的过程中，将cartItems集合中的多个CartItem传递给商家变成SalesItem
	//组成集合List<SalesItem> salesItems，将这个集合存入订单SalesOrder对象中，返回订单号
	session.removeAttribute("cart");//cart的生命周期结束，销毁
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>订单状态</title>
	</head>
	<body>
		<h3>您的订单已成功下单....3秒钟后跳转至支付页面....</h3>
	</body>
</html>