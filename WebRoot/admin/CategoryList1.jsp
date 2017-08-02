<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="category.*,java.util.*"  %>

<%
	request.setCharacterEncoding("utf8");
    int pageNo=1;
    final int pageSize=5;
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
	}
	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
		<title>类别列表</title>
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
		<span>类别管理 &raquo;类别列表 </span><br>
		<div style="text-align:center">
			<span><a href="CategoryAdd1.jsp" target="detail" >添加根类别</a></span>
		</div>
		<table  style="border:3px solid #fff1cc;border-collapse:collapse;width:100% ">
			<tr style="background-color:#fff1cc;" >
				<th>类别编号</th>
				<th>类别名称</th>
				<th>类别描述</th>
				<th>PID</th>
				<th>代表字串</th>
				<th>级别</th>
				<th>处理</th>
			</tr>
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
				<td><%= c.getId()   %></td>
				<td style="text-align:left;"><%= preStr+c.getName() %></td>
				<td><%= c.getDescribe() %></td>
				<td><%= c.getPid() %></td>
				<td><%= c.getCno() %></td>
				<td><%= c.getGrade() %></td>
				<td>
					<a name="modify" href="CategoryModify1.jsp?id=<%= c.getId() %>" target="detail" >修改类别</a>&nbsp;&nbsp;
					
					<% if(c.getGrade()<Category.MAX_GRADE)
						{
					%>	
						<a name="add" href="CategoryAddChild1.jsp?pid=<%=c.getId()%>&grade=<%= c.getGrade() %>" target="detail">添加子类别</a>
					<%
						}
					%>
			</td>
			</tr>	
		<%
			}
		%>	
		</table>
		<form name="form1" method=post action="CategoryList1.jsp" style="float:left" >
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
		<form name="form2" method=post action="CategoryList1.jsp" style="float:right" >
			<input type="text" name="pageNo" value="<%= pageNo %>" size=6 />
			<input type="submit" name="submit" value="提交" />
		</form>	
	</body>
</html>



















