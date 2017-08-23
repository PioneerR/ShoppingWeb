<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="category.Category"%>
<%@page import="java.util.List"%>
<%@ page import="product.*,category.CategoryService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<%
	request.setCharacterEncoding("utf8");
	int id=Integer.parseInt(request.getParameter("id"));
    Product	p=ProductMgr.getInstance().getProduct(id);

	int categoryId = -1;
	//因为这些数据都是要一次提交的，所以每个参数都必须要有，但是如果有些参数有误，需要标识，用负号进行标识
	String strCategoryId = request.getParameter("categoryId");
	if(strCategoryId != null && !strCategoryId.trim().equals("")) {
		categoryId = Integer.parseInt(strCategoryId);
	}
	
	
	String action=request.getParameter("action");
	if(action!=null && action.trim().equals("pruductmodify"))
	{	
		String name=request.getParameter("product");
		int normalPrice=Integer.parseInt(request.getParameter("normalPrice"));
		int memberPrice=Integer.parseInt(request.getParameter("memberPrice"));	
		String describe=request.getParameter("describe");
		
		p.setName(name);
		p.setNormalPrice(normalPrice);
		p.setMemberPrice(memberPrice);
		p.setDescribe(describe);
		p.setCategoryId(categoryId);
	
		ProductMgr.getInstance().modify(p);
		out.println("恭喜您，修改类别成功！");
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
		<title>修改产品</title>
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
		<form action="ProductModify1.jsp" method="post"  >
			<input type=hidden name="action" value="pruductmodify" />
			<input type=hidden name="id" value="<%= id %>"/>
			<!--第二次入坑，id要再传回去，不然提交后，计算会出现id的NumberFormatException-->
			<table class="table" width="100%" style="border:1px solid #fff1cc;">
				<tr style="border:1px;background-color:#fff1cc;">
					<th colspan=2>产品修改</th>
				</tr>
				<tr>
					<td style="border:1px;background-color:#fff1cc;">产品名称：</td>
					<td><input type="text" size=155% name="product" value="<%= p.getName()  %>" /></td>
				</tr>
				<tr>
					<td style="border:1px;background-color:#fff1cc;">市场价格：</td>
					<td><input type="text" size=155% name="normalPrice" value="<%= p.getNormalPrice() %>" /></td>
				</tr>
				<tr>
					<td style="border:1px;background-color:#fff1cc;">会员价格：</td>
					<td><input type="text" size=155% name="memberPrice" value="<%= p.getMemberPrice()  %>" /></td>
				</tr>
				<tr>
					<td style="border:1px;background-color:#fff1cc;">所属类别：</td>
					<td>
						<select name="categoryId">
						<option value="-1" selected="selected" >----------------</option>
						<%
							List<Category> categories=CategoryService.getInstance().getCategories();
							Iterator<Category> it=categories.iterator();
							while(it.hasNext())
							{
								Category c=it.next();
								String selected="";
								if(c.getId()==p.getCategoryId()) selected="selected";
								//selected="selected",设置默认选项
								String preStr="";
								for(int i=1;i<c.getGrade();i++){preStr+="----";}
						%>
							<option value="<%= c.getId() %>" <%= selected %>>
								<%= preStr+c.getName() %>
							</option>
						<%
							}						
						%>					
						</select>
					</td>
				</tr>
				<tr>
					<td style="border:1px;background-color:#fff1cc;">产品描述：</td>
					<td><textarea cols=115% rows=2 name="describe"><%= p.getDescribe() %></textarea></td>
				</tr>				
			</table>
			<input type="submit" name="submit" value="提交" />
		</form>
	</body>
</html>