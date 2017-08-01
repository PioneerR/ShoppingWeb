<%@ page import="category.CategoryService" %>
<%@ page import="category.Category" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("utf8");
	int id=Integer.parseInt(request.getParameter("id"));
	Category c=CategoryService.getInstance().loadById(id);
	String action=request.getParameter("action");	
	if(action!=null && action.trim().equals("modify"))
	{
		String name=request.getParameter("category");
		String describe=request.getParameter("describe");
		
		c.setName(name);
		c.setDescribe(describe);
		c.update();
			
		out.println("修改类别成功！");
%>
	<script type="text/javascript">
	   parent.main.location.reload();
	</script>
<% 	
		return;
	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>修改类别</title>
		<style type="text/css">
			.table{
				border:solid 1px blue;
				border-collapse: collapse;
			}
			td{		
				border:solid 3px #fff1cc;
			}		
		</style>
	</head>
	<body>
		<form action="CategoryModify1.jsp" method="post"  >
			<input type=hidden name="action" value="modify" />
			<input type=hidden name="id" value="<%= id %>"/>
			<table class="table" width="100%" style="border:1px solid #fff1cc;">
				<tr style="border:1px;background-color:#fff1cc;">
					<th colspan=2>修改类别-必填内容</th>
				</tr>
				<tr>
					<td style="border:1px;background-color:#fff1cc;">类别名称：</td>
					<td><input type="text" size=158% name="category" value="<%= c.getName() %>" /></td>
				</tr>
				<tr>
					<td style="border:1px;background-color:#fff1cc;">类别描述：</td>
					<td><textarea cols=117% rows=5 name="describe" ><%= c.getDescribe() %></textarea></td>
					<!-- 文本区域的文字，并不是value值 -->
				</tr>				
			</table>
			<input type="submit" name="submit" value="提交" />
		</form>
	</body>
</html>