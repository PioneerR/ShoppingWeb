<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress"%>

<%!
	Integer number;
	synchronized void numberVisiter()
	{
		ServletContext application = getServletContext();
		Integer num = (Integer)application.getAttribute("count");
		if(num == null)//如果是第一个访问者
		{
			num = new Integer(1);
			application.setAttribute("count",num);
		}
		else
		{
			num = new Integer(num.intValue() + 1);
			application.setAttribute("count",num);
		}
	}
%>
<%
	request.setCharacterEncoding("utf8");//若该句不写，数据库的数据会是乱码,且该句必须放在第一行
	//以下代码是为了测试同时在线人数的
	if(session.isNew())
	{
	  	numberVisiter();
	  	Integer number = (Integer)application.getAttribute("count");
	  	System.out.println(number);
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8">
    <link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
  	<title>艺术创想校园管理中心</title> 
    <link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css"> 
  	<style type="text/css">
  		iframe
  		{
			border-radius:10px;
		}
		.header{
			background:url("/Gouwu/images/background/chengguo.png") no-repeat;height:500px;
		}
		.header1{
			background:url("/Gouwu/images/background/chengguo.png") no-repeat;height:500px;
			background-position:0% 120%; 
		}
  	</style>
  </head>
  <body>
  	  <%@ include file="AdminNav.jsp" %>
  
	  <div class="heia wida " style="padding:8% 5% 5% 5%;">
	   	<div class="boxs10 widpc100 borr10">
	   	    <div class="flol" style="">
				<a href="/Gouwu/Index1.jsp" class="fontw700" target="_blank" style="color:#03a9f4;">				
					<img src="/Gouwu/images/icon/yscx.png" class="wida" style="height:100px;">艺术创想  享你所想
				</a>
			</div>	
	   	  <div class="header borr10">
	      </div>	     

	      <div class="header1 borr10">
	      </div>		  
	  	</div>
	  </div>
	  
	  <%@ include file="/Footer.jsp" %>
  </body>
</html>

