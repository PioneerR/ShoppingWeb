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
		response.sendRedirect("Confirm1.jsp");
	}
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>用户登录</title>
		<style type="text/css">
			td{
				text-align:center;
				border:3px solid #fff1cc;
			}
			a{
				text-decoration: none;
			}
		</style>
	</head>
	<body>
		<form action="UserLogin1.jsp" method="post">
			<input type="hidden" name="action" value="login">
			<table> 
				<tr>
					<td>用户名:</td>
					<td><input type="text" name="username" /></td>
				</tr>
				<tr>
					<td>密码:</td>
					<td><input type="password" name="password" /></td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="登录" />
						<input type="reset"  value="重置" />
					</td>
					<td>
						<a href="UserModify1.jsp" >忘记密码？</a>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>