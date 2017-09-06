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
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
		<title>艺术创想</title>
	    <link type="text/css" rel="stylesheet" href="/Gouwu/css/base.css" /> 
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
							个人信息
						</div>						
					</div>											
					<div class="flol" style="margin-right:120px;margin-top:30px;margin-left:13px; " >
						<img src="/Gouwu/images/user/<%= u.getId()+".jpg" %>" style="width:120px;height:120px;"
							 onerror="javascript:this.src='/Gouwu/images/user/moren.jpg'" />
					</div>						
					<table style="margin-top:20px;padding-left:10px;padding-right:10px;margin-bottom:3%;" class="flol">						
						<tr style="height:30px; ">
							<td class="colb fonts16 textl" style="margin-left:13px;">
								家长姓名：
							</td>
							<td class="textl" style="width:150px;"><%= u.getUsername() %></td>						
						</tr>						
						<tr>
							<td class="colb fonts16 textl" style="margin-left:13px;">
								手机号码：
							</td>							
							<td class="wid100 textl">
								<%
									if(u.getPhone()==null)
									{										
										out.print("<font style='color:#ff9632;'>尚未填写</font>");
									}
									else
									{
										out.print(u.getPhone());
									}
								%>
							</td>							
						</tr>
						<tr>
							<td class="colb fonts16 textl" style="margin-left:13px;">
								微信/QQ：
							</td>
							<td class="wid200 textl">
								<%
									if(u.getQQ()==null)
									{										
										out.print("<font style='color:#ff9632;'>尚未填写</font>");
									}
									else
									{
										out.print(u.getQQ());
									}
								%>
							</td>							
						</tr>						
						<tr>
							<td class="colb fonts16 textl" style="margin-left:13px;">
								邮箱地址：
							</td>
							<td class="wid200 textl">
								<%
									if(u.getEmail()==null)
									{
										out.print("<font style='color:#ff9632;'>尚未填写</font>");
									}
									else
									{
										out.print(u.getEmail());
									}
								%>
							</td>							
						</tr>
						<tr>
							<td class="colb fonts16 textl" style="margin-left:13px;">
								收货地址：
							</td>
							<td class="wid200 textl">
								<%
									if(u.getAddress()==null)
									{										
										out.print("<font style='color:#ff9632;'>尚未填写</font>");
									}
									else
									{
										out.print(u.getAddress());
									}
								%>
							</td>							
						</tr>
					</table>	
				</div>			
			</div>
			<a href="Usermodify1.jsp" class="flor marpc1 backgb padlr30 boxs5 textc borr5" 
			   style="margin-right:30px;padding-bottom:5px;padding-top:5px;color:#fff;" >
				修改
			</a>
			<a href="javascript:window.history.go(-1)" class="flor marpc1 backgw padlr30 colgy boxs5 textc borr5" 
			   style="margin-right:10px;padding-bottom:5px;padding-top:5px;" >
				返回
			</a>
		</div>
		
		<%@ include file="Footer.jsp" %>			
	</body>
</html>