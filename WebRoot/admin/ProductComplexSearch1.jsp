<%@ page import="category.CategoryService"%>
<%@ page import="category.Category"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
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
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
		<title>艺术创想</title>
		<link type="text/css" rel="stylesheet" href="/Gouwu/css/base.css" />		
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
	
		<div class="textc colb fontw700 fonts24" style="margin-left:0%;margin-bottom:30px;padding:6% 0% 0% 0%;">
			<img src="/Gouwu/images/product/yscx.png" style="height:100px;" class=""/>课程高级搜索
		</div>
		<div style="margin-left:21%; ">
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
						<td class="colb fonts16 textl" style="margin-left:13px;height:25px;">
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
	   	
		<iframe frameborder=0  style="padding:0% 2% 0% 2%;height:850px;width:80%;margin-left:9%;;"
	      		  src="" class="" scrolling="no" name="complexsearch"></iframe>
	     
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
			<div class="flol heia martbpc1 fonts14" style="margin-left:33%;">
				Copyright © 2017 艺术创想  Designed by 
				<a href="https://github.com/PioneerR" target="_blank" style="color:#03a9f4;">PioneerR</a> | 				
				<a href="http://www.miitbeian.gov.cn/" target="_blank" style="color:#03a9f4;">闽ICP备17023054号</a>
			</div>
	    </div>  		  
			
	</body>
</html>