<%@ page import="stat.StatService"%>
<%@ page import="stat.ProductStatItem"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	List<ProductStatItem> items = StatService.getProductsBySaleCount(); 
	String imgName = (String)request.getAttribute("imgName");
	//从servlet转发至jsp只能用request.setAttribute()存储数据，且由于不同的页面，所拥有的的request对象是不同的
	//因此必须让两个页面都拥有同一个request对象，才可以用request.getAttribute()获得存储的数据
	//通常在jsp与jsp之间都是用可以用session.setAttribute()进行传递数据，也可以用request.setAttribute()传递数据
	//但是在servlet到jsp时，若request对象不同，导致无法传递，除非将servlet的request以及response对象传递给jsp
	//这样servlet与jsp就拥有了同一套request对象，也就可以取出存储的数据
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
	</head>
	<body>
		<%@ include file="AdminNav.jsp" %>
	
		<div class="heia wida" style="padding:8% 5% 5% 5%;">
			<div class="boxs10 widpc90 borr10 padpc5 overfh">
				<div class="colb fonts20 fontw700 martb10" style="margin-left:25px;">
					报名数据统计
				</div>
				<div class="pad10 borr10 boxs10 flol" style="margin:30px 150px 30px 25px;">
					<table>
						<tr>
							<td style="width:150px;" class="colgy">产品名称</td>
							<td style="width:100px;" class="colgy">销售总量</td>
						</tr>
						<tr><td colspan="2"><hr></td></tr>
						<%
							for(int i=0;i<items.size();i++)
							{
								ProductStatItem p=items.get(i);
						%>
						<tr>
							<td class="colb"><%= p.getProductName() %></td>
							<td><%= p.getTotalSalesCount() %></td>
						</tr>
						<tr><td colspan="2"><hr></td></tr>	
						<%
							}
						%>
					</table>
				</div>	
				<div class="flol" style="margin-top:30px;">			
					<img src="<%=request.getContextPath()%>/admin/images/stat/<%= imgName %>" />
						<!-- request.getContextPath()返回站点根目录 -->
				</div>
			</div>
		</div>
		
		<%@ include file="/Footer.jsp" %>				
	</body>
</html>