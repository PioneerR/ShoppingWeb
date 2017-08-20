<%@ page language="java" import="java.util.*" pageEncoding="utf8" %>
<%@ page contentType="text/html;charset=utf8" %>

<%
	request.setCharacterEncoding("utf8");
	String action=request.getParameter("action");	
	if(action!=null && action.equals("adminlogin"))
	{
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		if(!username.equals("admin") || !password.equals("239338"))
		{
			out.println("username or password not correct!");
			return;
		}
		
		session.setAttribute("admin", "admin");
		//管理员获得权限别忘了写，因为后面的页面需要确认是否有管理员权限，会用到session
		response.sendRedirect("admin/AdminIndex1.jsp");	
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
    <title>管理员登录</title>
  </head>
  <body>
  	<form method="post" action="AdminLogin1.jsp"  >
  	<input type="hidden" name="action" value="adminlogin" />
  	<table border=1>
  		<tr>
  			<td>admin name：</td>
  			<td><input type="text" name="username" /></td>
  		</tr>
  		<tr>
  			<td>admin password：</td>
  			<td><input type="password" name="password" /></td>
  		</tr>
  		<tr>
  			<td>
  				<input type="submit" name="submit" value="登录" />
  				<input type="reset" name="reset" value="重置" >
  			</td>
  		</tr>
  	</table>
  	</form>
  </body>
</html>

