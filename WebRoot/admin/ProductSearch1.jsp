<%@page import="category.CategoryService"%>
<%@page import="category.Category"%>
<%@page import="java.util.List"%>
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
			<img src="/Gouwu/images/product/yscx.png" style="height:100px;" class=""/>课程搜索
		</div>
		<div style="margin-left:33%; ">
			<form action="SearchResult1.jsp" method="post" target="search"
				  style="margin-bottom:0px" name="simpleform">
				<input type="hidden" name="search" value="simplesearch" />
				<input type="text" name="keyword" size=50 style="margin-right:0px;height:25px;"/>
				<a href="javascript:document.simpleform.submit();" class="colw backgb boxs5 borr5"
				   style="padding:5px 12px;" >搜索</a>
				<a href="ProductComplexSearch1.jsp" class="colgy boxs5 borr5"
				   style="padding:5px 12px;" >高级搜索</a>   
			</form>
		</div>
		
		<iframe frameborder=0  style="padding:0% 2% 0% 2%;height:500px;width:96%;"
	      		  src="" class="" scrolling="auto" name="search"></iframe>
		
	</body>
</html>