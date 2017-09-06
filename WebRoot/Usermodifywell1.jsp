<%@ page import="category.CategoryService"%>
<%@ page import="category.Category"%>
<%@ page import="order.OrderMgr"%>
<%@ page import="order.SalesOrder"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="client.CartItem"%>
<%@ page import="client.Cart"%>
<%@ page import="user.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf8");

	User u=(User)session.getAttribute("user");
	if(u == null)
	{
		response.sendRedirect("UserLogin1.jsp");
		return;
	}
	
	response.setHeader("refresh","2;URL=Userinfo1.jsp");//2秒钟后跳转
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
		<title>艺术创想</title>
		<link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css" />
	</head>
	<body>
		<%@ include file="Nav.jsp" %>
		
		<div style="padding:10% 5% 5% 5%;">
			<div class="widpc100 textc colb fontw700 fonts22 boxs10 borr20" style="padding-bottom:15%;">
				<div class="backgb" style="height:50px;width:50px;padding-left:2px;padding-top:2px;margin-bottom:10%;">
					<img src="/Gouwu/images/icon/gou1.png" />
				</div>
				<img src="/Gouwu/images/icon/gou.png"/>
				<span style="margin-bottom:12%;">您的信息已修改成功...</span>
			</div>
		</div>
		
		<%@ include file="Footer.jsp" %>
	</body>
</html>


	