<%@ page language="java" import="java.util.*" pageEncoding="utf8" %>
<%@ page contentType="text/html;charset=utf8" import="user.*" %>

<%
	request.setCharacterEncoding("utf8");//若该句不写，数据库的数据会是乱码
	String action=request.getParameter("action");//判定是否有提交事件
	
	if(action!=null && action.equals("register"))
	{
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String phone=request.getParameter("phone");
		String address=request.getParameter("address");
		
		User u=new User();
		u.setUsername(username);
		u.setPassword(password);
		u.setPhone(phone);
		u.setAddress(address);
		u.setDate(new Date());
		u.save();
		
		out.println("恭喜您注册成功！");
		return;//常常用于提交回本页面并将数据转交到后台进行存储的操作
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>用户注册</title>
  </head>
  <body>
  	<form method="post" action="Register1.jsp"  >
  	<input type="hidden" name="action" value="register" />
  	<table>
  		<tr>
  			<td>用户名：<input type="text" name="username" /></td>
  		</tr>
  		<tr>
  			<td>登录密码：<input type="password" name="password" /></td>
  		</tr>
  		<tr>
  			<td>确认密码：<input type="password" name="password2" /></td>
  		</tr>
  		<tr>
  			<td>手机号码：<input type="text" name="phone" /></td>
  		</tr>
  		<tr>
  			<td>收件地址：<br><textarea name="address" cols="25" rows="5" ></textarea></td>
  		</tr>
  		<tr>
  			<td><input type="submit" name="regsubmit" value="提  交" /></td>
  		</tr>
  	</table>
  	</form>
  </body>
</html>
