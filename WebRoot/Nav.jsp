<%@	page import="product.Product"%>
<%@	page import="category.CategoryService"%>
<%@	page import="category.Category"%>
<%@	page import="user.User"%>
<%@	page import="java.util.List"%>
<%@	page import="product.ProductMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf8");
	List<Category> categories=CategoryService.getInstance().getCategoriesGradeTwo();
	User uu=(User)session.getAttribute("user");

	String actions=request.getParameter("action");
	if(actions !=null && actions.equals("exit"))
	{
		session.invalidate();
		System.out.println("1111");
		response.sendRedirect("/Gouwu/");
		System.out.println("aaaa");
	}
	
	//从登录页面返回时能够强制刷新
	response.setHeader("Pragma","No-cache"); 		
	response.setHeader("Cache-Control","no-cache"); 
	response.setHeader("Cache-Control", "No-store");
	response.setDateHeader("Expires", 0);
%>


	<div class="widpc100 backgb" style="position:fixed;top:0;height:70px;
		 box-shadow:5px 5px 8px #B5B4B4,-5px 5px 8px #B5B4B4;" id="nav">
		<nav style="" class="overfh">
			<div class="flol" style="margin-right:20px;margin-left:7%;">
				<a href="Index1.jsp" style="color:white;" class="fontw700">				
					<img src="/Gouwu/images/icon/yscx.png" class="wida" style="height:50px;">艺术创想
				</a>
			</div>
			
			<div class="itemshow flol wid100 textc" style="margin-top:17px; ">
				<a href="ShowProducts1.jsp" class="" style="color:#fff;">课程</a>
				<div class="itemhide" style="margin-left:18%;width:150px;padding-bottom:5px;">
				<%
					Category cg=categories.get(0);				
				%>		
					<a href="ShowProducts1.jsp?categoryId=<%= cg.getId() %>">
						<div class="item backgw borrt5 textc fonts16 colgy" style="line-height:37px;">
							<%= cg.getName() %>
						</div>
					</a>						
				<%						
					for(int i=1;i<categories.size()-1;i++)
					{							
						cg=categories.get(i);							
				%>	
					<a href="ShowProducts1.jsp?categoryId=<%= cg.getId() %>">
						<div class="item backgw textc fonts16 colgy" style="line-height:37px;">
							<%= cg.getName() %>
						</div>
					</a>
				<%
					}
						cg=categories.get(categories.size()-1);							
				%>
					<a href="ShowProducts1.jsp?categoryId=<%= cg.getId() %>" >
						<div class="item backgw borrb5 textc fonts16 colgy" style="line-height:37px;">
							<%= cg.getName() %>
						</div>
					</a>	
				</div>
			</div>
			
			<div class="itemshow flol wid100 textc" style="margin-top:17px;margin-left:45%; ">
				<a href="Buy1.jsp" class="" style="color:#fff;">
					<img src="/Gouwu/images/background/cart2.png" class="wida" style="height:22px;">
				</a>
				<div class="itemhide" style="width:150px;padding-bottom:5px; ">
					<a href="Buy1.jsp">
						<div class="item backgw textc fonts16 colgy borr5" style="line-height:37px;margin-right:15%;">
							查看购物车
						</div>
					</a>
				</div>
			</div>
			
	<%
		if(uu==null)
		{
	%>	
			<div class="flol marlr15" style="margin-top:25px;" >
				<a href="Register1.jsp" style="color:white;">
					<img src="/Gouwu/images/icon/signup.png" class="wida" style="height:20px;margin-right:5px;">注册
				</a>
			</div>
			<div class="flol marlr15" style="margin-top:25px;" >
				<a href="UserLogin1.jsp" style="color:white;">
					<img src="/Gouwu/images/icon/signin.png" class="wida" style="height:20px;">登录
				</a>
			</div>
	<%
		}
		else
		{
	%>
			<div class="itemshow flol marlr15"  >
				<a href="" style="color:white;">
					<img src="/Gouwu/images/user/<%= uu.getId()+".jpg" %>" class="wida" 
						 style="height:30px;width:30px;margin-right:5px;margin-top:25px;margin-bottom:-8px; "
						 onerror="javascript:this.src='/Gouwu/images/icon/user.png'">
					<%= uu.getUsername() %>
				</a>
				<div class="itemhide" style="width:150px;padding-bottom:5px;">
					<a href="Orderstatus1.jsp">
						<div class="item borrt5 textc backgw colgy fonts16" style="line-height:37px;margin-right:10%;">
							我的订单
						</div>
					</a>
					<a href="Userinfo1.jsp">
						<div class="item textc backgw colgy fonts16" style="line-height:37px;margin-right:10%;">
							个人信息
						</div>
					</a>
					<a href="Index1.jsp?action=exit">
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