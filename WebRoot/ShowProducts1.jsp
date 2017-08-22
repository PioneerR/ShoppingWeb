<%@page import="user.User"%>
<%@page import="category.CategoryService"%>
<%@page import="category.Category"%>
<%@ page import="product.ProductMgr" %>
<%@ page import="product.Product" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	request.setCharacterEncoding("utf8");
	List<Category> categories=CategoryService.getInstance().getCategoriesGradeTwo();
	User u=(User)session.getAttribute("user");
	
	String action=request.getParameter("action");
	if(action !=null && action.equals("exit"))
	{
		session.invalidate();
		response.sendRedirect("/Gouwu/");
	}

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
	
	
	
	
	//从登录页面返回时能够强制刷新
	response.setHeader("Pragma","No-cache"); 		
	response.setHeader("Cache-Control","no-cache"); 
	response.setHeader("Cache-Control", "No-store");
	response.setDateHeader("Expires", 0);
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
		<div class="widpc100 backgb" style="position:fixed;top:0;height:70px;
			 box-shadow:5px 5px 8px #B5B4B4,-5px 5px 8px #B5B4B4;" id="nav">
			<nav style="" class="overfh">
				<div class="flol" style="margin-right:20px;margin-left:7%;">
					<a href="Index1.jsp" style="color:white;" class="fontw700">				
						<img src="/Gouwu/images/icon/yscx.png" class="wida" style="height:50px;">艺术创想
					</a>
				</div>
				
				<div class="itemshow flol wid100 textc" style="margin-top:17px; ">
					<a href="ShowProducts1.jsp" class="" style="color:#fff;">课程</a>
					<div class="itemhide" style="margin-left:18%;width:150px;padding-bottom:5px;">
					<%
						Category cg=categories.get(0);				
					%>		
						<a href="ShowProducts1.jsp?categoryId=<%= cg.getId() %>">
							<div class="item backgw borrt5 textc fonts16 colgy" style="line-height:37px;">
								<%= cg.getName() %>
							</div>
						</a>						
					<%						
						for(int i=1;i<categories.size()-1;i++)
						{							
							cg=categories.get(i);							
					%>	
						<a href="ShowProducts1.jsp?categoryId=<%= cg.getId() %>">
							<div class="item backgw textc fonts16 colgy" style="line-height:37px;">
								<%= cg.getName() %>
							</div>
						</a>
					<%
						}
							cg=categories.get(categories.size()-1);							
					%>
						<a href="ShowProducts1.jsp?categoryId=<%= cg.getId() %>" >
							<div class="item backgw borrb5 textc fonts16 colgy" style="line-height:37px;">
								<%= cg.getName() %>
							</div>
						</a>	
					</div>
				</div>
				
				<div class="itemshow flol wid100 textc" style="margin-top:17px;margin-left:45%; ">
					<a href="Buy1.jsp" class="" style="color:#fff;">
						<img src="/Gouwu/images/background/cart2.png" class="wida" style="height:22px;">
					</a>
					<div class="itemhide" style="width:150px;padding-bottom:5px; ">
						<a href="Buy1.jsp">
							<div class="item backgw textc fonts16 colgy borr5" style="line-height:37px;margin-right:15%;">
								查看购物车
							</div>
						</a>
					</div>
				</div>
				
		<%
			if(u==null)
			{
		%>	
				<div class="flol marlr15" style="margin-top:25px;" >
					<a href="Register1.jsp" style="color:white;">
						<img src="/Gouwu/images/icon/signup.png" class="wida" style="height:20px;margin-right:5px;">注册
					</a>
				</div>
				<div class="flol marlr15" style="margin-top:25px;" >
					<a href="UserLogin1.jsp" style="color:white;">
						<img src="/Gouwu/images/icon/signin.png" class="wida" style="height:20px;">登录
					</a>
				</div>
		<%
			}
			else
			{
		%>
				<div class="itemshow flol marlr15" style="margin-top:17px;" >
					<a href="" style="color:white;">
						<img src="/Gouwu/images/icon/user.png" class="wida" 
							 style="height:20px;margin-right:5px;">
						<%= u.getUsername() %>
					</a>
					<div class="itemhide" style="width:150px;padding-bottom:5px;">
						<a href="Orderstatus1.jsp">
							<div class="item borrt5 textc backgw colgy fonts16" style="line-height:37px;margin-right:10%;">
								我的订单
							</div>
						</a>
						<a href="Index1.jsp?action=exit">
							<div class="item borrb5 textc backgw colgy fonts16" style="line-height:37px;margin-right:10%;">
								退出
							</div>
						</a>					
					</div>
				</div>
		<%
			}
		%>	
			</nav>
		</div>
	
		<div style="padding:10% 8% 0% 8% ;" class="overfh">
	<%
		for(int i=0;i<products.size();i++)
		{
			Product p=products.get(i);
	%>
			<table class="hei400 boxs10 borr10 pad15 flol backgw" style="width:330px;margin:1.5%;">
				<tr>
					<td colspan="2">
						<a href="ShowProductDetail1.jsp?id=<%= p.getId() %>&cgid=<%= cgid %>" target="_blank" style="float:left;" >
							<img src="images/product/<%= p.getId()+".jpg" %>" class="wid300 hei300" />
						</a>
					</td>
				</tr>
				<tr>
					<td>
					<table style="margin-top:15%;">
						<tr>
							<td style="text-align:left;">
								<a href="ShowProductDetail1.jsp?id=<%= p.getId() %>&cgid=<%= cgid %>" style="text-decoration: none;font-size:20; ">
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
			<div class="flol heia martbpc1 fonts14" style="margin-left:38%;">
				Copyright © 2017 艺术创想  Designed by 
				<a href="https://github.com/PioneerR" target="_blank" style="color:#03a9f4;">PioneerR</a>
			</div>
	    </div>
	    
	</body>
</html>