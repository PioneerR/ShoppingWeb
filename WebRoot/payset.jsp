<%@ page import="category.CategoryService"%>
<%@ page import="category.Category"%>
<%@ page import="user.User"%>
<%@ page import="java.util.List"%>
<%@ page import="order.SalesOrder"%>
<%@ page import="order.OrderMgr"%>
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

	if(u == null)
	{
		response.sendRedirect("UserLogin1.jsp");
		return;
	}

	String orderIdStr=request.getParameter("orderId");
	int orderId=Integer.parseInt(orderIdStr);
	
	String paysetStr=request.getParameter("payset");
	int payset=Integer.parseInt(paysetStr);
	
	//点击浏览器后退按钮时，不读取该页缓存，并自动刷新本页面
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
		<style type="text/css">
			hr{		
			 border:none;
			 border-top:1px dashed #03a9f4;
			}
		</style>
	</head>
	<body >
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
				<div class="itemshow flol marlr15"  >
					<a href="" style="color:white;">
						<img src="/Gouwu/images/user/<%= u.getId()+".jpg" %>" class="wida" 
							 style="height:30px;width:30px;margin-right:5px;margin-top:25px;margin-bottom:-8px; "
							 onerror="javascript:this.src='/Gouwu/images/icon/user.png'">
						<%= u.getUsername() %>
					</a>
					<div class="itemhide" style="width:150px;padding-bottom:5px;">
						<a href="Orderstatus1.jsp">
							<div class="item borrt5 textc backgw colgy fonts16" style="line-height:37px;margin-right:10%;">
								我的订单
							</div>
						</a>
						<a href="Userinfo1.jsp">
							<div class="item textc backgw colgy fonts16" style="line-height:37px;margin-right:10%;">
								个人信息
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
	
		<div style="padding:10% 5% 5% 5%;">
			<div class="widpc100 textc colb fontw700 fonts22 boxs10 borr20" style="padding-bottom:5%;">
				<div class="backgb" style="height:50px;width:50px;padding-left:4px;padding-top:9px;">
					<img src="/Gouwu/images/icon/payset.png" />
				</div>
		<%
			if(payset == 1)
			{
		%>
				<img src="/Gouwu/images/icon/wx.png"/>
				<span>微信支付</span><hr>
				<img src="/Gouwu/images/icon/wxpay.png" class="boxs10 hei200 wid200" style="margin-top:30px;"/>
				<a class="borr5 fonts18 marlrpc5 backgb boxs5 padtb5" href="Orderstatus1.jsp?orderId=<%= orderId %>&action=change"
					 style="margin-top:30px;margin-left:42%;display:block;color:#fff;width:193px;">支付成功
				</a>
		<%
			}
			else if(payset == 2)
			{
		%>
				<img src="/Gouwu/images/icon/zfb.png"/>
				<span>支付宝支付</span><hr>
				<img src="/Gouwu/images/icon/zfbpay.png" class="boxs10 hei200 wid200" style="margin-top:30px;"/>
				<a class="borr5 fonts18 marlrpc5 backgb boxs5 padtb5" href="Orderstatus1.jsp?orderId=<%= orderId %>&action=change"
					 style="margin-top:30px;margin-left:42%;display:block;color:#fff;width:193px;">支付成功
				</a>
		<%
			}
		%>	
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
			<div class="flol heia martbpc1 fonts14" style="margin-left:33%;">
				Copyright © 2017 艺术创想  Designed by 
				<a href="https://github.com/PioneerR" target="_blank" style="color:#03a9f4;">PioneerR</a> | 				
				<a href="http://www.miitbeian.gov.cn/" target="_blank" style="color:#03a9f4;">闽ICP备17023054号</a>
			</div>
	    </div>
	</body>
</html>