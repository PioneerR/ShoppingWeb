<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf8" %>
<%@ page import="user.*,java.util.*" %>

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
	final int PAGE_SIZE=4;//每个页面最多显示的条数
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
	
	String yscxadmin=(String)session.getAttribute("yscxadmin");
	if(yscxadmin == null)
	{
		response.sendRedirect("/Gouwu/UserLogin1.jsp");
		return;
	}

	String action=request.getParameter("action");
	if(action !=null && action.equals("exit"))
	{
		session.invalidate();
		response.sendRedirect("/Gouwu/");
		return;
	}
	
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
	<div class="widpc100 backgb" style="position:fixed;top:0;height:50px;
			 box-shadow:5px 5px 8px #B5B4B4,-5px 5px 8px #B5B4B4;" id="nav">
		  <nav style="" class="overfh">
			<div class="flol" style="margin-right:10%;margin-left:7%;">
				<a href="/Gouwu/admin/AdminIndex1.jsp" style="color:white;" class="fontw700">				
					<img src="/Gouwu/images/icon/yscx.png" class="wida" style="height:30px;">艺术创想管理中心
				</a>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="/Gouwu/admin/AdminIndex1.jsp" style="color:#fff;">首页</a>
				<div class="ishide " style="line-height:35px;">						
					<a href="/Gouwu/Index1.jsp">
						<div class="is colgy backgw" style="line-height:34px">用户首页</div>						
					</a>		
				</div>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="/Gouwu/admin/UserList1.jsp" style="color:#fff;">用户管理</a>
				<div class="ishide " style="line-height:35px;">						
					<a href="/Gouwu/admin/UserList1.jsp"  class=""  >
						<div class="is colgy backgw" style="line-height:34px">用户列表</div>						
					</a>		
				</div>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="/Gouwu/admin/CategoryList1.jsp" class="" style="color:#fff;">课程类别</a>
				<div class="ishide " style="line-height:35px;  ">						
					<a href="/Gouwu/admin/CategoryList1.jsp" >
						<div class="is colgy backgw"style="line-height:34px">类别列表</div>
					</a>		
				</div>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="/Gouwu/admin/ProductList1.jsp" style="color:#fff;">课程管理</a>
				<div class="ishide " style="line-height:35px;  ">						
					<a href="/Gouwu/admin/ProductList1.jsp">
						<div class="is colgy backgw"style="line-height:34px">课程列表</div>
					</a>
					<a href="/Gouwu/admin/ProductSearch1.jsp" class="" onclick="">
						<div class="is colgy backgw"style="line-height:34px">课程搜索</div>
					</a>
					<a href="/Gouwu/admin/ProductComplexSearch1.jsp" class="" onclick="">
						<div class="is colgy backgw"style="line-height:34px">高级搜索</div>
					</a>		
				</div>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="/Gouwu/admin/OrderList1.jsp" class="" style="color:#fff;">报名管理</a>
				<div class="ishide " style="line-height:35px;  ">						
					<a href="/Gouwu/admin/OrderList1.jsp">
						<div class="is colgy backgw"style="line-height:34px">报名列表</div>
					</a>		
				</div>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="/Gouwu/servlet/SalesCountServlet" class="" style="color:#fff;">数据统计</a>
				<div class="ishide " style="line-height:35px;  ">						
					<a href="/Gouwu/servlet/SalesCountServlet">
						<div class="is colgy backgw"style="line-height:34px">分类统计</div>
					</a>		
				</div>
			</div>
		
		<%
			if(yscxadmin==null)
			{
		%>					
				<div class="flol marlr15" style="margin-top:25px;" >
					<a href="/Gouwu/UserLogin1.jsp" style="color:white;">
						<img src="/Gouwu/images/icon/signin.png" class="wida" style="height:20px;">登录
					</a>
				</div>
		<%
			}
			else
			{
		%>			
			<div class="itemshow flol" style="margin-top:0px;margin-left:10%;" >
				<a href="" style="color:white;">
					<img src="/Gouwu/images/icon/user.png" class="wida" 
						 style="height:20px;margin-right:5px;">
					管理员
				</a>
				<div class="itemhide" style="width:150px;padding-bottom:5px;">
					<a href="/Gouwu/admin/OrderList1.jsp">
						<div class="item borrt5 textc backgw colgy fonts16" style="line-height:37px;margin-right:10%;">
							待处理预报名
						</div>
					</a>
					<a href="/Gouwu/admin/AdminIndex1.jsp?action=exit">
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
	
	
	<div class="heia wida" style="padding:8% 5% 5% 5%;">
		<div class="boxs10 widpc90 borr10  padpc5">
			<div class="flol colb fonts20 fontw700 martb15" style="margin-left:25px; ">
				用户列表
			</div>
			
			<div class="pad10 borr10" style="margin-bottom:30px; ">
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
						//当页面的数据都没了的时候，跳到上一页，此时的pageNO已经是上一页的了，但是浏览器自动跳转会出错，我们需要人工跳转刷新
						if(users.size()==0)
						{
							response.sendRedirect("UserList1.jsp?pageNo="+(pageNo));
							return;
						}
					
						int total=0;
						for(int i=0;i<users.size();i++)
						{
							User u = users.get(i);
							total=u.getTotalCount();
					%>
					<tr>				
						<td style="width:100px;" class="colb fontw700">
							<%= u.getUsername() %>
						</td>
						<td style="width:150px;" class="colb">					
							<%= u.getPhone() %>					
						</td>
						<td style="width:150px;">
							<%
								if(u.getQQ()==null)
								{										
									out.print("<font style='color:#696969;'>/</font>");
								}
								else
								{
									out.print(u.getQQ());
								}
							%>
						</td>
						<td style="width:200px;">
							<%
								if(u.getEmail()==null)
								{										
									out.print("<font style='color:#696969;'>/</font>");
								}
								else
								{
									out.print(u.getEmail());
								}
							%>
						</td>
						<td style="width:250px;">
							<%
								if(u.getAddress()==null)
								{										
									out.print("<font style='color:#696969;'>/</font>");
								}
								else
								{
									out.print(u.getAddress());
								}
							%>
						</td>
						<td style="width:100px;" class="fonts14">
							<%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(u.getDate()) %>
						</td>
						<td>
							<% String url=request.getRequestURL()
							+(request.getQueryString()==null?"":"?"+request.getQueryString()); %>
							<a href="UserDelete1.jsp?id=<%=u.getId()%>&from=<%=url%>" class="colgy fonts24" 
							   onclick="return confirm('真的要删除吗？')">x</a>
						</td>
					</tr>
					<tr><td colspan="7"><hr></td></tr>							
					<%
						}
					%>
					<tr>				
						<td colspan="4"></td>	
						<td class="colb fontw700 fonts20 textr">总人数</td>			
						<td class="colb fontw700 fonts20" colspan="2"><%= total %></td>
					</tr>
				</table>		
			</div>
			
			<form name="form1" method=post action="UserList1.jsp" style="float:left" >
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
			<div style="margin-left:25%;" class="flol">
				<a href="UserList1.jsp?pageNo=<%
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
						<a href="UserList1.jsp?pageNo=<%= i %>" class="fonts18" 
							style="color:#03a9f4;margin-left:15px;"><%= i %></a>
					<%
						}
					%>
				<a href="UserList1.jsp?pageNo=<%
								if(pageNo+1<=totalPages)
								{
									out.println(pageNo+1);
								}
								%>" class="boxs5 borr5 colgys pad5" 
					style="margin-left:15px;padding:3px 8px 3px 8px;">下一页</a>	
			</div>
			
			<form name="form2" method=post action="UserList1.jsp" style="float:right" >
				<input type="text" name="pageNo" class="textc" value="<%= pageNo %>" size=6 />
				<input type="submit" name="submit" value="提交" />
			</form>
		</div>		
	</div>
	
	<div class="widpc100 backgbs" style="height:100px;padding-top:30px;background-color:#eafbf6;">
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
		<div class="flol heia martbpc1 fonts14" style="margin-left:38%;">
			Copyright © 2017 艺术创想  Designed by 
			<a href="https://github.com/PioneerR" target="_blank" style="color:#03a9f4;">PioneerR</a>
		</div>
    </div>
</body>
</html>