<%@ page import="category.CategoryService"%>
<%@ page import="category.Category"%>
<%@ page import="user.User"%>
<%@ page import="java.util.List"%>
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
	if(action !=null && action.equals("modify"))
	{
		String username=request.getParameter("username");
		String phone=request.getParameter("phone");
		String address=request.getParameter("address");
		String email=request.getParameter("email");
		String qq=request.getParameter("qq");
		
		u.setUsername(username);
		u.setPhone(phone);
		u.setAddress(address);
		u.setQQ(qq);
		u.setEmail(email);
		
		u.update();
		response.sendRedirect("Usermodifywell1.jsp");
	}
	
	
	if(u == null)
	{
		response.sendRedirect("UserLogin1.jsp");
		return;
	}
	
	//不论是第一次进入该页面，还是第二次返回该页面，都刷新页面，不保留表单信息
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
	    <link type="text/css" rel="stylesheet" href="/Gouwu/css/base.css" /> 
		<style type="text/css">
			input{
			  color: #B5B4B4;
			  font-size: 16px;
			  border: none;
			  border-bottom: solid #B5B4B4 1px;
			  margin: 5px 0 0px 0;
			  padding-bottom:5px; 
			}					
		</style>		
	</head>
	<body>
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
			<div class="boxs10 borr10">	
				<div class="backgb" style="height:50px;width:50px;padding-left:5px;padding-top:5px;">
					<img src="/Gouwu/images/background/info.png" />
				</div>
				
				<div class="pad20 overfh" style="margin-left:100px; ">	
					<div>
						<div class="colb fonts20 fontw700 textl" style="margin-left:13px;">
							个人信息修改
						</div>						
					</div>	
					
					<form action="/Gouwu/servlet/UserUpload" method="post" name="form2" class="flol" 
						  style="margin-right:120px;margin-top:30px; " encTYPE="multipart/form-data">							
						<input type="hidden" name="id" value="<%= u.getId() %>">					
						<img  style="width:120px;height:120px;margin-top:3%;margin-left:13px;"
							  src="/Gouwu/images/user/<%= u.getId()+".jpg" %>" 
							  onerror="javascript:this.src='/Gouwu/images/user/moren.jpg'" />
						<input type="file" name="img" style="width:160px;border-bottom:none;display:block;margin:10px 0px 10px 13px "/>	
						<a href="javascript:window.form2.submit()" class="backgw padlr30 colgys boxs5 textc borr5" 
						   style="padding-bottom:2px;padding-top:2px;display:block;width:55px;margin-top:0px;margin-left:13px;" >
							上传
						</a>
					</form>	
								
					<form method="post" action="Usermodify1.jsp" name="form1" class="flol">
					<input type="hidden" name="action" value="modify">					
					<table style="margin-top:20px;padding-left:10px;padding-right:10px;margin-bottom:3%;">						
						<tr style="">
							<td class="colb fonts16 textl" style="margin-left:13px;">
								家长姓名：
							</td>
							<td class="textl" style="width:150px;">
								<input type="text" name="username" value="<%= u.getUsername() %>" style="width:100px;" />
							</td>			
						</tr>
						<tr>
							<td class="colb fonts16 textl" style="margin-left:13px;">
								手机号码：
							</td>							
							<td class="wid100 textl">
								<input type="text" name="phone" value="<%= u.getPhone() %>" style="width:150px;"/>
							</td>							
						</tr>
						<tr>
							<td class="colb fonts16 textl" style="margin-left:13px;">
								微信/QQ：
							</td>							
							<td class="wid100 textl">
								<input type="text" name="qq" value="<% 
									if(u.getQQ()==null)
									{										
										out.print("尚未填写");
									}
									else
									{
										out.print(u.getQQ());
									}%>" style="width:150px;"/>
							</td>							
						</tr>
						<tr>
							<td class="colb fonts16 textl" style="margin-left:13px;">
								邮箱地址：
							</td>							
							<td class="wid100 textl">
								<input type="text" name="email" value="<% 
									if(u.getEmail()==null)
									{										
										out.print("尚未填写");
									}
									else
									{
										out.print(u.getEmail());
									}%>" style="width:150px;"/>
							</td>							
						</tr>
						<tr>
							<td class="colb fonts16 textl" style="margin-left:13px;">
								收货地址：
							</td>
							<td class="wid200 textl">
								<input type="text" name="address" value="<% 
									if(u.getAddress()==null)
									{										
										out.print("尚未填写");
									}
									else
									{
										out.print(u.getAddress());
									}%>" style="width:200px;"/>
							</td>							
						</tr>
					</table>	
					
				</div>			
			</div>
			<a href="javascript:window.form1.submit()" class="flor marpc1 backgb padlr30 boxs5 textc borr5" 
			   style="margin-right:30px;padding-bottom:5px;padding-top:5px;color:#fff;" >
				保存
			</a>
			</form>
			<a href="javascript:window.history.go(-1)" class="flor marpc1 backgw padlr30 colgy boxs5 textc borr5" 
			   style="margin-right:10px;padding-bottom:5px;padding-top:5px;" >
				返回
			</a>
		</div>
		
		<div class="widpc100 backgbs" style="height:100px;padding-top:30px;background-color:#eafbf6;margin-top:50px; ">
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