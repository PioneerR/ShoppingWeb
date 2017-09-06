<%@ page import="user.User"%>
<%@ page import="category.CategoryService"%>
<%@ page import="category.Category"%>
<%@ page import="product.ProductMgr" %>
<%@ page import="product.Product" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	request.setCharacterEncoding("utf8");
	String id=request.getParameter("categoryId");
	List<Product> products=null;
	int cgid=0;//将类别id传给产品详情页，让其可以返回类别页面
	if(id!=null && !id.equals("0"))
	{
		try
		{
			int categoryId=Integer.parseInt(id);
			cgid=categoryId;
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
	<body>
		<%@ include file="Nav.jsp" %>		
	
		<div style="padding:10% 8% 0% 8% ;" class="overfh">
	<%
		for(int i=0;i<products.size();i++)
		{
			Product p=products.get(i);
	%>
			<table class="hei400 boxs10 borr10 pad15 flol backgw" style="width:330px;margin:1.5%;">
				<tr>
					<td colspan="2">					
						<a href="ShowProductDetail1.jsp?id=<%= p.getId() %>&cgid=<%= cgid %>" 
							target="_blank" style="float:left;">
							<img src="images/product/<%= p.getId()+".jpg" %>" class="wid300 hei300" 
								 onerror="javascript:this.src='/Gouwu/images/product/yscx.png'"/>
						</a>
					</td>
				</tr>
				<tr>
					<td>
					<table style="margin-top:10%;">
						<tr>
							<td style="text-align:left;">
								<a href="ShowProductDetail1.jsp?id=<%= p.getId() %>&cgid=<%= cgid %>" 
									style="text-decoration: none;font-size:20;">
									<b class="fonts20 colb" style="width:25%;font-family:Microsoft Yahei;">
										<%= p.getName() %>
									</b>
								</a>
							</td>
							<td class="textr colr fonts20" style="width:5%;" >
								<b>¥<%= p.getNormalPrice() %></b>
							</td>
						</tr>
						<tr>
							<td class="textl flol overfh" style="color:#696969;font-family:Microsoft Yahei;height:20px;">
								<%= p.getDescribe() %>
							</td>
							<td class="textr">
								<a href="ShowProductDetail1.jsp?id=<%= p.getId() %>&cgid=<%= cgid %>"
								   style="color:#03a9f4;">详情</a>
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
	<%
		if(products.size()==0)
		{	
	%>	
		<div class="marlrpc10 boxs10 borr10" style="height:350px;">
			<div class="widpc80 fontw700 fonts22" style="height:200px;">
				<div class="backgb flol" style="height:50px;width:50px;padding-left:2px;padding-top:2px;">
					<img src="/Gouwu/images/icon/gantanhao.png" />
				</div>
				<img src="/Gouwu/images/background/dengdai.gif" class="heia flol marlr25" 
					 style="width:200px;margin-left:26%;margin-top:10%; "/>
				<div class="flol padtbpc10  textc colb martbpc10">
					课程即将上线! 敬请期待~
				</div>
			</div>
		</div>
	<%
		}
	%>			
		<a href="javascript:window.history.go(-1)" class="flor marpc1 backgb padlr30 boxs5 textc borr5" 
		   style="margin-right:150px;padding-bottom:5px;color:#fff;margin-bottom:5%;" >
			返回
		</a>
			
		<%@ include file="Footer.jsp" %>
	    
	</body>
</html>