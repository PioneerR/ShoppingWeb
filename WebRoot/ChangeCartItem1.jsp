<%@page import="client.Cart"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="client.CartItem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	request.setCharacterEncoding("utf8");
	int productid=Integer.parseInt(request.getParameter("productid"));
	int count=Integer.parseInt(request.getParameter("count"));
	
	Cart c=(Cart)session.getAttribute("cart");
	if(c == null)
	{
		c=new Cart();
		session.setAttribute("cart", c);
	}
	
	List<CartItem>items=c.getItems();
	Iterator<CartItem> it=items.iterator();
	while(it.hasNext())
	{
		CartItem ci=it.next();
		if(ci.getProduct().getId()==productid)
		{
			ci.setCount(count);
		}
	}
	

	response.setContentType("text/html;charset=utf8");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>