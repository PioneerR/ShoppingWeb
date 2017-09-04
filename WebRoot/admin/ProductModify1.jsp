<%@ page import="java.util.Date"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="category.Category"%>
<%@ page import="java.util.List"%>
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
		
		out.println("<div style='padding:10% 5% 5% 5%;box-shadow:0 0 10px #B5B4B4;border-radius:10px;width:80%;height:200px;margin-left:5%;margin-top:5%;'");
		out.println("<div style=''>");
		out.println("<h2 style='color:#03a9f4;text-align:center;padding:6%;'>"+"修改课程成功！~"+"</h2>");
		out.println("</div></div>");
		
		out.println("<a href='javascript:window.history.go(-2)' style='text-decoration:none;");
		out.println("background:#03a9f4;padding-bottom:5px;padding-top:5px;color:#fff;float:right;");
		out.println("margin:2% 5% 5% 5%;padding-left:30px;padding-right:30px;text-align:center;border-radius:5px;'>");
		out.println("返回</a>");
		return;
	}
	
	String yscxadmin=(String)session.getAttribute("yscxadmin");
	if(yscxadmin == null)
	{
		response.sendRedirect("/Gouwu/UserLogin1.jsp");
		return;
	}

	if(action !=null && action.equals("exit"))
	{
		session.invalidate();
		response.sendRedirect("/Gouwu/");
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
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
  		<title>艺术创想校园管理中心</title> 
    	<link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css">		
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
	
		<div style="padding:8% 5% 5% 5%;">
			<div class="boxs10 borr10 padpc5 widpc90">	
				<div class="backgb" style="height:50px;width:50px;padding-left:5px;padding-top:5px;">
					<img src="/Gouwu/images/background/info.png" />
				</div>
				
				<div class="pad20 overfh" style="margin-left:100px; ">	
					<div>
						<div class="colb fonts20 fontw700 textl" style="margin-left:13px;">
							课程信息修改
						</div>						
					</div>	
					
					<form action="/Gouwu/servlet/FileUpload" method="post" name="form2" class="flol" 
						  style="margin-right:60px;margin-top:30px; " encTYPE="multipart/form-data">
						<input type="hidden" name="id" value="<%= id %>" />										
						<img  style="width:120px;height:120px;margin-top:3%;margin-left:13px;"
							  src="/Gouwu/images/product/<%= id+".jpg" %>" 
							  onerror="javascript:this.src='/Gouwu/images/product/yscx.png'" />
						<input type="file" name="img" style="width:160px;border-bottom:none;display:block;margin:10px 0px 10px 13px "/>	
						<a href="javascript:window.form2.submit()" class="backgw padlr30 colgys boxs5 textc borr5" 
						   style="padding-bottom:2px;padding-top:2px;display:block;width:55px;margin-top:0px;margin-left:13px;" >
							上传
						</a>
					</form>
								
					<form method="post" action="ProductModify1.jsp" name="form1" class="flol" >
					<input type=hidden name="action" value="pruductmodify" />
					<input type=hidden name="id" value="<%= id %>"/>
					<table style="margin-top:20px;padding-left:10px;padding-right:10px;margin-bottom:3%;">						
						<tr style="">
							<td class="colb fonts16 textl" style="margin-left:13px;">
								课程名称：
							</td>
							<td class="textl" style="width:250px;">
								<input type="text" name=product style="width:150px;" value="<%= p.getName() %>" />
							</td>			
						</tr>
						<tr style="">
							<td class="colb fonts16 textl" style="margin-left:13px;">
								所属类别：
							</td>
							<td class="textl">
								<select name="categoryId" style="width:155px;">
								<option value="-1" selected="selected" >--------------------------</option>
								<%
									List<Category> categories=CategoryService.getInstance().getCategoriesGradeTwo();
									Iterator<Category> it=categories.iterator();
									while(it.hasNext())
									{
										Category c=it.next();
										String selected="";
										if(c.getId()==p.getCategoryId()) selected="selected";
										//selected="selected",设置默认选项
								%>
									<option value="<%= c.getId() %>" <%= selected %>>
										<%= c.getName() %>
									</option>
								<%
									}						
								%>					
								</select>
							</td>			
						</tr>
						<tr style="">
							<td class="colb fonts16 textl" style="margin-left:13px;" >
								市场价格：
							</td>
							<td class="textl" style="width:250px;">
								<input type="text" name=normalPrice style="width:150px;" 
										value="<%= p.getNormalPrice() %>"/>
							</td>			
						</tr>
						<tr style="">
							<td class="colb fonts16 textl" style="margin-left:13px;" >
								会员价格：
							</td>
							<td class="textl" style="width:250px;">
								<input type="text" name=memberPrice style="width:150px;" 
										value="<%= p.getMemberPrice() %>"/>
							</td>			
						</tr>
						<tr>
							<td class="colb fonts16 textl" style="margin-left:13px;">
								课程描述：
							</td>							
							<td class="wid100 textl">
								<textarea cols=30px rows=5 name="describe"><%= p.getDescribe() %></textarea>								
							</td>							
						</tr>					
					</table>	
					
				</div>			
			</div>
			<a href="javascript:window.form1.submit()" class="flor marpc1 backgb padlr30 boxs5 textc borr5" 
			   style="margin-right:30px;padding-bottom:5px;padding-top:5px;color:#fff;">
				保存
			</a>
			</form>
			<a href="javascript:window.history.go(-1)" class="flor marpc1 backgw padlr30 colgy boxs5 textc borr5" 
			   style="margin-right:10px;padding-bottom:5px;padding-top:5px;" >
				返回
			</a>
		</div>
	
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