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
	List<Category> categories=CategoryService.getInstance().getCategoriesGradeTwo();
	User u=(User)session.getAttribute("user");
	
	String action=request.getParameter("action");
	if(action !=null && action.equals("exit"))
	{
		session.invalidate();
		response.sendRedirect("/Gouwu/");
	}
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
		out.println("<h3>没有您要找的商品！~</h3>");
		return;
	}

	if(session.getAttribute("count")!=null)//为了在form1表单提交后，刷新页面时保持count的数据不变
	{
		count=(Integer)(session.getAttribute("count"));
	}
	
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
		<style type="text/css">
		.button-1{
		 border-radius:50px;
		 width: 200px;
		 text-align: center;
		 padding:5px;
		 margin:0 23px;
		}
		td{
		  text-align:center;
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
				window.setTimeout(document.form1.submit(),1000);
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
				<div class="itemshow flol marlr15" style="margin-top:17px;" >
					<a href="" style="color:white;">
						<img src="/Gouwu/images/icon/user.png" class="wida" 
							 style="height:20px;margin-right:5px;">
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
	
		<div class="padlrpc5 overfh">
			<div class="boxs10 heia wida borr20 backgbs" style="overflow:hidden;padding:5% 8%;margin-top:10%;background-color:#c8f7f7">
			   
			    <div class="flol hei400 wid500" style="overflow:hidden;padding-top:50px;">
				    <div>
					  <img src="images/product/<%= p.getId()+".jpg" %>" class="wida" style="height:450px;"/>
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
						<input type="hidden" name="id" value="<%= p.getId() %>"/>
						<table>	
							<tr style="height:50px;">
								<td><b class="colr fonts28">¥<%= p.getNormalPrice() %></b></td>
							</tr>
							<tr style="height:50px">
								<td>
									<input type="button" style="width:20%;font-size:20px;"class="borrl10" value="-" onclick="dele()"/>
									<input type="text" id="count" name="count" class="textc" value="<%= count %>"/>
									<input type="button" style="width:20%;font-size:20px;" class="borrr10" value="+" onclick="add()"/>
								</td>
							</tr>
							<tr style="height:50px">
								<td>
									<a href="" onclick="aler()" >
										<div class="button-1 backgy" style="cursor:pointer;">				            
								          	<div class="title-text colgys" style="font-size:16px;">加入购物车</div>
								        </div>
							        </a>
								</td>
							</tr>
							<tr style="height:50px">
								<td>                      
									<a href="Buy1.jsp" onclick="document.form1.submit();" >
										<div class="button-1 backgr" style="cursor:pointer;">				     
								          	<div class="title-text colw" style="font-size:16px;">立刻下单</div>
								        </div>
									</a>
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