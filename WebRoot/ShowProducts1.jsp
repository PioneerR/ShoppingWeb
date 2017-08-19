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
		<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
		<title>艺术创想</title>
		<link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css" />
		<style type="text/css" >
			table:hover{
			  box-shadow:0 0 15px #03a9f4;	
			}
			table table:hover{
			  box-shadow:0 0 0px #fff;	
			}
		</style>		
	</head>
	<body >
		<div style="padding:5% 8%;" class="overfh">
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
									<b class="fonts20 colb" style="width:25%;font-family:Microsoft Yahei;"><%= p.getName() %></b>
								</a>
							</td>
							<td class="textr colr fonts20" style="width:5%;" >
								<b>¥<%= p.getNormalPrice() %></b>
							</td>
						</tr>
						<tr>
							<td class="cols2 textl" style="color:#696969;font-family:Microsoft Yahei;" >
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
		</div>
		
		<div class="widpc100 backgbs overfh" style="height:100px;padding-top:30px;background-color:#eafbf6;margin-top:50px; ">
	    	<div class="widpc100 heia">
		    	<div class="flol backgr" style="margin-right:20px;margin-left:45%;border-radius:60%;height:40px;width:40px;">
			    	<a href="" target="_blank" style="position:relative;left:22%;top:22%;">				
						<img src="/Gouwu/images/icon/weibo.png" class="wida" style="height:20px;border-radius:50%">
					</a>
				</div>
				<div class="flol" style="margin-right:20px;border-radius:60%;height:40px;width:40px;background-color:#4867AA;">
					<a href="" target="_blank" style="position:relative;left:20%;top:20%;">				
						<img src="/Gouwu/images/icon/facebook.png" class="wida" style="height:25px;border-radius:50%">
					</a>
				</div>
				<div class="flol backg" style="margin-right:20px;border-radius:60%;height:40px;width:40px;">
					<a href="https://github.com/PioneerR" style="position:relative;left:20%;top:20%;">				
						<img src="/Gouwu/images/icon/github.png" class="wida" style="height:25px;border-radius:50%">
					</a>
				</div>
			</div>
			<div class="flol widpc100 heia martbpc1 fonts14" style="margin-left:38%;">
				Copyright © 2017 艺术创想  Designed by 
				<a href="https://github.com/PioneerR" target="_blank" style="color:#03a9f4;">PioneerR</a>
			</div>
	    </div>
	    
	</body>
</html>