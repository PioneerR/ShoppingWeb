<%@ page import="product.Product"%>
<%@ page import="order.SalesItem"%>
<%@ page import="order.SalesOrder"%>
<%@ page import="java.util.List"%>
<%@ page import="order.OrderMgr"%>
<%@ page import="user.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf8");
	User u=(User)session.getAttribute("user");
	if(u == null)
	{
		response.sendRedirect("UserLogin1.jsp");
		return;
	}

	List<SalesOrder> orders=OrderMgr.getInstance().getOrders();
	int uid=u.getId();
	
	String [] status={"待付款","等待审核","待发货","已发货","订单已取消"};
	
	
	String action=request.getParameter("action");
	String orderIdStr=request.getParameter("orderId");
	if(orderIdStr != null)
	{
		
		int orderId=Integer.parseInt(orderIdStr);
		for(int i=0;i<orders.size();i++)
		{
			SalesOrder so=orders.get(i);
			if(so.getId()==orderId)
			{
			
				if(action!=null && action.equals("change"))
				{
					so.setStatus(2);					
				}
				else if(action!=null && action.equals("cancel"))
				{
					so.setStatus(1);					
				}
				OrderMgr.getInstance().updateStatus(so);
			}
		}
	}
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
		<title>艺术创想</title>
		<link type="text/css" rel="stylesheet" href="/Gouwu/css/base.css" />
		<style type="text/css">
			hr{		
			 border:none;
			 border-top:1px dashed #03a9f4;
			}		
		</style>
	</head>
	<body class="padpc5">
		
		<div class="backgb flol" style="height:50px;width:50px;padding-left:5px;padding-top:5px;">
			<img src="/Gouwu/images/background/info.png" />
		</div>
		<div class="boxs10 borr10 pad10">
			<table class="widpc100">
				<tr>
					<td class="colb fonts20 fontw700">我的订单</td>
					<td>课程名称</td>
					<td>总价</td>
					<td>订单状态</td>
					<td>修改</td>
					<td>详情</td>
				</tr>
				<tr><td colspan="6"><hr></td></tr>
		<%
			for(int i=0;i<orders.size();i++)
			{
				SalesOrder so=orders.get(i);
				if(so.getUser().getId()==uid)
				{
					List<SalesItem> items=OrderMgr.getInstance().getSalesItems(so);
					for(int j=0;j<items.size();j++)
					{
						SalesItem si=items.get(j);
						Product p=si.getProduct();
		%>
				<tr>
					<td style="width:130px;">
						<a href="ShowProductDetail1.jsp?id=<%= p.getId() %>">
						 	<img src="images/product/<%= p.getId()+".jpg" %>" class="borr10 boxs5" style="height:120px;width:120px;" />
						</a>
					</td>
					<td style="width:150px;">
						<a class="fonts24 fontw700" style="color:#03a9f4;" href="ShowProductDetail1.jsp?id=<%= p.getId() %>">
						<%= p.getName() %></a>
					</td>
					<td class="colgys fonts20" style="width:120px;">
						¥ <%= p.getNormalPrice()*si.getCount() %>
					</td>
					<td class="wid100">
						<span class="borr5 fonts18 marlrpc5 backgb boxs5 padtb5" style="color:#fff;">
							<%= status[so.getStatus()] %>
						</span>
					</td>
					<td class="wid200">	
					<%
						if(so.getStatus()==0)
						{
					%>	
						<form action="Orderstatus1.jsp" method="post" name="form1">
							<input type="hidden" name="action" value="change"/>
							<input type="hidden" name="orderId" value="<%= so.getId() %>"/>				
							<input type="submit" class="borr5 fonts18 marlrpc5 backgr boxs5 padtb5" 
							       style="color:#fff;" value="完成支付" />								
						</form>
					<%
						}
						if(so.getStatus() == 0 || so.getStatus() == 2)
						{
					%>	
						<form action="Orderstatus1.jsp" method="post" name="form2">
							<input type="hidden" name="action" value="cancel"/>
							<input type="hidden" name="orderId" value="<%= so.getId() %>"/>
							<input type="submit" class="borr5 fonts18 marlrpc5 backgw boxs5 padtb5 colgy curp"
							 	   value="取消订单" />
						</form>
					<%
						}
					%>						
					</td>
					<td style="width:100px;">
						<a class="borr5 fonts18 marlrpc5 backgb boxs5 padtb5"  style="color:#fff;"
							href="OrderDetail1.jsp?orderId=<%= so.getId() %>" >
							订单详情
						</a>
					</td>
				</tr>
				<tr><td colspan="6"><hr></td></tr>	
		<%			
					}
				}
			}
		%>
			</table>
		</div>
	</body>
</html>