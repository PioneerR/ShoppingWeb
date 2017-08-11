<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="client.CartItem"%>
<%@ page import="client.Cart"%>
<%@ page import="product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf8");
	Cart c = (Cart)session.getAttribute("cart");//getAttribute获得的是object类
	if(c==null)
	{
		c=new Cart();
		session.setAttribute("cart", c);
	}

	String action=request.getParameter("action");
	if(action !=null && action.trim().equals("add"))
	{
		int id=Integer.parseInt(request.getParameter("id"));
		int count=Integer.parseInt(request.getParameter("count"));
		session.setAttribute("count", count);//为了产品详情页提交表单后数量不变
		Product p=ProductMgr.getInstance().getProduct(id);
		CartItem ci=new CartItem();
		ci.setProduct(p);
		if(count>=0)
		{
			ci.setCount(count);
		}
		else
		{
			ci.setCount(0);
		}
		c.add(ci);
	}
	if(action != null && action.trim().equals("delete"))
	{
		int id=Integer.parseInt(request.getParameter("id"));
		c.deleteItemById(id);
	}
	if(action !=null && action.trim().equals("update"))
	{
		for(int i=0;i<c.getItems().size();i++)
		{
			CartItem ci=c.getItems().get(i);
			int count=Integer.parseInt(request.getParameter("product"+ci.getProduct().getId()));
			ci.setCount(count);
		}
	}

	
	//String path=request.getContextPath();
	//String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	List<CartItem>items=c.getItems();
	Iterator<CartItem> it=items.iterator();
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>购物车</title>
		<link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css" />
		<style type="text/css">
			td{
				text-align:center;
				border-collapse: collapse;
			}
			hr{		
				border:none;
				border-top:1px dashed #03a9f4;
			}
			.button-1{
			 border-radius:20px;
			 width: 100px;
			 text-align: center;
			 padding:5px;
			 margin: 20px;
			 cursor: pointer;
			}
			input{
			  color:#000;
			  font-size: 18px;
			  border:none;
			  width: 25%;
			  margin:auto;
			  background-color:white; 
			}	
		</style>
		<script type="text/javascript">
			function add()
			{
				var a=document.getElementsByName("count")[0].value;
				//getElementByName获得的是一个数组，如果想指定获取某个元素，必须用角标
				a=parseInt(a);
				a++;
				document.getElementsByName("count")[0].value=a;
			}
			function dele()
			{
				//getElementById()的Element后面没有s
				var a=document.getElementById("count").value;
				a=parseInt(a);
				a--;
				if(a<0) a=0;
				document.getElementById("count").value=a;	
			}
			window.onload=function()
			{
				var checks=document.getElementsByName("check");
				var checkall=document.getElementById("checkall");
				checkall.onclick=function()
				{
					if(checkall.checked==true)
					{
						for(var i=0;i<checks.length;i++)
						{
							checks[i].checked=true;
						}
					}
					else
					{
						for(var i=0;i<checks.length;i++)
						{
							checks[i].checked=false;
						}
					}
				}
			}	

		</script>
	</head>
	<body class="padpc5"> 
		<div class="backgb flol" style="height:50px;width:50px;padding-left:15px;padding-top:15px;">
			<img src="/Gouwu/images/background/cart.png"/>
		</div>
		<div class="pad10 boxs10 borr10">
			<table class="widpc100">
				<tr>
					<td></td>
					<td class="colb fonts20 fontw700">购物车</td>
					<td>产品名称</td>
					<td>产品单价</td>
					<td>购买数量</td>
					<td>订单总价</td>
					<td></td>
				</tr>
				<tr><td colspan="7"><hr></td></tr>
				<%
					while(it.hasNext())
					{
						CartItem ci=it.next();
						Product p=ci.getProduct();
				%>
				<tr>
					<td style="width:50px;">
						<input type="checkbox" value="<%=  %>" name="check"/>
					</td>
					<td style="width:200px;">
						 <img src="images/product/<%= p.getId()+".jpg" %>" class="borr10" style="height:120px;width:120px;"/>
					</td>
					<td class="colb fonts24 fontw700 wid300" >
						<%= ci.getProduct().getName() %>
					</td>
					<td class="colgys fonts20" style="width:150px;">
						¥<%= ci.getProduct().getNormalPrice() %>
					</td>
					<td class="wid200">
						<input type="button" class="backgbs borrl10 colw" value="-" onclick="dele()"/>
						<input type="text" id="count" class="backgbs textc" name="count" value="<%= ci.getCount() %>"/>
						<input type="button" class="backgb borrr10 colw" value="+" onclick="add()"/>   
					</td>
					<td class="colgys fonts20" style="width:150px;" id="itemtotal">
						¥<%= ci.getProduct().getNormalPrice()*ci.getCount() %>
					</td>
					<td class="colgys fonts22">
						<a href="Buy1.jsp?action=delete&id=<%= ci.getProduct().getId() %>">x</a>
					</td>
				</tr>
				<tr><td colspan="7"><hr></td></tr>
				<%
					}
				%>
				<tr>
					<td><input type="checkbox" id="checkall" /></td>
					<td>已选择x门课程  </td>
					<td class="textl padlr20">删除选中的课程</td>
					<td></td>
					<td class="colgys fonts20">Total</td>
					<td class="colb fonts22 fontw700" id="total">¥ 0.0</td>
					<td></td>
				</tr>
			</table>
			<div class="button-1 flor colw marlrpc5 backgb">结算</div>
		</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		<form action="Buy1.jsp" method="post">
		<input type="hidden" name="action" value="update"/>
		<table style="border:3px solid #fff1cc;border-collapse:collapse;width:50% ">
			<tr style="background-color:#fff1cc;">
				<th>产品Id</th>
				<th>产品名称</th>
				<th>购买数量</th>
				<th>单价</th>
				<th>总价</th>
				<th>处理</th>
			</tr>
			<%
				while(it.hasNext())
				{
					CartItem ci=it.next();
			%>
			<tr>
				<td><%= ci.getProduct().getId() %></td>
				<td><%= ci.getProduct().getName() %></td>
				<td>
					<input type="text" size=3 name="<%= "product"+ci.getProduct().getId() %>"
						   value="<%= ci.getCount() %>"/>
				</td>
				<td><%= ci.getProduct().getNormalPrice() %></td>
				<td><%= ci.getProduct().getNormalPrice()*ci.getCount() %></td>
				<td>
					<a href="Buy1.jsp?action=delete&id=<%= ci.getProduct().getId() %>">删除</a>
				</td>
			</tr>
			<%
				}
			%>
			<tr>
				<td colspan="6">
					<a href="Confirm1.jsp" style="margin-right:100px;">确认订单</a>
					<a href="javascript:document.forms[0].submit()" >修改订单</a>
				</td>
			</tr>
		</table>
		</form>
	</body>
</html>