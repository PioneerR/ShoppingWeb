<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="order.OrderMgr"%>
<%@ page import="order.SalesOrder"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%!
	public int check(int a)
	{
		int n=0;
		if(a>10)
		{
			a=a-10;
			n++;
			check(a);//递归计算56中的整十数5
		}
		return n;
	}
%>

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
	
	//点击浏览器后退按钮时，不读取该页缓存，并自动刷新本页面
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
		<div class="flol colb fonts24 fontw700 martb10" style="margin-left:25px;">
			报名列表
		</div>		
				
		<div class="pad10 borr10" style="margin-bottom:30px; ">
			<table class="widpc100">
				<tr>				
					<td class="colgy">用户名</td>
					<td class="colgy">手机号码</td>
					<td class="colgy">发货地址</td>					
					<td class="colgy">OrderID</td>
					<td class="colgy">报名状态</td>
					<td class="colgy">报名时间</td>
					<td></td>
				</tr>
				<tr><td colspan="7"><hr></td></tr>
				<%
					String [] arr={"待付款","请求取消课程","待排课","已排课","课程已取消"};
				
					for(int i=0;i< orders.size();i++)
					{
						SalesOrder so = orders.get(i);
				%>
				<tr>				
					<td style="width:150px;" class="colb fontw700">
						<%= so.getUser().getUsername() %>
					</td>
					<td style="width:100px;">					
						<%= so.getUser().getPhone() %>					
					</td>
					<td style="width:250px;">	
						<%
							if(so.getAddress()==null)
							{										
								out.print("<font style='color:#696969;'>/</font>");
							}
							else
							{
								out.print(so.getAddress());
							}
						%>
					</td>
					<td style="width:80px;">
						<%= so.getId() %>
					</td>					
					<td style="width:100px;" class="colb">
						<%= arr[so.getStatus()] %>
					</td>
					<td style="width:100px;" class="fonts14">
						<%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(so.getODate()) %>
					</td>
					<td style="">					
						<a name="modify" href="OrderModify1.jsp?id=<%=so.getId()%>" style="padding:3px 8px;color:#fff;"
						   class="backgb borr5 boxs5">修改状态</a>
						   &nbsp;
						<a name="delete1" href="OrderDetailShow1.jsp?id=<%=so.getId()%>" class="borr5 boxs5 backgb" 
						   style="padding:3px 8px;color:#fff;">报名详情</a>	
					</td>
				</tr>
				<tr><td colspan="7"><hr></td></tr>							
				<%
					}
				%>				
			</table>		
		</div>
		
		<form name="form1" method=post action="OrderList1.jsp" style="float:left" >
			<select name="pageNo" onchange="document.form1.submit()" class="textc" >
				<% 
					for(int i=1;i<=totalPages;i++)
					{
				%>
					<option value=<%=i%> <%=(pageNo==i)?"selected":""%>>第<%=i%>页</option>
				<%
					}
				%>
			</select>
		</form>
		<div style="margin-left:33%;" class="flol">
			<a href="OrderList1.jsp?pageNo=1" class="boxs5 borr5 colgys pad5" 
				style="padding:3px 8px 3px 8px;">首页</a>	
			<a href="OrderList1.jsp?pageNo=<%
							if(pageNo-1>0)
							{
								out.println(pageNo-1);
							}
							%>" class="boxs5 borr5 colgys" style="padding:3px 8px 3px 8px;">上一页</a>
				<%
					int a=1,b=totalPages;//如果不符合以下两个if,那么a=1,b==totalpages,此时
					int m=0;
					m=check(pageNo);
					if(totalPages>10 && m==0)
					{
						a=1;
						b=10;
					}
					else if(totalPages>10 && m>=1)
					{
						a=1+m*10;
						b=(m+1)*10;
						if(b>totalPages)
						{
							b=totalPages;
						}	
					}
					for(int i=a;i<=b;i++)
					{
				%>
					<a href="OrderList1.jsp?pageNo=<%= i %>" class="fonts18" 
						style="color:#03a9f4;margin-left:15px;"><%= i %></a>
				<%
					}
				%>
			<a href="OrderList1.jsp?pageNo=<%
							if(pageNo+1<=totalPages)
							{
								out.println(pageNo+1);
							}
							%>" class="boxs5 borr5 colgys pad5" 
				style="margin-left:15px;padding:3px 8px 3px 8px;">下一页</a>	
			<a href="OrderList1.jsp?pageNo=<%= totalPages %>" class="boxs5 borr5 colgys pad5" 
				style="padding:3px 8px 3px 8px;">尾页</a>	
		</div>
		
		<form name="form2" method=post action="OrderList1.jsp" style="float:right" >
			<input type="text" name="pageNo" class="textc" value="<%= pageNo %>" size=6 />
			<input type="submit" name="submit" value="Go" />
		</form>
	
	</body>
</html>