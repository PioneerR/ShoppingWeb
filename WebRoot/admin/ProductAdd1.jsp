<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="category.Category"%>
<%@page import="java.util.List"%>
<%@ page import="product.*,category.CategoryService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<%
	request.setCharacterEncoding("utf8");
	int categoryId = -1;
	//因为这些数据都是要一次提交的，所以每个参数都必须要有，但是如果有些参数有误，需要标识，用负号进行标识
	String strCategoryId = request.getParameter("categoryId");
	if(strCategoryId != null && !strCategoryId.trim().equals("")) {
		categoryId = Integer.parseInt(strCategoryId);
	}
	
	
	String action=request.getParameter("action");
	if(action!=null && action.trim().equals("pruductadd"))
	{	
		String name=request.getParameter("product");
		int normalPrice=Integer.parseInt(request.getParameter("normalPrice"));
		int memberPrice=Integer.parseInt(request.getParameter("memberPrice"));	
		String describe=request.getParameter("describe");
		
		Product p=new Product();
		p.setName(name);
		p.setNormalPrice(normalPrice);
		p.setMemberPrice(memberPrice);
		p.setDescribe(describe);
		p.setDate(new Date());
		p.setCategoryId(categoryId);
	
	
		ProductMgr.getInstance().add(p);
		out.println("恭喜您，添加类别成功！");
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
		<title>添加产品</title>
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
		<form action="ProductAdd1.jsp" method="post"  >
			<input type=hidden name="action" value="pruductadd" />
			<table class="table" width="100%" style="border:1px solid #fff1cc;">
				<tr style="border:1px;background-color:#fff1cc;">
					<th colspan=2>产品添加</th>
				</tr>
				<tr>
					<td style="border:1px;background-color:#fff1cc;">产品名称：</td>
					<td><input type="text" size=155% name="product" /></td>
				</tr>
				<tr>
					<td style="border:1px;background-color:#fff1cc;">市场价格：</td>
					<td><input type="text" size=155% name="normalPrice" /></td>
				</tr>
				<tr>
					<td style="border:1px;background-color:#fff1cc;">会员价格：</td>
					<td><input type="text" size=155% name="memberPrice" /></td>
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
								if(c.getId()==999) selected="selected";
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
					<td><textarea cols=115% rows=2 name="describe"></textarea></td>
				</tr>				
			</table>
			<input type="submit" name="submit" value="提交" />
		</form>
	</body>
</html>