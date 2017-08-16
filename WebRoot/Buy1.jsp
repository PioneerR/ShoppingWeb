<%@ page import="user.User"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="client.CartItem"%>
<%@ page import="client.Cart"%>
<%@ page import="product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf8");
	String idStr=request.getParameter("id");
	User u=(User)session.getAttribute("user");
	if(u == null && idStr == null)
	{
		response.sendRedirect("UserLogin1.jsp");
		return;
	}
	else if(u == null && idStr != null)
	{
		int id=Integer.parseInt(idStr);
		session.setAttribute("id", id);
		response.sendRedirect("UserLogin1.jsp");
		return;
	}
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
		return;
	}
	if(action != null && action.trim().equals("delete"))
	{
		int id=Integer.parseInt(request.getParameter("id"));
		c.deleteItemById(id);
	}
	if(action != null && action.trim().equals("deletex"))
	{
		String [] ids=request.getParameterValues("check");
		if( ids!=null )
		{
			for(int k=0;k<ids.length;k++)
			{
				int id=Integer.parseInt(ids[k]);
				c.deleteItemById(id);
			}
		}
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
	int a=0;
	List<CartItem>items=c.getItems();
	Iterator<CartItem> it=items.iterator();
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>购物车</title>
		<link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css" />
		<script type="text/javascript" src="/Gouwu/jquery/jquery-3.1.1.min.js"></script>
		<style type="text/css">			
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
			function sele(id)//javascript函数名不能用关键字select。
			{				
				var number=document.getElementById("number");
				var checki=document.getElementById(id);					
				
				if(checki.checked==true)
				{
					number.innerText++;	
					check(id);
					click(1);
				}
				else if(checki.checked==false)
				{
					number.innerText--;
					check(id);
					click(0);
				
					if(number.innerText<0)
					{
						number.innerText=0;
					}
				}			
			}			
			
			function check(id)
			{				
				//获得i
				var i=id.substring(5,id.length);				
				//alert(i);
				//获得total处的数值
				var totals=document.getElementById("total");
				var total=document.getElementById("total").innerText;	
				var zero=parseInt(total.substring(1,total.length));
				//alert(zero);
				//获得itemtotal处的数值				
				var itemtotal=document.getElementById("itemtotal"+i).innerText;
				var itemtotalprice=parseInt(itemtotal.substring(1,itemtotal.length));
				//alert(itemtotalprice);
				
				var checki=document.getElementById(id);									
				if(checki.checked==true)
				{
					zero=zero+itemtotalprice;						
					totals.innerText="¥ "+parseFloat(zero).toFixed(1);
				}
				else if(checki.checked==false)
				{				
					zero=zero-itemtotalprice;					
					totals.innerText="¥ "+parseFloat(zero).toFixed(1);
				}							
			}
		</script>
		<script type="text/javascript">		
			var request;
			function addCartItem(id)
			{
				var s=document.getElementById(id).id;
				var ss=s.split("+");//获得：id值+"+"+i  整个字符串
				var pid=ss[0];//获得id值
				var i=ss[1];//获得i的值
				
				var productid=document.getElementById(pid);						
				var count=document.getElementById(pid).value;
				count++;
				var url="ChangeCartItem1.jsp?productid="+escape(pid)+"&count="+count;
				
				var itemtotal=document.getElementById("itemtotal"+i);
				var normal=document.getElementById("normalprice"+i).innerText;
				var normalprice=normal.substring(1,normal.length);
				
				init();
				request.open("post",url,true);
				request.onreadystatechange=function()
				{
					if(request.readyState==4 && request.status==200)
					{
						productid.outerHTML="<input type='text' id='"+pid+"' class='backgbs textc' name='"
										   +pid+"' value='"+count+"'></input>";									 
					
						itemtotal.innerText="¥ "+parseFloat(normalprice*count).toFixed(1);
					}
				}
				request.send(null);
				//alert(request.readyState);
				//alert(request.status);
				
				var checki=document.getElementById("check"+i);	
				if(checki.checked==true)
				{				
					var normal=document.getElementById("normalprice"+i).innerText;
					var normalprice=parseInt(normal.substring(1,normal.length));						
					var totals=document.getElementById("total");
					var total=document.getElementById("total").innerText;	
					var zero=parseInt(total.substring(1,total.length));
					
					zero=zero+normalprice;					
					totals.innerText="¥ "+parseFloat(zero).toFixed(1);
				}
			}
			function deleCartItem(id)
			{
				var s=document.getElementById(id).id;
				var ss=s.split("-");
				var pid=ss[0];
				var i=ss[1];
				
				var productid=document.getElementById(pid);						
				var count=document.getElementById(pid).value;
				count--;
				if(count<0){count=0;}
				
				var url="ChangeCartItem1.jsp?productid="+escape(pid)+"&count="+count;
				
				var itemtotal=document.getElementById("itemtotal"+i);
				var normal=document.getElementById("normalprice"+i).innerText;
				var normalprice=normal.substring(1,normal.length);
				
				init();
				request.open("post",url,true);
				request.onreadystatechange=function()
				{
					if(request.readyState==4 && request.status==200)
					{
						productid.outerHTML="<input type='text' id='"+pid+"' class='backgbs textc' name='"
										   +pid+"' value='"+count+"'></input>";									 
					
						itemtotal.innerText="¥ "+parseFloat(normalprice*count).toFixed(1);
					}
				}
				request.send(null);
				
				var checki=document.getElementById("check"+i);	
				if(checki.checked==true)
				{				
					var totals=document.getElementById("total");
					var total=document.getElementById("total").innerText;	
					var zero=parseInt(total.substring(1,total.length));
					
					var itemtotals=document.getElementById("itemtotal"+i).innerText;				
					var itemtotalprices=parseInt(itemtotals.substring(1,itemtotals.length));				
					if(itemtotalprices>0)
					{
						zero=zero-normalprice;
					}						

					totals.innerText="¥ "+parseFloat(zero).toFixed(1);	
				}
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
		<script type="text/javascript">
			window.onload=function()
			{
				var checks=document.getElementsByName("check");
				var checkall=document.getElementById("checkall");
				
				checkall.onclick=function()
				{
					if(checkall.checked==true)
					{
						for(var j=0;j<checks.length;j++)
						{
							checks[j].checked=true;	
						}
						sel();
					}
					else
					{								
						for(var j=0;j<checks.length;j++)
						{
							checks[j].checked=false;
						}
						sel();
					}
				}
			}	
			
			function sel()
			{
				var checks=document.getElementsByName("check");
				var checkall=document.getElementById("checkall");	
				var number=document.getElementById("number");
				
				var click=document.getElementById("click");	
				
				var totals=document.getElementById("total");						
				var total=document.getElementById("total").innerText;						
				var totalprice=parseInt(total.substring(1,total.length));						
				
				var itemtotal=document.getElementsByName("itemtotal");										
				if(checkall.checked==true)
				{				
					sum=checks.length;
					click.style="pointer-events:auto;background-color:#03a9f4;";
					
					number.innerText=checks.length;	
					for(var j=0;j<checks.length;j++)
					{		
						var value=itemtotal[j].innerText;								
						var pricej=parseInt(value.substring(1,value.length));					
						totalprice+=pricej;//JavaScript中数据计算，注意要先转换成int类型，parseInt()										
					}
					totals.innerText="¥ "+parseFloat(totalprice).toFixed(1);
				}
				else if(checkall.checked==false)
				{
					sum=0;
					click.style="pointer-events:none;background-color:#B5B4B4;";
					
					number.innerText=0;
					for(var j=0;j<checks.length;j++)
					{
						var value=itemtotal[j].innerText;								
						var pricej=parseInt(value.substring(1,value.length));					
						totalprice-=pricej;
						//JavaScript中数据计算或大小判断运算，注意要先转换成int类型，parseInt()
						//JavaScript注意变量的定义，在同一个范围内，不要重复定义，否则会运算出错
					}
					totals.innerText="¥ "+parseFloat(totalprice).toFixed(1);							
				}																							
			}		
			
			//form嵌套
			$(document).ready(function()
			{  
	            $("#confirm").click(function(){  
	            	
	                $("#form1").attr("action","Buy1.jsp");   
	                $("#form1").submit();  
	            });   
	         });  
			
			//超链接是否能被点击
			var sum=0;
			function click(a)
			{
				var click=document.getElementById("click");
				var checkall=document.getElementById("checkall");
				var checks=document.getElementsByName("check");
				if(a==0)
				{
					sum=sum-1;					
					if(sum==0)
					click.style="pointer-events:none;background-color:#B5B4B4;";	
				}					
				else if(a==1)
				{
					sum=sum+1;				
					if(sum>=0)
					click.style="pointer-events:auto;background-color:#03a9f4;";
				}
				
				if(sum==0)
				{
					checkall.checked=false;
				}
				else if(sum==checks.length)
				{
					checkall.checked=true;
				}	
			}				
		</script>	
	</head>
	<body class="padpc5"> 
		<div class="backgb flol" style="height:50px;width:50px;padding-left:15px;padding-top:15px;">
			<img src="/Gouwu/images/background/cart.png" />
		</div>
		<div class="pad10 boxs10 borr10">
			<table class="widpc100">
				<tr>
					<td></td>
					<td class="colb fonts20 fontw700">购物车</td>
					<td>课程名称</td>
					<td>课程单价</td>
					<td>购买数量</td>
					<td>订单总价</td>
					<td></td>
				</tr>
				<tr><td colspan="7"><hr></td></tr>
				<%
					for(int i=0;i<items.size();i++)
					{	
						CartItem ci=items.get(i);
						Product p=ci.getProduct();
				%>
				<tr id="product">
					<td style="width:50px;">
						<form action="Confirm1.jsp" method="post" name="form1" id="form1">
							<input type="hidden" name="action" value="deletex" />
							<input type="checkbox" value="<%= p.getId() %>" name="check" id="check<%= i %>" 
							       class="checkbox" onclick="sele(this.id)"/>
							<label for="check<%= i %>"></label>       				
					</td>
					<td style="width:200px;">
						<a href="ShowProductDetail1.jsp?id=<%= p.getId() %>">
						 	<img src="images/product/<%= p.getId()+".jpg" %>" class="borr10" style="height:120px;width:120px;" />
						</a>
					</td>
					<td >
						<a class="fonts24 fontw700 wid300" style="color:#03a9f4;" href="ShowProductDetail1.jsp?id=<%= p.getId() %>">
						<%= ci.getProduct().getName() %></a>
					</td>
					<td class="colgys fonts20" style="width:150px;" id="normalprice<%= i %>">
						¥ <%= ci.getProduct().getNormalPrice() %>
					</td>
					<td class="wid200">
						<input type="button" id="<%= p.getId() %>-<%= i %>" class="backgbs borrl10 colw" value="-" 
							   onclick="deleCartItem(this.id)()"/>
						<input type="text" id="<%= p.getId() %>" name="count<%= i %>" class="backgbs textc" 
							   value="<%= ci.getCount() %>" readonly="true" />
						<input type="button" id="<%= p.getId() %>+<%= i %>" class="backgb borrr10 colw" value="+" 
							   onclick="addCartItem(this.id)" />
					</td>
					<td class="colgys fonts20" style="width:150px;" id="itemtotal<%=i %>" name="itemtotal">
					¥ <%= ci.getProduct().getNormalPrice()*ci.getCount() %></td>
					<td >
						<a href="Buy1.jsp?action=delete&id=<%= ci.getProduct().getId() %>" class="colgys fonts24">x</a>
					</td>
				</tr>
				<tr><td colspan="7"><hr></td></tr>							
				<%
					}
				%>
				<tr>
					<td><input type="checkbox" id="checkall" class="checkbox" /><label for="checkall"></label></td>
					<td>已选择 <b class="colb" id="number"><%= a %></b> 门课程  </td>
					<td class="textl padlr20">
						<a href="" id="confirm" onclick="return confirm('确定要删除吗？')" class="colgy">
							删除选中的课程</a></form>
					</td>
					<td></td>
					<td class="colgys fonts20">Total</td>
					<td class="colb fonts22 fontw700" id="total">¥ 0.0</td>
					<td></td>
				</tr>
			</table>
			<a href="javascript:document.form1.submit()" class="button-1 flor colw marlrpc5 backggy" 
			   style="pointer-events:none;" id="click">
				结算
			</a>
		</div>
	
	</body>
</html>