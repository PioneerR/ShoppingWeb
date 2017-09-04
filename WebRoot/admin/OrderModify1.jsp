<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="user.User"%>
<%@ page import="order.SalesOrder"%>
<%@ page import="order.OrderMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	request.setCharacterEncoding("utf8");
	int orderid=Integer.parseInt(request.getParameter("id"));
	SalesOrder so=OrderMgr.getInstance().loadById(orderid);
	
	int status=so.getStatus();
	User u=so.getUser();
	
	String action=request.getParameter("action");
	if(action !=null && action.trim().equals("modify"))
	{
		status=Integer.parseInt(request.getParameter("status"));
		so.setStatus(status);
		OrderMgr.getInstance().update(so);
		
		out.println("<div style='padding:10% 5% 5% 5%;box-shadow:0 0 10px #B5B4B4;border-radius:10px;width:80%;height:200px;margin-left:5%;margin-top:5%;'");
		out.println("<div style=''>");
		out.println("<h2 style='color:#03a9f4;text-align:center;padding:6%;'>"+"报名信息修改成功！~"+"</h2>");
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
			<div class="boxs10 borr10 widpc90 padpc5">	
				<div class="backgb" style="height:50px;width:50px;padding-left:5px;padding-top:5px;">
					<img src="/Gouwu/images/background/info.png" />
				</div>
				
				<div class="pad20 overfh" style="margin-left:100px; ">	
					<div>
						<div class="colb fonts20 fontw700 textl" style="margin-left:13px;">
							报名信息修改
						</div>						
					</div>	
					
					<div  class="flol" style="margin-right:60px;margin-top:30px; ">
						<img  style="width:120px;height:120px;margin-top:3%;margin-left:13px;"
							  src="/Gouwu/images/user/<%= u.getId()+".jpg" %>" 
							  onerror="javascript:this.src='/Gouwu/images/user/moren.jpg'" />						
					</div>
								
					<form method="post" action="OrderModify1.jsp" name="form1" class="flol" >
					<input type="hidden" name="action" value="modify"/>
					<input type="hidden" name="id" value="<%= orderid %>"/>
					<table style="margin-top:20px;padding-left:10px;padding-right:10px;margin-bottom:3%;">						
						<tr style="">
							<td class="colb fonts16 textl" style="margin-left:13px;">
								用户名：
							</td>
							<td class="textl" style="width:250px;">
								<%= u.getUsername() %>
							</td>			
						</tr>
						<tr style="">
							<td class="colb fonts16 textl" style="margin-left:13px;">
								手机号码：
							</td>
							<td class="textl">
								<%= u.getPhone() %>
							</td>			
						</tr>
						<tr style="">
							<td class="colb fonts16 textl" style="margin-left:13px;" >
								发货地址：
							</td>
							<td class="textl" style="width:250px;">
								<%= u.getAddress() %>
							</td>			
						</tr>
						<tr>
							<td class="colb fonts16 textl" style="margin-left:13px;">
								报名时间：
							</td>							
							<td class="wid100 textl">
								<%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(so.getODate()) %>								
							</td>							
						</tr>
						<tr style="">
							<td class="colb fonts16 textl" style="margin-left:13px;" >
								OrderID：
							</td>
							<td class="textl" style="width:250px;">
								<%= so.getId() %>
							</td>			
						</tr>
						<tr>
							<td class="colb fonts16 textl" style="margin-left:13px;">
								订单状态：
							</td>							
							<td class="wid100 textl">
								<select name="status" style="float:inherit;">
									<option value="0" <%= (status==0)?"selected":"" %>>待付款</option>
									<option value="1" <%= (status==1)?"selected":"" %>>请求取消课程</option>
									<option value="2" <%= (status==2)?"selected":"" %>>待排课</option>
									<option value="3" <%= (status==3)?"selected":"" %>>已排课</option>
									<option value="4" <%= (status==4)?"selected":"" %>>课程已取消</option>
								</select>								
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