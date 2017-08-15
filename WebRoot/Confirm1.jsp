<%@page import="java.util.Iterator"%>
<%@ page import="client.Cart"%>
<%@ page import="client.CartItem"%>
<%@ page import="java.util.List"%>
<%@ page import="user.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	User u=(User)session.getAttribute("user");
	if(u == null)
	{
		response.sendRedirect("UserLogin1.jsp");
		return;
	}
	
	Cart c=(Cart)session.getAttribute("cart");
	if(c == null)
	{
		c=new Cart();
		session.setAttribute("cart", c);
	}
	
	String [] ids=request.getParameterValues("check");
	//System.out.println(ids[0]);
	
	//List<CartItem> items=c.getItems();
	//Iterator<CartItem> it=items.iterator();
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>确认订单</title>
		<style type="text/css">
			.button-1{
			 border-radius:20px;
			 width: 100px;
			 text-align: center;
			 padding:5px;
			 margin: 20px;
			 cursor: pointer;
			}
			hr{		
			 border:none;
			 border-top:1px dashed #03a9f4;
			}
			input{
			  color:#000;
			  font-size: 18px;
			  border:none;
			  width: 25%;
			  margin:auto;
			  background-color:white; 
			}
			.button-1{
			 border-radius:20px;
			 width: 100px;
			 text-align: center;
			 padding:5px;
			 margin: 20px;
			 cursor: pointer;
			}
			tr{
			height:30px; 
			}
			td{
			border:solid 1px #ff0;
			}
		</style>
		<link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css" />
	</head>
	<body class="padpc5">		
		<form action="Order1.jsp" name="form1" method="post">
		<input type="hidden" name="action" value="confirm"/>
		<div class="boxs10 borr10">
			<div>
				<div class="backgb" style="height:50px;width:50px;padding-left:5px;padding-top:5px;">
					<img src="/Gouwu/images/background/info.png" />
				</div>
			</div>
			<div class="pad20">	
				<table class="padtbpc2">
					<tr>
						<td colspan=3 class="colb fonts20 fontw700 textl">
							<img src="/Gouwu/images/background/site.png" />寄送至
						</td>
					</tr>
					<tr>
						<td style="width:120px;"><%= u.getUsername() %></td>
						<td class="wid400"><%= u.getAddress() %></td>
						<td class="wid200"><%= u.getPhone() %></td>
					</tr>
				</table>
				
				<table class="padtbpc2">
					<tr>
						<td class="colb fonts20 fontw700 textl">
							<img src="/Gouwu/images/background/pay.png" />&nbsp;&nbsp;付款方式
						</td>
					</tr>
					<tr>
						<td class="wid100 boxs10">
							<select>	
								<option>微信支付</option>
								<option>支付宝</option>
							</select>
						</td>
					</tr>
				</table>
				
				<table class="widpc100 padtbpc2">
					<tr>
						<td class="colb fonts20 fontw700 textl" colspan=4>
							&nbsp;<img src="/Gouwu/images/background/order.png" style="margin-right:20px;"/>订单确认
						</td>
					</tr>
					<tr>
						<td></td>
						<td>课程名称</td>
						<td>课程单价</td>
						<td>购买数量</td>
						<td>总价</td>
					</tr>
					<tr><td colspan="5"><hr></td></tr>
					<%
						for(int i=0;i<ids.length;i++)
						{
							int id=Integer.parseInt(ids[i]);
							CartItem ci=c.getItemByPid(id);	
					%>
					<tr>					
						<td style="width:100px;">						
							<img src="images/product/<%= ci.getProduct().getId()+".jpg" %>" 
								 class="borr10" style="height:100px;width:100px;" />						
						</td>
						<td class="fonts22 wid200" >
							<%= ci.getProduct().getName() %>
						</td>
						<td class="colgys fonts20" style="width:150px;" id="normalprice<%= i %>">
							¥ <%= ci.getProduct().getNormalPrice() %>
						</td>
						<td class="wid100 fonts20">
							<%= ci.getCount() %>
						</td>
						<td class="colgys fonts20" style="width:150px;" id="itemtotal<%=i %>" name="itemtotal">
						¥ <%= ci.getProduct().getNormalPrice()*ci.getCount() %></td>					
					</tr>
					<tr><td colspan="5"><hr></td></tr>							
					<%
						}
					%>
					<tr>
						<td colspan="3"></td>				
						<td class="colb fonts20" style="font-weight:550">实付款</td>
						<td class="colb fonts22 fontw700" id="total">¥ 0.0</td>
					</tr>
				</table>				
			</div>	
			<a href="javascript:document.form1.submit()" style="pointer-events:none;" 
			   class="button-1 flor colw marlrpc5 backgb"  >
				提交订单
			</a>
		</div>
		</form>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		<form action="Order1.jsp" method="post">
		<input type="hidden" name="action" value="confirm"/>
		<table style="border:3px solid #fff1cc;border-collapse:collapse;width:50% ">
			<tr style="background-color:#fff1cc;">
				<th>产品Id</th>
				<th>产品名称</th>
				<th>购买数量</th>
				<th>单价</th>
				<th>总价</th>
			</tr>
			<%
				//while(it.hasNext())
				//{
					//CartItem ci=it.next();
				for(int i=0;i<ids.length;i++)
				{
					int id=Integer.parseInt(ids[i]);
					CartItem ci=c.getItemByPid(id);	
			%>
			<tr>
				<td><%= ci.getProduct().getId() %></td>
				<td><%= ci.getProduct().getName() %></td>
				<td><%= ci.getCount() %></td>
				<td><%= ci.getProduct().getNormalPrice() %></td>
				<td><%= ci.getProduct().getNormalPrice()*ci.getCount() %></td>
			</tr>
			<%
				}
			%>
			<tr>
				<td colspan="6" style="text-align:right; ">
					收货地址：<%= u.getAddress() %><br>
					联系方式：<%= u.getPhone() %><br>
					<input type="submit" name="confirm" value="提交订单" />
				</td>
			</tr>
		</table>
		</form>
	</body>
</html>