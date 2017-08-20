<%@ page import="category.CategoryService"%>
<%@ page import="category.Category"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf8" %>
<%@ page contentType="text/html;charset=utf8" import="user.*" %>

<%
	request.setCharacterEncoding("utf8");//若该句不写，数据库的数据会是乱码,且该句必须放在第一行
	List<Category> categories=CategoryService.getInstance().getCategoriesGradeTwo();
	User u=(User)session.getAttribute("user");
	
	String action=request.getParameter("action");
	if(action !=null && action.equals("exit"))
	{
		session.removeAttribute("user");
		response.sendRedirect("Index1.jsp");
	}

	if(action!=null && action.equals("register"))
	{
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String password2=request.getParameter("password2");
		String phone=request.getParameter("phone");
		//String address=request.getParameter("address");
		
		if(username.trim()=="" || password.trim()=="" || password2.trim()=="" || phone.trim()=="" )
		{
			out.println("<div style='padding:10% 5% 5% 5%;box-shadow:0 0 10px #B5B4B4;border-radius:10px;width:80%;height:250px;margin-left:5%;margin-top:5%;'");
			out.println("<div style=''>");
			out.println("<h2 style='color:#ff9632;text-align:center;padding:0% 8%;'>");
			out.println("<img src='/Gouwu/images/icon/yscx.png' style='width:200px;height:auto;'/>");
			out.println("请将信息填写完整！~");
			out.println("</h2></div></div>");
			
			out.println("<a href='javascript:window.history.go(-1)' style='text-decoration:none;");
			out.println("background:#03a9f4;padding-bottom:5px;padding-top:5px;color:#fff;float:right;");
			out.println("margin:2% 5% 5% 5%;padding-left:30px;padding-right:30px;text-align:center;border-radius:5px;'>");
			out.println("返回</a>");
			return;
		}
		else if(username.trim()!="" && password.trim()!="" && password2.trim()!="" && phone.trim()!="" )
		{
			if(password.trim().equals(password2.trim()))
			{
				u=new User();
				u.setUsername(username);
				u.setPassword(password);
				u.setPhone(phone);
				//u.setAddress(address);
				u.setDate(new Date());
				u.save();
				
				session.setAttribute("user",u);
				
				out.println("<div style='padding:10% 5% 5% 5%;box-shadow:0 0 10px #B5B4B4;border-radius:10px;width:80%;height:300px;margin-left:5%;margin-top:5%;'");
				out.println("<div style=''>");
				out.println("<h2 style='color:#03a9f4;text-align:center;padding:0% 8%;'>");
				out.println("<img src='/Gouwu/images/icon/yscx.png' style='width:200px;height:auto;'/>");
				out.println("恭喜您注册成功！~");
				out.println("</h2></div></div>");
				//response.setHeader("refresh","2;URL=payset.jsp");可以用于延时加载，但是无法回到上一个浏览页面								
				return;//常常用于提交回本页面并将数据转交到后台进行存储的操作
			}
			else 
			{
				out.println("<div style='padding:10% 5% 5% 5%;box-shadow:0 0 10px #B5B4B4;border-radius:10px;width:80%;height:250px;margin-left:5%;margin-top:5%;'");
				out.println("<div style=''>");
				out.println("<h2 style='color:#ff9632;text-align:center;padding:0% 8%;'>");
				out.println("<img src='/Gouwu/images/icon/yscx.png' style='width:200px;height:auto;'/>");
				out.println("两次输入的密码不一致！请重新输入！~");
				out.println("</h2></div></div>");	
				
				out.println("<a href='javascript:window.history.go(-1)' style='text-decoration:none;");
				out.println("background:#03a9f4;padding-bottom:5px;padding-top:5px;color:#fff;float:right;");
				out.println("margin:2% 5% 5% 5%;padding-left:30px;padding-right:30px;text-align:center;border-radius:5px;'>");
				out.println("返回</a>");
				
				return;	
				
			}
		}	
	}
	 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  	<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
  	<link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css" />
    <title>艺术创想</title>
    <style type="text/css">
		input{
		  color: #B5B4B4;
		  font-size: 16px;
		  width: 100%;
		  border: none;
		  border-bottom: solid #B5B4B4 1px;
		  margin: 6% 0 3% 0;
		  padding-bottom:10px; 
		}		
		.header-filter{
			background-color:rgba(0,0,0,0.3);
			position: absolute;
			top:0;
			left:0;
			}
		.header{
		  background:url("/Gouwu/images/background/timg.jpg") no-repeat;
		  background-position: 50% 40%;
		  position: absolute;
		  top:0;
		  left:0;
		  z-index: -1;
		}
    </style>
    <script type="text/javascript">
    	function al()
    	{
    		var username=document.getElementById("username");
    		var password=document.getElementById("password");
    		var password2=document.getElementById("password2");
    		var phone=document.getElementById("phone");
    		
    		if(username.value==null))
    		{
    			alert("请填写用户名！")
    		}
    		else if(phone.value==null))
    		{
    			alert("请填写手机号码！")
    		}
    		else if(password.value==null))
    		{
    			alert("请填写登录密码！")
    		}
    		else if(password.value==null))
    		{
    			alert("请填写确认密码！")
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

    <div class="header widpc100 heipc100" >
      <div class="header-filter widpc100 heipc100">
          
          <form method="post" action="Register1.jsp" style="padding-bottom:0;overflow:hidden;width:300px;"
          	class="heia borr10 padtb30 boxsg backgw marlra marpc15 colb textc fonts18 letters1"  >
  			<input type="hidden" name="action" value="register" />
          	  用户注册<br>
          	
        	<div class="flol" style="margin-left:30px;margin-right:5px; padding-top:25px;"> 	 
	          	<img src="/Gouwu/images/icon/userb.png" style="width:20px;" />
	        </div>
	        <div class="flol widpc70" style="margin-right:15px;" > 
	          	<input type="text" name="username" id="username" placeholder="用户名"/>
	        </div>	        
	        <div class="flol" style="margin-left:30px;margin-right:5px; padding-top:20px; "> 	 
	          	<img src="/Gouwu/images/icon/shouji.png" style="width:20px;"/>
	        </div>
	        <div class="flol widpc70" style="margin-right:15px;" > 
	          	<input type="text" name="phone" id="phone" placeholder="手机号码"/>
	        </div>
	        <div class="flol" style="margin-left:30px;margin-right:5px; padding-top:20px; "> 	 
	          	<img src="/Gouwu/images/icon/password.png" style="width:20px;"/>
	        </div>
	        <div class="flol widpc70" style="margin-right:15px;" > 
	          	<input type="password" name="password" id="password" placeholder="登录密码" />
	        </div>	        
	        <div class="flol" style="margin-left:30px;margin-right:5px; padding-top:20px; "> 	 
	          	<img src="/Gouwu/images/icon/password.png" style="width:20px;"/>
	        </div>
	        <div class="flol widpc70" style="margin-right:15px;" > 
	          	<input type="password" name="password2" id="password2" placeholder="确认密码" />
	        </div>
          	<input type="submit" value="注册"  name="regsubmit" style="border-bottom:none;margin-top:15px;margin-bottom:20px; "
          		   class="backgb colw borr25 padtb5 wid100 fonts16 curp"/>
          </form>
      </div>
    </div>

  </body>
</html>
