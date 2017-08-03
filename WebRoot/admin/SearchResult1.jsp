<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List" %>
<%@ page import="product.ProductMgr" %>
<%@ page import="category.Category" %>
<%@ page import="product.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf8");

	final int pageSize=5;//全局常量
	int pageNo=1;
	String strPageNo=request.getParameter("pageNo");
	if(strPageNo!=null && !strPageNo.equals("") )
	{
		try
		{
			pageNo=Integer.parseInt(strPageNo);
			//虽然strPageNo不为空，但也有可能为其他数据类型
		}
		catch(NumberFormatException e)
		{
			pageNo=1;
		}
	}
	if(pageNo<=0)
	{
		pageNo=1;//虽然strPageNo是int的数据类型，但是有可能是负数
	}
%>


<%	
	List<Product>products =new ArrayList();
	String keyword=request.getParameter("keyword");
	int totalRecords=ProductMgr.getInstance().find(products, pageNo, pageSize, keyword);
	int totalPages=(totalRecords-1)/pageSize+1;
	if(pageNo>totalPages)
	{
		pageNo=totalPages;//虽然strPageNo是int的数据类型，也是正数，但是有可能输入的值大于总页数
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>简单搜索结果</title>
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
		<span>产品搜索结果 </span><br>
		<div style="text-align:center">
			<span><a href="ProductAdd1.jsp" target="detail" >添加新产品</a></span>
		</div>
		<table width=100% style="border:3px solid #fff1cc;border-collapse:collapse; ">
		
			<tr style="background-color:#fff1cc;" >
				<th>选择</th>
				<th>产品ID</th>
				<th>产品名称</th>
				<th>产品描述</th>
				<th>市场价格</th>
				<th>会员价格</th>
				<th>上架时间</th>
				<th>所属类别</th>
				<th>处理</th>
			</tr>
			<form action="ProductDelete1.jsp?parameter=x" target="detail" method="post" >	
		<%
			for(int i=0;i<products.size();i++)
			{
				Product p=products.get(i);//集合取出的方式是 get，数组取出方式是[]
				Category c=ProductMgr.getInstance().getCategory(p.getCategoryId());
				//通过产品类别的id号，取得产品类别，进而获取类别属性
		%>
			<tr>
				<td><input type="checkbox" name="delete" value="<%= p.getId()  %>" /></td>
				<td><%= p.getId() %></td>
				<td><%= p.getName() %></td>
				<td><%= p.getDescribe() %></td> 
				<td><%= p.getNormalPrice() %></td>
				<td><%= p.getMemberPrice() %></td>
				<td><%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.format(p.getDate()) %></td>
				<td><%= c.getName()+c.getCno() %></td>
				<td>
					<a name="delete1" href="ProductDelete1.jsp?id=<%= p.getId() %>&parameter=1" target="detail" onclick="return confirm('真的要删除吗？')">删</a>
					&nbsp;&nbsp;
					<a name="modify" href="ProductModify1.jsp?id=<%= p.getId() %>&action=modify" target="detail" >改</a>
					&nbsp;&nbsp;
					<a name="upload" href="ProductUpload1.jsp?id=<%= p.getId() %>" target="detail" >上传</a>
				</td>
			</tr>	
		<%
			}
		%>	
			<tr>
				<td>		
					<input type="checkbox" id="deleteall" />
					<input type="submit" value="删除" onclick="return confirm('真的要删除吗?')" />		
				</td>
				</form>	<!-- 注意，要提交的数据，一定要放在form表单内部，比如checkbox，否则会空指针异常 -->
				<td colspan=8 >
					<form action="SearchResult1.jsp" method="post" >
						<input type="text" name="keyword" />
						<input type="submit" value="搜索" />
					</form>
				</td>			
			</tr>
		</table>
		<form name="form1" method=post action="SearchResult1.jsp" style="float:left" >
			<input type="hidden" name="keyword" value="<%= keyword %>" />
			<!-- 只要是从request.getParameter过来的参数，都要注意回传，否则keyword=null -->
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
		<form name="form2" method=post action="SearchResult1.jsp" style="float:right" >
			<input type="hidden" name="keyword" value="<%= keyword %>" />
			<input type="text" name="pageNo" value="<%= pageNo %>" size=6 />
			<input type="submit" name="submit" value="提交" />
		</form>	
	</body>
</html>