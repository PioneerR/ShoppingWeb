<%@ page import="user.User"%>
<%@ page import="category.CategoryService"%>
<%@ page import="category.Category"%>
<%@ page import="client.CartItem"%>
<%@ page import="java.util.List"%>
<%@ page import="client.Cart"%>
<%@ page import="product.ProductMgr"%>
<%@ page import="product.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	request.setCharacterEncoding("utf8");
	User u=(User)session.getAttribute("user");
	
	String action=request.getParameter("action");
	
	String id=request.getParameter("id");
    Product p=null;
    
    int count=1;
	if(id!= null)
	{
		try
		{
			int productid=Integer.parseInt(id);
			p=ProductMgr.getInstance().getProduct(productid);
		}
		catch(NumberFormatException e)
		{
			e.printStackTrace();
		}
	}
	else
	{
		out.println("<div style='padding:10% 5% 5% 5%;box-shadow:0 0 10px #B5B4B4;border-radius:10px;width:80%;height:200px;margin-left:5%;margin-top:5%;'");
		out.println("<div style=''>");
		out.println("<h2 style='color:#03a9f4;text-align:center;padding:6%;'>"+"没有您要找的课程！~"+"</h2>");
		out.println("</div></div>");
		
		out.println("<a href='javascript:window.history.go(-1)' style='text-decoration:none;");
		out.println("background:#03a9f4;padding-bottom:5px;padding-top:5px;color:#fff;float:right;");
		out.println("margin:2% 5% 5% 5%;padding-left:30px;padding-right:30px;text-align:center;border-radius:5px;'>");
		out.println("返回</a>");
		return;
	}

	if(session.getAttribute("count")!=null)//为了在form1表单提交后，刷新页面时保持count的数据不变
	{
		count=(Integer)(session.getAttribute("count"));
	}
	
	
	if(action !=null && action.trim().equals("add"))
	{
		String idStr=request.getParameter("productid");
		String countStr=request.getParameter("count");
		int productid=Integer.parseInt(idStr);
		int counts=Integer.parseInt(countStr);
		//session.setAttribute("count", counts);//为了产品详情页提交表单后数量不变
		Product pro=ProductMgr.getInstance().getProduct(productid);
		CartItem ci=new CartItem();
		ci.setProduct(pro);
		if(counts>=0)
		{
			ci.setCount(counts);
		}
		else
		{
			ci.setCount(0);
		}
		
		Cart c = (Cart)session.getAttribute("cart");//getAttribute获得的是object类
		if(c==null)
		{
			c=new Cart();
		}
		c.add(ci);
		session.setAttribute("cart", c);
	}
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">		
		<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
		<title>艺术创想</title>
		<link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css" />
		<style type="text/css">
			.button-1{
			 border-radius:50px;
			 width: 200px;
			 text-align: center;
			 padding:5px;
			 margin:0 23px;
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
			function aler()
			{
				alert("已成功加入购物车！~");
				//window.setTimeout(document.form1.submit(),500);
				//window.history.go(-1);
				//return false;//提交表单后，不刷新页面,似乎无效
			}
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
		</script>		
	</head>
	<body >
		<%@ include file="Nav.jsp" %>
	
		<div class="padlrpc5 overfh">
			<div class="boxs10 heia wida borr20 backgbs" style="overflow:hidden;padding:5% 8%;margin-top:10%;background-color:#c8f7f7">
			   
			    <div class="flol hei400 wid500" style="overflow:hidden;padding-top:50px;">
				    <div>
					  <img src="images/product/<%= p.getId()+".jpg" %>" class="wida" style="height:450px;"
					  		onerror="javascript:this.src='/Gouwu/images/product/yscx.png'"/>
					</div>
				</div>
				
				<div class="flol" style="margin-left:10%;width:40%">				
					<div>	
						<div style="height:50px" class="textc">
							<b class="colb" style="font-size:40px;"><%= p.getName() %></b>
						</div>
						<div style="height:200px;">
							<p class="textl colgys fonts20" style="padding:0;" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<%= p.getDescribe() %>
							</p>
						</div>
					</div>
	
					<div style="margin-left:15%;">
						<form name="form1" action="Buy1.jsp" method="post">
						<input type="hidden" name="action" value="add"/>
						<input type="hidden" name="productid" value="<%= p.getId() %>"/>
						<table>	
							<tr style="height:50px;">
								<td><b class="colr fonts28">¥<%= p.getNormalPrice() %></b></td>
							</tr>
							
							<tr style="height:50px">
								<td>
									<a href="ShowProductDetail1.jsp?action=add&productid=<%= p.getId() %>&count=<%= count %>&id=<%= p.getId() %>"
									   onclick="aler()" >
										<div class="button-1 backgy" style="cursor:pointer;">				            
								          	<div class="title-text colgys" style="font-size:16px;">加入购物车</div>
								        </div>
							        </a>
								</td>
							</tr>
							<tr style="height:50px">
								<td>                      
									<input type="submit" value="立刻报名" style="font-size:16px;"
										class="button-1 backgr title-text colw curp" />					
								</td>
							</tr>				
						</table>
						</form>
			    	</div>
			    	
			   </div>
			 </div>
					<%
						String cgidStr=request.getParameter("cgid");//如果cgid!=0,那么点击返回时，就会回到对应的类别产品页面
						int cgid=0;                      //拿到上一页的课程类别id，如果cgid=0，那么点击返回时，就返回所有产品页      
						if(cgidStr!=null){cgid=Integer.parseInt(cgidStr);}					
					%>			 			 
			 <a href="ShowProducts1.jsp?categoryId=<%= cgid %>" class="flor marpc1 backgb padlr30 boxs5 textc borr5" 
			   style="margin-right:30px;padding-bottom:5px;color:#fff;" >
				返回
			 </a>
		 </div>
		  
		 <%@ include file="Footer.jsp" %>
	      	
	</body>
</html>