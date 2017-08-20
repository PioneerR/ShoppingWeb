<%@ page import="category.Category"%>
<%@ page import="category.CategoryService"%>
<%@ page import="java.util.List"%>
<%@ page import="user.User"%>
<%@ page import="user.PasswordNotCorrectException"%>
<%@ page import="user.UserNotFoundException"%>
<%@ page import="java.sql.SQLException"%>
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
	String url=request.getParameter("url");//确认--是从首页跳转到登录页面的
	if(action !=null && action.trim().equals("login"))
	{
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		//User u=null;
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
		
		//设置session时间为三个月
		String sessiontime=request.getParameter("cookietime");
		if(sessiontime!=null && sessiontime.equals("true"))//&&左边为假，右边不执行
		{
			HttpSession sess=request.getSession(true);
			sess.setMaxInactiveInterval(90*24*3600);//三个月的时间
			
			Cookie cookie=new Cookie("username",username);//密码和账号都要写到cookie内
			       cookie=new Cookie("password",password);
			cookie.setMaxAge(90*24*3600);
			response.addCookie(cookie);
		}

		
		if(url!=null && url.equals("index"))
		{	
			response.sendRedirect("Index1.jsp");
%>
		<script type="text/javascript">
			window.history.go(1);//表单提交相当于又一次页面请求，所以是回到上一个页面的上一个页面.进入上一个缓存页面，读取缓存
		</script>
<%			
		}
		else
		{
%>
		<script type="text/javascript">
			window.history.go(-2);
		</script>
<%
		}
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
					<a href="UserLogin1.jsp" style="color:white;">
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
	
		<div class="widpc100 heipc100 header">
	      <div class="widpc100 heipc100 header-filter">	
	            
	          <form class="heia borr10 padtb30 boxsg backgw marlra marpc15 colb textc fonts18 letters1" 
	          	    style="padding-bottom:0;overflow:hidden;width:300px;" method="post" action="UserLogin1.jsp">
		          <input type="hidden" name="action" value="login">	
		          <input type="hidden" name="url" value="<%= url %>">	    
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
		          <div class="flol" style="letter-spacing:0em;padding-left:33px;margin-top:14px;">
		          	<div class=" flol" style="margin-right:4px;">
		          		<input type="checkbox" class="checkbox" id="sessiontime" name="cookietime" value="true" />
		          		<label for="sessiontime"></label>	
		          	</div>
		          	<div class="textl fonts14 colgy flol" style="margin-left:2px;">
		          		记住我
		          	</div>		          	
		          </div>
		          <div class="fonts14 textr flor" style="letter-spacing:0em;margin-top:15px;">
		          	<a href="UserModify1.jsp" class="colgy padlr20" >忘记密码？</a>
		          </div>		          
		          <input type="submit" value="登录" class="backgb boxs5 colw borr25 padtb5 wid100 fonts16 martb20" 
		          		 style="border-bottom:none;margin-top:30;cursor:pointer;" />
	          </form>	  
			  
	      </div>
	    </div>		
	</body>
</html>