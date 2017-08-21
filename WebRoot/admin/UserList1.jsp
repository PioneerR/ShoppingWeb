<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf8" %>
<%@ page import="user.*,java.util.*" %>

<%
	request.setCharacterEncoding("utf8"); 
	final int PAGE_SIZE=5;//每个页面最多显示的条数
	int pageNo=1;//pageNo默认值是第一页
	
	String strPageNo=request.getParameter("pageNo");
	if(strPageNo!=null && !strPageNo.trim().equals(""))
	{
		try
		{
			pageNo=Integer.parseInt(strPageNo.trim());
		}
		catch(NumberFormatException e)
		{
			pageNo=1;
		}
	}
	if(pageNo<0)
	{
		pageNo=1;
	}

	//List接口在util包中
	List <User> users=new ArrayList<User>();
	int totalRecords=User.getUsers(users,pageNo,PAGE_SIZE);//拿到users集合，返回数据总条数
	int totalPages = (totalRecords + PAGE_SIZE - 1) / PAGE_SIZE;
	
	if (pageNo > totalPages)
		pageNo = totalPages;
%>  
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf8">	
	<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
  	<title>艺术创想校园管理中心</title> 
    <link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css"> 
	<style type="text/css">
		table
		{
		 	border-collapse:collapse;
		 	text-align:center;	 	
		}	
		th,td{
			text-align:center;
			border:3px solid #fff1cc;
		}
	</style>
</head>
<body>
	<div class="flol colb fonts18 fontw700 martb15">
		用户列表
	</div>
	
	<table border=1 width=100% >
		<tr style="background-color:#fff1cc">
			<th>用户名</th>
			<th>UID</th>
			<th>联系电话</th>
			<th>注册时间</th>
			<th>送货地址</th>
			<th>处理</th>
		</tr>
	<%
		for(int i=0;i< users.size();i++)
		{
			User u = users.get(i);
	%>	
		<tr>
			<td><%= u.getUsername() %></td>
			<td><%= u.getId() %></td>
			<td><%= u.getPhone() %></td>
			<td><%= u.getDate() %></td>
			<td><%= u.getAddress() %></td>
			<td>
				<% String url=request.getRequestURL()
					+(request.getQueryString()==null?"":"?"+request.getQueryString()); %>
				<!-- 以上就是为了获得本页面的URL以及参数，将该URL整个传给UserDelete页面 -->	
				<a target="detail" href="UserDelete1.jsp?id=<%=u.getId()%>&from=<%=url%>" 
					onclick="return confirm('真的要删除?')">删除</a>
				<!-- from只是一个参数的参数名 -->
			</td>
		</tr>
	<% 
		}
	%>
	</table>
	<form name="form1" method=post action="UserList1.jsp" style="float:left" >
		<select name="pageNo" onchange="document.form1.submit()" >
			<%
				for(int i=1;i<=totalPages;i++)
				{
			%>
				<option value=<%=i%> <%=(pageNo==i)?"selected":""%> >第<%=i%>页</option>
			<%
				}
			%>
		</select>
	</form>
	<form name="form2" method=post action="UserList1.jsp" style="float:right" >
		<input type="text" name="pageNo" value="<%= pageNo %>" size=6 />
		<input type="submit" name="submit" value="提交" />
	</form>
</body>
</html>