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
//	else 
//	{
//		InetAddress ia=InetAddress.getLocalHost();
//		String ip=ia.getHostAddress().toString();
//		String name=ia.getHostName().toString();
//		System.out.println(ip+"--"+name);
//	}	
//	System.out.println(session.getId());

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
		.ishide{
		 	display:none;  
		 	color:#B5B4B4;
		}
		/* 在navs被hover的时候list2的hidden属性被覆盖，就会显现出下拉菜单  */
		.isshow:hover >.ishide{
		 	display:block;
		 	
		}
		/* 导航刚开始的样子   */
		.isshow{
			line-height:50px;/* 让navs在hover的时候 不会使下拉菜单消失 */
			
		}		
		.isshow:hover{
			background-color:#009de6;		
		}
		/* item被呼出的效果   */
		.is{
			box-shadow:1px 1px 2px #B5B4B4,1px 1px 2px #B5B4B4;
		}
		/* item被hover后的效果  */
		.is:hover{
			background:#03a9f4;
			color:#fff;
		}
  	</style>
    <script type="text/javascript">
    	state=0;
    	menuState=0;
    	mainState=0;    
    </script>
  </head>
  <body>
  	    <div class="widpc100 backgb" style="position:fixed;top:0;height:50px;
			 box-shadow:5px 5px 8px #B5B4B4,-5px 5px 8px #B5B4B4;" id="nav">
		  <nav style="" class="overfh">
			<div class="flol" style="margin-right:13%;margin-left:7%;">
				<a href="AdminIndex1.jsp" style="color:white;" class="fontw700">				
					<img src="/Gouwu/images/icon/yscx.png" class="wida" style="height:30px;">艺术创想管理中心
				</a>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="UserList1.jsp" class="" target="main" style="color:#fff;">用户管理</a>
				<div class="ishide " style="line-height:35px;">						
					<a href="UserList1.jsp" target="main" class=""  onclick="window.location.href='#a'">
						<div class="is colgy backgw" style="line-height:34px">用户列表</div>						
					</a>		
				</div>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="CategoryList1.jsp" class="" target="main" style="color:#fff;">课程类别</a>
				<div class="ishide " style="line-height:35px;  ">						
					<a href="CategoryList1.jsp" target="main" class="" onclick="window.location.href='#a'">
						<div class="is colgy backgw"style="line-height:34px">类别列表</div>
					</a>		
				</div>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="ProductList1.jsp" class="" target="main" style="color:#fff;">课程管理</a>
				<div class="ishide " style="line-height:35px;  ">						
					<a href="ProductList1.jsp" target="main" class="" onclick="window.location.href='#a'">
						<div class="is colgy backgw"style="line-height:34px">课程列表</div>
					</a>
					<a href="ProductSearch1.jsp" target="main" class="" onclick="window.location.href='#a'">
						<div class="is colgy backgw"style="line-height:34px">课程搜索</div>
					</a>		
				</div>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="OrderList1.jsp" class="" target="main" style="color:#fff;">报名管理</a>
				<div class="ishide " style="line-height:35px;  ">						
					<a href="OrderList1.jsp" target="main" class="" onclick="window.location.href='#a'">
						<div class="is colgy backgw"style="line-height:34px">报名列表</div>
					</a>		
				</div>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="/Gouwu/servlet/SalesCountServlet" class="" target="main" style="color:#fff;">数据统计</a>
				<div class="ishide " style="line-height:35px;  ">						
					<a href="/Gouwu/servlet/SalesCountServlet" target="main" class="" onclick="window.location.href='#a'" >
						<div class="is colgy backgw"style="line-height:34px">分类统计</div>
					</a>		
				</div>
			</div>
		
		<%
			if(yscxadmin==null)
			{
		%>					
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
			<div class="itemshow flol" style="margin-top:0px;margin-left:10%;" >
				<a href="" style="color:white;">
					<img src="/Gouwu/images/icon/user.png" class="wida" 
						 style="height:20px;margin-right:5px;">
					管理员
				</a>
				<div class="itemhide" style="width:150px;padding-bottom:5px;">
					<a href="Orderstatus1.jsp">
						<div class="item borrt5 textc backgw colgy fonts16" style="line-height:37px;margin-right:10%;">
							待处理订单
						</div>
					</a>
					<a href="AdminIndex1.jsp?action=exit">
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
				<a href="/Gouwu/Index1.jsp" class="fontw700" style="color:#03a9f4;">				
					<img src="/Gouwu/images/icon/yscx.png" class="wida" style="height:100px;">艺术创想  享你所想
				</a>
			</div>	
	   	  <div class="header borr10">
	      </div>	     
	      <iframe frameborder=0   style="padding:5% 5% 5% 5%;height:500px;width:90%;" id="a"
	      		  src="OrderList1.jsp" class="boxs10" scrolling="yes" name="main"></iframe>
	      
	      <iframe style="" frameborder=0 height=500px width=100% class="boxs10" 
	      		  src="" scrolling="yes" name="detail"></iframe>
	      <div class="header1 borr10">
	      </div>		  
	  	</div>
	  </div>
  </body>
</html>

