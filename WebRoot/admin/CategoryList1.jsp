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
		<div class="flol colb fonts18 fontw700 martb15" style="margin-left:25px;">
			课程类别
		</div>
		<div class="flor fonts16" style="margin-right:25px;margin-top:20px; ">
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
					<td style="width:100px;" class="colb fontw700">
						<%= c.getName() %>
					</td>
					<td style="width:300px;" class="textl">					
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
						   style="padding:3px 8px;color:#fff;"class="backgb borr5 boxs5">修改类别</a>
						&nbsp;&nbsp;
					
						<% if(c.getGrade()<Category.MAX_GRADE)
							{
						%>	
							<a name="add" href="CategoryAddChild1.jsp?pid=<%=c.getId()%>&grade=<%= c.getGrade() %>" 
							   class="borr5 boxs5 backgb" style="padding:3px 8px;color:#fff;">添加子类别</a>
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
			<input type="submit" name="submit" value="提交" />
		</form>		
	</body>
</html>











