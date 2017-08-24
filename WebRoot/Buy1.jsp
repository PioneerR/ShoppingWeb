<%@ page import="category.CategoryService"%>
<%@ page import="category.Category"%>
<%@ page import="user.User"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="client.CartItem"%>
<%@ page import="client.Cart"%>
<%@ page import="product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf8");
	List<Category> categories=CategoryService.getInstance().getCategoriesGradeTwo();
	User u=(User)session.getAttribute("user");
	
	String action=request.getParameter("action");
	if(action !=null && action.equals("exit"))
	{
		session.invalidate();
		response.sendRedirect("/Gouwu/");
	}
	Cart c = (Cart)session.getAttribute("cart");//getAttribute获得的是object类
	if(c==null)
	{
		c=new Cart();
		session.setAttribute("cart", c);
	}

	String idStr=request.getParameter("id");
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

	
	int a=0;
	List<CartItem>items=c.getItems();
	Iterator<CartItem> it=items.iterator();
	
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
		<title>艺术创想</title>
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
			.boxs5{
				box-shadow:0 0 1px #B5B4B4;
				transition:all 0.6s;
			}
			.boxs5:hover {  
				box-shadow:0 0 10px #B5B4B4;
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
	<body > 
		<div class="widpc100 backgb" style="position:fixed;top:0;height:70px;
			 box-shadow:5px 5px 8px #B5B4B4,-5px 5px 8px #B5B4B4;" id="nav">
			<nav style="" class="overfh">
				<div class="flol" style="margin-right:20px;margin-left:7%;">
					<a href="Index1.jsp" style="color:white;" class="fontw700">				
						<img src="/Gouwu/images/icon/yscx.png" class="wida" style="height:50px;">艺术创想
					</a>
				</div>
				
				<div class="itemshow flol wid100 textc" style="margin-top:17px; ">
					<a href="ShowProducts1.jsp" class="" style="color:#fff;">课程</a>
					<div class="itemhide" style="margin-left:18%;width:150px;padding-bottom:5px;">
					<%
						Category cg=categories.get(0);				
					%>		
						<a href="ShowProducts1.jsp?categoryId=<%= cg.getId() %>">
							<div class="item backgw borrt5 textc fonts16 colgy" style="line-height:37px;">
								<%= cg.getName() %>
							</div>
						</a>						
					<%						
						for(int i=1;i<categories.size()-1;i++)
						{							
							cg=categories.get(i);							
					%>	
						<a href="ShowProducts1.jsp?categoryId=<%= cg.getId() %>">
							<div class="item backgw textc fonts16 colgy" style="line-height:37px;">
								<%= cg.getName() %>
							</div>
						</a>
					<%
						}
							cg=categories.get(categories.size()-1);							
					%>
						<a href="ShowProducts1.jsp?categoryId=<%= cg.getId() %>" >
							<div class="item backgw borrb5 textc fonts16 colgy" style="line-height:37px;">
								<%= cg.getName() %>
							</div>
						</a>	
					</div>
				</div>
				
				<div class="itemshow flol wid100 textc" style="margin-top:17px;margin-left:45%; ">
					<a href="Buy1.jsp" class="" style="color:#fff;">
						<img src="/Gouwu/images/background/cart2.png" class="wida" style="height:22px;">
					</a>
					<div class="itemhide" style="width:150px;padding-bottom:5px; ">
						<a href="Buy1.jsp">
							<div class="item backgw textc fonts16 colgy borr5" style="line-height:37px;margin-right:15%;">
								查看购物车
							</div>
						</a>
					</div>
				</div>
				
		<%
			if(u==null)
			{
		%>	
				<div class="flol marlr15" style="margin-top:25px;" >
					<a href="Register1.jsp" style="color:white;">
						<img src="/Gouwu/images/icon/signup.png" class="wida" style="height:20px;margin-right:5px;">注册
					</a>
				</div>
				<div class="flol marlr15" style="margin-top:25px;" >
					<a href="UserLogin1.jsp" style="color:white;">
						<img src="/Gouwu/images/icon/signin.png" class="wida" style="height:20px;">登录
					</a>
				</div>
		<%
			}
			else
			{
		%>
				<div class="itemshow flol marlr15"  >
					<a href="" style="color:white;">
						<img src="/Gouwu/images/user/<%= u.getId()+".jpg" %>" class="wida" 
							 style="height:30px;width:30px;margin-right:5px;margin-top:25px;margin-bottom:-8px; "
							 onerror="javascript:this.src='/Gouwu/images/icon/user.png'">
						<%= u.getUsername() %>
					</a>
					<div class="itemhide" style="width:150px;padding-bottom:5px;">
						<a href="Orderstatus1.jsp">
							<div class="item borrt5 textc backgw colgy fonts16" style="line-height:37px;margin-right:10%;">
								我的订单
							</div>
						</a>
						<a href="Userinfo1.jsp">
							<div class="item textc backgw colgy fonts16" style="line-height:37px;margin-right:10%;">
								个人信息
							</div>
						</a>
						<a href="Index1.jsp?action=exit">
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
	
		<div style="padding:10% 5% 5% 5% ">
			<div class="backgb flol" style="height:50px;width:50px;padding-left:15px;padding-top:15px;">
				<img src="/Gouwu/images/background/cart.png" />
			</div>
		<%
			if(it.hasNext()==true)
			{
		%>
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
							 	<img src="images/product/<%= p.getId()+".jpg" %>" class="borr10 boxs5" style="height:120px;width:120px;" />
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
							<a href="" id="confirm" onclick="return confirm('确定要删除吗？')" class="colgy pad5 borr5 boxs5">
							删除选中的课程</a></form>
						</td>
						<td></td>
						<td class="colgys fonts20">Total</td>
						<td class="colb fonts22 fontw700" id="total">¥ 0.0</td>
						<td></td>
					</tr>
				</table>
				<a href="javascript:document.form1.submit()" class="button-1 flor colw marlrpc5 backggy boxs5" 
				   style="pointer-events:none;" id="click">
					结算
				</a>
			</div>
		<%
			}
			else if(it.hasNext()==false)
			{	
		%>
			<div class="widpc100 textc colb fontw700 fonts22 boxs10 borr10 padtbpc10" style="height:200px;">
				<img src="/Gouwu/images/background/cart1.png"/>购物车空空如也!~<br>
				<a class="borr20 fonts18 marlrpc5 backgb boxs5 curp padtb5" href="ShowProducts1.jsp"
					 style="width:200px;margin-top:70px;margin-left:43%;display:block;color:#fff;">快去选购课程吧~
				</a>
			</div>
			
		<%
			}
		%>
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
			<div class="flol heia martbpc1 fonts14" style="margin-left:38%;">
				Copyright © 2017 艺术创想  Designed by 
				<a href="https://github.com/PioneerR" target="_blank" style="color:#03a9f4;">PioneerR</a>
			</div>
	    </div>
	    
	</body>
</html>