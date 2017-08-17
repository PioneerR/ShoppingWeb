<%@page import="user.User"%>
<%@page import="user.PasswordNotCorrectException"%>
<%@page import="user.UserNotFoundException"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	String action=request.getParameter("action");
	if(action !=null && action.trim().equals("login"))
	{
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		User u=null;
		try
		{
			u=User.check(username,password);
		}
		catch(UserNotFoundException e)
		{
			out.println(e.getMessage());
			return;
		}
		catch(PasswordNotCorrectException e1)
		{
			out.println(e1.getMessage());
			return;
		}
		session.setAttribute("user", u);
		int id=(Integer)(session.getAttribute("id"));
		response.sendRedirect("ShowProductDetail1.jsp?id="+id);
	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
		<title>艺术创想</title>
		<link type="text/css" rel="stylesheet" href="/Gouwu/css/base.css" />
		<style type="text/css">
			td{
				text-align:center;
				border:3px solid #fff1cc;
			}
			a{
				text-decoration: none;
			}
			.header{
			background:url("/Gouwu/images/background/timg.jpg") no-repeat;
			background-position: 50% 40%;
			position: absolute;
			top:0;
			left:0;
			z-index: -1;
			}
			.header-filter{
			background-color:rgba(0,0,0,0.3);
			position: absolute;
			top:0;
			left:0;
			}
			input{
			  color: #B5B4B4;
			  font-size: 16px;
			  width: 100%;
			  border: none;
			  border-bottom: solid #B5B4B4 1px;
			  margin: 6% 0 3% 0;
			  padding-bottom:10px; 
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
	<body>
	
		<div class="widpc100 heipc100 header">
	      <div class="widpc100 heipc100 header-filter">
	      
	          <form class="heia borr10 padtb30 boxsg backgw marlra marpc15 colb textc fonts18 letters1" 
	          	    style="padding-bottom:0;overflow:hidden;width:300px;" method="post" action="UserLogin1.jsp">
		          <input type="hidden" name="action" value="login">	    
		           	 用户登录<br>
		          <div class="flol" style="margin-left:30px;margin-right:5px; padding-top:20px; "> 	 
		          	<img src="/Gouwu/images/icon/email.png" />
		          </div>
		          <div class="flol widpc70" style="margin-right:15px;" > 
		          	<input type="text" name="username" placeholder="Email"/>
		          </div>
		          
		          <div class="flol" style="margin-left:30px;margin-right:3px; padding-top:20px;"> 
		          	<img src="/Gouwu/images/icon/password.png" style="margin-right:3px;"/>
		          </div>
		          <div class="flol widpc70" style="margin-right:15px;"  > 	
		          	<input type="password" name="password" placeholder="登录密码" /><br>
		          </div>
		          <div class="fonts14 textr" style="letter-spacing:0em;">
		          	<a href="UserModify1.jsp" class="colgy padlr20" >忘记密码？</a>
		          </div>
		          
		          <input type="submit" value="登录" class="backgb boxs5 colw borr25 padtb5 wid100 fonts16 martb20" 
		          		 style="border-bottom:none;margin-top:30;cursor:pointer;" />
	          </form>
			  
			  
	      </div>
	    </div>
		
	</body>
</html>