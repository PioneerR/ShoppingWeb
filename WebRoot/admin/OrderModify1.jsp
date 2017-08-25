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
		<div style="padding:5% 5% 5% 5%;">
			<div class="boxs10 borr10">	
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
	
	</body>
</html>