<%@ page import="product.ProductMgr"%>
<%@ page import="product.Product"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	request.setCharacterEncoding("utf8");
	String parameter=request.getParameter("parameter");
	if(parameter!=null & parameter.equals("1"))
	{
		int id1=Integer.parseInt(request.getParameter("id"));
		//System.out.println(id1);
		ProductMgr.getInstance().delete(id1);
%>
		<script type="text/javascript">
			parent.main.location.reload();
		</script>
<%
		return;
	}
	else if(parameter!=null & parameter.equals("x"))
	{
		String [] ids=request.getParameterValues("delete");
		for(int i=0;ids!=null & i<ids.length;i++)
		{
			int id=Integer.parseInt(ids[i].trim());
			ProductMgr.getInstance().delete(id);
		}
%>
		<script type="text/javascript">
			parent.main.location.reload();
	//parent.document.main.location.reload();刷新后会把整个页面刷新，并不会刷新main
		</script>
<%
		return;
	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>删除产品</title>		
	</head>
	<body>
		<span>恭喜您，删除成功，1秒钟后自动跳转.....</span>	
	</body>
</html>