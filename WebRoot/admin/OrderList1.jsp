<%@ page import="order.OrderMgr"%>
<%@ page import="order.SalesOrder"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	request.setCharacterEncoding("utf8"); 
	final int pageSize=5;//每个页面最多显示的条数
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
	List <SalesOrder> orders=new ArrayList<SalesOrder>();
	int totalRecords=OrderMgr.getInstance().getOrders(orders, pageNo, pageSize);
	int totalPages = (totalRecords + pageSize - 1) / pageSize;
	
	if (pageNo > totalPages)
		pageNo = totalPages;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
			a{
				text-decoration: none;
			}
		</style>
	</head>
	<body>
		<div class="flol colb fonts18 fontw700 martb15">
			报名列表
		</div>
	
		<table border=1 width=100% >
			<tr style="background-color:#fff1cc">
				<th>ID</th>
				<th>用户名</th>
				<th>发货地址</th>
				<th>下单时间</th>
				<th>订单状态</th>
				<th>处理</th>
			</tr>
		<%
			String [] arr={"待付款","请求取消课程","待排课","已排课","课程已取消"};
		
			for(int i=0;i< orders.size();i++)
			{
				SalesOrder so = orders.get(i);
		%>	
			<tr>
				<td><%= so.getId() %></td>
				<td><%= so.getUser().getUsername() %></td>
				<td><%= so.getAddress() %></td>
				<td><%= so.getODate() %></td>
				<td><%= arr[so.getStatus()] %></td>
				<td>
					<a target="detail" href="OrderDetailShow1.jsp?id=<%=so.getId()%>" 
					   style="margin-right:20px;">订单明细</a>
					<a target="detail" href="OrderModify1.jsp?id=<%=so.getId()%>">订单修改</a>
				</td>
			</tr>
		<% 
			}
		%>
		</table>
		<form name="form1" method=post action="OrderList1.jsp" style="float:left" >
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
		&nbsp;
		<span>共<%= totalPages %>页</span>
		&nbsp;
		<a href="OrderList1.jsp?pageNo=<%= pageNo-1 %>">上一页</a>
		&nbsp;
		<a href="OrderList1.jsp?pageNo=<%= pageNo+1 %>">下一页</a>
		&nbsp;
		<a href="OrderList1.jsp?pageNo=<%= totalPages %>">最后一页</a>
		<form name="form2" method=post action="OrderList1.jsp" style="float:right" >
			<input type="text" name="pageNo" value="<%= pageNo %>" size=6 />
			<input type="submit" name="submit" value="提交" />
		</form>	
	</body>
</html>