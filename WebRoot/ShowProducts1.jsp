<%@ page import="product.ProductMgr" %>
<%@ page import="product.Product" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	String id=request.getParameter("categoryId");
	List<Product> products=null;
	if(id!=null)
	{
		try
		{
			int categoryId=Integer.parseInt(id);
			products=ProductMgr.getInstance().getProducts(categoryId);
		}
		catch(NumberFormatException e)
		{
			e.printStackTrace();
		}
	}
	else
	{
		products=ProductMgr.getInstance().getProducts();
	}
	
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>产品服务</title>
		<link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css" />
		<style type="text/css" >
		body{
	      background:url("https://ws1.sinaimg.cn/large/006tKfTcly1fg2e1y440tj304g04g0nx.jpg")repeat;
		}
		table:hover{
		  box-shadow:0 0 15px #03a9f4;	
		}
		table table:hover{
		  box-shadow:0 0 0px #fff;	
		}
		</style>
	</head>
	<body style="padding:5% 8%;">
	<%
		for(int i=0;i<products.size();i++)
		{
			Product p=products.get(i);
	%>
		<table class="hei400 boxs10 borr10 pad15 flol backgw" style="width:330px;margin:1.5%;">
			<tr>
				<td colspan="2">
					<a href="ShowProductDetail1.jsp?id=<%= p.getId() %>" style="float:left;" >
						<img src="images/product/<%= p.getId()+".jpg" %>" class="wid300 hei300" />
					</a>
				</td>
			</tr>
			<tr>
				<td>
				<table class="martb15">
					<tr>
						<td style="text-align:left;">
							<a href="ShowProductDetail1.jsp?id=<%= p.getId() %>" style="text-decoration: none;font-size:20; ">
								<b class="fonts20 colb" style="width:25%;"><%= p.getName() %></b>
							</a>
						</td>
						<td class="textr colr fonts20" style="width:5%;" >
							<b>¥<%= p.getNormalPrice() %></b>
						</td>
					</tr>
					<tr>
						<td class="cols2 textl" style="color:#696969" >
							<%= p.getDescribe() %>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
	<%
		}
	%>	
	</body>
</html>