<%@page import="user.User"%>
<%@ page import="java.util.List"%>
<%@ page import="order.SalesOrder"%>
<%@ page import="order.OrderMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf8");
	User u=(User)session.getAttribute("user");
	if(u == null)
	{
		response.sendRedirect("UserLogin1.jsp");
		return;
	}

	String orderIdStr=request.getParameter("orderId");
	int orderId=Integer.parseInt(orderIdStr);
	
	String paysetStr=request.getParameter("payset");
	int payset=Integer.parseInt(paysetStr);
	
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
		<div class="padpc10">
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
					 style="margin-top:30px;margin-left:41%;display:block;color:#fff;width:193px;">支付成功
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
					 style="margin-top:30px;margin-left:41%;display:block;color:#fff;width:193px;">支付成功
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
			<div class="flol widpc100 heia martbpc1 fonts14" style="margin-left:38%;">
				Copyright © 2017 艺术创想  Designed by 
				<a href="https://github.com/PioneerR" target="_blank" style="color:#03a9f4;">PioneerR</a>
			</div>
	    </div>
	</body>
</html>