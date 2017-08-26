<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="category.*,java.util.*"  %>

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
    int pageNo=1;
    final int pageSize=8;
    String strPageNo=request.getParameter("pageNo");
    if(strPageNo !=null && !strPageNo.trim().equals(""))
    {
    	try
		{
			pageNo=Integer.parseInt(strPageNo);
		}
		catch(NumberFormatException e)
		{
			pageNo=1;
		}
    }
    if(pageNo<=0)
    {
    	pageNo=1;
    }
	
    
    List<Category> categories=new ArrayList();
	int totalRecords=CategoryService.getInstance().getCategories(categories,pageNo,pageSize);
	int totalPages=(totalRecords-1)/pageSize+1;
	if(pageNo>totalPages)
	{
		pageNo=totalPages;
		response.sendRedirect("CategoryList1.jsp?pageNo="+pageNo);
		return;
	}
	
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
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
		<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
	  	<title>艺术创想校园管理中心</title> 
	    <link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css"> 
		<style type="text/css">
			hr{		
				border:none;
				border-top:1px dashed #03a9f4;
			}
			a:link{color:#696969;}				
			a:visited {color:#696969;}			
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
			<div class="boxs10 widpc90 borr10 padpc5">		
				<div class="flol colb fonts20 fontw700 martb15" style="margin-left:25px;">
					课程类别
				</div>
				<div class="flor fonts16" style="margin-right:33px;margin-top:20px; ">
					<a href="CategoryAdd1.jsp" style="color:#fff;padding:3px 8px;" 
					   class="borr5 boxs5 backgb">添加新类别</a>
				</div>
				<div class="pad10 borr10" style="margin-bottom:30px; ">
					<table class="widpc100">
						<tr>				
							<td class="colgy">类别名称</td>
							<td class="colgy">课程类别描述</td>
							<td class="colgy">类别ID</td>
							<td class="colgy">隶属ID</td>
							<td class="colgy">类别编码</td>
							<td class="colgy">级别</td>
							<td></td>
						</tr>
						<tr><td colspan="7"><hr></td></tr>
						<%
							for(int i=0;i<categories.size();i++)
							{
								Category c=categories.get(i);//集合取出的方式是 get，数组取出方式是[]
								String preStr="";
								for(int j=1;j<c.getGrade();j++)
								{
									preStr+="----";
								}
						%>
						<tr>				
							<td style="width:100px;">
								<a name="modify" href="CategoryModify1.jsp?id=<%= c.getId() %>"
									 class="fontw700" style="color:#03a9f4;">						
									<%= c.getName() %>
								</a>
							</td>
							<td style="width:200px;" class="textl">					
								<%= c.getDescribe() %>					
							</td>
							<td style="width:50px;">
								<%= c.getId() %>
							</td>
							<td style="width:50px;">
								<%= c.getPid() %>
							</td>
							<td style="width:70px;">
								<%= c.getCno() %>
							</td>
							<td style="width:50px;">
								<%= c.getGrade() %>
							</td>
							<td style="width:150px;">
								<a name="modify" href="CategoryModify1.jsp?id=<%= c.getId() %>" 
								   style="padding:3px 8px;color:#fff;"class="backgb borr5 boxs5">修改</a>
								&nbsp;&nbsp;
								<a name="delete" href="CategoryDelete1.jsp?id=<%= c.getId() %>" 
									   class="borr5 boxs5 backgw colgy boxs5" style="padding:3px 8px;"
									   onclick="return confirm('真的要删除吗？');">删除</a>
								&nbsp;&nbsp;	   
								<% if(c.getGrade()<Category.MAX_GRADE)
									{
								%>	
									<a name="add" href="CategoryAddChild1.jsp?pid=<%=c.getId()%>&grade=<%= c.getGrade() %>" 
									   class="borr5 boxs5 backgw colgy boxs5" style="padding:3px 8px;">添加子类别</a>
								<%
									}
								%>
							</td>
						</tr>
						<tr><td colspan="7"><hr></td></tr>							
						<%
							}
						%>				
					</table>		
				</div>
				
				<form name="form1" method=post action="CategoryList1.jsp" style="float:left" >
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
					<a href="CategoryList1.jsp?pageNo=<%
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
							<a href="CategoryList1.jsp?pageNo=<%= i %>" class="fonts18" 
								style="color:#03a9f4;margin-left:15px;"><%= i %></a>
						<%
							}
						%>
					<a href="CategoryList1.jsp?pageNo=<%
									if(pageNo+1<=totalPages)
									{
										out.println(pageNo+1);
									}
									%>" class="boxs5 borr5 colgys pad5" 
						style="margin-left:15px;padding:3px 8px 3px 8px;">下一页</a>	
				</div>
				
				<form name="form2" method=post action="CategoryList1.jsp" style="float:right" >
					<input type="text" name="pageNo" class="textc" value="<%= pageNo %>" size=6 />
					<input type="submit" name="submit" value="Go" />
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






