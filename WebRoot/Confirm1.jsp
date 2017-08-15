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
	session.setAttribute("checks", ids);
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
			  color:#B5B4B4;
			  font-size: 16px;
			  border:none;
			  width: 100%;
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
		</style>
		<script type="text/javascript">
		function sure(num)
		{
			var b1=document.getElementById("b1");
			var b2=document.getElementById("b2");
			if(num==1)
			{
				b1.style.backgroundColor="#03a9f4";
				b1.style.color="#fff";
				
				b2.style.backgroundColor="#fff";
				b2.style.color="#B5B4B4";
				b2.style.boxShadow="0 0 2px #B5B4B4";
			}
			else if(num==2)
			{
				b1.style.backgroundColor="#fff";
				b1.style.color="#B5B4B4";
				b1.style.boxShadow="0 0 2px #B5B4B4";
				
				b2.style.backgroundColor="#03a9f4";
				b2.style.color="#fff";
			}
		}		
		</script>
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
				<table style="padding-bottom:2%;">
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
				
				<div class="padtbpc2" style="margin-bottom:8%;">
					<div class="colb fonts20 fontw700 textl" style="margin-bottom:20px;">					
						<img src="/Gouwu/images/background/pay.png" />&nbsp;&nbsp;付款方式						
					</div>
					<input type="button" name="1" class="boxs10 wid100 flol borr5 textc padtb10" style="margin-right:10px;" id="b1" value="微信支付" onclick="sure(1)" />
					<input type="button" name="2" class="boxs10 wid100 flol borr5 textc padtb10" id="b2" value="支付宝" onclick="sure(2)" />					
				</div>
				
				<table class="widpc100" style="margin-top:2%;">
					<tr>
						<td class="colb fonts20 fontw700 textl" colspan=4>
							<img src="/Gouwu/images/background/order.png" style="margin-right:15px;"/>订单确认
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
						double sum=0.0;
						//cc是存放选择了商品的购物车，把这个购物车当做订单来提交
						Cart cc=new Cart();
						for(int i=0;i<ids.length;i++)
						{
							int id=Integer.parseInt(ids[i]);
							CartItem ci=c.getItemByPid(id);
							//订单总价
							sum=sum+ci.getProduct().getNormalPrice()*ci.getCount();						
							cc.add(ci);													
					%>
					<tr>					
						<td style="width:100px;">						
							<img src="images/product/<%= ci.getProduct().getId()+".jpg" %>" 
								 class="borr10" style="height:100px;width:100px;" />						
						</td>
						<td class="fonts20 wid200" >
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
						session.setAttribute("cartorder", cc);
					%>
					<tr>
						<td colspan="3"></td>				
						<td class="colb fonts20" style="font-weight:700">实付款</td>
						<td class="colb fonts22 fontw700" id="total">¥ <%= sum %></td>
					</tr>
				</table>				
			</div>	
			<a href="javascript:document.form1.submit()" class="button-1 flor colw marpc1 backgb"  >
				提交订单
			</a>
		</div>
		</form>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
	</body>
</html>