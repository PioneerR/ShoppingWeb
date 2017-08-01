<%@page import="category.CategoryService"%>
<%@page import="category.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>产品搜索</title>
		<style type="text/css">
		 	th{
				text-align:center;
				border:3px solid #fff1cc;
			}
			td{
				border:3px solid #fff1cc;
			}
			a{
				text-decoration: none;
			}	
			input{
				margin-right: 20px; 			
			}
		</style>
	</head>
	<body>
		<form action="ProductSearch1.jsp" method="post" target="detail" style="margin-bottom:0px">
			<input type="hidden" name="search" value="simplesearch" />
			<table style="border-collapse: collapse;border:3px #fff1cc;" width=100%>
				<th style="background-color:#fff1cc;">简单搜索</th>
				<tr style="text-align:center;">
					<td><input type="text" name="simple" size=50 style="margin-right:0px;"/>
					<input type="submit" value="搜索"  ></td>
				</tr>	
			</table>
		</form>
		<form action="ProductSearch1.jsp" method="post" target="detail" >
			<input type="hidden" name="search" value="complexsearch" />
			<table  style="border-collapse: collapse;border:3px #fff1cc;" width=100% >
				<th style="background-color:#fff1cc;" colspan=2>
					高级搜索
				</th>
				<tr>
					<td width="100px">产品类别：</td>
					<td>
						<select name="categoryId"/>
							<option value="-1" >----所有商品----</option>
						<%
							List<Category>categories=CategoryService.getInstance().getCategories();
							for(int i=0;i<categories.size();i++)
							{
								Category c=categories.get(i);
								int grade=c.getGrade();
								String preStr="";
								for(int j=1;j<grade;j++)
								{
									preStr+="----";
								}
						%>
							<option value="<%= c.getId() %>"><%= preStr+c.getName() %></option>
						<%
							}
						%>	
						</select>
					</td>
				</tr>
				<tr>
					<td>产品名称：</td>
					<td><input type="text" name="productName"/></td>
				</tr>
				<tr>
					<td>市场价格：</td>
					<td>From：<input type="text" name="lowprice"/>To：<input type="text" name="highprice"/></td>
				</tr>
				<tr>
					<td>会员价格：</td>
					<td>From：<input type="text" name="mlowprice"/>To：<input type="text" name="mhighprice"/></td>
				</tr>
				<tr>
					<td>日期时间：</td>
					<td>From：<input type="text" name="date1"/>To：<input type="text" name="date2"/></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;" >
						<input type="submit" value="搜索" style="margin-right: 100px"/>
						<input type="reset" value="重置" />					
					</td>
				</tr>
			</table>
		</form>		
	</body>
</html>