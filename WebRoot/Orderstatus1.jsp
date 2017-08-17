<%@ page import="product.Product"%>
<%@ page import="order.SalesItem"%>
<%@ page import="order.SalesOrder"%>
<%@ page import="java.util.List"%>
<%@ page import="order.OrderMgr"%>
<%@ page import="user.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String orderIdStr=request.getParameter("orderid");
	if(orderIdStr!=null)
	{
		int orderId=Integer.parseInt(orderIdStr);
	}
	
	User u=(User)session.getAttribute("user");
	if(u == null)
	{
		response.sendRedirect("UserLogin1.jsp");
		return;
	}

	List<SalesOrder> orders=OrderMgr.getInstance().getOrders();
	int uid=u.getId();
	
	String [] status={"待发货","已发货","订单已取消"};
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
			var request;
			function changeToInputNP(id)
			{
				var productid=document.getElementById(id);
				var value=productid.value;
				productid.outerHTML="<input type='text' style='color:#03a9f4' id='"+id+"' value='"+value+"' size='5' onblur='changeNP(this.id)' />";
				document.getElementById(id).focus();			
			}
			function changeToInputMP(name)
			{
				var productids=document.getElementsByName(name);
				var productid=productids[0];
				var value=productid.value;
				productid.outerHTML="<input type='text' style='color:#03a9f4' name='"+name+"' value='"+value+"' size='5' onblur='changeMP(this.name)' />";
				document.getElementsByName(name)[0].focus();			
			}	
			
			function changeNP(id)
			{
				var productid=document.getElementById(id);
				var value=productid.value;//获得已经修改过后的价格
				var url="ChangePrice1.jsp?id="+escape(id)+"&normalprice="+value;
				
				init();
				request.open("post", url, true);
				request.onreadystatechange=function()
				{
					if(request.readyState==4 && request.status==200)
					{
						productid.outerHTML="<input type='text' id='"+ id +"' value="+value+" onclick='changeToInputNP(this.id)'></input>";
					}
				}
				request.send(null);
				alert("修改价格成功！");
			}
			function changeMP(name)
			{
				var productids=document.getElementsByName(name);
				var productid=productids[0];
				var value=productid.value;
				var url="ChangePrice1.jsp?id="+escape(name)+"&memberprice="+value;
				
				init();
				request.open("post", url, true);
				request.onreadystatechange=function()
				{
					if(request.readyState==4 && request.status==200)
					{
						productid.outerHTML="<input type='text' name='"+ name +"' value="+value+" onclick='changeToInputMP(this.name)'></input>";
					}
				}
				request.send(null);
				alert("修改会员价格成功！");
			}
			function init()
			{
				if(window.XMLHttpRequest)
				{
					request=new XMLHttpRequest();
				}
				else if(window.ActiveXObject)
				{
					request=new ActiveXObject("Microsoft.XMLHTTP");
				}
			}
		</script>		
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
						<a class="borr5 fonts18 marlrpc5 backgb boxs5 padtb5" href=""
						   style="color:#fff;" onclick="">
							完成支付  取消订单
						</a>							
					</td>
					<td style="width:100px;">
						<a class="borr5 fonts18 marlrpc5 backgb boxs5 padtb5" href="OrderDetail.jsp" style="color:#fff;" >
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