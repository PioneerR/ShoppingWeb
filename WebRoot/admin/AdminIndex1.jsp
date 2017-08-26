<%@ page import="java.net.InetAddress"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>

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
	
	String yscxadmin=(String)session.getAttribute("yscxadmin");
	if(yscxadmin == null)
	{
		response.sendRedirect("/Gouwu/UserLogin1.jsp");
		return;
	}

	String action=request.getParameter("action");
	if(action !=null && action.equals("exit"))
	{
		session.invalidate();
		response.sendRedirect("/Gouwu/");
		return;
	}
	
	response.setHeader("Pragma","No-cache"); 		
	response.setHeader("Cache-Control","no-cache"); 
	response.setHeader("Cache-Control", "No-store");
	response.setDateHeader("Expires", 0);
	
	
%>	

<%
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
  	    <div class="widpc100 backgb" style="position:fixed;top:0;height:50px;
			 box-shadow:5px 5px 8px #B5B4B4,-5px 5px 8px #B5B4B4;" id="nav">
		  <nav style="" class="overfh">
			<div class="flol" style="margin-right:10%;margin-left:7%;">
				<a href="/Gouwu/admin/AdminIndex1.jsp" style="color:white;" class="fontw700">				
					<img src="/Gouwu/images/icon/yscx.png" class="wida" style="height:30px;">艺术创想管理中心
				</a>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="/Gouwu/admin/AdminIndex1.jsp" style="color:#fff;">首页</a>
				<div class="ishide " style="line-height:35px;">						
					<a href="/Gouwu/Index1.jsp"  class=""  >
						<div class="is colgy backgw" style="line-height:34px">用户首页</div>						
					</a>		
				</div>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="/Gouwu/admin/UserList1.jsp" style="color:#fff;">用户管理</a>
				<div class="ishide " style="line-height:35px;">						
					<a href="/Gouwu/admin/UserList1.jsp"  class=""  >
						<div class="is colgy backgw" style="line-height:34px">用户列表</div>						
					</a>		
				</div>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="/Gouwu/admin/CategoryList1.jsp" class="" target="main" style="color:#fff;">课程类别</a>
				<div class="ishide " style="line-height:35px;  ">						
					<a href="/Gouwu/admin/CategoryList1.jsp" >
						<div class="is colgy backgw"style="line-height:34px">类别列表</div>
					</a>		
				</div>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="/Gouwu/admin/ProductList1.jsp" style="color:#fff;">课程管理</a>
				<div class="ishide " style="line-height:35px;  ">						
					<a href="/Gouwu/admin/ProductList1.jsp">
						<div class="is colgy backgw"style="line-height:34px">课程列表</div>
					</a>
					<a href="/Gouwu/admin/ProductSearch1.jsp" class="" onclick="">
						<div class="is colgy backgw"style="line-height:34px">课程搜索</div>
					</a>
					<a href="/Gouwu/admin/ProductComplexSearch1.jsp" class="" onclick="">
						<div class="is colgy backgw"style="line-height:34px">高级搜索</div>
					</a>		
				</div>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="/Gouwu/admin/OrderList1.jsp" class="" target="main" style="color:#fff;">报名管理</a>
				<div class="ishide " style="line-height:35px;  ">						
					<a href="/Gouwu/admin/OrderList1.jsp">
						<div class="is colgy backgw"style="line-height:34px">报名列表</div>
					</a>		
				</div>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="/Gouwu/servlet/SalesCountServlet" class="" target="main" style="color:#fff;">数据统计</a>
				<div class="ishide " style="line-height:35px;  ">						
					<a href="/Gouwu/servlet/SalesCountServlet">
						<div class="is colgy backgw"style="line-height:34px">分类统计</div>
					</a>		
				</div>
			</div>
		
		<%
			if(yscxadmin==null)
			{
		%>					
				<div class="flol marlr15" style="margin-top:25px;" >
					<a href="/Gouwu/UserLogin1.jsp" style="color:white;">
						<img src="/Gouwu/images/icon/signin.png" class="wida" style="height:20px;">登录
					</a>
				</div>
		<%
			}
			else
			{
		%>			
			<div class="itemshow flol" style="margin-top:0px;margin-left:10%;" >
				<a href="" style="color:white;">
					<img src="/Gouwu/images/icon/user.png" class="wida" 
						 style="height:20px;margin-right:5px;">
					管理员
				</a>
				<div class="itemhide" style="width:150px;padding-bottom:5px;">
					<a href="/Gouwu/admin/OrderList1.jsp">
						<div class="item borrt5 textc backgw colgy fonts16" style="line-height:37px;margin-right:10%;">
							待处理预报名
						</div>
					</a>
					<a href="/Gouwu/admin/AdminIndex1.jsp?action=exit">
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

