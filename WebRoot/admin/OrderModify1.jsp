<%@ page import="user.User"%>
<%@ page import="order.SalesOrder"%>
<%@ page import="order.OrderMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	request.setCharacterEncoding("utf8");
	int orderid=Integer.parseInt(request.getParameter("id"));
	SalesOrder so=OrderMgr.getInstance().loadById(orderid);
	
	int status=so.getStatus();
	User u=so.getUser();
	
	String action=request.getParameter("action");
	if(action !=null && action.trim().equals("modify"))
	{
		status=Integer.parseInt(request.getParameter("status"));
		so.setStatus(status);
		so.updateStatus();
%>	
	<script type="text/javascript">	
		parent.main.location.reload();
	</script>
<%		
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>订单修改</title>
	</head>
	<body>
		<span style="margin-right:25px;float:left;">订单号：<%= so.getId() %></span><br>
		<span style="float:left;">用户名：<%= u.getUsername() %></span><br>
		<span style="float:left;">订单状态：</span>
		<form action="OrderModify1.jsp" method="post" style="float:left;">
			<input type="hidden" name="action" value="modify"/>
			<input type="hidden" name="id" value="<%= orderid %>"/>
			<select name="status" style="float:inherit;">
				<option value="0" <%= (status==0)?"selected":"" %>>待发货</option>
				<option value="1" <%= (status==1)?"selected":"" %>>已发货</option>
				<option value="2" <%= (status==2)?"selected":"" %>>订单取消</option>
			</select>
			<input type="submit" value="提交" />			
		</form>
	</body>
</html>