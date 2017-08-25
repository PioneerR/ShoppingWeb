<%@page import="product.Product"%>
<%@ page import="order.SalesOrder"%>
<%@ page import="order.OrderMgr"%>
<%@ page import="order.SalesItem"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf8");
	int orderId=Integer.parseInt(request.getParameter("id"));
	SalesOrder so=OrderMgr.getInstance().loadById(orderId);
	List<SalesItem> items=OrderMgr.getInstance().getSalesItems(so);
	
	String [] payset={"其他","微信支付","支付宝支付"};
	String [] arr={"待付款","请求取消课程","待排课","已排课","课程已取消"};
	double sum=0.0;
	for(int i=0;i<items.size();i++)
	{
		SalesItem si=items.get(i);
		Product p=si.getProduct();
		sum=sum+p.getNormalPrice()*si.getCount();
	}
	
	//从登录页面返回时能够强制刷新
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
	    <style type="text/css">
			hr{		
				border:none;
				border-top:1px dashed #03a9f4;
			}
		</style> 
		<script type="text/javascript">
			function showProductInfo(descr) 
			{
				document.getElementById("productInfo").innerHTML=
					                "<font size=3 color=red>" + descr + "</font>";
			}
		</script>
	</head>
	<body>
		<div style="padding:1% 1% 1% 1%;">
			<div class="boxs10 borr10">	
				<div class="backgb" style="height:50px;width:50px;padding-left:5px;padding-top:5px;">
					<img src="/Gouwu/images/background/info.png" />
				</div>
				
				<div class="pad20">	
					<table style="margin-top:1%;padding-left:10px;padding-right:10px;margin-bottom:1%;">
						<tr>
							<td class="colb fonts20 fontw700 textl" colspan=5 style="margin-left:13px;">
								收货地址
							</td>
						</tr>
						<tr>
							<td class="textc" style="width:150px;"><%= so.getUser().getUsername() %></td>
							<td class="wid200 textl"><%= so.getUser().getAddress() %></td>
							<td class="wid100 textl"><%= so.getUser().getPhone() %></td>
						</tr>
					</table>
					
					<div class="padtbpc2" style="margin-bottom:2%;">
						<div class="colb fonts20 fontw700 textl" style="margin-bottom:5px;margin-left:13px;">					
							报名状态						
						</div>
						<div class="flol" style="margin-left:13px;">
							当前状态：<%= arr[so.getStatus()] %>
						</div>
						<div class="flol" style="margin-left:200px;">
							实付金额：<b class="colr">¥ <%= sum %></b>
						</div>
						<div class="flol" style="margin-left:200px;">
							支付方式：<%= payset[so.getPaySet()] %>
						</div>
					</div>
					
					<table class="widpc100" style="padding-left:10px;padding-right:10px; ">
						<tr>
							<td class="colb fonts20 fontw700 textl" colspan=5 style="margin-left:13px;">
								订单列表
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
							for(int i=0;i<items.size();i++)
							{
								SalesItem si=items.get(i);
								Product p=si.getProduct();
						%>
						<tr>					
							<td style="width:100px;">						
								<img src="/Gouwu/images/product/<%= p.getId()+".jpg" %>" 
									 class="borr10" style="height:60px;width:60px;" 
									 onerror="javascript:this.src='/Gouwu/images/product/yscx.png'"/>						
							</td>
							<td class="fonts20 wid200" >
								<%= p.getName() %>
							</td>
							<td class="colgys fonts20" style="width:150px;" id="normalprice<%= i %>">
								¥ <%= p.getNormalPrice() %>
							</td>
							<td class="wid100 fonts20">
								<%= si.getCount() %>
							</td>
							<td class="colgys fonts20" style="width:150px;" id="itemtotal<%=i %>" name="itemtotal">
							¥ <%= p.getNormalPrice()*si.getCount() %></td>					
						</tr>	
						<tr><td colspan="5"><hr></td></tr>					
						<%
							}
						%>
					</table>				
				</div>			
			</div>
			<a href="javascript:window.history.go(-1);" class="flor marpc1 backgb padlr30 boxs5 textc borr5" 
			   style="margin-right:30px;padding-bottom:5px;padding-top:5px;color:#fff;" >
				返回
			</a>
		</div>
	
	</body>
</html>