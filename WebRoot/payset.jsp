<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String payset=(String)session.getAttribute("payset");
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
	<body class="padpc10">
		<div class="widpc100 textc colb fontw700 fonts22 boxs10 borr20 padtbpc5" style="height:120px;">
	<%
		if(payset !=null && payset.equals("wx"))
		{
	%>
			<img src="/Gouwu/images/icon/wx.png"/>
			<span>微信支付</span><hr>
	<%
		}
		else if(payset !=null && payset.equals("zfb"))
		{
	%>
			<img src="/Gouwu/images/icon/zfb.png"/>
			<span>支付宝支付</span><hr>
	<%
		}
	%>	
		</div>
	</body>
</html>