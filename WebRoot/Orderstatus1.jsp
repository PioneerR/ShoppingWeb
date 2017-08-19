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
				else if(action!=null && action.equals("delete"))
				{
					OrderMgr.getInstance().delete(so);
				}	
				OrderMgr.getInstance().update(so);
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
		<script type="text/javascript">
			function sub()
			{
				document.form3.submit();
			}
		</script>
	</head>
	<body>
		<div class="padpc5">	
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
							<span class="borr5 fonts16 marlrpc5 colgys pad2">
								<%= status[so.getStatus()] %>
							</span>
						</td>
						<td class="wid200">	
						<%
							if(so.getStatus()==0)
							{
						%>	
							<form action="payset.jsp" method="post" name="form1">
								<input type="hidden" name="action" value="change"/>
								<input type="hidden" name="orderId" value="<%= so.getId() %>"/>	
								<input type="hidden" name="payset" value="<%= so.getPaySet() %>"/>				
								<input type="submit" class="borr5 fonts16 marlrpc5 backgr boxs5 pad2" 
								       style="color:#fff;border:none;" value="完成支付" />								
							</form>
						<%
								
							}
							if(so.getStatus() == 0 || so.getStatus() == 2)
							{
						%>	
							<form action="Orderstatus1.jsp" method="post" name="form2">
								<input type="hidden" name="action" value="cancel"/>
								<input type="hidden" name="orderId" value="<%= so.getId() %>"/>
								<input type="submit" class="borr5 fonts16 marlrpc5 backgw boxs5 pad2 colgy curp"
								 	   value="取消订单" style="border:none;margin-top:5px;"/>
							</form>
						<%
							}
							if(so.getStatus() == 4)
							{
						%>	
							<form action="Orderstatus1.jsp" method="post" name="form3">
								<input type="hidden" name="action" value="delete"/>
								<input type="hidden" name="orderId" value="<%= so.getId() %>"/>
								<input type="submit" value="删除订单" style="border:none;"
								       class="borr5 fonts16 backgw boxs5 pad2 colgy" />  
							</form>
						<%
							}						
						%>					
						</td>
						<td style="width:100px;">
						<%
							if(so.getStatus()!=4)
							{
						%>
							<a class="borr5 fonts16 marlrpc5 backgb boxs5 pad2"  style="color:#fff;"
								href="OrderDetail1.jsp?orderId=<%= so.getId() %>" >
								订单详情
							</a>
						<%
							}
						    else if(so.getStatus()==4)
						    {
						%>	
							<a class="borr5 fonts16 marlrpc5 backggy boxs5 pad2"  style="color:#fff;"
								href="OrderDetail1.jsp?orderId=<%= so.getId() %>" >
								订单详情
							</a>
						</td>
					</tr>
					<%			
							}
					%>			
					<tr><td colspan="6"><hr></td></tr>
			<%			
						}
					}
				}
			%>
				</table>
			</div>
		</div>	
		
		<div class="widpc100 backgbs" style="height:100px;padding-top:30px;background-color:#eafbf6;margin-top:50px; ">
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
			<div class="flol widpc100 heia martbpc1 fonts14" style="margin-left:38%;">
				Copyright © 2017 艺术创想  Designed by 
				<a href="https://github.com/PioneerR" target="_blank" style="color:#03a9f4;">PioneerR</a>
			</div>
	    </div>
	</body>
</html>