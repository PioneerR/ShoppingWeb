<%@ page import="category.CategoryService"%>
<%@ page import="category.Category"%>
<%@ page import="user.User"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	request.setCharacterEncoding("utf8");
	User u=(User)session.getAttribute("user");
	if(u == null)
	{
		response.sendRedirect("UserLogin1.jsp");
		return;
	}
	
	String action=request.getParameter("action");
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
		<%@ include file="Nav.jsp" %>
	
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
		
		<%@ include file="Footer.jsp" %>	
		
	</body>
</html>