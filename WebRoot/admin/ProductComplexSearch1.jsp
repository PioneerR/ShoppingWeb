<%@ page import="category.CategoryService"%>
<%@ page import="category.Category"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
		<title>艺术创想</title>
		<link type="text/css" rel="stylesheet" href="/Gouwu/css/base.css" />		
	</head>
	<body>
		<div class="textc colb fontw700 fonts24" style="margin-left:0%;margin-bottom:30px;">
			<img src="/Gouwu/images/product/yscx.png" style="height:100px;" class=""/>课程高级搜索
		</div>
		<div style="margin-left:15%; ">
			<form method="post" action="ComplexSearchResult1.jsp" target="complexsearch" 
				  name="complexform" class="flol" >
				<input type="hidden" name="search" value="complexsearch" />
				<table style="margin-top:24px;padding-left:10px;padding-right:10px;margin-bottom:3%;"
					   class="flol">						
					<tr style="">
						<td class="colb fonts16 textl" style="margin-left:13px;">
							课程类别：
						</td>
						<td class="textl">
							<select name="categoryId" style="width:200px;"/>
								<option value="-1" >-------------所有商品-------------</option>
							<%
								List<Category>categories=CategoryService.getInstance().getCategoriesGradeTwo();
								for(int i=0;i<categories.size();i++)
								{
									Category c=categories.get(i);
									int grade=c.getGrade();
							%>
								<option value="<%= c.getId() %>"><%= c.getName() %></option>
							<%
								}
							%>	
							</select>
						</td>			
					</tr>
					<tr style="">
						<td class="colb fonts16 textl" style="margin-left:13px;">
							课程名称：
						</td>
						<td class="textl">
							<input type="text" name="productName" style="width:195px;"/>
						</td>			
					</tr>
					</table>
					
					<table style="margin-top:20px;padding-left:10px;padding-right:10px;margin-bottom:3%;margin-left:100px;"
					   class="flol">
					<tr style="">
						<td class="colb fonts16 textl" style="margin-left:13px;" >
							市场价格：
						</td>
						<td class="textl" style="width:350px;">
							From：<input type="text" name="lowNormalPrice" style="width:80px;"/>
					        To：<input type="text" name="highNormalPrice" style="width:80px;"/>
						</td>			
					</tr>
					<tr>
						<td class="colb fonts16 textl" style="margin-left:13px;">
							会员价格：
						</td>							
						<td class="textl" style="width:350px;">
							From：<input type="text" name="lowMemberPrice" style="width:80px;"/>
					        To：<input type="text" name="highMemberPrice" style="width:80px;"/>							
						</td>							
					</tr>
					<tr style="">
						<td class="colb fonts16 textl" style="margin-left:13px;" >
							时间日期：
						</td>
						<td class="textl" style="width:350px;">
							From：<input type="text" name="startDate" style="width:80px;"/>
					        To：<input type="text" name="endDate" style="width:80px;"/>
						</td>			
					</tr>
				</table>	
		</div>
		<div style="margin-left:42%;margin-bottom:20px; " class="flol">
			<a href="javascript:document.complexform.submit();" class="colw backgb boxs5 borr5"
	   		   style="padding:3px 20px;" >搜索</a>
	   		<a href="ProductSearch1.jsp" class="colgy boxs5 borr5"
				   style="padding:3px 12px;margin-right:50px;" >简单搜索</a>   
			</form>
	   		<a href="ProductComplexSearch1.jsp" class="colgy backgw boxs5 borr5"
	   		   style="padding:3px 20px;" >清空</a>
	   	</div>	   
		<iframe frameborder=0  style="padding:0% 2% 0% 2%;height:500px;width:96%;"
	      		  src="" class="backgy" scrolling="auto" name="complexsearch"></iframe>
			
	</body>
</html>