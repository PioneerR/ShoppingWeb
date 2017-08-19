<%@ page import="java.util.Iterator"%>
<%@ page import="client.Cart"%>
<%@ page import="client.CartItem"%>
<%@ page import="java.util.List"%>
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
	
	Cart c=(Cart)session.getAttribute("cart");
	if(c == null)
	{
		c=new Cart();
		session.setAttribute("cart", c);
	}
	
	String [] ids=request.getParameterValues("check");
	session.setAttribute("checks", ids);
	 
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
		<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
		<title>艺术创想</title>
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
			.boxs5{
				box-shadow:0 0 1px #B5B4B4;
				transition:all 0.6s;
			}
			.boxs5:hover {  
				box-shadow:0 0 10px #B5B4B4;
			} 
			.boxs5::after{
				transition:all 0.6s;
			}
			
			.radio{
			  display: none;
			}
			.radio+label{
				background-color: #FFF; 
			    box-shadow: 0 0px 1px #B5B4B4; 
			    padding: 7px; 
			    border-radius: 5px; 	
			    transition:all 0.6s;
			}
			.radio+ label:hover{ 
			    box-shadow: 0 0px 10px #B5B4B4;   
			}
			.radio:checked + label { 
			    background-color: #03a9f4; 
			    box-shadow: 0 0px 1px #B5B4B4; 
			    color: #fff; 
			    transition:all 0.6s;
			}
			.radio:checked + label:hover { 
			     box-shadow: 0 0px 10px #B5B4B4; 
			}
			
		</style>
		<script type="text/javascript">
			function sure(num)
			{
				var b1=document.getElementById("b1");
				var b2=document.getElementById("b2");
				var sub=document.getElementById("sub");
				sub.style="pointer-events:auto;background-color:#03a9f4;";
				if(num==1)
				{
					b1.checked=true;
					b2.checked=false;
				}
				else if(num==2)
				{
					b1.checked=false;
					b2.checked=true;
				}
			}
			
		</script>
		<link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css" />
	</head>	
	<body >	
		<div class="padpc5">	
			<form action="Order1.jsp" name="form1" method="post">
			<input type="hidden" name="action" value="confirm"/>
			<div class="boxs10 borr10">
					
				<div class="backgb" style="height:50px;width:50px;padding-left:5px;padding-top:5px;">
					<img src="/Gouwu/images/background/info.png" />
				</div>
				
				<div class="pad20">	
					<table style="padding-bottom:2%;">
						<tr>
							<td colspan=3 class="colb fonts20 fontw700 textl">
								<img src="/Gouwu/images/background/site.png" />寄送至
							</td>
						</tr>
						<tr>
							<td class="textc" style="width:150px;"><%= u.getUsername() %></td>
							<td class="wid200 textl"><%= u.getAddress() %></td>
							<td class="wid100 textl"><%= u.getPhone() %></td>
						</tr>
					</table>
					
					<div class="padtbpc2" style="margin-bottom:8%;">
						<div class="colb fonts20 fontw700 textl" style="margin-bottom:20px;margin-left:13px;">					
							<img src="/Gouwu/images/background/pay.png" />&nbsp;&nbsp;付款方式						
						</div>
						<input type="checkbox" name="payset" class="radio" id="b1" value="1" onclick="sure(1)"/>
						<label for="b1" style="margin-right:5px;margin-left:20px;">微信支付</label>
						<input type="checkbox" name="payset" class="radio" id="b2" value="2" onclick="sure(2)"/>					
						<label for="b2" style="padding-left:15px;padding-right:15px;" >支付宝</label>
					</div>
					
					<table class="widpc100" style="margin-top:2%;padding-left:10px;padding-right:10px; ">
						<tr>
							<td class="colb fonts20 fontw700 textl" colspan=4>
								<img src="/Gouwu/images/background/order.png" style="margin-right:15px;margin-left:11px;"/>订单确认
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
				<a href="javascript:document.form1.submit()" style="pointer-events:none;"
				   class="button-1 flor colw marpc1 backggy" id="sub">
					提交订单
				</a>
				<a href="Buy1.jsp" class="flor colgy marpc1 backgw pad5 boxs5 textc borr5" style="width:70px;" >
					返回
				</a>
			</div>
			</form>
		</div>
		
		<div class="widpc100 backgbs" style="height:100px;padding-top:30px;background-color:#eafbf6;margin-top:50px;">
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