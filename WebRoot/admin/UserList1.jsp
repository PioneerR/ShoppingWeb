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
	
	//点击浏览器后退按钮时，不读取该页缓存，并自动刷新本页面
	response.setHeader("Pragma","No-cache"); 		
	response.setHeader("Cache-Control","no-cache"); 
	response.setHeader("Cache-Control", "No-store");
	response.setDateHeader("Expires", 0);
%>  
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf8">	
	<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
  	<title>艺术创想校园管理中心</title> 
    <link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css"> 
	<style type="text/css">
		hr{		
			border:none;
			border-top:1px dashed #03a9f4;
		}
	</style>
</head>
<body>
	<div class="flol colb fonts18 fontw700 martb15">
		用户列表
	</div>
	
	<div class="pad10 borr10">
		<table class="widpc100">
			<tr>				
				<td class="colgy">用户名</td>
				<td class="colgy">手机号码</td>
				<td class="colgy">微信/QQ</td>
				<td class="colgy">Email</td>
				<td class="colgy">收货地址</td>
				<td class="colgy">注册时间</td>
				<td></td>
			</tr>
			<tr><td colspan="7"><hr></td></tr>
			<%				
				User u=null;
				for(int i=0;i<users.size();i++)
				{
					u = users.get(i);
			%>
			<tr>				
				<td style="width:100px;" class="colb fontw700">
					<%= u.getUsername() %>
				</td>
				<td style="width:150px;">					
					<%= u.getPhone() %>
				</td>
				<td style="width:150px;">
					<%= u.getQQ() %>
				</td>
				<td style="width:200px;">
					<%= u.getEmail() %>
				</td>
				<td style="width:250px;">
					<%= u.getAddress() %>
				</td>
				<td style="width:100px;">
					<%= u.getDate() %>
				</td>
				<td>
					<% String url=request.getRequestURL()
					+(request.getQueryString()==null?"":"?"+request.getQueryString()); %>
					<a href="UserDelete1.jsp?id=<%=u.getId()%>&from=<%=url%>" class="colgy fonts24">x</a>
				</td>
			</tr>
			<tr><td colspan="7"><hr></td></tr>							
			<%
				}
			%>
			<tr>				
				<td colspan="4"></td>	
				<td class="colb fontw700 fonts20">总人数</td>			
				<td class="colb fontw700 fonts20" colspan="2"><%= u.getTotalCount() %></td>
			</tr>
		</table>		
	</div>
	
	
	
	
	
</body>
</html>