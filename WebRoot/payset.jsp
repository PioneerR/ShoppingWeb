<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String payset=(String)session.getAttribute("payset");
	int orderId=(Integer)session.getAttribute("orderId");
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
			.boxs5{
				box-shadow:0 0 1px #B5B4B4;
				transition:all 0.6s;
			}
			.boxs5:hover {  
				box-shadow:0 0 10px #B5B4B4;
			} 
		</style>
	</head>
	<body class="padpc10">
		<div class="widpc100 textc colb fontw700 fonts22 boxs10 borr20" style="padding-bottom:5%;">
			<div class="backgb" style="height:50px;width:50px;padding-left:5px;padding-top:9px;">
				<img src="/Gouwu/images/icon/payset.png" />
			</div>
	<%
		if(payset !=null && payset.equals("wx"))
		{
	%>
			<img src="/Gouwu/images/icon/wx.png"/>
			<span>微信支付</span><hr>
			<img src="/Gouwu/images/icon/wxpay.png" class="boxs10 hei200 wid200" style="margin-top:30px;"/>
			<a class="borr5 fonts18 marlrpc5 backgb boxs5 padtb5" href="Orderstatus1.jsp?orderId=<%= orderId %>"
				 style="margin-top:30px;margin-left:41%;display:block;color:#fff;width:193px;">支付成功
			</a>
	<%
		}
		else if(payset !=null && payset.equals("zfb"))
		{
	%>
			<img src="/Gouwu/images/icon/zfb.png"/>
			<span>支付宝支付</span><hr>
			<img src="/Gouwu/images/icon/zfbpay.png" class="boxs10 hei200 wid200" style="margin-top:30px;"/>
			<a class="borr5 fonts18 marlrpc5 backgb boxs5 padtb5" href="Orderstatus1.jsp?orderId=<%= orderId %>"
				 style="margin-top:30px;margin-left:41%;display:block;color:#fff;width:193px;">支付成功
			</a>
	<%
		}
	%>	
		</div>
	</body>
</html>