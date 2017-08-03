<%@ page import="product.ProductMgr" %>
<%@ page import="product.Product" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	int categoryId=Integer.parseInt(request.getParameter("categoryId"));
	List<Product> products=ProductMgr.getInstance().getProducts(categoryId);
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>产品页面</title>
	</head>
	<body>
	<%
		for(int i=0;i<products.size();i++)
		{
			Product p=products.get(i);
	%>
		<table style="width:40%;padding:10px;margin:20px;box-shadow:0 0 8px #000;border-radius:10px;">
			<tr>
				<td>
					<a href="ShowProductDetail1.jsp?id=<%= p.getId() %>" style="float:left;" >
						<img src="images/product/<%= p.getId()+".jpg" %>" height="180" width="150" />
					</a>
				</td>
				<td style="width:100%;">
					<table>
						<tr>
							<td>
								<a href="ShowProductDetail1.jsp?id=<%= p.getId() %>" style="text-decoration: none;font-size:20; ">
									<b><%= p.getName() %></b>
								</a>
							</td>
						</tr>
						<tr>						
							<div style="float:right;margin-top:30px;">
								<a href="Buy1.jsp?id=<%= p.getId() %>&action=add" target="cart">
									<img src="images/xiaoche.gif"  width=85 />
								</a>
							</div>
						</tr>
						<tr>
							<td>市场价格: ¥<%= p.getNormalPrice() %></td>
						</tr>
						<tr>
							<td>会员价格: ¥<%= p.getMemberPrice() %></td>
						</tr>
						<tr>
							<td>商品描述: <%= p.getDescribe() %></td>
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