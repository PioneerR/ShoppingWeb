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
	List<Category> categories=CategoryService.getInstance().getCategoriesGradeTwo();
	User u=(User)session.getAttribute("user");
	
	String action=request.getParameter("action");
	if(action !=null && action.equals("exit"))
	{
		session.removeAttribute("user");
		response.sendRedirect("Index1.jsp");
	}

	request.setCharacterEncoding("utf8");
	if(u == null)
	{
		response.sendRedirect("UserLogin1.jsp");
		return;
	}
	
	Cart cc=(Cart)session.getAttribute("cartorder");
	List<CartItem> items=cc.getItems();
	Iterator<CartItem> it=items.iterator();
	while(it.hasNext())
	{
		CartItem ci=it.next();
		int count=ci.getCount();
		//System.out.println(count);
	}
	//System.out.println(u.getAddress());
	
	int orderId=u.buy(cc);
	//买完之后，返回订单号。购买的过程中，将cartItems集合中的多个CartItem传递给商家变成SalesItem
	//组成集合List<SalesItem> salesItems，将这个集合存入订单SalesOrder对象中，返回订单号
	//session.setAttribute("orderId", orderId);
	session.removeAttribute("cartorder");//cart的生命周期结束，销毁

	
	//确认订单的时候，要将购物车中的这些物品删除
	String []ids=(String [])session.getAttribute("checks");
	Cart c=(Cart)session.getAttribute("cart");
	if(c == null)
	{
		c=new Cart();
		session.setAttribute("cart", c);
	}					
	for(int k=0;k<ids.length;k++)
	{
		int id=Integer.parseInt(ids[k]);
		c.deleteItemById(id);
	}
	
	
	String [] paysets=request.getParameterValues("payset");
	String paysetStr=paysets[0];

	//将支付方式存到数据库中
	SalesOrder so=OrderMgr.getInstance().loadById(orderId);
	if(paysetStr != null)
	{
		int payset=Integer.parseInt(paysetStr);
		so.setPaySet(payset);
		OrderMgr.getInstance().update(so);
	}
	response.setHeader("refresh","2;URL=payset.jsp?orderId="+orderId+"&payset="+so.getPaySet());//2秒钟后跳转
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
		<title>艺术创想</title>
		<link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css" />
		<script type="text/javascript">
	    	window.onscroll=function()
	    	{
	    		var t=document.documentElement.scrollTop || document.body.scrollTop;
	    		var nav=document.getElementById("nav");
	    		if(t<=500)
	    		{
	    			nav.style.backgroundColor='rgba(50,170,220,-0.1)';
	    			nav.style.boxShadow='none';
	    		}
	    		else
	    		{
	    			nav.style.backgroundColor='rgba(50,170,220,1)';//如果用双引号就会无效
	    			nav.style.boxShadow='5px 5px 8px #B5B4B4,-5px 5px 8px #B5B4B4';
	    		} 
	    	}
	   </script>
	</head>
	<body>
		<div class="widpc100" style="position:fixed;top:0;height:70px;" id="nav">
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
					<a href="UserLogin1.jsp?url=index" style="color:white;">
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
		
		<div class="padpc10">
			<div class="widpc100 textc colb fontw700 fonts22 boxs10 borr20" style="padding-bottom:15%;">
				<div class="backgb" style="height:50px;width:50px;padding-left:2px;padding-top:2px;margin-bottom:10%;">
					<img src="/Gouwu/images/icon/gou1.png" />
				</div>
				<img src="/Gouwu/images/icon/gou.png"/>
				<span style="margin-bottom:12%;">您的订单已成功下单....3秒钟后跳转至支付页面....</span>
			</div>
		</div>
		
		<div class="widpc100 backgbs" style="height:100px;padding-top:30px;background-color:#eafbf6;">
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


	