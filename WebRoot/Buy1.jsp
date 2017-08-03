<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="client.CartItem"%>
<%@ page import="client.Cart"%>
<%@ page import="product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf8");
	Cart c = (Cart)session.getAttribute("cart");//getAttribute获得的是object类
	if(c==null)
	{
		c=new Cart();
		session.setAttribute("cart", c);
	}

	String action=request.getParameter("action");
	if(action !=null && action.trim().equals("add"))
	{
		int id=Integer.parseInt(request.getParameter("id"));
		Product p=ProductMgr.getInstance().getProduct(id);
		CartItem ci=new CartItem();
		ci.setProduct(p);
		ci.setCount(1);
		c.add(ci);
	}
	if(action != null && action.trim().equals("delete"))
	{
		int id=Integer.parseInt(request.getParameter("id"));
		c.deleteItemById(id);
	}
	if(action !=null && action.trim().equals("update"))
	{
		for(int i=0;i<c.getItems().size();i++)
		{
			CartItem ci=c.getItems().get(i);
			int count=Integer.parseInt(request.getParameter("product"+ci.getProduct().getId()));
			ci.setCount(count);
		}
	}

	
	String path=request.getContextPath();
	String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	List<CartItem>items=c.getItems();
	Iterator<CartItem> it=items.iterator();
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>购物车</title>
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
		<table style="border:3px solid #fff1cc;border-collapse:collapse;width:50% ">
			<tr style="background-color:#fff1cc;">
				<th>产品Id</th>
				<th>产品名称</th>
				<th>购买数量</th>
				<th>单价</th>
				<th>总价</th>
				<th>处理</th>
			</tr>
			<%
				while(it.hasNext())
				{
					CartItem ci=it.next();
			%>
			<tr>
				<td><%= ci.getProduct().getId() %></td>
				<td><%= ci.getProduct().getName() %></td>
				<td>
					<input type="text" size=3 name="<%= "product"+ci.getProduct().getId() %>"
						   value="<%= ci.getCount() %>"/>
				</td>
				<td><%= ci.getProduct().getNormalPrice() %></td>
				<td><%= ci.getProduct().getNormalPrice()*ci.getCount() %></td>
				<td>
					<a href="Buy1.jsp?action=delete&id=<%= ci.getProduct().getId() %>">删除</a>
				</td>
			</tr>
			<%
				}
			%>
			<tr>
				<td colspan="6">
					<a href="Confirm1.jsp" style="margin-right:100px;">确认订单</a>
					<a href="" >修改订单</a>
				</td>
			</tr>
		</table>
	</body>
</html>